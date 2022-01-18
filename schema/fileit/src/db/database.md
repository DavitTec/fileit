[Back to resource list](../README.md#Resources)

# fileit_database

This resource manages PostgreSQL Fileit databases.

## Actions

- `create` - (default) Creates the given database.
- `drop` - Drops the given database.

## Properties

| Name       | Types   | Description                                                         | Default             | Required? |
| ---------- | ------- | ------------------------------------------------------------------- | ------------------- | --------- |
| `database` | String  | Name of the database to create                                      | Resource name       | yes       |
| `user`     | String  | User which run psql command                                         | `'fileit'`          | no        |
| `template` | String  | Template used to create the new database                            | `'template1'`       | no        |
| `host`     | String  | Define the host server where the database creation will be executed | localhost           | no        |
| `port`     | Integer | Define the port of PostgreSQL server                                | `5432`              | no        |
| `encoding` | String  | Define database encoding                                            | Not set             | no        |
| `locale`   | String  | Define database locale                                              | Not set             | no        |
| `owner`    | String  | Define the owner of the database                                    | Not set             | no        |

## Examples

To create database named 'my_app' with owner 'user1':

```ruby
postgresql_database 'my_app' do
  owner 'user1'
end
```

## Known issues

