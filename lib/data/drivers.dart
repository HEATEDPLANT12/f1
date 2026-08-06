import '../models/driver.dart';
import '../models/team.dart';

const List<Driver> allDrivers = [
  Driver(
    code: "NOR",
    firstName: "LANDO",
    lastName: "NORRIS",
    number: "01",
    imagePath: "assets/drivers/norris.webp",
  ),

  Driver(
    code: "PIA",
    firstName: "OSCAR",
    lastName: "PIASTRI",
    number: "81",
    imagePath: "assets/drivers/piastri.webp",
  ),

  Driver(
    code: "VER",
    firstName: "MAX",
    lastName: "VERSTAPPEN",
    number: "03",
    imagePath: "assets/drivers/verstappen.webp",
  ),

  Driver(
    code: "LEC",
    firstName: "CHARLES",
    lastName: "LECLERC",
    number: "16",
    imagePath: "assets/drivers/leclerc.webp",
  ),

  Driver(
    code: "HAM",
    firstName: "LEWIS",
    lastName: "HAMILTON",
    number: "44",
    imagePath: "assets/drivers/hamilton.webp",
  ),

  Driver(
    code: "HAD",
    firstName: "ISSAC",
    lastName: "HADJAR",
    number: "06",
    imagePath: "assets/drivers/hadjar.webp",
  ),

  Driver(
    code: "RUS",
    firstName: "GEORGE",
    lastName: "RUSSELL",
    number: "63",
    imagePath: "assets/drivers/russell.webp",
  ),

  Driver(
    code: "ANT",
    firstName: "KIMI",
    lastName: "ANTONELLI",
    number: "12",
    imagePath: "assets/drivers/antonelli.webp",
  ),

  Driver(
    code: "SAI",
    firstName: "CARLOS",
    lastName: "SAINZ",
    number: "55",
    imagePath: "assets/drivers/sainz.webp",
  ),

  Driver(
    code: "ALO",
    firstName: "FERNANDO",
    lastName: "ALONSO",
    number: "14",
    imagePath: "assets/drivers/alonso.webp",
  ),

  Driver(
    code: "GAS",
    firstName: "PIERRE",
    lastName: "GASLY",
    number: "10",
    imagePath: "assets/drivers/gasly.webp",
  ),

  Driver(
    code: "STR",
    firstName: "LANCE",
    lastName: "STROLL",
    number: "18",
    imagePath: "assets/drivers/stroll.webp",
  ),

  Driver(
    code: "COL",
    firstName: "FRANCO",
    lastName: "COLAPINTO",
    number: "43",
    imagePath: "assets/drivers/colapinto.webp",
  ),

  Driver(
    code: "LAW",
    firstName: "LIAM",
    lastName: "LAWSON",
    number: "30",
    imagePath: "assets/drivers/lawson.webp",
  ),

  Driver(
    code: "LIN",
    firstName: "ARVID ",
    lastName: "LINDBLAD",
    number: "41",
    imagePath: "assets/drivers/lindblad.webp",
  ),

  Driver(
    code: "OCO",
    firstName: "ESTEBAN",
    lastName: "OCO",
    number: "31",
    imagePath: "assets/drivers/ocon.webp",
  ),

  Driver(
    code: "BEA",
    firstName: "OLIVER",
    lastName: "BEARMAN",
    number: "87",
    imagePath: "assets/drivers/bearman.webp",
  ),

  Driver(
    code: "ALB",
    firstName: "ALEX",
    lastName: "ALBON",
    number: "23",
    imagePath: "assets/drivers/albon.webp",
  ),

  Driver(
    code: "HUL",
    firstName: "NICO",
    lastName: "HULKENBERG",
    number: "27",
    imagePath: "assets/drivers/hulkenberg.webp",
  ),

  Driver(
    code: "BOR",
    firstName: "GABRIEL",
    lastName: "BORTOLETO",
    number: "05",
    imagePath: "assets/drivers/bortoleto.webp",
  ),
];

/*final List<Driver> mclarenDrivers = allDrivers
    .where((d) => d.code == "NOR" || d.code == "PIA")
    .toList();

final List<Driver> ferrariDrivers = allDrivers
    .where((d) => d.code == "LEC" || d.code == "HAM")
    .toList();*/

List<Driver> getDriversForTeam(Team team) {
  switch (team.id) {
    case 'mclaren':
      return allDrivers
          .where((d) => d.code == 'NOR' || d.code == 'PIA')
          .toList();

    case 'ferrari':
      return allDrivers
          .where((d) => d.code == 'LEC' || d.code == 'HAM')
          .toList();

    case 'redbull':
      return allDrivers
          .where((d) => d.code == 'VER' || d.code == 'HAD')
          .toList();

    case 'haas':
      return allDrivers
          .where((d) => d.code == 'OCO' || d.code == 'BEA')
          .toList();

    case 'alpine':
      return allDrivers
          .where((d) => d.code == 'GAS' || d.code == 'COL')
          .toList();

    case 'mercedes':
      return allDrivers
          .where((d) => d.code == 'RUS' || d.code == 'ANT')
          .toList();

    case 'audi':
      return allDrivers
          .where((d) => d.code == 'BOR' || d.code == 'HUL')
          .toList();

    case 'racing_bulls':
      return allDrivers
          .where((d) => d.code == 'LAW' || d.code == 'LIN')
          .toList();

    case 'williams':
      return allDrivers
          .where((d) => d.code == 'SAI' || d.code == 'ALB')
          .toList();

    case 'aston_martin':
      return allDrivers
          .where((d) => d.code == 'ALO' || d.code == 'STR')
          .toList();

    default:
      return [];
  }
}
