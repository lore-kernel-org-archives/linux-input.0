From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 23/33] docs: input/ntrig: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:06 -0300
Message-ID: <355358d79dca250017195f1e0309d64edd432a07.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
 <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
 <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
 <011680ea06ad0b73922b17a6c453d5891bfd5386.1491069870.git.mchehab@s-opensource.com>
 <87be2676f773a689c9b39c4f79cd843fb3678133.1491069870.git.mchehab@s-opensource.com>
 <6730cd298d203d22aec9a5a708cd1d15982e624b.1491069870.git.mchehab@s-opensource.com>
 <b9b1a9e27971fd899876825f2ccfd638c6c62668.1491069870.git.mchehab@s-opensource.com>
 <07a688fbc69c47362aca5882a3bcf72329d0fe1a.1491069870.git.mchehab@s-opensource.com>
 <13245dfb9e3a0f34547925ef3e6efc87b8165ae2.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41669 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdDASQf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:35 -0400
In-Reply-To: <13245dfb9e3a0f34547925ef3e6efc87b8165ae2.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

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


