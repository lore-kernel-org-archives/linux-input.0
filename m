From: Ville Ranki <ville.ranki@iki.fi>
Subject: [PATCH] Input: joydev - Recognize joysticks with Z axis as joysticks.
Date: Thu, 25 Aug 2016 17:16:50 +0300
Message-ID: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirokuusama2.dnainternet.net ([83.102.40.153]:42574 "EHLO
        sirokuusama2.dnainternet.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759408AbcHYOXV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Aug 2016 10:23:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ville Ranki <ville.ranki@iki.fi>

Current implementation of joydev's input_device_id
table recognizes only devices with ABS_X, ABS_WHEEL
or ABS_THROTTLE axes as joysticks.

There are joystick devices that do not have those axes,
for example TRC Rudder device. The device in question
has ABS_Z, ABS_RX and ABS_RY axes causing it not being
detected as joystick.

This patch adds ABS_Z to the input_device_id list
allowing devices with ABS_Z axis to be detected
correctly.

Signed-off-by: Ville Ranki <ville.ranki@iki.fi>
---
 drivers/input/joydev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 5d11fea..f3135ae 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -950,6 +950,12 @@ static const struct input_device_id joydev_ids[] = {
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
 				INPUT_DEVICE_ID_MATCH_ABSBIT,
 		.evbit = { BIT_MASK(EV_ABS) },
+		.absbit = { BIT_MASK(ABS_Z) },
+	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT_MASK(EV_ABS) },
 		.absbit = { BIT_MASK(ABS_WHEEL) },
 	},
 	{
-- 
2.7.4

