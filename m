From: Simon Wood <simon@mungewell.org>
Subject: [PATCH] HID: hid-sony: Prevent LED overrun
Date: Tue, 17 Feb 2015 20:14:50 -0700
Message-ID: <1424229290-32089-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-04.shaw.ca ([64.59.134.12]:4365 "EHLO
	smtp-out-04.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbBRDYe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 22:24:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>

If the value written to led1 is larger than 1 (for SixAxis or Intec controllers),
it can effect other leds on the device.

For example:
# echo 3 > /sys/class/leds/0003\:054C\:0268.0013\:\:sony1/brightness

turns on both led1 and led2, led2 does not then behave as expected through it's
own interface.

Patch limits the LEDs 'value' to the 'max brightness', thus preventing bug.

Tested with SixAxis DS3, DS4 and Intec (3rd party) controllers, via USB connection.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d25..385fa1f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1296,6 +1296,9 @@ static void sony_led_set_brightness(struct led_classdev *led,
 			drv_data->led_delay_on[n] ||
 			drv_data->led_delay_off[n]))) {
 
+			if (value > led->max_brightness)
+				value = led->max_brightness;
+
 			drv_data->led_state[n] = value;
 
 			/* Setting the brightness stops the blinking */
-- 
1.9.1

