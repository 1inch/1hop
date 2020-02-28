const IpfsApi = require('ipfs-api');
const path = require("path");

const ipfs = IpfsApi({
    host: 'ipfs.1inch.exchange',
    port: 443,
    protocol: 'https',
    headers: {
        authorization: 'Basic ' + process.env.IPFS_SECRET
    }
});

ipfs.util.addFromFs(
    path.resolve(__dirname, '../dist/one-hop'),
    {
        recursive: true
    }
)
        .then(results => {

            results.map(value => console.log(value));
        });
