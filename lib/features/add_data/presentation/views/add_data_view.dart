import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/features/add_data/presentation/widgets/textfield_with_title_widget.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/home/presentation/widgets/category_segmented_btn_widget.dart';
import 'package:piduiteun/widgets/text_widget.dart';

class AddDataView extends StatelessWidget {
  const AddDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddDataPage();
  }
}

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {

  SegmentedChoice selectedValue = SegmentedChoice.pengeluaran;
  final keteranganEditingController = TextEditingController();
  final nominalEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final timeEditingController = TextEditingController();

  @override
  void initState() {
    dateEditingController.text = 
      DateFormat('dd MMMM yyyy', 'id').format(DateTime.now());
    timeEditingController.text = 
      DateFormat('HH:mm', 'id').format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    keteranganEditingController.dispose();
    nominalEditingController.dispose();
    dateEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah data'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: Column(
          children: [
            SizedBox(
              width: 1.sw,
              child: categorySegmentedBtnWidget(),
            ),
            SizedBox(height: 24.h,),
            keteranganTextfieldWidget(),
            SizedBox(height: 16.h,),
            nominalTextfieldWidget(),
            SizedBox(height: 16.h,),
            dateAndTimeRowWidget(context),
            const Spacer(),
            addInExBtnWidget(context),
          ],
        ),
      ),
    );
  }

  Row dateAndTimeRowWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: selectDateGestureDetectorWidget(context),
        ),
        SizedBox(width: 8.w,),
        Expanded(
          child: selectTimeGestureDetectorWidget(context),
        ),
      ],
    );
  }

  GestureDetector selectTimeGestureDetectorWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTimePicker(
          context: context, 
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
        ).then((value) {
          if(value != null) {
            setState(() {
              timeEditingController.text = value.format(context);
            });
          }
        });
      },
      child: timeTextfieldWidget(),
    );
  }

  GestureDetector selectDateGestureDetectorWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context, 
          initialDate: DateTime.now(), 
          firstDate: DateTime(1900), 
          lastDate: DateTime(2100),
        ).then((value) {
          if(value != null) {
            setState(() {
              dateEditingController.text = 
                DateFormat('dd MMMM yyyy', 'id').format(value);
            });
          }
        });
      },
      child: dateTextfieldWidget(),
    );
  }

  ElevatedButton addInExBtnWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ), 
      child: CustomTextWidget(
        text: selectedValue == SegmentedChoice.pengeluaran ? 
        'Tambah pengeluaran' :
        'Tambah pemasukan',
        size: 14.sp,
        weight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  TextFieldWithTitleWidget timeTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: 'Waktu', 
      textEditingController: timeEditingController,
      errorMessage: 'Waktu todak boleh kosong',
      hint: DateFormat('HH:mm', 'id').format(DateTime.now()),
      isEnabled: false,
    );
  }
  
  TextFieldWithTitleWidget dateTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: 'Tanggal', 
      textEditingController: dateEditingController,
      errorMessage: 'Tanggal todak boleh kosong',
      hint: DateFormat('dd MMMM yyyy', 'id').format(DateTime.now()),
      isEnabled: false,
    );
  }

  TextFieldWithTitleWidget nominalTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: 'Nominal', 
      textEditingController: nominalEditingController,
      errorMessage: 'Nominal todak boleh kosong',
      isCurrency: true,
      textInputType: TextInputType.number,
      hint: 'Contoh. 500000',
    );
  }

  TextFieldWithTitleWidget keteranganTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: 'Keterangan', 
      textEditingController: keteranganEditingController,
      errorMessage: 'Keterangan tidak boleh kosong',
      hint: 'Contoh. Ayam geprek',
    );
  }

  CategorySegmentedBtnWidget categorySegmentedBtnWidget() {
    return CategorySegmentedBtnWidget(
      selectedValue: <SegmentedChoice>{selectedValue}, 
      onSelectionChanged: (value) {
        setState(() {
          selectedValue = value.first;
        });
      },
    );
  }
}
