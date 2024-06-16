# Fully featured nginx
nginx dockerfile with the stream and rtmp module

* [tekn0ir/nginx-stream](https://github.com/tekn0ir/nginx-stream)
* [sergey-dryabzhinsky/nginx-rtmp-module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module)

### Zero downtime reloading of changed configs
If you change settings and need to relaod them on a running container w/o downtime
```bash
$ docker exec -ti nginx bash -c 'zero_downtime_reload.sh'
```
