FROM dunglas/frankenphp:php8.4

RUN install-php-extensions \
    pcntl \
    intl \
    pdo_mysql \
    redis

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html/backend

COPY ./src/backend /var/www/html/backend
COPY ./frankenphp/Caddyfile /etc/frankenphp/Caddyfile

ENV APP_ENV=local \
    APP_BASE_PATH=/var/www/html/backend \
    APP_PUBLIC_PATH=/var/www/html/backend/public \
    LARAVEL_OCTANE=1 \
    MAX_REQUESTS=200 \
    REQUEST_MAX_EXECUTION_TIME=30

EXPOSE 80 443

CMD ["frankenphp", "run", "--config", "/etc/frankenphp/Caddyfile"]