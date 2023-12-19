# SIMPLE EXPRESS DEMO

A simple demo to test out verdaccio.  

REF: [chrisguest75/nodejs_examples/03_express/README.md](https://github.com/chrisguest75/nodejs_examples/blob/master/03_express/README.md)  

## Configure .npmrc

```sh
npm set registry http://localhost:4873/ --location project
```

## Install generator

```sh
npm install -g express-generator
npm list -g
```

```sh
# generate example
express -c stylus -v hjs . 
```

## Run

```sh
# verdaccio must be running
npm install

DEBUG=express-demo:* npm start
open http://localhost:3000
```

## Resources

* https://stackoverflow.com/questions/59478090/how-to-create-offline-private-registry-of-verdaccio