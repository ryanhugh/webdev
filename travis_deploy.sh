# Exit if any commands fail. 
trap 'exit' ERR

# Echo each command as they are ran
set -v

# Pull requests and commits to other branches shouldn't try to deploy
if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo $TRAVIS_PULL_REQUEST
    echo $TRAVIS_BRANCH
    echo $SOURCE_BRANCH
    exit 0
fi

eval "$(ssh-agent -s)"
mkdir -p ~/.ssh 2> /dev/null
echo $GIT_PRIVATE_KEY | base64 --decode > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa

# Push to prod if this is the prod branch
if [ "$TRAVIS_BRANCH" == "prod" ]; then
  echo 'Deploying to prod'
  
  ssh -o StrictHostKeyChecking=no ubuntu@34.225.112.42 'cd webdev; git reset --hard'
  ssh -o StrictHostKeyChecking=no ubuntu@34.225.112.42 'cd webdev; git pull'
  ssh -o StrictHostKeyChecking=no ubuntu@34.225.112.42 'cd webdev; git checkout prod'

fi

echo "Done travis_deploy.sh"