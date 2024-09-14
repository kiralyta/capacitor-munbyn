import { WebPlugin } from '@capacitor/core';

import type { CapacitorMunbynPlugin } from './definitions';

export class CapacitorMunbynWeb
  extends WebPlugin
  implements CapacitorMunbynPlugin
{
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
