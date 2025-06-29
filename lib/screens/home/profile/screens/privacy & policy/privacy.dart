import 'package:dawini/const/colors.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    Widget sectionTitle(String title) => Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: TColors.labeltext,
        ),
      ),
    );

    Widget sectionParagraph(String content) => Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15.sp,
          color: TColors.labeltext,
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        appBar: AppBar(
          title: Text(
            "سياسة الخصوصية والشروط",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: TColors.labeltext,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: TColors.labeltext.withOpacity(0.3),
                    width: 2.0,
                  ),
                ),
                child: Icon(Icons.arrow_back, color: TColors.labeltext),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("1. المقدمة"),
              sectionParagraph(
                "يهدف هذا التطبيق إلى تسهيل حجز مواعيد الأطباء في الجزائر بطريقة آمنة وسهلة.",
              ),

              sectionTitle("2. أهلية الاستخدام"),
              sectionParagraph(
                "يجب أن يكون المستخدم بالغًا أو بإذن من ولي أمره لاستخدام التطبيق.",
              ),

              sectionTitle("3. سياسة الخصوصية"),
              sectionParagraph(
                "نلتزم بحماية بيانات المستخدمين وفقًا للقوانين الجزائرية والمعايير الدولية.",
              ),

              sectionTitle("3.1 المعلومات التي نجمعها"),
              sectionParagraph(
                "نقوم بجمع معلومات مثل الاسم، رقم الهاتف، العنوان، الأعراض، وسجل المواعيد.",
              ),

              sectionTitle("3.2 كيفية استخدام المعلومات"),
              sectionParagraph(
                "نستخدم المعلومات فقط لأغراض الحجز والتذكير وتحسين تجربة المستخدم.",
              ),

              sectionTitle("3.3 مشاركة البيانات"),
              sectionParagraph(
                "لا نشارك بياناتك إلا مع الأطباء الذين تقوم بالحجز لديهم، ولا نبيعها لأي جهة.",
              ),

              sectionTitle("3.4 أمان البيانات"),
              sectionParagraph(
                "نستخدم تقنيات تشفير حديثة وخوادم آمنة لضمان حماية البيانات.",
              ),

              sectionTitle("3.5 حقوق المستخدم"),
              sectionParagraph(
                "لك الحق في الوصول إلى بياناتك، تعديلها، أو حذفها عند الطلب.",
              ),

              sectionTitle("4. شروط الحجز واستخدام التطبيق"),
              sectionParagraph(
                "يمكن للمستخدم اختيار الطبيب المناسب وحجز الموعد حسب التوفر.",
              ),

              sectionTitle("4.2 مسؤوليات المستخدم"),
              sectionParagraph(
                "يجب تقديم معلومات دقيقة والالتزام بالمواعيد المحجوزة.",
              ),

              sectionTitle("5. سياسة الإلغاء"),
              sectionParagraph(
                "يمكن للمستخدم إلغاء الموعد قبل 12 ساعة بدون رسوم.",
              ),

              sectionTitle("5.1 الإلغاء من قبل المستخدم"),
              sectionParagraph(
                "الإلغاء المتكرر أو المتأخر قد يؤدي إلى تعليق مؤقت للحساب.",
              ),

              sectionTitle("5.2 الإلغاء من قبل الطبيب"),
              sectionParagraph(
                "قد يتم إلغاء الموعد في الحالات الطارئة، وسيتم إعلام المستخدم.",
              ),

              sectionTitle("6. الرسوم والدفع"),
              sectionParagraph(
                "حجز الموعد مجاني، أما رسوم الاستشارة فهي من صلاحيات الطبيب.",
              ),

              sectionTitle("7. تعليق الحساب أو إنهاؤه"),
              sectionParagraph(
                "نحتفظ بالحق في تعليق أو إنهاء الحساب عند إساءة الاستخدام.",
              ),

              sectionTitle("8. حدود المسؤولية"),
              sectionParagraph(
                "نحن مجرد منصة للحجز ولسنا مسؤولين عن التقييم أو نتائج العلاج.",
              ),

              sectionTitle("9. التعديلات والتحديثات"),
              sectionParagraph(
                "قد نقوم بتحديث هذه السياسة، وسيتم إعلام المستخدمين بأي تغييرات.",
              ),

              sectionTitle("10. القانون والاختصاص القضائي"),
              sectionParagraph(
                "تخضع هذه الشروط للقوانين الجزائرية، والمحاكم الجزائرية هي المختصة.",
              ),

              sectionTitle("11. اتصل بنا"),
              sectionParagraph(
                "لأي استفسار، يمكنكم التواصل معنا عبر البريد الإلكتروني أو الهاتف.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
