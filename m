From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] input: wacom - don't expose LED inactive option
Date: Mon,  3 Oct 2011 17:03:09 -0700
Message-ID: <1317686589-29610-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61940 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1JDABV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 20:01:21 -0400
Received: by ggnv2 with SMTP id v2so550360ggn.19
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 17:01:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

The LED also indicates the status of the tablet. Don't turn it off.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 Documentation/ABI/testing/sysfs-driver-wacom |    8 +++-----
 drivers/input/tablet/wacom.h                 |    6 +++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index b1d5c17..b560185 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -23,7 +23,7 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status0_lum
 Date:		August 2011
 Contact:	linux-input@vger.kernel.org
 Description:
-		Writing to this file sets the status LED luminance (0..127)
+		Writing to this file sets the status LED luminance (1..127)
 		when the stylus does not touch the tablet surface, and no
 		button is pressed on the stylus. This luminance level is
 		normally lower than the level when a button is pressed.
@@ -32,7 +32,7 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status1_lum
 Date:		August 2011
 Contact:	linux-input@vger.kernel.org
 Description:
-		Writing to this file sets the status LED luminance (0..127)
+		Writing to this file sets the status LED luminance (1..127)
 		when the stylus touches the tablet surface, or any button is
 		pressed on the stylus.
 
@@ -41,9 +41,7 @@ Date:		August 2011
 Contact:	linux-input@vger.kernel.org
 Description:
 		Writing to this file sets which one of the four status LEDs is
-		active (0..3). The other three LEDs are always inactive.  By
-		means of specifying "-1" it is possible to set all status LEDs
-		to inactive.
+		active (0..3). The other three LEDs are always inactive.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/buttons_luminance
 Date:		August 2011
diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 00332d66..561f107 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -115,9 +115,9 @@ struct wacom {
 	bool open;
 	char phys[32];
 	struct wacom_led {
-		u8 select; /* status led selector (0..3, -1=none) */
-		u8 llv;    /* status led brightness no button */
-		u8 hlv;    /* status led brightness button pressed */
+		u8 select; /* status led selector (0..3) */
+		u8 llv;    /* status led brightness no button (1..127) */
+		u8 hlv;    /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
 	} led;
 };
-- 
1.7.6

