class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @overirde
  FormWidgetState createState() {
    return FormWidgetState();
  }
}

class FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key : _formKey,
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.start,
        children : [
          TextFormField(
            validator : (value) {
              if(value == null || value.isEmpty){
                return 'need text';
              }
              return null;
            },
          ),
          Padding (
            padding : const 
          ),
        ]
      )
    )
  }
}
