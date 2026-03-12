import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../common/constants/app_strings.dart';
import '../models/drawing_stroke_model.dart';

abstract class IDrawingRemoteDataSource {
  Future<void> sendStroke(String roomId, DrawingStrokeModel stroke);
  Stream<List<DrawingStrokeModel>> watchCanvas(String roomId);
  Future<void> clearCanvas(String roomId);
}

class DrawingRemoteDataSourceImpl implements IDrawingRemoteDataSource {
  final FirebaseFirestore _firestore;
  DrawingRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> clearCanvas(String roomId) async {
    final strokes = await _firestore
        .collection(AppStrings.roomsPath)
        .doc(roomId)
        .collection(AppStrings.strokesPath)
        .get();

    final batch = _firestore.batch();
    for (var doc in strokes.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  @override
  Future<void> sendStroke(String roomId, DrawingStrokeModel stroke) async {
    await _firestore
        .collection(AppStrings.roomsPath)
        .doc(roomId)
        .collection(AppStrings.strokesPath)
        .add(stroke.toMap());
  }

  @override
  Stream<List<DrawingStrokeModel>> watchCanvas(String roomId) {
    return _firestore
        .collection(AppStrings.roomsPath)
        .doc(roomId)
        .collection(AppStrings.strokesPath)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return DrawingStrokeModel.fromMap(doc.data());
          }).toList();
        });
  }
}
