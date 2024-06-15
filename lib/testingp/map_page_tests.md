The Old Container for the Current Location:

Container(
                          
                          height: MediaQuery.of(context).size.width * 0.125,
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.centerLeft,
                          //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 188, 231, 195),
                              borderRadius: BorderRadius.circular(50.0)),
                          
                          child: TextButton(
                            child: Text('Current Locations',
                                style: TextStyle(color: Color.fromARGB(255, 148, 138, 138), fontSize: 24),
                                textAlign: TextAlign.left),
                            onPressed: () {},
                          ),
                          
                        ),



