import { registerPlugin } from '@capacitor/core';

import type { CapacitorMunbynPlugin } from './definitions';

const CapacitorMunbyn = registerPlugin<CapacitorMunbynPlugin>(
  'CapacitorMunbyn',
  {
    web: () => import('./web').then(m => new m.CapacitorMunbynWeb()),
  },
);

export * from './definitions';
export { CapacitorMunbyn };
