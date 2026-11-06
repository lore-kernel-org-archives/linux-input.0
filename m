Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975043;
	b=oEiV6OncEaO9R2yfR3j5HcmBdJ7zwAvEKtKg5jo9ZMln0hiOhE7Fk7xdleUEKVUD1xGs
	 cMOO9f5Ss5ObUV8J3n4ozA+3Lo7xx1sXr+aNW/YRrLNF3ed7BrX+fmuinUUPvWHTh7OHX
	 o5dN/2fFEkBhTCKGgCUJp94p17q6+hIrE6E4yZgzZGOb+A72a4WaFYpe8b7GxfvAVXxnR
	 Xwfa7TcY1cF4pNKJZPLEPmCuYS2AO0qksHd+mdemqfbziWhK6k+9N7wBRl4KtqJWGH0R3
	 mmrRUncGPbuiThsm4OAi+avU+g4DwmCPr30lEE+/9RqEgKoxgYirobDDQ6rAQmdXh9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975043;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hkSQvdh3FC6MIGSIeB+kH5rXVaMw72lATLr1WjdWlUY=;
	b=vdPZ5mYb2cCiRZei6saw8gFORk0/qVCZbzbubgbpaIxHWQrJD3XRjsj5m50FHJhYczG0
	 5PWGQzqe+ceJag//vAFm+iv+i4k+/bYL6pIQS0voYsbUs9MG1QBQybBgNJ8yoAIdi2Lza
	 uNXjMiIRtDMxPJnEHU93NQvd46IaSJTpdcwMhZbyoT5KNBWeX6i0iI3HIhZiaVWx20BQd
	 8m7Xd62tc781sWrSxH0Jo5zsmEJ+WXKpMm+m+wYQ8G21QtyET2AJ3qg06l2xv7Xqv2Xdz
	 cG4rtx/fLbP/hCg/zg6U8wW9PgRtKsbmG4ktrxsO5oYrAHy75VQ/sCvvKHc4royVpSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CKC8AwGt;
	arc=none smtp.remote-ip=91.218.175.171
Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0B606A335
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F0B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CKC8AwGt
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jJXQctkfCOOWOR19Qr1YpdgOibPqfE+y5WXbhTR6+7E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975039; v=1; x=1794579839;
 b=CKC8AwGtyNCxewgP65uLbhM4NhQNYj3jXl5d56cTbk9OkPzzNZaOTEeV53Zy369Q1P1U9IdV
 my9lSWxaYwmZTxU2xAQ0fjeJncfJ5uKNdO+NH32Un9+AS/Tu7k2ogW5BQRdkN8NN37itW5WNTtj
 FowS57b2thagIb4YraOmVmF8=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 812b825138e5b90f;
	Fri, 06 Nov 2026 14:23:59 +0000
X-Mizu-Trace-ID: 812b825138e5b90f
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Khamunetri Clark <khamunetriclark@gmail.com>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v14 02/18] HID: asus: add support for ROG Ally handhelds
Date: Fri,  6 Nov 2026 14:23:18 +0000
Message-ID: <20261106142334.1881-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106142334.1881-1-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the core functionality for ASUS handhelds:
- extend functionality of hid-asus if driver is enabled
- initialise the device to a "ready" state
- implement Ally X input mapping
- emit a single proper event for AC button long press

Each interface keeps its own state and reports on its own evdev.

Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 1262 +++++++++++++++++++++++++++++++++-------
 1 file changed, 1061 insertions(+), 201 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 46643022b68d..ae596a847571 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -22,16 +22,24 @@
 
 #include <linux/acpi.h>
 #include <linux/cleanup.h>
+#include <linux/compiler_attributes.h>
 #include <linux/container_of.h>
 #include <linux/dmi.h>
+#include <linux/err.h>
 #include <linux/hid.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/input/mt.h>
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
+#include <linux/rcupdate.h>
+#include <linux/stddef.h>
 #include <linux/leds.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 #include "hid-ids.h"
 
@@ -39,6 +47,9 @@ MODULE_AUTHOR("Yusuke Fujimaki <usk.fujimaki@gmail.com>");
 MODULE_AUTHOR("Brendan McGrath <redmcg@redmandi.dyndns.org>");
 MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
 MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
+MODULE_AUTHOR("Denis Benato <denis.benato@linux.dev>");
+MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
+MODULE_AUTHOR("Khamunetri Clark <khamunetriclark@gmail.com>");
 MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define T100_TPAD_INTF 2
@@ -56,6 +67,30 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
 
