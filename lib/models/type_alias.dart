typedef JSONObjectAlias = Map<String, dynamic>;
typedef JSONArrayAlias = List<dynamic>;
typedef Params = Map<String, dynamic>;
typedef ResponseHeader = Map<Object, dynamic>;

mixin JsonData {}

typedef Decoder<T extends Object> = T Function(Object? data);

typedef ResultParser<T> = T Function(Map<String, dynamic> data);
