### Goal
Users can register and create wishlists, selecting and filtering products from database.
Visitors can list all wishlists, enter one, add products to cart, and checkout so it will mock that cart products were bought.

### Development

_Make sure you have the latest stable version of docker and docker-compose._

Run:
```bash
$ docker-compose build
$ docker-compose up
$ docker-compose run app rails db:create db:migrate db:seed
```

_NOTE: If you are having permission problems when using Linux, try to run the following commands before proceeding:_

```bash
$ docker-compose down
$ sudo chown -R $USER:$USER .
```

_NOTE: If you are having assets problems, try manually install dependencies (happens on Alpine image):_

```bash
$ docker-compose run app yarn install
```

### Automated tests

Run:
```bash
$ docker-compose run app rspec
```