+#define HID_ALLY_INTF_KEYBOARD_IN 0x81
+#define HID_ALLY_INTF_CFG_IN 0x83
+#define HID_ALLY_X_INTF_IN 0x87
+
+#define HID_ALLY_GET_REPORT_ID 0x0D
+#define HID_ALLY_FEATURE_CODE_PAGE 0xD1
+
+#define HID_ALLY_X_INPUT_REPORT 0x0B
+
+#define HID_ALLY_READY_MAX_TRIES 6
+
+#define HID_INPUT_KEY_DELETE 0x4c
+#define HID_INPUT_KEY_F20 0x6f
+#define HID_INPUT_LCTRL_MODIFIER 0x01
+#define HID_INPUT_LALT_MODIFIER 0x04
+#define HID_INPUT_LCTRL_LALT (HID_INPUT_LCTRL_MODIFIER | HID_INPUT_LALT_MODIFIER)
+
+#define HID_INPUT_REPORT_ID_OFFSET 0
+#define HID_INPUT_MODIFIER_OFFSET 1
+#define HID_INPUT_RESERVED_OFFSET 2
+#define HID_INPUT_KEY_OFFSET 3
+
+#define ASUS_HID_INPUT_KBD_REPORT_ID 0x01
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -129,121 +164,964 @@ struct asus_work_action {
 		/* Data for BRIGHTNESS_SET */
 		unsigned int brightness;
 
-		/* Data for FN_LOCK_SYNC */
-		bool fn_lock;
+		/* Data for FN_LOCK_SYNC */
+		bool fn_lock;
+
+		/* Data for WMI_FAN */
+		struct hid_raw_event_data fan_hid_data;
+	} data;
+};
+
+struct asus_worker {
+	struct hid_device *hdev;
+	struct work_struct work;
+	struct list_head actions;
+	spinlock_t lock;
+	bool removed;
+};
+
+struct asus_xgm_led {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+};
+
+struct asus_touchpad_info {
+	int max_x;
+	int max_y;
+	int res_x;
+	int res_y;
+	int contact_size;
+	int max_contacts;
+	int report_size;
+};
+
+struct ally_intf {
+	struct hid_device *hdev;
+	/* HID-core evdev of this interface. Reports for it land here. */
+	struct input_dev *input;
+	/* Private gamepad node for report 0x0B. NULL on the other interfaces. */
+	struct input_dev *gamepad;
+	u8 cad_state;
+	unsigned long cad_last_event_time;
+	struct delayed_work resume_work;
+	/* Deferred free through ally_free(): keeps the memory valid for RCU
+	 * readers that loaded drvdata->ally before the teardown unpublished
+	 * it (see hid_asus_ally_terminate()).
+	 */
+	struct rcu_head rcu;
+};
+
+struct asus_drvdata {
+	unsigned long quirks;
+	struct hid_device *hdev;
+	struct input_dev *input;
+	struct input_dev *tp_kbd_input;
+	struct asus_worker *worker;
+	unsigned int kbd_backlight_brightness;
+	struct ally_intf *ally;
+	const struct asus_touchpad_info *tp;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	int battery_capacity;
+	int battery_stat;
+	bool battery_in_query;
+	unsigned long battery_next_query;
+	struct asus_hid_listener listener;
+	bool fn_lock;
+	struct asus_xgm_led *xgm_led;
+};
+
+static int asus_report_battery(struct asus_drvdata *, u8 *, int);
+
+static const struct asus_touchpad_info asus_i2c_tp = {
+	.max_x = 2794,
+	.max_y = 1758,
+	.contact_size = 5,
+	.max_contacts = 5,
+	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
+};
+
+static const struct asus_touchpad_info asus_t100ta_tp = {
+	.max_x = 2240,
+	.max_y = 1120,
+	.res_x = 30, /* units/mm */
+	.res_y = 27, /* units/mm */
+	.contact_size = 5,
+	.max_contacts = 5,
+	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
+};
+
+static const struct asus_touchpad_info asus_t100ha_tp = {
+	.max_x = 2640,
+	.max_y = 1320,
+	.res_x = 30, /* units/mm */
+	.res_y = 29, /* units/mm */
+	.contact_size = 5,
+	.max_contacts = 5,
+	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
+};
+
+static const struct asus_touchpad_info asus_t200ta_tp = {
+	.max_x = 3120,
+	.max_y = 1716,
+	.res_x = 30, /* units/mm */
+	.res_y = 28, /* units/mm */
+	.contact_size = 5,
+	.max_contacts = 5,
+	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
+};
+
+static const struct asus_touchpad_info asus_t100chi_tp = {
+	.max_x = 2640,
+	.max_y = 1320,
+	.res_x = 31, /* units/mm */
+	.res_y = 29, /* units/mm */
+	.contact_size = 3,
+	.max_contacts = 4,
+	.report_size = 15 /* 2 byte header + 3 * 4 + 1 byte footer */,
+};
+
+static const struct asus_touchpad_info medion_e1239t_tp = {
+	.max_x = 2640,
+	.max_y = 1380,
+	.res_x = 29, /* units/mm */
+	.res_y = 28, /* units/mm */
+	.contact_size = 5,
+	.max_contacts = 5,
+	.report_size = 32 /* 2 byte header + 5 * 5 + 5 byte footer */,
+};
+
+enum ally_command_codes {
+	CMD_SET_GAMEPAD_MODE            = 0x01,
+	CMD_SET_MAPPING                 = 0x02,
+	CMD_SET_JOYSTICK_MAPPING        = 0x03,
+	CMD_SET_JOYSTICK_DEADZONE       = 0x04,
+	CMD_SET_TRIGGER_RANGE           = 0x05,
+	CMD_SET_VIBRATION_INTENSITY     = 0x06,
+	CMD_LED_CONTROL                 = 0x08,
+	CMD_CHECK_READY                 = 0x0A,
+	CMD_SET_XBOX_CONTROLLER         = 0x0B,
+	CMD_CHECK_XBOX_SUPPORT          = 0x0C,
+	CMD_USER_CAL_DATA               = 0x0D,
+	CMD_CHECK_USER_CAL_SUPPORT      = 0x0E,
+	CMD_SET_TURBO_PARAMS            = 0x0F,
+	CMD_CHECK_TURBO_SUPPORT         = 0x10,
+	CMD_CHECK_RESP_CURVE_SUPPORT    = 0x12,
+	CMD_SET_RESP_CURVE              = 0x13,
+	CMD_CHECK_DIR_TO_BTN_SUPPORT    = 0x14,
+	CMD_SET_GYRO_PARAMS             = 0x15,
+	CMD_CHECK_GYRO_TO_JOYSTICK      = 0x16,
+	CMD_CHECK_ANTI_DEADZONE         = 0x17,
+	CMD_SET_ANTI_DEADZONE           = 0x18,
+};
+
+static const u8 ally_force_feedback_off[] = {
+	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
+};
+
+/*
+ * Each Ally interface owns its own ally_intf. A report is delivered on the
+ * evdev of the interface that received it. Nothing here points at another
+ * interface.
+ */
+static void ally_release_vendor_keys(struct input_dev *input)
+{
+	if (!input)
+		return;
+
+	input_report_key(input, KEY_F16, 0);
+	input_report_key(input, KEY_F17, 0);
+	input_report_key(input, KEY_F18, 0);
+	input_report_key(input, KEY_PROG1, 0);
+	input_sync(input);
+}
+
+static void ally_resume_work_fn(struct work_struct *work)
+{
+	struct ally_intf *intf = container_of(work, struct ally_intf,
+					      resume_work.work);
+
+	/*
+	 * Force release vendor buttons to prevent stuck keys on resume
+	 * (workaround for Ally X USB re-probing during suspend/resume).
+	 */
+	ally_release_vendor_keys(intf->input);
+}
+
+static void ally_quiesce(struct ally_intf *intf)
+{
+	if (!intf)
+		return;
+
+	/*
+	 * Disable so a concurrent asus_resume() cannot re-queue after the
+	 * cancel. The disabled state is sticky: a late schedule_delayed_work()
+	 * from a reader that loaded drvdata->ally before it was cleared is a
+	 * no-op, and the accesses it makes on the intf stay valid thanks to
+	 * the kfree_rcu() in ally_free(). drvdata->ally is cleared before
+	 * this runs.
+	 */
+	disable_delayed_work_sync(&intf->resume_work);
+}
+
+static void ally_unregister_gamepad(struct ally_intf *intf)
+{
+	if (!intf || !intf->gamepad)
+		return;
+
+	input_unregister_device(intf->gamepad);
+	intf->gamepad = NULL;
+}
+
+static void ally_free(struct ally_intf *intf)
+{
+	/*
+	 * Readers (asus_raw_event(), asus_resume()) may have loaded
+	 * drvdata->ally with rcu_dereference() while it was still published
+	 * and still be inside their RCU read-side critical sections: defer
+	 * the free to a grace period so they cannot observe freed memory.
+	 * The work has been canceled and disabled by ally_quiesce() already,
+	 * so nothing can touch intf after the grace period ends. NULL is a
+	 * no-op.
+	 */
+	kfree_rcu(intf, rcu);
+}
+
+/**
+ * handle_ctrl_alt_del() - detect a left button long press
+ * @intf: ally interface holding the sequence state
+ * @data: raw report buffer, rewritten in place when the sequence matches
+ * @size: length of @data in bytes
+ *
+ * The Ally left button emits a sequence of ctrl+alt+del events. Capture that
+ * and emit only a single code for that single event by rewriting @data in
+ * place. The return value tells the caller whether ally processing of this
+ * report should stop.
+ *
+ * Return: true when this step was recognized and @data was rewritten, so the
+ * caller stops and the generic parser consumes the rewritten report. false
+ * when @data was left unchanged and ally processing should continue.
+ */
+static bool handle_ctrl_alt_del(struct ally_intf *intf, u8 *data, int size)
+{
+	bool time_is_past = time_after(jiffies,
+				       intf->cad_last_event_time + msecs_to_jiffies(100));
+
+	if (size < 4 || data[HID_INPUT_REPORT_ID_OFFSET] != ASUS_HID_INPUT_KBD_REPORT_ID)
+		return false;
+
+	if (intf->cad_state > 0 && time_is_past)
+		intf->cad_state = 0;
+
+	intf->cad_last_event_time = jiffies;
+	switch (intf->cad_state) {
+	case 0:
+		if ((data[HID_INPUT_MODIFIER_OFFSET] == HID_INPUT_LCTRL_MODIFIER) &&
+		    (data[HID_INPUT_RESERVED_OFFSET] == 0x00) &&
+		    (data[HID_INPUT_KEY_OFFSET] == 0x00)) {
+			intf->cad_state = 1;
+			data[HID_INPUT_MODIFIER_OFFSET] = 0x00;
+			return true;
+		}
+		break;
+	case 1:
+		if ((data[HID_INPUT_MODIFIER_OFFSET] == HID_INPUT_LCTRL_LALT) &&
+		    (data[HID_INPUT_RESERVED_OFFSET] == 0x00) &&
+		    (data[HID_INPUT_KEY_OFFSET] == 0x00)) {
+			intf->cad_state = 2;
+			data[HID_INPUT_MODIFIER_OFFSET] = 0x00;
+			return true;
+		}
+		break;
+	case 2:
+		if ((data[HID_INPUT_MODIFIER_OFFSET] == HID_INPUT_LCTRL_LALT) &&
+		    (data[HID_INPUT_RESERVED_OFFSET] == 0x00) &&
+		    (data[HID_INPUT_KEY_OFFSET] == HID_INPUT_KEY_DELETE)) {
+			intf->cad_state = 3;
+			data[HID_INPUT_MODIFIER_OFFSET] = 0x00;
+			data[HID_INPUT_KEY_OFFSET] = HID_INPUT_KEY_F20;
+			return true;
+		}
+		break;
+	case 3:
+		if ((data[HID_INPUT_MODIFIER_OFFSET] == HID_INPUT_LALT_MODIFIER) &&
+		    (data[HID_INPUT_RESERVED_OFFSET] == 0x00) &&
+		    (data[HID_INPUT_KEY_OFFSET] == HID_INPUT_KEY_DELETE)) {
+			intf->cad_state = 4;
+			data[HID_INPUT_MODIFIER_OFFSET] = 0x00;
+			data[HID_INPUT_KEY_OFFSET] = 0x00;
+			return true;
+		}
+		break;
+	case 4:
+		if ((data[HID_INPUT_MODIFIER_OFFSET] == 0x00) &&
+		    (data[HID_INPUT_RESERVED_OFFSET] == 0x00) &&
+		    (data[HID_INPUT_KEY_OFFSET] == HID_INPUT_KEY_DELETE)) {
+			intf->cad_state = 5;
+			data[HID_INPUT_KEY_OFFSET] = 0x00;
+			return true;
+		}
+		break;
+	}
+	intf->cad_state = 0;
+	return false;
+}
+
+/**
+ * ally_vendor_keys() - Report a vendor button on this interface's evdev
+ * @input: HID-core input device of the interface that received the report
+ * @data: raw report buffer
+ * @size: length of @data in bytes
+ *
+ * Handles report 0x5A. A vendor key is reported down while @data[1] matches
+ * its code. @data[1] == 0 releases every known vendor key (and must reach
+ * hid-core). Any other code is ignored here and left to hid-core and the
+ * later filters. The same decode is used for every Ally interface.
+ *
+ * Return: true if @data[1] is one of the vendor codes, false otherwise.
+ */
+static bool ally_vendor_keys(struct input_dev *input, const u8 *data, int size)
+{
+	bool is_vendor;
+
+	if (size < 2 || data[0] != FEATURE_KBD_REPORT_ID)
+		return false;
+
+	is_vendor = data[1] == 0x38 || data[1] == 0xA6 ||
+		    data[1] == 0xA7 || data[1] == 0xA8 ||
+		    data[1] == 0x93;
+
+	/* Neither a vendor press nor a release: leave it to the other handlers. */
+	if (!is_vendor && data[1] != 0)
+		return false;
+
+	if (input) {
+		/* AC short press (ROG Ally) */
+		input_report_key(input, KEY_PROG1, data[1] == 0x38);
+
+		/* AC short release (ROG Ally X) */
+		input_report_key(input, KEY_PROG1, data[1] == 0x93);
+
+		/* CC short press & release */
+		input_report_key(input, KEY_F16,   data[1] == 0xA6);
+
+		/* AC long press */
+		input_report_key(input, KEY_F17,   data[1] == 0xA7);
+
+		/* AC long release */
+		input_report_key(input, KEY_F18,   data[1] == 0xA8);
+
+		input_sync(input);
+	}
+
+	/*
+	 * Only the vendor codes are consumed. They are reported on this
+	 * interface's evdev above, so hid-core never sees them pressed. Note
+	 * that 0xA8 ("AC long release") is itself a usage the firmware sends,
+	 * not the report that clears one. Everything else, including the 0x00
+	 * report that clears a held usage, must still reach hid-core: it can
+	 * only release the usages it saw pressed if it sees the report that
+	 * clears them.
+	 */
+	return is_vendor;
+}
+
+/**
+ * asus_find_report() - Find a report of the given type by its ID
+ * @hdev: HID device
+ * @type: report type (HID_INPUT_REPORT, HID_OUTPUT_REPORT or
+ * HID_FEATURE_REPORT)
+ * @report_id: report ID to look for
+ *
+ * Return: the report with the given ID, or NULL if the device does not
+ * declare such a report.
+ */
+static struct hid_report *asus_find_report(struct hid_device *hdev,
+					   unsigned int type, u8 report_id)
+{
+	return hdev->report_enum[type].report_id_hash[report_id];
+}
+
+/**
+ * asus_report_len() - Length of a feature report for the device
+ * @hdev: HID device
+ * @report_id: report ID of the feature report
+ *
+ * The same ASUS report ID can have different sizes depending on the device:
+ * report 0x5E is a 64-byte report on laptops but a 300-byte report on XG
+ * Mobile stations. Always size transfers from the report descriptor of the
+ * device at hand instead of hardcoding lengths.
+ *
+ * Return: the length of the feature report in bytes, or 0 if the device
+ * does not declare the report.
+ */
+static size_t asus_report_len(struct hid_device *hdev, u8 report_id)
+{
+	struct hid_report *report;
+
+	report = asus_find_report(hdev, HID_FEATURE_REPORT, report_id);
+
+	return report ? hid_report_len(report) : 0;
+}
+
+static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
+{
+	size_t hw_len = asus_report_len(hdev, buf[0]);
+
+	/* The payload (including the report ID) must fit the device report. */
+	if (!hw_len || buf_size > hw_len)
+		return -EINVAL;
+
+	u8 *dmabuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	memcpy(dmabuf, buf, buf_size);
+
+	/*
+	 * The report ID should be set from the incoming buffer due to LED and
+	 * key interfaces having different pages. Short payloads are zero-padded
+	 * to the exact report size the hardware expects for this report ID.
+	 */
+	return hid_hw_raw_request(hdev, buf[0], dmabuf, hw_len, HID_FEATURE_REPORT,
+				  HID_REQ_SET_REPORT);
+}
+
+/**
+ * asus_kbd_get_report() - Read a report sized from the descriptor
+ * @hdev: HID device
+ * @report_id: report ID to read
+ * @buf: buffer to store the report in
+ * @buf_size: size of @buf
+ *
+ * The transfer is performed at the exact report size the device declares
+ * for @report_id. The device may answer with a short read, and only the
+ * bytes that fit in @buf are copied into it.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int asus_kbd_get_report(struct hid_device *hdev, u8 report_id,
+			       u8 *buf, size_t buf_size)
+{
+	size_t hw_len = asus_report_len(hdev, report_id);
+	int ret;
+
+	if (!hw_len)
+		return -EINVAL;
+
+	u8 *dmabuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, report_id, dmabuf, hw_len,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0)
+		return ret;
+
+	/* The device may return less than requested (short read). */
+	memcpy(buf, dmabuf, min(buf_size, hw_len));
+
+	return 0;
+}
+
+static const u8 asus_report_id_init[] = {
+	FEATURE_KBD_REPORT_ID,
+	FEATURE_KBD_LED_REPORT_ID1,
+	FEATURE_KBD_LED_REPORT_ID2
+};
+
+static int ally_dev_set_report(struct hid_device *hdev, const u8 *buf, size_t len)
+{
+	return asus_kbd_set_report(hdev, buf, len);
+}
+
+static int ally_dev_get_report(struct hid_device *hdev, u8 *out, size_t len)
+{
+	return hid_hw_raw_request(hdev, HID_ALLY_GET_REPORT_ID, out, len,
+				  HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+}
+
+/**
+ * ally_gamepad_send_packet() - Send a raw packet to the gamepad device
+ * @hdev: HID device
+ * @buf: buffer containing the packet data
+ * @len: length of data to send
+ *
+ * Return: count of data transferred, negative if error.
+ */
+static int ally_gamepad_send_packet(struct hid_device *hdev, const u8 *buf, size_t len)
+{
+	return ally_dev_set_report(hdev, buf, len);
+}
+
+/**
+ * ally_gamepad_send_receive_packet() - Send a packet and receive the response
+ * @hdev: HID device
+ * @buf: buffer containing the packet data to send and receive response in
+ * @len: length of buffer
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int ally_gamepad_send_receive_packet(struct hid_device *hdev,
+					    u8 *buf, size_t len)
+{
+	int ret;
+
+	ret = ally_dev_set_report(hdev, buf, len);
+	if (ret >= 0) {
+		memset(buf, 0, len);
+		ret = ally_dev_get_report(hdev, buf, len);
+	}
+
+	return ret;
+}
+
+/**
+ * ally_alloc_cmd() - Construct a command buffer for the gamepad
+ * @hdev: HID device the command is built for
+ * @cmd: Command code to send
+ * @payload: Optional payload data to include in the command
+ * @payload_size: Size of the payload data
+ * @size: Where to store the length of the allocated buffer
+ *
+ * The buffer is sized after the feature report the device declares for
+ * the gamepad commands, and it is the caller responsibility to free the
+ * buffer using kfree().
+ *
+ * Return: the newly allocated buffer containing the command, or NULL on
+ * allocation failure or if the payload would not fit in the report.
+ */
+static u8 *ally_alloc_cmd(struct hid_device *hdev, u8 cmd, const u8 *payload,
+			  u8 payload_size, size_t *size)
+{
+	size_t hw_len = asus_report_len(hdev, FEATURE_KBD_REPORT_ID);
+	u8 *hidbuf;
+
+	/*
+	 * The payload is written after the 4-byte command header:
+	 * reject one that would spill past the end of the report.
+	 */
+	if (hw_len < 4 || payload_size > hw_len - 4)
+		return NULL;
+
+	hidbuf = kzalloc(hw_len, GFP_KERNEL);
+	if (!hidbuf)
+		return NULL;
+
+	hidbuf[0] = FEATURE_KBD_REPORT_ID;
+	hidbuf[1] = HID_ALLY_FEATURE_CODE_PAGE;
+	hidbuf[2] = cmd;
+	hidbuf[3] = payload_size;
+
+	if (payload_size > 0 && payload)
+		memcpy(&hidbuf[4], payload, payload_size);
+
+	*size = hw_len;
+
+	return hidbuf;
+}
+
+/**
+ * ally_gamepad_check_ready() - Wait for the gamepad MCU to report ready
+ * @hdev: HID device
+ *
+ * This should be called before any remapping attempts, and on driver
+ * init/resume, after the asus handshake has been performed on the
+ * configuration endpoint.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int ally_gamepad_check_ready(struct hid_device *hdev)
+{
+	const u8 payload[] = { 0x00 };
+	size_t buf_len;
+	int ret;
+
+	for (int i = 0; i < HID_ALLY_READY_MAX_TRIES; i++) {
+		u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_CHECK_READY,
+						       payload, sizeof(payload),
+						       &buf_len);
+		if (!buf)
+			return -ENOMEM;
+
+		ret = ally_gamepad_send_receive_packet(hdev, buf, buf_len);
+		if (ret < 0)
+			hid_dbg(hdev, "ROG Ally check %d/%d failed: %d\n", i,
+				HID_ALLY_READY_MAX_TRIES, ret);
+		else if (buf[2] == CMD_CHECK_READY)
+			return 0;
+
+		/* Back off on a bus error as well as on a not-ready answer. */
+		usleep_range(1000, 2000);
+	}
+
+	hid_err(hdev, "ROG Ally never responded with a ready\n");
+	return -ENODEV;
+}
+
+static int ally_get_endpoint_address(struct hid_device *hdev)
+{
+	struct usb_host_endpoint *ep;
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return -ENODEV;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	if (!intf || !intf->cur_altsetting)
+		return -ENODEV;
+
+	if (intf->cur_altsetting->desc.bNumEndpoints == 0)
+		return -ENODEV;
+
+	ep = intf->cur_altsetting->endpoint;
+	if (!ep)
+		return -ENODEV;
+
+	return ep->desc.bEndpointAddress;
+}
+
+struct ally_x_input_report {
+	__le16 x, y;
+	__le16 rx, ry;
+	__le16 z, rz;
+	u8 buttons[3];
+} __packed;
+
+/* The hatswitch outputs integers, we use them to index this X|Y pair */
+static const int hat_values[][2] = {
+	{ 0, 0 }, { 0, -1 }, { 1, -1 }, { 1, 0 },   { 1, 1 },
+	{ 0, 1 }, { -1, 1 }, { -1, 0 }, { -1, -1 },
+};
+
+/**
+ * ally_x_raw_event() - Parse and report an Ally X gamepad input report
+ * @input: input device to report the events on
+ * @data: raw report buffer
+ * @size: length of @data in bytes
+ *
+ * Return: true if the event was handled, otherwise false.
+ */
+static bool ally_x_raw_event(struct input_dev *input, u8 *data, int size)
+{
+	struct ally_x_input_report *in_report;
+	u16 x, y, rx, ry, z, rz;
+	u8 byte;
+
+	if (!input)
+		return false;
+
+	if (size < 1)
+		return false;
+
+	if (data[0] != HID_ALLY_X_INPUT_REPORT)
+		return false;
+
+	/*
+	 * hid-core only guarantees size >= 1 and does not zero-pad short
+	 * reports before ->raw_event, so a truncated transfer would leave the
+	 * payload below pointing at stale DMA buffer contents.
+	 */
+	if (size < 1 + sizeof(*in_report))
+		return false;
+
+	in_report = (struct ally_x_input_report *)&data[1];
+
+	/* USB HID payloads are little-endian: convert them explicitly. */
+	x = get_unaligned_le16(&in_report->x);
+	y = get_unaligned_le16(&in_report->y);
+	rx = get_unaligned_le16(&in_report->rx);
+	ry = get_unaligned_le16(&in_report->ry);
+	z = get_unaligned_le16(&in_report->z);
+	rz = get_unaligned_le16(&in_report->rz);
+
+	input_report_abs(input, ABS_X, x - 32768);
+	input_report_abs(input, ABS_Y, y - 32768);
+	input_report_abs(input, ABS_RX, rx - 32768);
+	input_report_abs(input, ABS_RY, ry - 32768);
+	input_report_abs(input, ABS_Z, z);
+	input_report_abs(input, ABS_RZ, rz);
+
+	byte = in_report->buttons[0];
+	input_report_key(input, BTN_A, byte & BIT(0));
+	input_report_key(input, BTN_B, byte & BIT(1));
+	input_report_key(input, BTN_X, byte & BIT(2));
+	input_report_key(input, BTN_Y, byte & BIT(3));
+	input_report_key(input, BTN_TL, byte & BIT(4));
+	input_report_key(input, BTN_TR, byte & BIT(5));
+	input_report_key(input, BTN_SELECT, byte & BIT(6));
+	input_report_key(input, BTN_START, byte & BIT(7));
+
+	byte = in_report->buttons[1];
+	input_report_key(input, BTN_THUMBL, byte & BIT(0));
+	input_report_key(input, BTN_THUMBR, byte & BIT(1));
+	input_report_key(input, BTN_MODE, byte & BIT(2));
+
+	/*
+	 * The hatswitch byte is device-controlled; treat anything the table
+	 * does not cover as centred rather than indexing out of bounds.
+	 */
+	byte = in_report->buttons[2];
+	if (byte >= ARRAY_SIZE(hat_values))
+		byte = 0;
+	input_report_abs(input, ABS_HAT0X, hat_values[byte][0]);
+	input_report_abs(input, ABS_HAT0Y, hat_values[byte][1]);
+
+	input_sync(input);
+
+	return true;
+}
+
+static int ally_x_input_open(struct input_dev *dev)
+{
+	struct ally_intf *intf = input_get_drvdata(dev);
+
+	return hid_hw_open(intf->hdev);
+}
+
+static void ally_x_input_close(struct input_dev *dev)
+{
+	struct ally_intf *intf = input_get_drvdata(dev);
+
+	hid_hw_close(intf->hdev);
+}
+
+static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev,
+						struct ally_intf *intf)
+{
+	struct input_dev *input_dev = input_allocate_device();
+
+	if (!input_dev)
+		return ERR_PTR(-ENOMEM);
+
+	input_dev->dev.parent = &hdev->dev;
+	input_dev->id.bustype = hdev->bus;
+	input_dev->id.vendor = hdev->vendor;
+	input_dev->id.product = hdev->product;
+	input_dev->id.version = hdev->version;
+	input_dev->uniq = hdev->uniq;
+	input_dev->name = "ASUS ROG Ally X Gamepad";
+
+	input_set_drvdata(input_dev, intf);
+	/*
+	 * Let the input core hold the hardware open while the device node
+	 * is in use: without these the interface could be runtime-suspended
+	 * and drop events.
+	 */
+	input_dev->open = ally_x_input_open;
+	input_dev->close = ally_x_input_close;
+
+	return input_dev;
+}
+
+static int ally_x_setup_input(struct hid_device *hdev, struct ally_intf *intf)
+{
+	struct input_dev *input = ally_x_alloc_input_dev(hdev, intf);
+	int ret;
+
+	if (IS_ERR(input))
+		return PTR_ERR(input);
+
+	input_set_abs_params(input, ABS_X, -32768, 32767, 0, 0);
+	input_set_abs_params(input, ABS_Y, -32768, 32767, 0, 0);
+	input_set_abs_params(input, ABS_RX, -32768, 32767, 0, 0);
+	input_set_abs_params(input, ABS_RY, -32768, 32767, 0, 0);
+	input_set_abs_params(input, ABS_Z, 0, 1023, 0, 0);
+	input_set_abs_params(input, ABS_RZ, 0, 1023, 0, 0);
+	input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
+	input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
+	input_set_capability(input, EV_KEY, BTN_A);
+	input_set_capability(input, EV_KEY, BTN_B);
+	input_set_capability(input, EV_KEY, BTN_X);
+	input_set_capability(input, EV_KEY, BTN_Y);
+	input_set_capability(input, EV_KEY, BTN_TL);
+	input_set_capability(input, EV_KEY, BTN_TR);
+	input_set_capability(input, EV_KEY, BTN_SELECT);
+	input_set_capability(input, EV_KEY, BTN_START);
+	input_set_capability(input, EV_KEY, BTN_MODE);
+	input_set_capability(input, EV_KEY, BTN_THUMBL);
+	input_set_capability(input, EV_KEY, BTN_THUMBR);
+
+	ret = input_register_device(input);
+	if (ret) {
+		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
+		input_free_device(input);
+		return ret;
+	}
+
+	intf->gamepad = input;
+	return 0;
+}
+
+static int hid_asus_ally_init(struct hid_device *hdev)
+{
+	int ret;
+
+	/* Failure at this point is non-critical. The packet goes to this interface. */
+	ret = ally_gamepad_send_packet(hdev, ally_force_feedback_off,
+				       sizeof(ally_force_feedback_off));
+	if (ret < 0)
+		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
+
+	return 0;
+}
+
+/**
+ * hid_asus_ally_raw_event() - Route raw reports from one Ally interface
+ * @hdev: HID device the report arrived on
+ * @intf: that interface's ally state
+ * @data: raw report buffer
+ * @size: length of @data in bytes
+ *
+ * Called from the raw_event callback, which may run in atomic context.
+ * Only this interface's own input devices are used.
+ *
+ * Return: true if the event was handled, otherwise false.
+ */
+static bool hid_asus_ally_raw_event(struct hid_device *hdev, struct ally_intf *intf,
+				    u8 *data, int size)
+{
+	if (!intf)
+		return false;
+
+	if (ally_vendor_keys(intf->input, data, size))
+		return true;
+
+	switch (ally_get_endpoint_address(hdev)) {
+	case HID_ALLY_X_INTF_IN:
+		return ally_x_raw_event(intf->gamepad, data, size);
+	case HID_ALLY_INTF_KEYBOARD_IN:
+		if (handle_ctrl_alt_del(intf, data, size))
+			return false;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static struct input_dev *ally_interface_input(struct hid_device *hdev)
+{
+	struct hid_input *hidinput;
+
+	if (list_empty(&hdev->inputs))
+		return NULL;
+
+	hidinput = list_first_entry(&hdev->inputs, struct hid_input, list);
+	return hidinput->input;
+}
+
+/**
+ * hid_asus_ally_probe() - Initialize the ROG Ally HID extension
+ * @hdev: HID device
+ *
+ * The Ally code is a plugin of the Asus HID driver: one ally_intf per
+ * bound interface, freed by the caller after hid_hw_stop(). Interfaces
+ * do not share device pointers, so a second interface cannot evict the
+ * first.
+ *
+ * Return: an ally_intf pointer on success, NULL when this endpoint has no
+ * Ally role, or an ERR_PTR on failure. On failure the function frees
+ * anything it allocated.
+ */
+static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
+{
+	int ret, ep = ally_get_endpoint_address(hdev);
+
+	if (ep < 0)
+		return ERR_PTR(ep);
 
-		/* Data for WMI_FAN */
-		struct hid_raw_event_data fan_hid_data;
-	} data;
-};
+	if (ep != HID_ALLY_INTF_CFG_IN && ep != HID_ALLY_X_INTF_IN &&
+	    ep != HID_ALLY_INTF_KEYBOARD_IN)
+		return NULL;
 
-struct asus_worker {
-	struct hid_device *hdev;
-	struct work_struct work;
-	struct list_head actions;
-	spinlock_t lock;
-	bool removed;
-};
+	struct ally_intf *intf __free(kfree) = kzalloc_obj(*intf);
 
-struct asus_xgm_led {
-	struct led_classdev cdev;
-	struct hid_device *hdev;
-};
+	if (!intf)
+		return ERR_PTR(-ENOMEM);
 
-struct asus_touchpad_info {
-	int max_x;
-	int max_y;
-	int res_x;
-	int res_y;
-	int contact_size;
-	int max_contacts;
-	int report_size;
-};
+	intf->hdev = hdev;
+	intf->input = ally_interface_input(hdev);
+	INIT_DELAYED_WORK(&intf->resume_work, ally_resume_work_fn);
 
-struct asus_drvdata {
-	unsigned long quirks;
-	struct hid_device *hdev;
-	struct input_dev *input;
-	struct input_dev *tp_kbd_input;
-	struct asus_worker *worker;
-	unsigned int kbd_backlight_brightness;
-	const struct asus_touchpad_info *tp;
-	struct power_supply *battery;
-	struct power_supply_desc battery_desc;
-	int battery_capacity;
-	int battery_stat;
-	bool battery_in_query;
-	unsigned long battery_next_query;
-	struct asus_hid_listener listener;
-	bool fn_lock;
-	struct asus_xgm_led *xgm_led;
-};
+	switch (ep) {
+	case HID_ALLY_INTF_CFG_IN:
+		/*
+		 * This function assumes the asus-specific initialization
+		 * to have been performed already at this point.
+		 */
+		ret = ally_gamepad_check_ready(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
+			return ERR_PTR(ret);
+		}
 
-static int asus_report_battery(struct asus_drvdata *, u8 *, int);
+		hid_asus_ally_init(hdev);
+		break;
+	case HID_ALLY_X_INTF_IN:
+		ret = ally_x_setup_input(hdev, intf);
+		if (ret) {
+			hid_err(hdev, "Failed to create Ally X gamepad device.\n");
+			return ERR_PTR(ret);
+		}
+		break;
+	case HID_ALLY_INTF_KEYBOARD_IN:
+		break;
+	default:
+		return NULL;
+	}
 
-static const struct asus_touchpad_info asus_i2c_tp = {
-	.max_x = 2794,
-	.max_y = 1758,
-	.contact_size = 5,
-	.max_contacts = 5,
-	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
-};
+	return no_free_ptr(intf);
+}
 
