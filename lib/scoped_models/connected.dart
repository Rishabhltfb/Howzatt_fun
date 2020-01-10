import 'package:scoped_model/scoped_model.dart';

import '../models/entry.dart';

class Connected extends Model {
  List<Entry> _entries = [];
  String _selEntryId;
  bool _isLoading = false;
}
