export interface CapacitorMunbynPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
