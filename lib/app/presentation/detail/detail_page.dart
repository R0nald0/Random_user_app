import 'package:flutter/material.dart';
import 'package:random_user_bus_2_teste/app/core/ui/theme/app_theme.dart';
import 'package:random_user_bus_2_teste/app/core/ui/widget/app_horizontal_divider.dart';
import 'package:random_user_bus_2_teste/app/core/ui/widget/app_vertical_divider.dart';
import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';
import 'package:random_user_bus_2_teste/app/presentation/detail/component/expandadle_item.dart';

class DetailPage extends StatelessWidget {
  final User _userResult;
  const DetailPage({super.key, required User userResult})
    : _userResult = userResult;

  @override
  Widget build(BuildContext context) {
    final User(
      :pictures,
      :name,
      :title,
      :gender,
      :cell,
      :phone,
      :nat,
      :email,
      :streetNumber,
      :streetName,
      :city,
      :country,
      :postcode,
      :state,
      :latitude,
      :longitude,
      :timezoneOffset,
      :timezoneDescription,
      :uuid,
      :username,
      :password,
      :salt,
      :md5,
      :sha1,
      :sha256,
      :dateOfBirth,
      :age,
      :registeredDate,
      :registeredAge,
      :idName,
      :idValue,
    ) = _userResult;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profiel user',
          style: AppTheme.theme.textTheme.labelMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage: NetworkImage(pictures[1]),
                ),
              ),
              Text(
                '$title $name',
                style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                  fontSize: 21,
                ),
              ),
              Row(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(gender, style: AppTheme.theme.textTheme.bodySmall),
                      Text(
                        "Gender",
                        style: AppTheme.theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  AppVerticalDivider(),
                  Column(
                    children: [
                      Text(phone, style: AppTheme.theme.textTheme.bodySmall),
                      Text(cell, style: AppTheme.theme.textTheme.bodySmall),
                      Text(
                        "Phone ",
                        style: AppTheme.theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  AppVerticalDivider(),
                  Column(
                    children: [
                      Text(nat, style: AppTheme.theme.textTheme.labelSmall),
                      Text("Nat ", style: AppTheme.theme.textTheme.labelMedium),
                    ],
                  ),
                ],
              ),

              AppHorizantalDivider(),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Email: ",
                      style: AppTheme.theme.textTheme.displayLarge,
                    ),
                    Text(email, style: AppTheme.theme.textTheme.bodySmall),
                  ],
                ),
              ),

              ExpandableItem(
                title: 'Location',
                children: [
                  ItemDescriptionRow(
                    title: 'Strete',
                    description: '$streetName,$streetNumber',
                  ),
                  ItemDescriptionRow(title: 'City', description: city),
                  ItemDescriptionRow(title: 'State', description: state),
                  ItemDescriptionRow(title: 'Coutry', description: country),
                  ItemDescriptionRow(title: 'Post code', description: postcode),
                  ItemDescriptionRow(
                    title: 'Cordinater',
                    description: "Latitude:$latitude - Longitude: $longitude",
                  ),
                  ItemDescriptionRow(
                    title: 'Timezone',
                    description:
                        "Offset:$timezoneOffset - Description: $timezoneDescription",
                  ),
                ],
              ),
              ExpandableItem(
                title: 'Login',
                children: [
                  ItemDescriptionRow(
                    title: 'UUID',
                    description: '$streetName,$streetNumber',
                  ),
                  ItemDescriptionRow(
                    title: 'User-name',
                    description: '$streetName,$streetNumber',
                  ),
                  ItemDescriptionRow(
                    title: 'Password',
                    description: '$streetName,$streetNumber',
                  ),
                  ItemDescriptionRow(
                    title: 'Salt',
                    description: '$streetName,$streetNumber',
                  ),
                  ItemDescriptionRow(
                    title: 'Sha1',
                    description: '$streetName,$streetNumber',
                  ),
                  ItemDescriptionRow(
                    title: 'Sha256',
                    description: '$streetName,$streetNumber',
                  ),
                ],
              ),
              ExpandableItem(
                title: 'Date Of Birth',
                children: [
                  ItemDescriptionRow(
                    title: 'Date Of Birth',
                    description: dateOfBirth,
                  ),
                  ItemDescriptionRow(title: 'Age', description: '$age'),
                ],
              ),
              ExpandableItem(
                title: 'Registred',
                children: [
                  ItemDescriptionRow(
                    title: 'Date',
                    description: registeredDate,
                  ),
                  ItemDescriptionRow(
                    title: 'Age',
                    description: '$registeredAge',
                  ),
                ],
              ),
              ExpandableItem(
                title: 'Id',
                children: [
                  ItemDescriptionRow(title: 'Name', description: idName),
                  ItemDescriptionRow(title: 'Value', description: idValue),
                ],
              ),
              ExpandableItem(
                title: 'Pictures',
                children: [
                  ItemDescriptionRow(title: 'Large', description: pictures[0]),
                  ItemDescriptionRow(title: 'medium', description: pictures[1]),
                  ItemDescriptionRow(
                    title: 'thumbnail',
                    description: pictures[2],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Save user'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class ItemDescriptionRow extends StatelessWidget {
  final String title;
  final String description;

  const ItemDescriptionRow({
    super.key,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text('$title: ', style: AppTheme.theme.textTheme.labelMedium),
        Text(description, style: AppTheme.theme.textTheme.bodySmall),
      ],
    );
  }
}
