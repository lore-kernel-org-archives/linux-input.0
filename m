From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 23/37] docs: input/ntrig: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:23 -0300
Message-ID: <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/ntrig.txt | 49 ++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/Documentation/input/ntrig.txt b/Documentation/input/ntrig.txt
index be1fd981f73f..a6b22ce6c61c 100644
--- a/Documentation/input/ntrig.txt
+++ b/Documentation/input/ntrig.txt
@@ -1,7 +1,11 @@
+.. include:: <isonum.txt>
+
+=========================
 N-Trig touchscreen Driver
--------------------------
-	Copyright (c) 2008-2010 Rafi Rubin <rafi@seas.upenn.edu>
-	Copyright (c) 2009-2010 Stephane Chatty
+=========================
+
+:Copyright: |copy| 2008-2010 Rafi Rubin <rafi@seas.upenn.edu>
+:Copyright: |copy| 2009-2010 Stephane Chatty
 
 This driver provides support for N-Trig pen and multi-touch sensors.  Single
 and multi-touch events are translated to the appropriate protocols for
@@ -22,16 +26,18 @@ but only for that one device.
 
 The following parameters are used to configure filters to reduce noise:
 
-activate_slack		number of fingers to ignore before processing events
-
-activation_height	size threshold to activate immediately
-activation_width
-
-min_height		size threshold bellow which fingers are ignored
-min_width		both to decide activation and during activity
-
-deactivate_slack	the number of "no contact" frames to ignore before
-			propagating the end of activity events
++-----------------------+-----------------------------------------------------+
+|activate_slack		|number of fingers to ignore before processing events |
++-----------------------+-----------------------------------------------------+
+|activation_height,	|size threshold to activate immediately		      |
+|activation_width	|						      |
++-----------------------+-----------------------------------------------------+
+|min_height,		|size threshold bellow which fingers are ignored      |
+|min_width		|both to decide activation and during activity	      |
++-----------------------+-----------------------------------------------------+
+|deactivate_slack	|the number of "no contact" frames to ignore before   |
+|			|propagating the end of activity events		      |
++-----------------------+-----------------------------------------------------+
 
 When the last finger is removed from the device, it sends a number of empty
 frames.  By holding off on deactivation for a few frames we can tolerate false
@@ -44,15 +50,20 @@ Additional sysfs items
 ----------------------
 
 These nodes just provide easy access to the ranges reported by the device.
-sensor_logical_height	the range for positions reported during activity
-sensor_logical_width
 
-sensor_physical_height	internal ranges not used for normal events but
-sensor_physical_width	useful for tuning
++-----------------------+-----------------------------------------------------+
+|sensor_logical_height, | the range for positions reported during activity    |
+|sensor_logical_width   |                                                     |
++-----------------------+-----------------------------------------------------+
+|sensor_physical_height,| internal ranges not used for normal events but      |
+|sensor_physical_width  | useful for tuning                                   |
++-----------------------+-----------------------------------------------------+
 
 All N-Trig devices with product id of 1 report events in the ranges of
-X: 0-9600
-Y: 0-7200
+
+* X: 0-9600
+* Y: 0-7200
+
 However not all of these devices have the same physical dimensions.  Most
 seem to be 12" sensors (Dell Latitude XT and XT2 and the HP TX2), and
 at least one model (Dell Studio 17) has a 17" sensor.  The ratio of physical
-- 
2.9.3

