# TestCourses

## Development

Run these lines after git cloning:

```sh
bin/configs
bundle install
cd .tools; bundle install; cd ..
bin/overcommit --install
```

Change parameters in `.env.local` & `.env.test.local` file.

After that you can create and fill database: `bin/rails db:prepare` or `bin/setup`.

Run `bin/rswag` to regenerate file `swagger/v1/swagger.yaml`.

Run `bin/rspec` for test suite.

Run `bin/rails s` and go to `http://localhost:3000/api-docs` to open OpenAPI UI.
