From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 017/123] HID: Add 044f:b320 ThrustMaster, Inc. 2 in 1 DT
Date: Tue, 13 Aug 2019 22:09:01 -0400
Message-ID: <20190814021047.14828-17-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ilya Trukhanov <lahvuun@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Ilya Trukhanov <lahvuun@gmail.com>

[ Upstream commit 65f11c72780fa9d598df88def045ccb6a885cf80 ]

Enable force feedback for the Thrustmaster Dual Trigger 2 in 1 Rumble Force
gamepad. Compared to other Thrustmaster devices, left and right rumble
motors here are swapped.

Signed-off-by: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-tmff.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index e12f2588ddebb..bdfc5ff3b2c5c 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -22,6 +22,8 @@
 
 #include "hid-ids.h"
 
+#define THRUSTMASTER_DEVICE_ID_2_IN_1_DT	0xb320
+
 static const signed short ff_rumble[] = {
 	FF_RUMBLE,
 	-1
@@ -76,6 +78,7 @@ static int tmff_play(struct input_dev *dev, void *data,
 	struct hid_field *ff_field = tmff->ff_field;
 	int x, y;
 	int left, right;	/* Rumbling */
+	int motor_swap;
 
 	switch (effect->type) {
 	case FF_CONSTANT:
@@ -100,6 +103,13 @@ static int tmff_play(struct input_dev *dev, void *data,
 					ff_field->logical_minimum,
 					ff_field->logical_maximum);
 
+		/* 2-in-1 strong motor is left */
+		if (hid->product == THRUSTMASTER_DEVICE_ID_2_IN_1_DT) {
+			motor_swap = left;
+			left = right;
+			right = motor_swap;
+		}
+
 		dbg_hid("(left,right)=(%08x, %08x)\n", left, right);
 		ff_field->value[0] = left;
 		ff_field->value[1] = right;
@@ -226,6 +236,8 @@ static const struct hid_device_id tm_devices[] = {
 		.driver_data = (unsigned long)ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304),   /* FireStorm Dual Power 2 (and 3) */
 		.driver_data = (unsigned long)ff_rumble },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, THRUSTMASTER_DEVICE_ID_2_IN_1_DT),   /* Dual Trigger 2-in-1 */
+		.driver_data = (unsigned long)ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323),   /* Dual Trigger 3-in-1 (PC Mode) */
 		.driver_data = (unsigned long)ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb324),   /* Dual Trigger 3-in-1 (PS3 Mode) */
-- 
2.20.1
