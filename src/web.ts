import { PluginListenerHandle, WebPlugin } from '@capacitor/core';

import type { CapacitorMunbynPlugin } from './definitions';

export class CapacitorMunbynWeb
  extends WebPlugin
  implements CapacitorMunbynPlugin
{
  // WiFi Methods
  async connect(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async disconnect(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async newLine(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async cut(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async align(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async print(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async setLogo(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async printLogo(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async tableHeader(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async addListener(): Promise<PluginListenerHandle> {
    throw this.unimplemented('Not implemented on web.');
  }

  async fontSize(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async checkConnection(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }
}
