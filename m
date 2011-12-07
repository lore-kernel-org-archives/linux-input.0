From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 2/2] Input: wacom: Add LED support for Cintiq 24HD
Date: Wed,  7 Dec 2011 15:04:57 -0800
Message-ID: <1323299097-1576-2-git-send-email-killertofu@gmail.com>
References: <1323299097-1576-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36774 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab1LGXGU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 18:06:20 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1598012iak.19
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2011 15:06:20 -0800 (PST)
In-Reply-To: <1323299097-1576-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

The Cintiq 24HD has three LEDs on the left side of the tablet and
three LEDs on the right side of the tablet. Switching to LED 0,
1, or 2 will enable the top, middle, or bottom LED for the respective
side. Switching to LED 3 turns off the LEDs on the respective side.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v1:
 * No changes.

 Documentation/ABI/testing/sysfs-driver-wacom |   17 +++++++++--------
 drivers/input/tablet/wacom_sys.c             |    5 ++++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index 82d4df1..0130d66 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -15,9 +15,9 @@ Contact:	linux-input@vger.kernel.org
 Description:
 		Attribute group for control of the status LEDs and the OLEDs.
 		This attribute group is only available for Intuos 4 M, L,
-		and XL (with LEDs and OLEDs) and Cintiq 21UX2 (LEDs only).
-		Therefore its presence implicitly signifies the presence of
-		said LEDs and OLEDs on the tablet device.
+		and XL (with LEDs and OLEDs) and Cintiq 21UX2 and Cintiq 24HD
+		(LEDs only). Therefore its presence implicitly signifies the
+		presence of said LEDs and OLEDs on the tablet device.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status0_luminance
 Date:		August 2011
@@ -41,16 +41,17 @@ Date:		August 2011
 Contact:	linux-input@vger.kernel.org
 Description:
 		Writing to this file sets which one of the four (for Intuos 4)
-		or of the right four (for Cintiq 21UX2) status LEDs is active (0..3).
-		The other three LEDs on the same side are always inactive.
+		or of the right four (for Cintiq 21UX2 and Cintiq 24HD) status
+		LEDs is active (0..3). The other three LEDs on the same side are
+		always inactive.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status_led1_select
 Date:		September 2011
 Contact:	linux-input@vger.kernel.org
 Description:
-		Writing to this file sets which one of the left four (for Cintiq 21UX2)
-		status LEDs is active (0..3). The other three LEDs on the left are always
-		inactive.
+		Writing to this file sets which one of the left four (for Cintiq 21UX2
+		and Cintiq 24HD) status LEDs is active (0..3). The other three LEDs on
+		the left are always inactive.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/buttons_luminance
 Date:		August 2011
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 2fe21d1..7e63183 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -563,7 +563,8 @@ static int wacom_led_control(struct wacom *wacom)
 	if (!buf)
 		return -ENOMEM;
 
-	if (wacom->wacom_wac.features.type == WACOM_21UX2)
+	if (wacom->wacom_wac.features.type == WACOM_21UX2 ||
+	    wacom->wacom_wac.features.type == WACOM_24HD)
 		led = (wacom->led.select[1] << 4) | 0x40;
 
 	led |=  wacom->led.select[0] | 0x4;
@@ -782,6 +783,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 					   &intuos4_led_attr_group);
 		break;
 
+	case WACOM_24HD:
 	case WACOM_21UX2:
 		wacom->led.select[0] = 0;
 		wacom->led.select[1] = 0;
@@ -816,6 +818,7 @@ static void wacom_destroy_leds(struct wacom *wacom)
 				   &intuos4_led_attr_group);
 		break;
 
+	case WACOM_24HD:
 	case WACOM_21UX2:
 		sysfs_remove_group(&wacom->intf->dev.kobj,
 				   &cintiq_led_attr_group);
-- 
1.7.7.3

