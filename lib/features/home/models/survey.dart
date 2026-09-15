/// نموذج الاستبيان المعروض في الصفحة الرئيسية.
class Survey {
  const Survey({
    required this.id,
    required this.title,
    required this.field,
    required this.researcher,
    required this.organization,
    required this.minutes,
    required this.questions,
    required this.reward,
    required this.joined,
    required this.target,
    this.closesIn,
  });

  final String id;
  final String title;
  final String field; // المجال: نفسي، صحي، تعليمي...
  final String researcher;
  final String organization;
  final int minutes; // مدة التعبئة
  final int questions;
  final int reward; // المقابل بالريال
  final int joined; // عدد من شارك
  final int target; // حجم العيّنة المطلوب
  final String? closesIn; // الوقت المتبقي قبل الإغلاق

  /// نسبة اكتمال العيّنة (0 إلى 1).
  double get fillRatio {
    if (target <= 0) return 0;
    return (joined / target).clamp(0.0, 1.0).toDouble();
  }

  int get fillPercent => (fillRatio * 100).round();

  /// كم مشارك ناقص لاكتمال العيّنة.
  int get remaining => (target - joined) < 0 ? 0 : target - joined;
}
