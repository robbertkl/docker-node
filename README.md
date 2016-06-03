# robbertkl/node

Docker container running Node.js:

* Either run it directly with a mounted volume or extend it into an image with your code included
* Does not expose any ports

## Usage

Either run it directly:

```
docker run -d -v <path-to-code>:/usr/src/app -p 80:3000 robbertkl/node
```

Or extend it:

```
FROM robbertkl/node

COPY package.json ./
RUN npm install
COPY . .

EXPOSE 3000

...
```

## Authors

* Robbert Klarenbeek, <robbertkl@renbeek.nl>

## License

This repo is published under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
