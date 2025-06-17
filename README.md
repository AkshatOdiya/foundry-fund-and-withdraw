
# Foundry Fund and Withdraw Project

This repository contains a simple smart contract project built using **Foundry**. The project demonstrates the core functionality of **funding** and **withdrawing** Ether from a contract, along with unit tests to ensure its correctness.

## 🚀 Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) (installed via `foundryup`)
- Git

### Compile Contracts

```bash
forge build
```

### Run Tests

```bash
forge test
```

### Deploy Contract (Local / Anvil)

```bash
forge script script/DeployFundMe.s.sol --fork-url <RPC_URL> --broadcast
```

## 📄 Contracts

### `FundMe.sol`

A minimal smart contract that:

* Allows users to fund the contract with ETH.
* Allows the owner to withdraw the entire balance.
* Includes modifiers to restrict functions to the contract owner.

## 🧪 Tests

The `FundMe.t.sol` file includes unit tests for:

* Funding functionality.
* Withdrawal by the owner.
* Handling of reverts for unauthorized withdrawals.
---

# 📘 Foundry Fundamentals – Project Setup & Deployment Guide

---

## 🛠️ Creating a Foundry Project 

1. Initialize a Foundry project in the current directory:

   ```bash
   forge init
   ```

2. To create a new project in a new folder:

   ```bash
   forge init name_of_folder
   ```

3. If the folder is not empty, force initialization:

   ```bash
   forge init --force
   ```

4. Compile all smart contracts in your project:

   ```bash
   forge build
   # or
   forge compile
   ```

---

## 🚀 Deploying a Smart Contract (Using Anvil)

1. Start Anvil:

   ```bash
   anvil
   ```

2. Deploy with interactive CLI using default Anvil RPC URL:

   ```bash
   forge create SimpleStorage --interactive
   ```

3. Deploy explicitly using custom RPC URL and private key:

   ```bash
   forge create SimpleStorage --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
   ```

---

## 🧾 Deploying via Scripts 

> Scripts are preferred for deployment.

* Scripts are stored in the `script/` folder with `.s.sol` suffix, e.g.,
  `script/DeploySimpleStorage.s.sol`

### Running a Script:

1. Run and automatically launch Anvil:

   ```bash
   forge script script/DeploySimpleStorage.s.sol
   ```

2. Simulate deployment with custom RPC URL:

   ```bash
   forge script script/DeploySimpleStorage.s.sol --rpc-url <RPC_URL>
   ```

3. To broadcast a transaction:

   ```bash
   forge script script/DeploySimpleStorage.s.sol --rpc-url <RPC_URL> --broadcast --private-key <PRIVATE_KEY>
   ```

---

## 🔐 Private Key Safety

> Never use your private key in real environments with real money.

### Recommended Practices:

1. ✅ **Testing**: Use `.env` file and **never expose it**.
   Example `.env` and also check if it is `.gitignore`:

   ```env
   PRIVATE_KEY=<your_private_key>
   RPC_URL=<your_rpc_url>
   ```

   Load environment variables:

   ```bash
   source .env
   ```

   Deploy using variables:

   ```bash
   forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY
   ```

