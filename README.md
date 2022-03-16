# scratch_me
To run this locally please follow the following instructions

1. Please ensure you run the project using flutter: Flutter version 2.5.3
2. Make sure you cd into https://github.com/Brianspha/scratch_me/tree/main/scracth_me_contracts and ``yarn or npm i``
3. Create a .env file with the following spec
   ``KOVAN_NODE_URL= "YOUR KOVAN RPC URL"
    IOTEX_ACCOUNT_KEY="YOUR PRIVATE KEY"``
5. In the same folder run ``yarn kovan`` which will deploy the contracts to kovan
6. Back to the flutter project navigate to the https://github.com/Brianspha/scratch_me/tree/main/assets folder and create a folder named ``environment`` in the folder create a file called `.env``
7. In the .env file created under the assets folder add these varaible names
``
ADMIN_PRIVATE_KEY="The admin key used to deploy the contracts to kovan"
TOKEN_NAME="Scratch Me Token"
TOKEN_MANAGER_ADDRESS="The address of the token manger deployed to kovan refer to the output of the contract deployment"
RPC_NETWORK_URL="KOVAN RPC URL"
``
8.  If you are going to run this using ganache please ensure your have a local ganache instance running on port ``8546``
9. Back to the contract project copy paste the address as illustrated above if you are deploying this to a ganache isntance you will need to copy the first address private an paste it as the admin key in the environment file like so ``ADMIN_PRIVATE_KEY="The admin key used to deploy the contracts to ganache"`` and copy the rest of the contract deployment addresses from the console
10. All should be good after this
 
