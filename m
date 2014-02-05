From: Simon Wood <simon@mungewell.org>
Subject: [PATCH] HID: hid-sony Report actual brightness value when reading LED
Date: Wed,  5 Feb 2014 12:34:18 -0700
Message-ID: <1391628858-2916-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:42567 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbaBETe3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 14:34:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org

The Dualshock4 controller contains a RGB LED, which is enabled via
the '/sys/class/leds' interface. At present the driver only returns
whether each of the RGB LEDs is lit (ie not off), but no indication
of it's brightness.

This patch fixes the reading of the current brightnes so that it
returns the value (rather than just off=0, on=LED_FULL).

Tested on the DS4 and SixAxis (for compatibility).

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1235405..f9a7610 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -790,7 +790,6 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	struct sony_sc *drv_data;
 
 	int n;
-	int on = 0;
 
 	drv_data = hid_get_drvdata(hdev);
 	if (!drv_data) {
@@ -799,13 +798,11 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	}
 
 	for (n = 0; n < drv_data->led_count; n++) {
-		if (led == drv_data->leds[n]) {
-			on = !!(drv_data->led_state[n]);
-			break;
-		}
+		if (led == drv_data->leds[n])
+			return drv_data->led_state[n];
 	}
 
-	return on ? LED_FULL : LED_OFF;
+	return LED_OFF;
 }
 
 static void sony_leds_remove(struct hid_device *hdev)
-- 
1.8.1.2