2. ✅ **Production**:
   Use `--interactive` or **keystore encryption** [`keystore Tutorial`](https://github.com/Cyfrin/foundry-full-course-f23?tab=readme-ov-file#can-you-encrypt-a-private-key---a-keystore-in-foundry-yet).

3. To encrypt key(Cast encrypt using ERC2335 algorithm):

   ```bash
   cast wallet create
   ```

   View accounts:

   ```bash
   cast wallet list
   ```

---

## 🧩 Interacting with Contracts Using `cast`

### Writing to Blockchain:

```bash
cast send <CONTRACT_ADDRESS> "store(uint256)" 1337 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```
To know more about cast send you can use  
```bash
cast send --help
```

**Breakdown**:

* `cast send` → Sign and publish transaction
* `0x...` → Contract address
* `"store(uint256)"` → Function signature
* `1337` → Argument to function
* `--rpc-url` & `--private-key` → Network and wallet

---

### Reading from Blockchain:

```bash
cast call <CONTRACT_ADDRESS> "retrieve()"
```

---

## 🌐 Deploying to Testnet or Mainnet 

> Use **Alchemy** instead of MetaMask’s built-in RPCs.  
**MetaMask’**s built-in connections (like Infura for mainnet or Sepolia) are not developer-friendly for local or custom testing,They **don’t allow you to freely configure** things like `forking`, impersonation, or using custom chains like Anvil, so if you want to use something like Anvil or a different RPC provider, you must add your own RPC URL manually.

1. After setting up Alchemy, get your RPC URL.

2. Deploy to Sepolia (or another network):

   ```bash
   forge script script/DeploySimpleStorage.s.sol --rpc-url $Sepolia_RPC_URL --private-key $PRIVATE_KEY --broadcast
   ```

---

## 🧹 Cleaning Up the Project

Ensure consistent formatting across the project:

```bash
forge fmt
```

---

## ⚡ Foundry ZKsync Integration – Setup & Usage Notes

---

### 🚀 Getting Started with ZKsync and Foundry

To work with ZKsync in Foundry, follow these **three essential steps**:

---

### 1. 🛠️ Install `foundry-zksync`

ZKsync requires a custom fork of Foundry called [`foundry-zksync`](https://github.com/matter-labs/foundry-zksync), which replaces your existing `forge` and `cast` binaries.

> ⚠️ **IMPORTANT:**
> Installing `foundry-zksync` will **override existing Foundry binaries** (`forge`, `cast`). Keep your environments separated.

#### Installation Steps:

1. Clone the repository in a **separate directory**:

   ```bash
   git clone https://github.com/matter-labs/foundry-zksync.git
   ```

2. Navigate into the cloned directory:

   ```bash
   cd foundry-zksync
   ```

3. Run the install script:

   ```bash
   ./install-foundry-zksync
   ```

> ✅ Requires a Unix-like environment (Mac, Linux, or WSL on Windows).

4. Verify successful installation:

   ```bash
   forge --version
   ```

---

### 2. ⚙️ Compile for ZKsync

When using `foundry-zksync`, compile your contracts with the ZKsync flag:

```bash
forge build --zksync
```

---

### 3. 🔄 Switching Between ZKsync & Vanilla Foundry

You can toggle between ZKsync-specific and original Foundry environments:

* Switch to ZKsync Foundry:

  ```bash
  foundryup-zksync
  ```

* Switch back to Vanilla Foundry:

  ```bash
  foundryup
  ```

> 💡 This helps maintain compatibility with standard EVM tooling when you're not actively using ZKsync.

---

## 🏠 Launching ZKsync Anvil

Use the following command to launch Anvil for ZKsync:

```bash
anvil-zksync
```

---

## 🌐 ZKsync Local Deployment

Deploy using the ZKsync RPC URL with the following command:

```bash
forge create src/SimpleStorage.sol:SimpleStorage --rpc_url <RPC_URL> --private_key <PRIVATE_KEY> --legacy --zksync
```

---

## 🔁 Transaction Types in Broadcasts

* The `/broadcast` folder stores transaction info.
* It’s divided by chain ID:

  * `260` → ZKsync
  * `31337` → Anvil

Ethereum and ZKsync support multiple transaction types:

* `0x0`: Legacy
* `0x1`: Access list
* `0x2`: [EIP-1559](https://eips.ethereum.org/EIPS/eip-1559) (default in EVM)
* `0x71` (`113`): [ZKsync-specific transaction type](https://docs.zksync.io/zk-stack/concepts/transaction-lifecycle#eip-712-0x71)

> 👀❗**IMPORTANT:**
> This `0x2` type is the current default type for the EVM, earlier it was `0x0`.

> ZKsync introduces `0x71`, which supports features like [Account Abstraction](https://docs.zksync.io/build/developer-reference/account-abstraction/)

---

## 📡 Deploying to ZKsync Sepolia

1. Create an app in [Alchemy](https://www.alchemy.com/) using the **ZKsync Sepolia** network.
2. Add the RPC URL to your `.env` as:

   ```env
   ZKSYNC_RPC_URL=<your_zksync_sepolia_url>
   ```

Then deploy using the appropriate script and configuration.

---

## 📎 Resources

* [ZKsync Transaction Types](https://docs.zksync.io/zk-stack/concepts/transaction-lifecycle#transaction-types)
* [Cyfrin Blog – EIP-4844 & Proto-Danksharding](https://www.cyfrin.io/blog/what-is-eip-4844-proto-danksharding-and-blob-transactions)

---

### ✅ Conclusion

The ZKsync VM and EVM ecosystems support various transaction types to meet different EIP requirements. By examining deployment folders and understanding the use of flags like `--legacy`, we can effectively distinguish between these transaction types.

Use `foundry-zksync` only in isolated projects where ZKsync support is needed, and always switch back to Vanilla Foundry for regular development to avoid compatibility issues.n

---
# More to know  
## Introduction to Smart Contract Testing

`forge test` will do. You can see more by `forge test --help`.

1. Forge identifies all the files in the test folder, enters the files, and runs the `setUp` function.
2. After setup, it searches for public/external functions that start with `test` and calls each, asserting their results.

---

`forge install` is the command to install dependencies.
For example:

```bash
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 
```

You can specify a branch (e.g., `master`) or a tag (e.g., `v1.2.3.4` or `0.6.1`).
Some dependencies like `forge-std` come preinstalled with `forge init`.

---

## Testing: Crucial Step

Convention: All test files are stored in the `test` folder and named with `.t.sol`.
Import the Foundry test contract helpers:

```solidity
import {Test} from "forge-std/Test.sol";
```

Inherit this in your test contract:

```solidity
contract FundMeTest is Test {
```

The `setUp` function always runs first to perform all prerequisite actions (deployments, user addresses, balances, approvals, etc.).

---

## Writing the Deploy Script

Deploy scripts allow flexibility for different networks.
If contracts have hardcoded addresses (e.g., Sepolia’s AggregatorV3Interface), deploy scripts let you swap them for local/mainnet/others testnets as needed.

Naming convention: `.s.sol`
Import for scripts:

```solidity
import {Script} from "forge-std/Script.sol";
```


---

## Types of Test 

- **Unit tests:** Isolate and test individual functions.
- **Integration tests:** Verify contract interactions with other contracts/external systems.
- **Forking tests:** Use a forked blockchain state for realistic simulation.
- **Staging tests:** Run tests on a deployed contract in a staging environment.

For unit testing:

```bash
forge test --mt <testfunctionname>
```

For forking tests (e.g., for functions needing real-world data). `Forking test` is done when we need we want simulate the real environment.
**Important**
For example here `getVersion` is the function we need forking for. It will fail because we have linked `AggregatorV3Interface` with it, which work with real world data not localy simulated environment. To run this test we need forking:  

1. Add to `.env`:

```bash
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOURAPIKEYWILLGOHERE 
```

2. Run:

```bash
forge test --mt testPriceFeedVersionIsAccurate --fork-url $SEPOLIA_RPC_URL
```


**Note:** Forking uses Alchemy API. Use it sparingly for high coverage.
Check coverage with:

```bash
forge coverage
```


---

## Refactoring Code and Test 

Refactoring means changing code without changing functionality.

Example constructor:

```solidity
constructor(address priceFeed) {
    i_owner = msg.sender;
    s_priceFeed = AggregatorV3Interface(priceFeed);
}
```

Deploy with:

```solidity
FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
```


---

## Importance of Config-Based Mocking in Local Testing 

Using configs (like `HelperConfig`) and mocks:

- Enables chain-agnostic testing (dynamic configs by `block.chainid`)
- Safe refactoring and local testing with Anvil
- Easy support for new networks (just add new config)
- Mocks simulate real contracts for reliable test coverage  

**see in HelperConfig, for Anvil the code is written different using the dependency MockV3Interface.sol**
without file like `HelperConfig` Remember how `testPriceFeedVersionIsAccurate` was always failing when we didn't provide the option `--fork-url $SEPOLIA_RPC_URL`? But with `HelperConfig.s.sol` `Try running `forge test`. Try running `forge test --fork-url $SEPOLIA_RPC_URL`

**A config like HelperConfig.s.sol is essential for local, chain-agnostic testing with mocks. It lets you run forge test without needing a live network or --rpc-url.**

**Key takeaway:** Config and mock systems speed up testing and reflect clean architecture.

---

## Foundry Cheatcodes 

- `expectRevert`
- Prefix storage variables with `s_` for clarity
- Private variables are more gas-efficient than public ones

**User management cheatcodes:**

- [`prank`](https://book.getfoundry.sh/cheatcodes/prank): Sets `msg.sender` for the next call
- [`startPrank`](https://book.getfoundry.sh/cheatcodes/start-prank) / [`stopPrank`](https://book.getfoundry.sh/cheatcodes/stop-prank): Set `msg.sender` for multiple calls
- [`makeAddr`](https://book.getfoundry.sh/reference/forge-std/make-addr?highlight=mak#makeaddr): Create new user addresses

```solidity
address alice = makeAddr("alice");
```

- [`deal`](https://book.getfoundry.sh/cheatcodes/deal): Set ETH balance for an address

```solidity
vm.deal(alice, STARTING_BALANCE);
```


**Testing methodology:**
Arrange-Act-Assert (AAA):

- **Arrange:** Set up variables and preconditions
- **Act:** Execute the function
- **Assert:** Check outputs

[`hoax`](https://book.getfoundry.sh/reference/forge-std/hoax?highlight=hoax#hoax): Combines `deal` and `prank`

```solidity
hoax(address(i), SEND_VALUE);
```

**Multi-Funder Withdrawal Test – Key Learnings:**

- Using `uint160` to simulate addresses avoids unnecessary typecasting since address in Solidity is 20 bytes (same as uint160). This improves gas efficiency and simplifies conversions.
- The `hoax(address, value)` function simplifies tests by combining deal (give ETH) and prank (simulate caller)
- Avoid `address(0)` in funder loops. The loop starts at index 1 to skip address(0), which has special behavior and should be avoided in testing funders.
- Assert contract balance is zero and owner’s balance increases after withdrawal

---

## Chisel

A tool for quickly testing Solidity code snippets locally (Anvil) or on a forked network.
Use `chisel` in your terminal for an interactive Solidity shell.

---

## Calculation of Gas

Run:

```bash
forge snapshot --mt testWithdrawFromASingleFunder
```

This creates a `.gas-snapshot` file with gas usage.

Set gas price:

```solidity
vm.txGasPrice(GAS_PRICE);
```

Calculate gas used:

```solidity
uint256 gasStart = gasleft();
// ... operations ...
uint256 gasEnd = gasleft();
uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
```


---

## Optimizing GAS Consumption by Managing Storage

**Layout of State Variables:**

- Each storage slot is 32 bytes
- Slots start at 0 and are filled contiguously
- Variables <32 bytes can be packed together
- Immutable and constant variables are in bytecode, not storage

Tools:

- `forge inspect <Contract> storageLayout`: View storage layout
- `cast storage <contract_address> <slot_number>`: Read raw storage data
- `vm.load`: Access storage in tests

| Tool | Use Case | Live/Local | Detail Level |
| :-- | :-- | :-- | :-- |
| forge inspect | Understand storage layout | Static (pre-deploy) | High-level |
| cast storage | Read actual storage data | Dynamic (post-deploy) | Low-level (raw data) |
| vm.load | Test stored values | Local test env | Programmatic access |

**Key Takeaway:** Combine these tools for full control over storage understanding and testing.

---

## More Optimization

- Opcodes are EVM instructions; see [EVM opcodes](https://www.evm.codes/)
- MLOAD/MSTORE(min cost 3 gas) is much cheaper than SLOAD/SSTORE(min cost 100 gas)
- Minimize storage reads/writes for gas efficiency
- In loops, cache data structure lengths in a variable before the loop
for example:
in for loops instead of passing the lenght of any data structure in for loop bracket, it is better to access it before of for loop and store it in a variable and then put it in for loop.

---

## ✅ Integration Tests with Foundry

Integration tests verify contract interactions with external systems.

---

### 📁 Folder Setup

- Inside `test` directory:
    - `unit/` for unit tests
    - `integration/` for end-to-end tests
- Move `FundMe.t.sol` to `test/unit/`
- Update import paths as needed
- Run `forge test` to ensure all passes

---

### 📜 Script Setup – Interacting with Deployed Contracts

- Create `Interactions.s.sol` in `script/`
- Add two contracts:
    - `FundFundMe` (calls `fund`)
    - `WithdrawFundMe` (calls `withdraw`)

Install Foundry DevOps:

```bash
forge install Cyfrin/foundry-devops
```


---

### 🧪 Integration Test Example

Create `FundMeTestIntegration.t.sol` in `integration/` folder.

---

### ✅ Run Integration Test

```bash
forge test --mt testUserCanFundAndOwnerWithdraw -vv
```

Expected output:

```text
[PASS] testUserCanFundAndOwnerWithdraw() (gas: ...)
Logs:
  Withdraw FundMe balance!
```


---

### ⚠️ Notes \& Gotchas

#### 🛠 If `foundry-devops` fails to build:

1. In `foundry-devops/src/DevOpsTools.sol`, replace:

```solidity
vm.keyExists(...)
```

with:

```solidity
vm.keyExistsJson(...)
```

2. Ensure `forge-std/Vm.sol` contains `keyExistsJson`. If not:

```bash
forge update --force
```


---

#### 🧨 About FFI (Foreign Function Interface)

- Allows executing shell commands from tests
- Used for custom deployment or fetching external data

> ⚠️ **Risk Alert:**
> If cloning third-party repos, check that:
> - `foundry.toml` does not have `ffi = true`
> - You understand all FFI calls

Read more: [Foundry Book - FFI](https://book.getfoundry.sh/cheatcodes/ffi?highlight=ffi#ffi)

---

## 🏁 Final Thoughts

You can now:

- Interact with deployed contracts via scripts
- Validate end-to-end flows with integration tests
- Stay safe with external code and libraries

---

## Makefile

A `Makefile` automates building and deploying smart contracts.

**Advantages:**

- Automates build/deploy tasks
- Integrates with Foundry commands
- Manages dependencies
- Streamlines workflow

Example:

```makefile
build:
	forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
```

Run with:

```bash
make build
make deploy-sepolia
```


---

## Working with ZKSync 

ZKSync Era VM differs from EVM. See [ZKSync docs](https://docs.zksync.io/build/developer-reference/ethereum-differences/evm-instructions).

**DevOps tools:**

- `foundry-devops`
    - `ZkSyncChainChecker`
    - `FoundryZkSyncChecker`

Install:

```bash
forge install cyfrin/foundry-devops@0.2.2 
```
```bash
import { ZkSyncChainChecker } from "lib/foundry-devops/src/ZkSyncChainChecker.sol";
import { FoundryZkSyncChecker } from "lib/foundry-devops/src/FoundryZkSyncChecker.sol";
```
**Setting Up ZKSyncDevOps**
The file [`test/unit/ZkSyncDevOps.t.sol`](https://github.com/Cyfrin/foundry-fund-me-cu/blob/main/test/unit/ZkSyncDevOps.t.sol) is a minimal test file that shows how tests may fail on the ZKsync VM but pass on an EVM, or vice versa.

Before Running Test:  
- Install any missing dependencies using the command:
```bash
forge install cyfrin/foundry-devops@0.2.2 
```
AND  

```bash
forge install cyfrin/foundry-devops@0.2.2 --no-comm
```

```bash
rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"
```

- Update `.gitignore` with `.DS_store` and `zkout/`.

**VM environment modifiers**
You can switch environments between `fundryup` and `fundryup-zksync` to observe different behaviors of the `ZkSyncDevOps.t.sol` tests. For instance, the following command
```bash
forge test --mt testZkSyncChainFails -vvv
```
will pass in both Foundry environments. However, if you remove the `skipZkSync` modifier, the test will fail on ZKsync because the content of the function is not supported on this chain.

For more details on these modifiers, refer to the [foundry-devops repo](https://github.com/Cyfrin/foundry-devops?tab=readme-ov-file#usage---zksync-checker). The `skipzksync` modifier skips tests on the ZKsync chain, while `onlyzksync` runs tests only on a ZKsync-based chain.  

**Foundry version modifiers:**

- `onlyFoundryZkSync`: Runs tests only if `foundryup--zksync` is active
- `onlyVanillaFoundry`: Runs tests only if `foundryup` is active

> 🗒️ **Note:**
> Ensure `ffi = true` is enabled in `foundry.toml`.

---

<div style="text-align: center">⁂</div>


---

## 🔍 Additional Resources

* [Foundry Book](https://book.getfoundry.sh/)
* [Solidity Docs](https://docs.soliditylang.org/en/latest/)
* [Anvil (Local Ethereum node)](https://book.getfoundry.sh/anvil/)

## ✍️ Author

* [Akshat Odiya](https://github.com/AkshatOdiya)

## ⚠️ License

This project is licensed under the MIT License.
