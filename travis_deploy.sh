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
  
  # Delete the GIMP files
  rm $(find . | grep .xcf\$)
  
  # Make a tarball of stuff
  tar -cvzf hw.tar.gz *
  
  # And upload that stuff
  scp -o StrictHostKeyChecking=no -r hw.tar.gz ubuntu@52.45.2.162:~/www/webdev/default/
  
  ssh -o StrictHostKeyChecking=no ubuntu@52.45.2.162 'cd www/webdev; git reset --hard'
  ssh -o StrictHostKeyChecking=no ubuntu@52.45.2.162 'cd www/webdev; git pull'
  ssh -o StrictHostKeyChecking=no ubuntu@52.45.2.162 'cd www/webdev; git checkout prod'

fi

echo "Done travis_deploy.sh"