-static const struct asus_touchpad_info asus_t100ta_tp = {
-	.max_x = 2240,
-	.max_y = 1120,
-	.res_x = 30, /* units/mm */
-	.res_y = 27, /* units/mm */
-	.contact_size = 5,
-	.max_contacts = 5,
-	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
-};
+static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf *intf)
+{
+	int ep;
 
-static const struct asus_touchpad_info asus_t100ha_tp = {
-	.max_x = 2640,
-	.max_y = 1320,
-	.res_x = 30, /* units/mm */
-	.res_y = 29, /* units/mm */
-	.contact_size = 5,
-	.max_contacts = 5,
-	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
-};
+	/*
+	 * The extensions failed to probe and the device is operating as a
+	 * generic HID device: do not fail the resume because of that.
+	 */
+	if (!intf)
+		return 0;
 
-static const struct asus_touchpad_info asus_t200ta_tp = {
-	.max_x = 3120,
-	.max_y = 1716,
-	.res_x = 30, /* units/mm */
-	.res_y = 28, /* units/mm */
-	.contact_size = 5,
-	.max_contacts = 5,
-	.report_size = 28 /* 2 byte header + 5 * 5 + 1 byte footer */,
-};
+	ep = ally_get_endpoint_address(hdev);
+	if (ep != HID_ALLY_INTF_CFG_IN)
+		return 0;
 
-static const struct asus_touchpad_info asus_t100chi_tp = {
-	.max_x = 2640,
-	.max_y = 1320,
-	.res_x = 31, /* units/mm */
-	.res_y = 29, /* units/mm */
-	.contact_size = 3,
-	.max_contacts = 4,
-	.report_size = 15 /* 2 byte header + 3 * 4 + 1 byte footer */,
-};
+	return hid_asus_ally_init(hdev);
+}
 
