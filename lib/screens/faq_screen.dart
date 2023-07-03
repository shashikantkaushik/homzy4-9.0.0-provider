import 'package:flutter/material.dart';
class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}
class _FaqScreenState extends State<FaqScreen> {
  final bool customIcon=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Colors.teal,

        title: Text('FAQ',style: TextStyle(fontSize: 22, ),textAlign: TextAlign.center,),
      ),
      body :Container(
        child :ListView(
          children: [
            Column(
              children:[
                ExpansionTile(
                  title: const Text('What services does the homzy provide?',style: TextStyle(fontSize: 18),),
                  children:[
                    ListTile(
                      title: Text('The homzy provides a range of services such as cleaning, plumbing, electrical, beauty'
                          ' services,hair cutting  and many more.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5),),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),

            Column(
              children:[

                ExpansionTile(
                  title: const Text('How do I book a service through the homzy app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('To book a service through the home service app, you need to select the service '
                          'you require and choose subservice ,click on book button, choose a date and time, and enter '
                          'your location and other details and do the payment . You will then be connected to a service'
                          ' provider who will confirm the booking.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5),),

                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('Can I schedule a service for a specific date and time?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('Yes, you can schedule a service for a specific date and time through the '
                          'app. You can choose the preferred time slot when booking the service.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('What are the payment options available in homzy app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('We accept payment from razor pay gateway you can pay there with any such '
                          ' credit/debit cards,UPI id , and net banking. You can choose the payment option that is convenient for you.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('How can I sign up for the app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('You can sign up for the app by downloading it from the googleplay store and'
                          ' creating an account using your email address or phone number.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('How can I upload the image of the thing which is to be repaired? ',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('Once you place the order or request a service by selecting the service you need, '
                          'providing the necessary details such as the address or service location, you will be directed toimage'
                          ' uplaoding option where you can uplaod the image',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('How can I contact customer support for any queries or concerns?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('You can contact customer support through the homzy app'
                          ' help center or support section.Through our provided chat bot you can ask any question regarding the services and you can resolve your queries.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('What should I do if there is an issue with my order or service request?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('If there is any issue with your service request, such as a delay or '
                          'incorrect order, you can contact customer support immediately. The homzy app will provide a '
                          'refund or compensation depending on the issue with considering that given information is true by the app user.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('Is there a loyalty program or rewards program on the app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('Some service apps may offer a loyalty'
                          ' program or rewards program to incentivize users to use the app frequently. You can check the apps features or rewards section'
                          ' to see if such a program is available.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('How can I give feedback or rate the service on the homzy app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('we do not provide feedback or rating of the service on the app '
                          ' to the order or service details and selecting the feedback or rating option. '
                          'Your feedback can not help us to improve the service .',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[
                ExpansionTile(
                  title: const Text('How can I cancel my order or service request on the app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('You can not cancel your order or service request on the app by'
                          'you can deny the provider afterwards when he will contact you for the service,'
                          ' cancellation policies and charges may apply.',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5)),
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[

                ExpansionTile(
                  title: const Text('Is there a loyalty program or rewards program on the app?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('No there is no loyality bonus provided by homzy application',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5),),

                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),
            Column(
              children:[

                ExpansionTile(
                  title: const Text('What should I do if did not contacted me after accepting the request?',style: TextStyle(fontSize: 18)),
                  children:[
                    ListTile(
                      title: Text('You can go to customer support section and register you complain if you had paid the amt then it will be refunded with terms and conditions',style: TextStyle(color: Colors.grey.shade700,fontSize: 15.5),),

                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    //setState(() => customIcon = expanded);
                  },
                )
              ],
            ),

          ],

        ),
      ),
    );
  }
}