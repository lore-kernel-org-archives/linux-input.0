From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] input: wacom - Lower the LED luminance
Date: Mon,  3 Oct 2011 17:02:50 -0700
Message-ID: <1317686570-29572-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56224 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1JDABC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 20:01:02 -0400
Received: by gyg10 with SMTP id 10so3948667gyg.19
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 17:01:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

The LED luminance level is normally lower when no button is pressed.

Reviewed-by: Eduard Hasenleithner <eduard@hasenleithner.at>
Tested-by: Eduard Hasenleithner <eduard@hasenleithner.at>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 Documentation/ABI/testing/sysfs-driver-wacom |    3 ++-
 drivers/input/tablet/wacom_sys.c             |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index dfe1d46..b1d5c17 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -25,7 +25,8 @@ Contact:	linux-input@vger.kernel.org
 Description:
 		Writing to this file sets the status LED luminance (0..127)
 		when the stylus does not touch the tablet surface, and no
-		button is pressed on the stylus.
+		button is pressed on the stylus. This luminance level is
+		normally lower than the level when a button is pressed.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status1_luminance
 Date:		August 2011
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 0eccf57..7facacc 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -678,7 +678,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 
 		/* Initialize default values */
 		wacom->led.select = 0;
-		wacom->led.llv = 30;
+		wacom->led.llv = 10;
 		wacom->led.hlv = 20;
 		wacom->led.img_lum = 10;
 		wacom_led_control(wacom);
-- 
1.7.6