-static const struct asus_touchpad_info medion_e1239t_tp = {
-	.max_x = 2640,
-	.max_y = 1380,
-	.res_x = 29, /* units/mm */
-	.res_y = 28, /* units/mm */
-	.contact_size = 5,
-	.max_contacts = 5,
-	.report_size = 32 /* 2 byte header + 5 * 5 + 5 byte footer */,
-};
+static struct ally_intf *hid_asus_ally_terminate(struct asus_drvdata *drvdata)
+{
+	/*
+	 * Pairs with rcu_assign_pointer() in asus_probe(): ensures the
+	 * ally_intf fields set before publication (input, gamepad,
+	 * resume_work) are visible before we quiesce and free it.
+	 *
+	 * asus_probe() and asus_remove() are the only writers and are
+	 * serialized by the device lock, so this is a plain read.
+	 */
+	struct ally_intf *ally = rcu_dereference_protected(drvdata->ally, true);
 
-static const u8 asus_report_id_init[] = {
-	FEATURE_KBD_REPORT_ID,
-	FEATURE_KBD_LED_REPORT_ID1,
-	FEATURE_KBD_LED_REPORT_ID2
-};
+	if (!ally)
+		return NULL;
+
+	/*
+	 * Unpublish first so no rcu_dereference() reader can pick @ally up
+	 * past this point. Readers that already loaded it are given a full
+	 * grace period to drop out before ally_free() frees the memory, and
+	 * quiescing the work makes any schedule_delayed_work() they were
+	 * about to perform a no-op.
+	 */
+	rcu_assign_pointer(drvdata->ally, NULL);
+
+	ally_quiesce(ally);
+	ally_unregister_gamepad(ally);
+
+	return ally;
+}
 
 /*
  * Send events to asus-wmi driver for handling special keys
@@ -496,6 +1374,8 @@ static int asus_raw_event(struct hid_device *hdev,
 		struct hid_report *report, u8 *data, int size)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_intf *intf;
+	bool stop_parsing;
 	int ret;
 
 	if (size < 2) {
@@ -512,6 +1392,25 @@ static int asus_raw_event(struct hid_device *hdev,
 	if (drvdata->quirks & QUIRK_MEDION_E1239T)
 		return asus_e1239t_event(drvdata, data, size);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		/*
+		 * Return -1 to suppress further processing by the generic HID
+		 * input parser for reports we fully handle. The interface is
+		 * published with rcu_assign_pointer() only after its fields
+		 * are set, and is kept alive by the RCU read-side lock even
+		 * if it races with the teardown in asus_remove(). Letting
+		 * report 0x0B reach the default parser creates a generic
+		 * gamepad and Steam Input overlaps.
+		 */
+		rcu_read_lock();
+		intf = rcu_dereference(drvdata->ally); /* fields are published */
+		stop_parsing = hid_asus_ally_raw_event(hdev, intf, data, size);
+		rcu_read_unlock();
+
+		if (stop_parsing)
+			return -1;
+	}
+
 	/*
 	 * Skip these report ID, the device emits a continuous stream associated
 	 * with the AURA mode it is in which looks like an 'echo'.
@@ -581,104 +1480,6 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-/**
- * asus_find_report() - Find a report of the given type by its ID
- * @hdev: HID device
- * @type: report type (HID_INPUT_REPORT, HID_OUTPUT_REPORT or
- * HID_FEATURE_REPORT)
- * @report_id: report ID to look for
- *
- * Return: the report with the given ID, or NULL if the device does not
- * declare such a report.
- */
-static struct hid_report *asus_find_report(struct hid_device *hdev,
-					   unsigned int type, u8 report_id)
-{
-	return hdev->report_enum[type].report_id_hash[report_id];
-}
-
-/**
- * asus_report_len() - Length of a feature report for the device
- * @hdev: HID device
- * @report_id: report ID of the feature report
- *
- * The same ASUS report ID can have different sizes depending on the device:
- * report 0x5E is a 64-byte report on laptops but a 300-byte report on XG
- * Mobile stations. Always size transfers from the report descriptor of the
- * device at hand instead of hardcoding lengths.
- *
- * Return: the length of the feature report in bytes, or 0 if the device
- * does not declare the report.
- */
-static size_t asus_report_len(struct hid_device *hdev, u8 report_id)
-{
-	struct hid_report *report;
-
-	report = asus_find_report(hdev, HID_FEATURE_REPORT, report_id);
-
-	return report ? hid_report_len(report) : 0;
-}
-
-static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
-{
-	size_t hw_len = asus_report_len(hdev, buf[0]);
-
-	/* The payload (including the report ID) must fit the device report. */
-	if (!hw_len || buf_size > hw_len)
-		return -EINVAL;
-
-	u8 *dmabuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	memcpy(dmabuf, buf, buf_size);
-
-	/*
-	 * The report ID should be set from the incoming buffer due to LED and
-	 * key interfaces having different pages. Short payloads are zero-padded
-	 * to the exact report size the hardware expects for this report ID.
-	 */
-	return hid_hw_raw_request(hdev, buf[0], dmabuf, hw_len, HID_FEATURE_REPORT,
-				  HID_REQ_SET_REPORT);
-}
-
-/**
- * asus_kbd_get_report() - Read a report sized from the descriptor
- * @hdev: HID device
- * @report_id: report ID to read
- * @buf: buffer to store the report in
- * @buf_size: size of @buf
- *
- * The transfer is performed at the exact report size the device declares
- * for @report_id. The device may answer with a short read, and only the
- * bytes that fit in @buf are copied into it.
- *
- * Return: 0 on success, negative errno on failure.
- */
-static int asus_kbd_get_report(struct hid_device *hdev, u8 report_id,
-			       u8 *buf, size_t buf_size)
-{
-	size_t hw_len = asus_report_len(hdev, report_id);
-	int ret;
-
-	if (!hw_len)
-		return -EINVAL;
-
-	u8 *dmabuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	ret = hid_hw_raw_request(hdev, report_id, dmabuf, hw_len,
-				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
-	if (ret < 0)
-		return ret;
-
-	/* The device may return less than requested (short read). */
-	memcpy(buf, dmabuf, min(buf_size, hw_len));
-
-	return 0;
-}
-
 static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 {
 	/*
@@ -1395,6 +2196,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0x5f: asus_map_key_clear(KEY_PROG2);	break; /* S-shaped programmable key */
 		case 0x6b: asus_map_key_clear(KEY_F21);		break; /* ASUS touchpad toggle */
 		case 0x38: asus_map_key_clear(KEY_PROG1);	break; /* ROG key */
+		case 0x93: asus_map_key_clear(KEY_PROG1);	break; /* ROG Ally X AC button */
 		case 0xba: asus_map_key_clear(KEY_PROG2);	break; /* Fn+C ASUS Splendid */
 		case 0x5c: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Space Power4Gear */
 		case 0x99: asus_map_key_clear(KEY_PROG4);	break; /* Fn+F5 "fan" symbol */
@@ -1569,6 +2371,7 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 static int __maybe_unused asus_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_intf *intf;
 
 	/*
 	 * If we have a backlight listener registered, restore the previous state,
@@ -1578,12 +2381,25 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
 
+	/*
+	 * Published with rcu_assign_pointer() after the fields are set. The
+	 * RCU read-side lock keeps @intf alive even if the resume races with
+	 * the teardown in asus_remove(): a work that got quiesced in the
+	 * meantime is disabled and schedule_delayed_work() just drops it.
+	 */
+	rcu_read_lock();
+	intf = rcu_dereference(drvdata->ally);
+	if (intf)
+		schedule_delayed_work(&intf->resume_work, msecs_to_jiffies(500));
+	rcu_read_unlock();
+
 	return 0;
 }
 
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
 
 	if (!drvdata->tp)
 		asus_initialize_reports(hdev);
@@ -1591,6 +2407,22 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 	if (drvdata->tp)
 		return asus_start_multitouch(hdev);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		/*
+		 * hid_asus_ally_reset_resume() only NULL-tests the interface,
+		 * it never dereferences it: rcu_access_pointer() suffices and
+		 * does not need an RCU read-side section, which would be
+		 * illegal here anyway as the reset resume sleeps in the raw
+		 * request it sends to the device.
+		 */
+		ret = hid_asus_ally_reset_resume(hdev,
+						 rcu_access_pointer(drvdata->ally));
+		if (ret) {
+			hid_err(hdev, "Failed to resume ROG Ally HID extensions: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1598,6 +2430,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hid_report_enum *rep_enum;
 	struct asus_drvdata *drvdata;
+	struct ally_intf *ally;
 	struct hid_report *rep;
 	bool is_vendor = false;
 	int ret;
@@ -1715,12 +2548,22 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
-	/* Laptops keyboard backlight is always at 0x5a */
+	/* Laptops keyboard backlight is always FEATURE_KBD_REPORT_ID */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
 		(asus_kbd_register_leds(hdev)))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		ally = hid_asus_ally_probe(hdev);
+		if (IS_ERR(ally))
+			hid_err(hdev, "Failed to initialize ROG Ally HID extensions: %ld\n",
+				PTR_ERR(ally));
+		else
+			/* Readers take this with rcu_dereference(). */
+			rcu_assign_pointer(drvdata->ally, ally);
+	}
+
 	/*
 	 * For ROG keyboards, skip rename for consistency and ->input check as
 	 * some devices do not have inputs.
@@ -1755,6 +2598,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		ally = hid_asus_ally_terminate(drvdata);
+		asus_worker_stop(drvdata->worker);
+		hid_hw_stop(hdev);
+		ally_free(ally);
+		return ret;
+	}
+
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 	return ret;
@@ -1763,6 +2614,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void asus_remove(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_intf *ally;
 
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
@@ -1770,6 +2622,14 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		ally = hid_asus_ally_terminate(drvdata);
+		asus_worker_stop(drvdata->worker);
+		hid_hw_stop(hdev);
+		ally_free(ally);
+		return;
+	}
+
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 }
-- 
2.47.3

