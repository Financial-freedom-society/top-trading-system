# CURSOR.md

This file provides guidance to Cursor when working with code in this repository.

## Repository Overview

This is NautilusTrader, a high-performance algorithmic trading platform and event-driven backtester. The platform combines a Rust core for performance-critical components with Python bindings for ease of use, providing quantitative traders with the ability to backtest and deploy trading strategies with identical code paths between backtesting and live trading.

## 🎯 PRIMARY DOCUMENTATION REFERENCE

**🔒 UNBREAKABLE RULE**: Before working on ANY component or task in this repository, you MUST ALWAYS start with the comprehensive documentation index. This rule is enforced in `docs/documentation-first-rule.md` and `.bmad-core/core-config.yaml`.

### [`docs/index.md`](docs/index.md) - Your Essential Navigation Hub

This index catalogs all 88 documentation files and serves as your roadmap for understanding and modifying any part of NautilusTrader. 

### Task-Based Documentation Workflow

**When working on repository components, follow this systematic approach:**

1. **Start with `docs/index.md`** - Identify the relevant documentation category
2. **Navigate to specific documentation** - Follow the index guidance to find detailed information
3. **Process and understand** - Read the relevant docs before making changes
4. **Apply knowledge** - Use documentation insights for implementation

### Examples of Documentation-Driven Development

**Example 1: Working with Events**
- Task: Create/modify event-related functionality
- Process: `docs/index.md` → API Reference → `docs/api_reference/model/events.md`
- Understand: Event-driven architecture, OrderEvent, PositionEvent, AccountEvent patterns
- Apply: Use learned patterns for new event implementations

**Example 2: Adding Exchange Integration** 
- Task: Create new exchange adapter
- Process: `docs/index.md` → Concepts → `docs/concepts/adapters.md` + Integrations → `docs/integrations/index.md`
- Understand: Adapter patterns, API unification standards, integration requirements
- Apply: Follow established patterns for new exchange integration

**Example 3: Strategy Development**
- Task: Implement trading strategy  
- Process: `docs/index.md` → Concepts → `docs/concepts/strategies.md` + API Reference → `docs/api_reference/trading.md`
- Understand: Strategy framework, event-driven patterns, execution flow
- Apply: Build strategy using documented patterns and APIs

**Example 4: Data Processing**
- Task: Handle custom market data
- Process: `docs/index.md` → Concepts → `docs/concepts/data.md` + API Reference → `docs/api_reference/model/data.md`
- Understand: Data types, aggregation patterns, custom data handling
- Apply: Implement data processing following established patterns

### Multi-Agent Collaboration

**When working with specialized agents, ensure they:**
1. **Start with `docs/index.md`** for component understanding
2. **Follow documentation-first approach** before code changes
3. **Cross-reference multiple documentation sources** (Concepts + API Reference + Integrations)
4. **Validate against established patterns** documented in the guides

### Documentation Categories Quick Reference

- **Getting Started** → New user setup, installation, first backtest
- **Concepts** → Architectural understanding, design patterns, workflows  
- **API Reference** → Specific implementation details, class/method documentation
- **Developer Guide** → Development environment, coding standards, testing
- **Integrations** → Exchange adapters, data providers, real-world connectivity
- **Tutorials** → Hands-on examples, interactive learning

**Remember**: The documentation index is not just a reference—it's your strategic tool for understanding how every piece of NautilusTrader fits together before making changes.

## Architecture Overview

NautilusTrader follows a hybrid Rust/Python architecture based on Domain-Driven Design (DDD), event-driven architecture, messaging patterns, and ports-and-adapters patterns:

**Rust Core (`crates/`)**: Performance-critical components written in Rust including:
- `core`: Foundational types, time handling, UUID generation, mathematical functions, correctness validation
- `model`: Rich trading domain models (instruments, orders, positions, events) with type safety
- `backtest`: High-performance backtesting engine with realistic matching engines and order book simulation
- `execution`: Order execution management, routing, and lifecycle tracking
- `data`: Market data aggregation, processing, and real-time streaming
- `network`: High-performance networking with WebSocket/HTTP clients using tokio async runtime
- `adapters`: Exchange-specific implementations (Databento, Binance, Bybit, Interactive Brokers, etc.)

