# Laravel base Docker image
Small Docker image for Laravel with RoadRunner and some needed extensions

Example entrypoint:

```bash
php
    -d
    variables_order=EGPCS
    artisan
    octane:start
    --server=roadrunner
    --watch
    --host=0.0.0.0
    --port=8000
    --workers=auto
    --task-workers=auto
    --max-requests=500
```
