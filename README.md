docker-backup
=============

docker-backup is a Docker image that allows scheduled backups.

Alteração para criar nova versão da imagem.

Structure
---------

 * [Backup gem](http://backup.github.io/backup/v4/) for backup
 * [Busybox crond](https://www.busybox.net/) for job schedule
 * [whenever](https://github.com/javan/whenever) for schedule description

Usage
-----

In order to use docker-backup, you need to define the schedule and the backup models.

### Schedule definition

You must create a schedule.rb file. For example:

```ruby
# schedule.rb

every :day, at: '01:00am' do
  backup :database
end
```

For more information on syntax, read the [whenever documentation](https://github.com/javan/whenever).

### Backup model definition

For each backup defined in schedule.rb you need to write a model file inside the models directory. For example:

```ruby
# models/database.rb

Model.new(:database, 'Database backup') do
  database MongoDB do |db|
    db.name = "my_database_name"
    db.host = "mongo"
    db.port = 27017
  end
end
```

For more information, read the [Backup gem documentation](http://backup.github.io/backup/v4/).

### Running the container

    $ docker run -d -v `pwd`/schedule.rb:/Backup/schedule.rb -v `pwd`/models:/Backup/models investtools/backup

If you use [docker-compose](https://docs.docker.com/compose/), the docker-compose.yml file would look like this:

```yaml
# docker-compose.yml

version: '2'
services:
  redis:
    image: redis
  mongo:
    image: mongo
  backup:
    image: investtools/backup
    volumes:
      - ./backup:/Backup
    environment:
      - TZ=America/Sao_Paulo
```

The content of ./backup can be something like this:

    backup/
      schedule.rb
      models/
        redis.rb
        mongo.rb

### Supported resources

Although the Backup gem supports a lot of [databases](http://backup.github.io/backup/v4/databases/), [compressors](http://backup.github.io/backup/v4/compressors/), [encryptors](http://backup.github.io/backup/v4/encryptors/), [storages](http://backup.github.io/backup/v4/storages/), [syncers](http://backup.github.io/backup/v4/syncers/) and [notifiers](http://backup.github.io/backup/v4/notifiers/), many of them need system packages that are not installed in this image. The currently installed packages are:

 * MongoDB
 * Redis
 * GPG

If you need another package, you can either [open an issue](https://github.com/investtools/docker-backup/issues/new) or fork this repository and edit the [Dockerfile](https://github.com/investtools/docker-backup/blob/master/Dockerfile#L4).
