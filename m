From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Tue, 04 Feb 2014 23:11:25 +0100
Message-ID: <3580124.nFkHgCoyEf@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <4656889.s9yIX65sPh@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.spider.cz ([31.31.77.241]:39338 "EHLO prifuk.cz"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934410AbaBDWL3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 17:11:29 -0500
In-Reply-To: <4656889.s9yIX65sPh@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, simon@mungewell.org, linux-input@vger.kernel.org

Port hid-lg4ff to ff-memless-next.

---
 drivers/hid/Kconfig     |  2 +-
 drivers/hid/hid-lg4ff.c | 86 +++++++++++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 34e2d39..31c4b43 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -389,7 +389,7 @@ config LOGIG940_FF
 config LOGIWHEELS_FF
 	bool "Logitech wheels configuration and force feedback support"
 	depends on HID_LOGITECH
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	default LOGITECH_FF
 	help
 	  Say Y here if you want to enable force feedback and range setting
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index befe0e3..f236b9f 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -25,6 +25,7 @@
 
 
 #include <linux/input.h>
+#include <linux/input/ff-memless-next.h>
 #include <linux/usb.h>
 #include <linux/hid.h>
 
@@ -44,6 +45,8 @@
 #define G27_REV_MAJ 0x12
 #define G27_REV_MIN 0x38
 
+#define FF_UPDATE_RATE 8
+
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
 
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range);
@@ -182,47 +185,60 @@ int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field *field,
 	}
 }
 
-static int hid_lg4ff_play(struct input_dev *dev, void *data, struct ff_effect *effect)
+static int hid_lg4ff_start_combined(struct hid_device *hid, struct hid_report *report,
+				    const struct mlnx_simple_force *force)
+{
+	__s32 *value = report->field[0]->value;
+	int scaled_x;
+
+	/* Scale down from MLNX range */
+	scaled_x = 0x80 - (force->x * 0xff / 0xffff);
+
+	value[0] = 0x11;	/* Slot 1 */
+	value[1] = 0x08;
+	value[2] = scaled_x;
+	value[3] = 0x80;
+	value[4] = 0x00;
+	value[5] = 0x00;
+	value[6] = 0x00;
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	return 0;
+}
+
+static int hid_lg4ff_stop_combined(struct hid_device *hid, struct hid_report *report)
+{
+	__s32 *value = report->field[0]->value;
+
+	value[0] = 0x11;	/* Slot 1 */
+	value[1] = 0x08;
+	value[2] = 0x80;
+	value[3] = 0x80;
+	value[4] = 0x00;
+	value[5] = 0x00;
+	value[6] = 0x00;
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	return 0;
+}
+
+static int hid_lg4ff_control(struct input_dev *dev, void *data, const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
 	struct hid_report *report = list_entry(report_list->next, struct hid_report, list);
-	__s32 *value = report->field[0]->value;
-	int x;
-
-#define CLAMP(x) do { if (x < 0) x = 0; else if (x > 0xff) x = 0xff; } while (0)
-
-	switch (effect->type) {
-	case FF_CONSTANT:
-		x = effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
-		CLAMP(x);
-
-		if (x == 0x80) {
-			/* De-activate force in slot-1*/
-			value[0] = 0x13;
-			value[1] = 0x00;
-			value[2] = 0x00;
-			value[3] = 0x00;
-			value[4] = 0x00;
-			value[5] = 0x00;
-			value[6] = 0x00;
-
-			hid_hw_request(hid, report, HID_REQ_SET_REPORT);
-			return 0;
-		}
 
-		value[0] = 0x11;	/* Slot 1 */
-		value[1] = 0x08;
-		value[2] = x;
-		value[3] = 0x80;
-		value[4] = 0x00;
-		value[5] = 0x00;
-		value[6] = 0x00;
-
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	switch (command->cmd) {
+	case MLNX_START_COMBINED:
+		return hid_lg4ff_start_combined(hid, report, &command->u.simple_force);
+		break;
+	case MLNX_STOP_COMBINED:
+		return hid_lg4ff_stop_combined(hid, report);
 		break;
+	default:
+		dbg_hid("Unsupported effect command");
+		return -EINVAL;
 	}
-	return 0;
 }
 
 /* Sends default autocentering command compatible with
@@ -608,7 +624,7 @@ int lg4ff_init(struct hid_device *hid)
 	for (j = 0; lg4ff_devices[i].ff_effects[j] >= 0; j++)
 		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
 
-	error = input_ff_create_memless(dev, NULL, hid_lg4ff_play);
+	error = input_ff_create_mlnx(dev, (void *)NULL, hid_lg4ff_control, FF_UPDATE_RATE);
 
 	if (error)
 		return error;
-- 
1.8.5.3


