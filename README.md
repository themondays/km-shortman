# Shortman
Link shortener

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`


## Endpoints

You can visit [`localhost:4001`](http://localhost:4001) or [`localhost:4000`](http://localhost:4000) from your browser (each endpoint has specific purpose).

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

Endpoints delegated between web and API applications which is running on separate ports.

### Shortlink Endpoint
Shortlink will return a permanent redirect with status code 301 

```
GET <hostname>:4000/<hashId>
```

### API
General purpose - allow direct connections.

#### Create new link

##### Request
```
POST <hostname>/api/1.0/links
Content-Type: application/json
```

##### Required Parameters

```
{"link": {
  "url": "https://google.com/"
}}
```

##### Response
```
{
 Response "data": {
    "hashid": "8EjZ6r4jyn",
    "hits": 0,
    "id": 10538,
    "short_url": "http://<hostname>:4000/8EjZ6r4jyn",
    "url": "https://google.com/"
  }
}
```
#### Get link by hashid

##### Request
```
GET <hostname>/api/1.0/links/<hashid>
Content-Type: application/json
```

##### Required Parameters

```
GET parameter hashid must be valid string
```

##### Response
```
{
 Response "data": {
    "hashid": "8EjZ6r4jyn",
    "hits": 0,
    "id": 10538,
    "short_url": "http://<hostname>:4000/8EjZ6r4jyn",
    "url": "https://google.com/"
  }
}
```

### Web
Create a redirect for `GET <hostname>/<hashid>` requests. Can be replaced with API/Client pair.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

