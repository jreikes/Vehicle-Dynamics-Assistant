-- phpMyAdmin SQL Dump
-- version 2.6.4-pl4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Apr 01, 2015 at 04:17 PM
-- Server version: 5.0.27
-- PHP Version: 4.4.2
-- 
-- Database: `vehicledynamics`
-- 
CREATE DATABASE `vehicledynamics` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE vehicledynamics;

-- --------------------------------------------------------

-- 
-- Table structure for table `adjustments`
-- 

CREATE TABLE `adjustments` (
  `id` int(11) NOT NULL auto_increment,
  `adjustment_group` varchar(64) NOT NULL default '',
  `adjustment` varchar(128) NOT NULL default '',
  `positive` varchar(255) NOT NULL default '',
  `negative` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

-- 
-- Dumping data for table `adjustments`
-- 

INSERT INTO `adjustments` VALUES (1, 'Tires', 'Pressure', 'Increase tire pressure', 'Decrease tire pressure');
INSERT INTO `adjustments` VALUES (2, 'Tires', 'Size / stagger', 'Increase tire stagger', 'Decrease tire stagger');
INSERT INTO `adjustments` VALUES (3, 'Tires', 'Compound', 'Use softer tire compound', 'Use harder tire compound');
INSERT INTO `adjustments` VALUES (4, 'Tires', 'Wheel offset', 'Increase wheel offset', 'Decrease wheel offset');
INSERT INTO `adjustments` VALUES (5, 'Alignment', 'Front toe', 'Adjust toe inward front', 'Adjust toe outward front');
INSERT INTO `adjustments` VALUES (6, 'Alignment', 'Front camber', 'Increase negative camber front', 'Decrease negative camber front');
INSERT INTO `adjustments` VALUES (7, 'Alignment', 'Caster', 'Increase caster', 'Decrease caster');
INSERT INTO `adjustments` VALUES (8, 'Alignment', 'Rear toe', 'Adjust toe inward rear', 'Adjust toe outward rear');
INSERT INTO `adjustments` VALUES (9, 'Alignment', 'Rear camber', 'Increase negative camber rear', 'Decrease negative camber rear');
INSERT INTO `adjustments` VALUES (10, 'Shocks', 'Simultaneous compression and rebound damping adjustment (single-adjustable dampers only)', 'Increase shock damping', 'Decrease shock damping');
INSERT INTO `adjustments` VALUES (11, 'Shocks', 'Compression damping (independent of rebound)', 'Increase compression damping', 'Decrease compression damping');
INSERT INTO `adjustments` VALUES (12, 'Shocks', 'Rebound damping (independent of compression damping)', 'Increase rebound damping', 'Decrease rebound damping');
INSERT INTO `adjustments` VALUES (13, 'Shocks', 'Low speed compression damping', 'Increase low speed compression damping', 'Decrease low speed compression damping');
INSERT INTO `adjustments` VALUES (14, 'Shocks', 'Low speed rebound damping', 'Increase low speed rebound damping', 'Decrease low speed rebound damping');
INSERT INTO `adjustments` VALUES (15, 'Shocks', 'Ride height', 'Increase ride height', 'Decrease ride height');
INSERT INTO `adjustments` VALUES (16, 'Shocks', 'Droop / travel', 'Increase available suspension droop', 'Decrease available suspension droop');
INSERT INTO `adjustments` VALUES (17, 'Hidden', '16', 'Increase available suspension bump travel', 'Decrease available suspension bump travel');
INSERT INTO `adjustments` VALUES (18, 'Shocks', 'Nitrogen pressure', 'Increase damper nitrogen pressure', 'Decrease damper nitrogen pressure');
INSERT INTO `adjustments` VALUES (19, 'Sway bars', 'Front adjustable', 'Increase sway bar stiffness front', 'Decrease sway bar stiffness front');
INSERT INTO `adjustments` VALUES (20, 'Sway bars', 'Rear adjustable', 'Increase sway bar stiffness rear', 'Decrease sway bar stiffness rear');
INSERT INTO `adjustments` VALUES (21, 'Springs', 'Rate', 'Increase spring rate', 'Decrease spring rate');
INSERT INTO `adjustments` VALUES (22, 'Springs', 'Preload', 'Increase spring preload', 'Decrease spring preload');
INSERT INTO `adjustments` VALUES (23, 'Aerodynamics', 'Adjustable rear wing/diffuser', 'Increase rear downforce', 'Decrease rear downforce');
INSERT INTO `adjustments` VALUES (24, 'Aerodynamics', 'Adjustable front splitter', 'Increase front downforce', 'Decrease front downforce');
INSERT INTO `adjustments` VALUES (25, 'Other', 'Differential lockup (only for cars equipped with a limited slip differential)', 'Increase differential lockup', 'Decrease differential lockup');
INSERT INTO `adjustments` VALUES (26, 'Other', 'Torque split (only for all wheel drive vehicles that can adjust front-rear torque split)', 'Increase torque bias to rear on AWD vehicles', 'Increase torque bias to front on AWD vehicles');
INSERT INTO `adjustments` VALUES (27, 'Other', 'Brake bias (may be adjusted via dydraulic distribution, brake pad compound, rotor size, or caliper choice)', 'Increase front brake bias', 'Increase rear brake bias');
INSERT INTO `adjustments` VALUES (28, 'Other', 'Weight distribution (vehicles with readily moveable weight such as ballast or battery location)', 'Move weight toward car rear', 'Move weight toward car front');
INSERT INTO `adjustments` VALUES (29, 'Hidden', '6, 9', 'Increase negative camber', 'Decrease negative camber');
INSERT INTO `adjustments` VALUES (30, 'Hidden', '5, 8', 'Adjust toe inward', 'Adjust toe outward');
INSERT INTO `adjustments` VALUES (31, 'Hidden', '0', 'Check for play in suspension components, ball joints, bushings, etc.', 'Check for play in suspension components, ball joints, bushings, etc.');
INSERT INTO `adjustments` VALUES (32, 'Hidden', '1', 'Check tire pressures', 'Check tire pressures');
INSERT INTO `adjustments` VALUES (33, 'Hidden', '0', 'Check alignment', 'Check alignment');
INSERT INTO `adjustments` VALUES (34, 'Hidden', '15, 16, 22', 'Check corner balance', 'Check corner balance');
INSERT INTO `adjustments` VALUES (35, 'Hidden', '15, 16, 22', 'Check if suspension is bottoming out', 'Check if suspension is bottoming out');

-- --------------------------------------------------------

-- 
-- Table structure for table `problems`
-- 

CREATE TABLE `problems` (
  `id` int(11) NOT NULL auto_increment,
  `problem_type` tinyint(4) NOT NULL default '0',
  `problem` varchar(255) NOT NULL default '',
  `solutions` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- 
-- Dumping data for table `problems`
-- 

INSERT INTO `problems` VALUES (1, 0, 'Steady state', '+1f, -1r, +2, -3f, +3r, -6, +9, +10f, -10r, +13f, -13r, +14f, -14r, +15f, -15r, +18f, -18r, +19, -20, +21f, -21r, +22f, -22r, -28, +35');
INSERT INTO `problems` VALUES (2, 0, 'Corner entry', '+5, +11f, -12r, +25, +27');
INSERT INTO `problems` VALUES (3, 0, 'Corner exit', '+8, -11r, +12f');
INSERT INTO `problems` VALUES (4, 0, 'High speed', '+23, -24, +35');
INSERT INTO `problems` VALUES (5, 0, 'Braking', '+5, +7, +11f, -12r, +27');
INSERT INTO `problems` VALUES (6, 1, 'Front inside wheel lift', '+21r, -19, -14f, -12f');
INSERT INTO `problems` VALUES (7, 1, 'Rear inside wheel lift', '+21f, -20, -14r, -12r');
INSERT INTO `problems` VALUES (8, 1, 'Excess wear on inside edge of tire', '-29, +30');
INSERT INTO `problems` VALUES (9, 1, 'Excess wear on outside edge of tire', '+1, +29, -30');
INSERT INTO `problems` VALUES (10, 1, 'Excess wear on centerline of tire', '-1');
INSERT INTO `problems` VALUES (11, 1, 'Nervous handling', '+5, +7, +8, -10, -11, -12, -13, -14, +15, +17, -18, -19, -20, -21, -25, +35');
INSERT INTO `problems` VALUES (12, 1, 'Slow vehicle response', '+10, +11, +12, +13, +14, -15, +18, +19, +20, +21, +29, -30');
INSERT INTO `problems` VALUES (13, 1, 'Instability or jumpiness over rough pavement or bumps', '-10, -11, +15, +16, +17, -21, +35');
INSERT INTO `problems` VALUES (14, 1, 'Wheelspin', '+25');
INSERT INTO `problems` VALUES (15, 1, 'Power oversteer', '-1r, -11r, +12f, -25r, -26');
INSERT INTO `problems` VALUES (16, 1, 'Power understeer', '-1f, +11r, -12f, -25f, +26');
INSERT INTO `problems` VALUES (17, 1, 'Torque steer', '+32, +33, +25');
INSERT INTO `problems` VALUES (18, 1, 'Inconsistent handling', '+31, +32, +33, +34');
INSERT INTO `problems` VALUES (19, 1, '"Clunking" noise over bumps', '+31, +35');
