import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:piduiteun/features/add_data/domain/entities/expenditure.dart';
import 'package:piduiteun/features/add_data/presentation/bloc/add_data_bloc.dart';
import 'package:piduiteun/features/add_data/presentation/widgets/textfield_with_title_widget.dart';
import 'package:piduiteun/features/home/domain/entities/category.dart';
import 'package:piduiteun/features/home/domain/entities/segmented_choice.dart';
import 'package:piduiteun/features/home/presentation/bloc/home_bloc.dart';
import 'package:piduiteun/features/home/presentation/cubit/in_ex_summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/cubit/summary_cubit.dart';
import 'package:piduiteun/features/home/presentation/widgets/category_segmented_btn_widget.dart';
import 'package:piduiteun/injection_container.dart';
import 'package:piduiteun/l10n/l10n.dart';
import 'package:piduiteun/widgets/text_widget.dart';

class AddDataView extends StatelessWidget {
  const AddDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddDataBloc>(),
      child: const AddDataPage(),
    );
  }
}

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  SegmentedChoice selectedValue = SegmentedChoice.expense;
  final keteranganEditingController = TextEditingController();
  final nominalEditingController = TextEditingController();
  final dateEditingController = TextEditingController(
    text: DateFormat('dd MMMM yyyy').format(DateTime.now()),
  );
  final timeEditingController = TextEditingController(
    text: DateFormat('dd MMMM yyyy').format(DateTime.now()),
  );

  final formKey = GlobalKey<FormState>();


  DateTime dateTime = DateTime.now();
  String? chipValue;

  @override
  void initState() {
    dateEditingController.text =
        DateFormat('dd MMMM yyyy').format(DateTime.now());
    timeEditingController.text =
        DateFormat('HH:mm').format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    keteranganEditingController.dispose();
    nominalEditingController.dispose();
    dateEditingController.dispose();
    timeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addDataAppBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 1.sw,
                child: categorySegmentedBtnWidget(),
              ),
              SizedBox(height: 24.h),
              keteranganTextfieldWidget(),
              SizedBox(height: 16.h),
              nominalTextfieldWidget(),
              SizedBox(height: 16.h),
              dateAndTimeRowWidget(context),
              SizedBox(height: 16.h),
              kategoriTextWidget(),
              if (selectedValue == SegmentedChoice.expense)
                categoryExWrapWidget(context)
              else
                categoryInWrapWidget(context),
              const Spacer(),
              addDataBlocListener(context),
            ],
          ),
        ),
      ),
    );
  }

  BlocListener<AddDataBloc, AddDataState> addDataBlocListener(
    BuildContext context,
  ) {
    return BlocListener<AddDataBloc, AddDataState>(
      listener: (context, state) {
        if(state is AddDataSucceed){
          showDialog<String>(
            context: context, 
            builder: (_) {
              return AlertDialog(
                title: const Text('Berhasil'),
                content: const Text('Data pengeluaran berhasil ditambahkan'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(), 
                    child: const Text('kembali'),
                  ),
                ],
              );
            },
          ).then((_){
            nominalEditingController.clear();
            dateEditingController.text =
                DateFormat('dd MMMM yyyy', 'id').format(DateTime.now());
            timeEditingController.text =
                DateFormat('HH:mm', 'id').format(DateTime.now());
            keteranganEditingController.clear();
            chipValue = null;
          });
          //add event to homeBloc
          context.read<HomeBloc>().add(GetExDataEvent());
          context.read<SummaryCubit>().thisMonthSummaryEvent();
          context.read<InExSummaryCubit>().inExSummEvent();
        } else if (state is AddDataFailed){
          showDialog<String>(
            context: context, 
            builder: (_) {
              return AlertDialog.adaptive(
                title: const Text('Gagal'),
                content: Text(state.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(), 
                    child: const Text('kembali'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: addInExBtnWidget(context),
    );
  }

  Wrap categoryInWrapWidget(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: [
        ChoiceChip(
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          side: BorderSide.none,
          label: const Text('Salary'),
          selected: chipValue == 'Salary',
          onSelected: (value) {
            setState(() {
              chipValue = value ? 'Salary' : null;
            });
          },
        ),
      ],
    );
  }

  Wrap categoryExWrapWidget(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: ExpanseCategory.values.map((e) {
        return ChoiceChip(
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          side: BorderSide.none,
          label: Text(e.name),
          selected: chipValue == e.name,
          onSelected: (value) {
            setState(() {
              chipValue = value ? e.name : null;
            });
          },
        );
      }).toList(),
    );
  }

  CustomTextWidget kategoriTextWidget() {
    return CustomTextWidget(
      text: context.l10n.category,
      size: 14.sp,
      weight: FontWeight.w500,
    );
  }

  Row dateAndTimeRowWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: selectDateGestureDetectorWidget(context),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: selectTimeGestureDetectorWidget(context),
        ),
      ],
    );
  }

  MediaQuery selectTimeGestureDetectorWidget(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        alwaysUse24HourFormat: true,
      ),
      child: GestureDetector(
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.inputOnly,
          ).then((value) {
            if (value != null) {
              setState(() {
                timeEditingController.text = value.format(context);
              });
            }
          });
        },
        child: timeTextfieldWidget(),
      ),
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
          if (value != null) {
            setState(() {
              dateEditingController.text =
                  DateFormat('dd MMMM yyyy').format(value);
              dateTime = value;
            });
          }
        });
      },
      child: dateTextfieldWidget(),
    );
  }

  Widget addInExBtnWidget(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1.sw,
        height: 48.h,
        child: ElevatedButton(
          onPressed: () {
            if(chipValue == null){
              showDialog<String>(
                context: context, 
                builder: (_){
                  return AlertDialog(
                    title: Text(context.l10n.genericErrorMessage),
                    content: Text(context.l10n.categoryErrorMessage),
                    actions: [
                      GestureDetector(
                        onTap: ()=> context.pop(),
                        child: Text(context.l10n.back),
                      ),
                    ],
                  );
                },
              );
            }
            if(formKey.currentState!.validate()){
              if(selectedValue == SegmentedChoice.expense){
                context.read<AddDataBloc>().add(
                  AddExDataEvent(
                    expenditure: Expenditure(
                      expenditure: int.parse(
                        nominalEditingController.text.replaceAll('.', ''),
                      ),
                      dateTime: dateTime, 
                      information: keteranganEditingController.text, 
                      time: timeEditingController.text, 
                      tag: chipValue!,
                    ),
                  ),
                );
              } else {
                context.read<AddDataBloc>().add(
                  AddInDataEvent(
                    expenditure: Expenditure(
                      expenditure: int.parse(
                        nominalEditingController.text.replaceAll('.', ''),
                      ),
                      dateTime: dateTime, 
                      information: keteranganEditingController.text, 
                      time: timeEditingController.text, 
                      tag: chipValue!,
                    ),
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: CustomTextWidget(
            text: selectedValue == SegmentedChoice.expense
                ? '${context.l10n.addBtnText} ${context.l10n.expenses}'
                : '${context.l10n.addBtnText} ${context.l10n.income}',
            size: 14.sp,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  TextFieldWithTitleWidget timeTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: context.l10n.time,
      textEditingController: timeEditingController,
      errorMessage: context.l10n.timeErrorMessage,
      hint: DateFormat('HH:mm', 'id').format(DateTime.now()),
      isEnabled: false,
    );
  }

  TextFieldWithTitleWidget dateTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: context.l10n.date,
      textEditingController: dateEditingController,
      errorMessage: context.l10n.dateErrorMessage,
      hint: DateFormat('dd MMMM yyyy').format(DateTime.now()),
      isEnabled: false,
    );
  }

  TextFieldWithTitleWidget nominalTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: 'Nominal',
      textEditingController: nominalEditingController,
      errorMessage: context.l10n.nominalErrorMessage,
      isCurrency: true,
      textInputType: TextInputType.number,
      hint: '${context.l10n.eg} 500000',
      prefix: Container(
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(223, 228, 218, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            bottomLeft: Radius.circular(8.r),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 4.h, horizontal: 12.w,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(210, 215, 200, 1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: const Text('Rp. '),
        ),
      ),
    );
  }

  TextFieldWithTitleWidget keteranganTextfieldWidget() {
    return TextFieldWithTitleWidget(
      title: context.l10n.description,
      textEditingController: keteranganEditingController,
      errorMessage: context.l10n.descriptionErrorMessage,
      hint: '${context.l10n.eg} Ayam geprek',
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
