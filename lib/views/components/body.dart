import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bushier2/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
            height: size.height * 0.2,
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                      bottom: 36 + kDefaultPadding,
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Vendors',
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          SvgPicture.asset('assets/icons/search.svg')
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            height: 24,
            child: CustomWidgets.titleText(context, 'Recommended')
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: kDefaultPadding * 2.5,
              left: kDefaultPadding,
              top: kDefaultPadding / 2,
            ),
            width: size.width * 0.6,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/vendors_greenturf.jpeg'),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Green Turf Asia\n",
                              style: TextStyle(
                                color: kTextColor,
                              ),
                            ),
                            TextSpan(
                              text: "4.8",
                              style: TextStyle(
                                color: kTextColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$5000',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: kDefaultPadding * 2.5,
              left: kDefaultPadding,
              top: kDefaultPadding / 2,
            ),
            width: size.width * 0.6,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/vendors_verticalgarden.png'),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Vertical Garden Pte. Ltd.\n",
                              style: TextStyle(
                                color: kTextColor,
                              ),
                            ),
                            TextSpan(
                              text: "4.7",
                              style: TextStyle(
                                color: kTextColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$4000',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: kDefaultPadding * 2.5,
              left: kDefaultPadding,
              top: kDefaultPadding / 2,
            ),
            width: size.width * 0.6,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/vendors_mosscape.png'),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Mosscape\n",
                              style: TextStyle(
                                color: kTextColor,
                              ),
                            ),
                            TextSpan(
                              text: "4.5",
                              style: TextStyle(
                                color: kTextColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$3000',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
