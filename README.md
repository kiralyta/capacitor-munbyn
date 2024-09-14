# capacitor-munbyn

A Capacitor.js bridge to Munbyn ITPP047 pos thermal printer.

## Install

```bash
npm install capacitor-munbyn
npx cap sync
```

## API

<docgen-index>

* [`connect(...)`](#connect)
* [`disconnect()`](#disconnect)
* [`newLine()`](#newline)
* [`cut()`](#cut)
* [`print(...)`](#print)
* [`addListener('wifiConnected', ...)`](#addlistenerwificonnected-)
* [`addListener('wifiDataWritten', ...)`](#addlistenerwifidatawritten-)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### connect(...)

```typescript
connect(options: ConnectWiFiOptions) => Promise<void>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#connectwifioptions">ConnectWiFiOptions</a></code> |

--------------------


### disconnect()

```typescript
disconnect() => Promise<void>
```

--------------------


### newLine()

```typescript
newLine() => Promise<void>
```

--------------------


### cut()

```typescript
cut() => Promise<void>
```

--------------------


### print(...)

```typescript
print(options: SendCommandOptions) => Promise<void>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#sendcommandoptions">SendCommandOptions</a></code> |

--------------------


### addListener('wifiConnected', ...)

```typescript
addListener(eventName: 'wifiConnected', listenerFunc: (result: WiFiConnectedResult) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                     |
| ------------------ | ---------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'wifiConnected'</code>                                                             |
| **`listenerFunc`** | <code>(result: <a href="#wificonnectedresult">WiFiConnectedResult</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('wifiDataWritten', ...)

```typescript
addListener(eventName: 'wifiDataWritten', listenerFunc: (result: WiFiDataWrittenResult) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                                         |
| ------------------ | -------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'wifiDataWritten'</code>                                                               |
| **`listenerFunc`** | <code>(result: <a href="#wifidatawrittenresult">WiFiDataWrittenResult</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### Interfaces


#### ConnectWiFiOptions

| Prop       | Type                |
| ---------- | ------------------- |
| **`host`** | <code>string</code> |
| **`port`** | <code>number</code> |


#### SendCommandOptions

| Prop       | Type                |
| ---------- | ------------------- |
| **`text`** | <code>string</code> |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### WiFiConnectedResult

| Prop       | Type                |
| ---------- | ------------------- |
| **`host`** | <code>string</code> |
| **`port`** | <code>number</code> |


#### WiFiDataWrittenResult

| Prop      | Type                |
| --------- | ------------------- |
| **`tag`** | <code>number</code> |

</docgen-api>
