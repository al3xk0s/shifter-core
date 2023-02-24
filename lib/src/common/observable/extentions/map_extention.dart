extension MapExt<K, V> on Map<K, V> {
  void put(K key, V value) => this[key] = value;
}