**Python Bindings (`nautilus_trader/`)**: Python interface using Cython and PyO3:
- Wraps Rust core functionality for Python accessibility with zero-copy data sharing
- Strategy development framework with comprehensive examples and patterns
- Configuration management and system orchestration via NautilusKernel
- Live trading and backtesting node builders with unified APIs

**Event-Driven Architecture**: Single-threaded message-passing system via MessageBus enabling:
- Deterministic execution and reproducible backtests
- Real-time data processing with nanosecond-precision timestamping
- Pub/Sub, Request/Response, and Command/Event messaging patterns
- Optional Redis-backed state persistence for crash recovery

**Core System Components**:
- `NautilusKernel`: Central orchestration and lifecycle management
- `MessageBus`: High-performance inter-component communication backbone
- `Cache`: In-memory storage for instruments, accounts, orders, and positions
- `DataEngine`: Market data processing and routing with multi-source support
- `ExecutionEngine`: Order lifecycle management and venue routing
- `RiskEngine`: Pre-trade risk checks and real-time position monitoring

## Development Environment Setup

### Prerequisites
- **Rust toolchain**: Install via rustup (https://rustup.rs/)
- **Python**: Managed via uv package manager (preferred)
- **IDE**: PyCharm Professional (for Cython support) or VS Code with Cython extension
- **Clang**: Required for compilation on all platforms

### Initial Setup
```bash
# Complete development setup
make install-debug           # Install in debug mode (faster compilation)
pre-commit install          # Enable pre-commit hooks
```

### Development Services
```bash
# PostgreSQL and Redis for integration testing
make init-services          # Start containers and setup database
make stop-services          # Stop containers (preserves data)
make purge-services         # Remove containers and volumes
```

## Development Workflow Commands

### Primary Build System
The comprehensive `Makefile` provides all essential commands:

```bash
# Installation & Building
make install-debug        # Install in debug mode for development (recommended)
make install             # Install in release mode with all dependencies
make build-debug         # Build in debug mode (significantly faster compilation)
make build               # Build package in release mode
make clean               # Clean all build artifacts and caches

# Testing
make cargo-test          # Run Rust tests using cargo-nextest (isolated parallel execution)
make pytest              # Run Python tests with pytest
make test-performance    # Run performance benchmarks with CodSpeed

# Code Quality & Formatting
make format              # Format Rust code using nightly formatter
make ruff                # Run Python linting with automatic fixes  
make clippy              # Run Rust linting with automatic fixes
make pre-commit          # Run all pre-commit hooks on all files
```

### Advanced Rust Development
```bash
# Targeted testing
make cargo-test-crate-nautilus-model    # Test specific crate
make cargo-test-lib                     # Library tests only (faster)
make cargo-test-debug                   # Debug mode tests with symbols

# Performance & Benchmarking
make cargo-ci-benches                   # Run criterion benchmarks for CI

# Development verification
make check-features                     # Verify all feature combinations compile
make clippy-crate-<name>               # Run clippy on specific crate
```

### Precision Modes & Feature Flags
**Precision modes** (affects Price, Quantity, Money types):
- **High-precision** (default): 128-bit integers, up to 16 decimals (Linux/macOS)
- **Standard-precision**: 64-bit integers, up to 9 decimals (Windows only)

**Key feature flags**:
- `high-precision`: Enable 128-bit precision mode
- `ffi`: C foreign function interface
- `python`: Python bindings via PyO3
- `defi`: DeFi/blockchain functionality

### Environment Variables & Build Optimization
```bash
BUILD_MODE=debug|release     # Compilation optimization (debug recommended for development)
HIGH_PRECISION=true|false    # Enable 128-bit precision (default: true)
VERBOSE=false               # Reduce build output for cleaner console
PARALLEL_BUILD=true         # Enable parallel compilation (default)
RUSTUP_TOOLCHAIN=nightly    # Use nightly toolchain for faster builds with cranelift
```

### Development Tools & Integrations

**Package Management**:
- **uv**: Primary tool for Python dependencies and virtual environments
- **Cargo**: Rust dependency management with workspace support
- **Poetry**: Build backend (transitioning to uv)

**Testing Strategy**:
- **cargo-nextest**: Rust test runner with process isolation for reliability
- **pytest**: Python testing with comprehensive fixtures and parametrization
- **Coverage**: Both Rust (cargo-llvm-cov) and Python (coverage.py) reporting
- **Performance**: CodSpeed for benchmark regression detection

**IDE Configuration**: Pre-configured settings available in docs for:
- VSCode with rust-analyzer optimizations
- Astro Nvim with optimized LSP settings
- PyCharm Professional for Cython development

## Coding Standards & Best Practices

### Code Style (Universal)
- **Spaces only**, never tabs (enforced by formatters)
- **100 character line limit** with thoughtful wrapping
- **American English spelling** (color, serialize, behavior)

### Python/Cython Guidelines
- **Type annotations required** for all function/method signatures
- **NumPy docstring format** throughout codebase
- **Imperative mood** for Python docstrings ("Return a client")
- Use `is None` / `is not None` for explicit None checks (Cython optimization)
- Comprehensive type hints with generics where appropriate

### Rust Guidelines  
- **Indicative mood** for doc comments ("Returns a client")
- **Zero unsafe code** outside explicitly marked sections
- **Comprehensive error handling** with proper error types
- **Feature flags** to control compilation scope

### Commit Standards
- **60 character subject limit** with imperative voice
- **Capitalize subject line**, no ending period
- **Optional body** with 100 character width, bullet points acceptable

## System Architecture Deep Dive

### Environment Contexts
- **Backtest**: Historical data with simulated venues and deterministic execution
- **Sandbox**: Real-time data with simulated venues for strategy validation  
- **Live**: Real-time data with live venues (paper trading or real accounts)

### Component State Lifecycle
All components follow finite state machine patterns:
`PRE_INITIALIZED` → `READY` → `RUNNING` → `STOPPED` / `DEGRADED` / `FAULTED` → `DISPOSED`

### Data & Execution Flow Patterns
**Data Flow**: External ingestion → DataEngine processing → Cache storage → MessageBus events → Consumer delivery
**Execution Flow**: Strategy commands → MessageBus → RiskEngine validation → ExecutionEngine routing → External submission → Event feedback

### Type Safety & Memory Management
- **Rust core**: Memory-safe and type-safe by construction (compiler guaranteed)
- **Cython layer**: Runtime type checking with TypeError/ValueError on invalid types
- **Zero-copy data sharing** between Rust and Python where possible

## Integration & Adapter Development

**Adapter Pattern**: Each exchange integration implements standardized traits:
- Rust adapters in `crates/adapters/` for performance-critical operations
- Python configuration in `nautilus_trader/adapters/` for ease of use
- Support for REST APIs, WebSocket feeds, and FIX protocols
- Real-time order book management with tick-level precision

## Strategy Development Patterns

**Strategy Options**:
- **Python strategies**: Rapid prototyping in `nautilus_trader/examples/strategies/`
- **Cython strategies**: High-performance implementations with C-level optimization
- **Actor pattern**: Custom components extending base Actor class

**Key Features**:
- **Event-driven**: Strategies respond to market data, execution events, and timers
- **Deterministic backtesting**: Identical code paths between backtest and live
- **Nanosecond precision**: High-resolution timing for tick-level analysis
- **Risk integration**: Built-in risk checks and position management

## API Reference Structure

The NautilusTrader Python API is organized into logical modules with comprehensive Sphinx-generated documentation:

### Core Modules

**`nautilus_trader.model`**: Rich trading domain model
- **`instruments`**: Multi-asset instrument types (CryptoPerpetual, Equity, FuturesContract, OptionContract, CurrencyPair, etc.)
- **`orders`**: Complete order type hierarchy (Market, Limit, StopMarket, StopLimit, TrailingStop, etc.)
- **`data`**: Market data types (Bar, QuoteTick, TradeTick, OrderBookSnapshot, etc.)
- **`events`**: Event-driven architecture events (OrderEvent, PositionEvent, AccountEvent, etc.)
- **`identifiers`**: Type-safe identifier system (InstrumentId, StrategyId, OrderId, etc.)
- **`objects`**: Value objects (Money, Price, Quantity, etc.) with precision mode support

**`nautilus_trader.data`**: Market data processing stack
- **`aggregation`**: Real-time bar and data aggregation with customizable intervals
- **`client`**: Base data client for adapter implementations
- **`engine`**: DataEngine for processing and routing market data events
- **`messages`**: Data-related command and event messages

**`nautilus_trader.execution`**: Order execution and management
- **`engine`**: ExecutionEngine for order lifecycle management
- **`client`**: Base execution client for venue adapters
- **`algorithm`**: Execution algorithms (TWAP, etc.) 
- **`emulator`**: Local order emulation for advanced order types
- **`matching_core`**: High-performance order matching engine
- **`reports`**: Execution and trade reporting

**`nautilus_trader.backtest`**: Backtesting infrastructure
- **`engine`**: BacktestEngine with realistic venue simulation
- **`node`**: Complete backtesting node for strategy evaluation
- **`results`**: Comprehensive backtesting results and analytics
- **`models`**: Venue and fill models for realistic simulation

### Component Modules

**`nautilus_trader.trading`**: Strategy development framework
- **`strategy`**: Base Strategy class with event-driven architecture
- **`trader`**: Trader class for live execution management
- **`controller`**: Controller for managing multiple strategies

**`nautilus_trader.indicators`**: High-performance technical indicators
- **Moving Averages**: SMA, EMA, WMA, HMA, AMA with factory pattern
- **Oscillators**: RSI, MACD, Stochastics, CCI, ROC
- **Channels**: Bollinger Bands, Keltner Channel, Donchian Channel
- **Volume**: OBV, Pressure, VWAP
- **Custom**: Spread Analyzer, Volatility Ratio, Swings, Fuzzy Candlesticks

**`nautilus_trader.adapters`**: Exchange and data provider integrations
- **Live Venues**: Binance, Bybit, Interactive Brokers, dYdX, Coinbase INTX, etc.
- **Data Providers**: Databento, Tardis Machine
- **Betting**: Betfair exchange integration
- **Template**: Base adapter implementation patterns

**`nautilus_trader.analysis`**: Performance analytics
- **Statistics**: Win rate, Sharpe ratio, drawdown, profit factor, expectancy
- **Reporting**: Automated performance report generation
- **Analysis**: Portfolio and strategy performance analysis

### Infrastructure Modules

**`nautilus_trader.cache`**: High-performance caching layer
- In-memory storage for instruments, accounts, orders, positions
- Redis backend support for persistence
- Optimized read/write access patterns

**`nautilus_trader.portfolio`**: Portfolio and risk management
- Real-time position tracking and PnL calculation
- Multi-currency and cross-asset portfolio management
- Risk metrics and exposure monitoring

**`nautilus_trader.persistence`**: Data storage and retrieval
- **Catalog**: Data cataloging system with Parquet support
- **Wranglers**: Data transformation and loading utilities
- **Storage**: Efficient data storage for backtesting and analysis

**`nautilus_trader.serialization`**: Data serialization
- High-performance binary serialization
- Arrow-based columnar data processing
- Message serialization for persistence and transport

### Usage Patterns

**Strategy Development**:
```python
from nautilus_trader.trading.strategy import Strategy
from nautilus_trader.model.data import Bar
from nautilus_trader.indicators import ExponentialMovingAverage

class MyStrategy(Strategy):
    def on_start(self):
        self.ema = ExponentialMovingAverage(14)
    
    def on_bar(self, bar: Bar):
        self.ema.update(bar.close)
        # Strategy logic here
```

**Backtesting**:
```python
from nautilus_trader.backtest import BacktestNode
from nautilus_trader.config import BacktestConfig

config = BacktestConfig(...)  # Configuration
node = BacktestNode(config=config)
results = node.run()  # Execute backtest
```

**Live Trading**:
```python
from nautilus_trader.live import LiveNode  
from nautilus_trader.config import LiveConfig

config = LiveConfig(...)  # Configuration
node = LiveNode(config=config)
node.run()  # Execute live trading
```

## Critical Development Notes

- **Always use `make build-debug` for development** (significantly faster compilation)
- **Run tests before commits**: Both `make cargo-test` and `make pytest` must pass
- **Single-threaded design**: Optimal performance through deterministic execution
- **Crash-only design**: Components designed for clean restart capabilities  
- **Type safety priority**: Compile-time correctness prevents runtime errors
- **Platform portability**: Must compile and run on Linux, macOS, and Windows
- **API Documentation**: Auto-generated from docstrings using Sphinx with NumPy format
- **Versioning**: Separate API references for latest stable and nightly development branches