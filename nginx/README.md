1. File structure

```
nginx/
├── conf.d/
│   ├── default.conf               # Default site config (can be disabled/removed)
│   └── services.conf              # Config for routing to microservices
├── ssl/
│   ├── your-domain.crt            # SSL certificate (if using HTTPS)
│   └── your-domain.key            # SSL private key
├── nginx.conf                     # Main Nginx configuration file
├── Dockerfile                     # Dockerfile for Nginx image
└── README.md                      # Info about this Nginx setup
```