import 'package:flutter/material.dart';
import '../models/team.dart';

const teams = [
  Team(
    id: 'mclaren',
    name: 'McLaren',
    logoPath: 'assets/images/teams/mclaren.svg',
    iconPath: 'assets/icons/mclaren.webp',
    accentColor: Color.fromARGB(255, 255, 128, 0),
    tileColor: Color.fromARGB(255, 174, 87, 0),
    driverCodes: ['NOR', 'PIA'],
  ),

  Team(
    id: 'ferrari',
    name: 'Ferrari',
    logoPath: 'assets/images/teams/ferrari.svg',
    iconPath: 'assets/icons/ferrari.webp',
    accentColor: Color(0xFFDC0000),
    tileColor: Color.fromARGB(255, 172, 0, 0),
    driverCodes: ['LEC', 'HAM'],
  ),

  Team(
    id: 'mercedes',
    name: 'Mercedes',
    logoPath: 'assets/images/teams/mercedes.svg',
    iconPath: 'assets/icons/mercedes.webp',
    accentColor: Color(0xFF00D2BE),
    tileColor: Color.fromARGB(181, 0, 167, 150),
    driverCodes: ['RUS', 'ANT'],
  ),

  Team(
    id: 'redbull',
    name: 'Red Bull',
    logoPath: 'assets/images/teams/red_bull.svg',
    iconPath: 'assets/icons/red_bull.webp',
    accentColor: Color(0xFF0600EF),
    tileColor: Color.fromARGB(255, 6, 0, 174),
    driverCodes: ['VER', 'HAD'],
  ),

  Team(
    id: 'aston_martin',
    name: 'Aston Martin',
    logoPath: 'assets/images/teams/aston_martin.svg',
    iconPath: 'assets/icons/aston_martin.webp',
    accentColor: Color(0xFF006F62),
    tileColor: Color.fromARGB(255, 0, 103, 77),
    driverCodes: ['ALO', 'STR'],
  ),

  Team(
    id: 'williams',
    name: 'Williams',
    logoPath: 'assets/images/teams/williams.svg',
    iconPath: 'assets/icons/williams.webp',
    accentColor: Color.fromARGB(255, 1, 90, 254),
    tileColor: Color.fromARGB(255, 1, 33, 92),
    driverCodes: ['ALB', 'SAI'],
  ),

  Team(
    id: 'alpine',
    name: 'Alpine',
    logoPath: 'assets/images/teams/alpine.svg',
    iconPath: 'assets/icons/alpine.webp',
    accentColor: Color(0xFF0090FF),
    tileColor: Color.fromARGB(255, 244, 50, 215),
    driverCodes: ['GAS', 'COL'],
  ),

  Team(
    id: 'racing_bulls',
    name: 'Racing Bulls',
    logoPath: 'assets/images/teams/vcarb.svg',
    iconPath: 'assets/icons/racing_bulls.webp',
    accentColor: Color(0xFF2B4562),
    tileColor: Color.fromARGB(255, 86, 104, 124),
    driverCodes: ['LAW', 'LIN'],
  ),

  Team(
    id: 'audi',
    name: 'Audi',
    logoPath: 'assets/images/teams/audi.svg',
    iconPath: 'assets/icons/audi.webp',
    accentColor: Color.fromARGB(255, 102, 20, 23),
    tileColor: Color.fromARGB(235, 118, 118, 118),
    driverCodes: ['HUL', 'BOR'],
  ),

  Team(
    id: 'haas',
    name: 'Haas',
    logoPath: 'assets/images/teams/haas.svg',
    iconPath: 'assets/icons/haas.webp',
    accentColor: Color(0xFFFFFFFF),
    tileColor: Color.fromARGB(255, 174, 174, 174),
    driverCodes: ['OCO', 'BEA'],
  ),

  /*Team(
    id: 'cadillac',
    name: 'Cadillac',
    logoPath: 'assets/images/teams/cadillac.svg',
    iconPath: 'assets/icons/cadillac.webp',
    accentColor: Color.fromARGB(255, 92, 91, 91),
    tileColor: Color.fromARGB(255, 255, 255, 255),
    //needsBackground: false,
    //logoWidth: 130,
  ),*/
];
