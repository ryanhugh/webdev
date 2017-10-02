defmodule NuMartWeb.ProductController do
  use NuMartWeb, :controller

  alias NuMart.Shop
  alias NuMart.Shop.Product

  def index(conn, _params) do
    products = Shop.list_products()
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Shop.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Shop.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Shop.get_product!(id)
    cart = conn.assigns[:current_cart]
    cart_item = %NuMart.Shop.CartItem{
      product_id: id,
      count: 1,
      cart_id: cart.id,
    }
    cart_item = Shop.change_cart_item(cart_item)
    render(conn, "show.html", product: product, cart_item: cart_item)
  end

  def edit(conn, %{"id" => id}) do
    product = Shop.get_product!(id)
    changeset = Shop.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Shop.get_product!(id)

    case Shop.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Shop.get_product!(id)
    {:ok, _product} = Shop.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end
end
