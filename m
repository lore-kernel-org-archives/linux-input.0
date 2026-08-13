Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C447426B
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632466; cv=none; b=c1e1n4hYnunWSOG6Kdhqvyt1+jp8/EfH18DaipqcgyyOAcV1oTvl6cO3SQWh4EH/6cnZwI+X/QCcrcm5Ecc7T+qBAlxNlHaJb6ckonqK9Nm9KFGvjLjN0ZWsZaojb54L6AVIqUvnZB2nZ92+JsjvpizSpajJWrQNQ9KTH/SMW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632466; c=relaxed/simple;
	bh=o5xo44wCUjb7jlih/DDQAWMnnmmN5lMtGSpZlvl2g7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOky68pRsBfAYORgxVVWbqbnMvKP6EbucazGFpEJ2THyNJlt1j2NzgihsBYgEbnGu3pQ0jW4oNx8nx3n2gdGMas2l60cb82eSCvl4EPJFlVcWCK9baZSxeeHunn2Q5ddPEL6KC6rivO9IF75oaKM+4RRtdzAK0HDoLXB4wZqlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VF1k49Xn; arc=none smtp.client-ip=91.218.175.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VF1k49Xn"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o5xo44wCUjb7jlih/DDQAWMnnmmN5lMtGSpZlvl2g7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632460; v=1; x=1787237260;
 b=VF1k49Xnp5nopDAQOCRQZkgv+Lc4RG0A2RcT6oWpBUzul7iD5yyRjLmZgXCkvheZxLzLXLL8
 R+IR6WmEBF3Uwtpi11lRgKYz97wm3jSKst0SHBs/tCqvtacfUWdKn+aLDNNZ6DqBT8f7jI9Xw51
 Il6ccm7LWTS2G2AJFA1AspdY=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 24149915a76f14db;
	Thu, 13 Aug 2026 14:47:40 +0000
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 02/12] HID: asus: add support for ROG Ally handhelds
Date: Thu, 13 Aug 2026 14:47:26 +0000
Message-ID: <20260813144736.2477941-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144736.2477941-1-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the core functionality for ASUS handhelds:
- extend functionality of hid-asus if driver is enabled
- initialise the device to a "ready" state
- implement Ally X input mapping
- emit a single proper event for AC button long press

Assisted-by: Claude:claude-fable-5
Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 729 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 725 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 897b04d06b46..f4b2c4a616b7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -24,11 +24,16 @@
 #include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/hid.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/x86/asus-wmi.h>
+#include <linux/types.h>
 #include <linux/input/mt.h>
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
+#include <linux/stddef.h>
 #include <linux/leds.h>
 
 #include "hid-ids.h"
@@ -37,6 +42,9 @@ MODULE_AUTHOR("Yusuke Fujimaki <usk.fujimaki@gmail.com>");
 MODULE_AUTHOR("Brendan McGrath <redmcg@redmandi.dyndns.org>");
 MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
 MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
+MODULE_AUTHOR("Denis Benato <denis.benato@linux.dev>");
+MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
+MODULE_AUTHOR("Khamunetri Clark <khamunetriclark@gmail.com>");
 MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define T100_TPAD_INTF 2
@@ -55,6 +63,19 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
 
+#define HID_ALLY_INTF_KEYBOARD_IN 0x81
+#define HID_ALLY_INTF_CFG_IN 0x83
+#define HID_ALLY_X_INTF_IN 0x87
+
+#define HID_ALLY_GET_REPORT_ID 0x0D
+#define HID_ALLY_SET_REPORT_ID 0x5A
+#define HID_ALLY_FEATURE_CODE_PAGE 0xD1
+
+#define HID_ALLY_X_INPUT_REPORT_SIZE 16
+#define HID_ALLY_X_INPUT_REPORT 0x0B
+
+#define HID_ALLY_READY_MAX_TRIES 6
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -154,6 +175,23 @@ struct asus_touchpad_info {
 	int report_size;
 };
 
+struct ally_handheld {
+	/* All read/write to IN interfaces must lock */
+	struct mutex intf_mutex;
+	struct hid_device *cfg_hdev;
+
+	struct input_dev *ally_x_input;
+	struct hid_device *ally_x_hdev;
+
+	struct hid_device *keyboard_hdev;
+	struct input_dev *keyboard_input;
+
+	u8 cad_sequence_state;
+	unsigned long cad_last_event_time;
+
+	struct delayed_work resume_work;
+};
+
 struct asus_drvdata {
 	unsigned long quirks;
 	struct hid_device *hdev;
@@ -161,6 +199,7 @@ struct asus_drvdata {
 	struct input_dev *tp_kbd_input;
 	struct asus_worker *worker;
 	unsigned int kbd_backlight_brightness;
+	struct ally_handheld *rog_ally;
 	const struct asus_touchpad_info *tp;
 	struct power_supply *battery;
 	struct power_supply_desc battery_desc;
@@ -232,12 +271,655 @@ static const struct asus_touchpad_info medion_e1239t_tp = {
 	.report_size = 32 /* 2 byte header + 5 * 5 + 5 byte footer */,
 };
 
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
+static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
+	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
+};
+
+/*
+ * The ROG Ally device presents multiple USB interfaces (keyboard, mouse, gamepad,
+ * and custom configuration interface) that bind to the same module. Since only
+ * one ROG Ally device can be connected at a time, we use a single global static
+ * ally_handheld structure to share state across these separate HID interfaces.
+ */
+static void ally_resume_work_fn(struct work_struct *work);
+
+/* Changes to ally_drvdata must lock */
+static DEFINE_MUTEX(ally_data_mutex);
+static struct ally_handheld ally_drvdata = {
+	.intf_mutex = __MUTEX_INITIALIZER(ally_drvdata.intf_mutex),
+	/*
+	 * Initialised statically so it is always safe to cancel, whichever
+	 * of the interfaces probed or failed to probe.
+	 */
+	.resume_work = __DELAYED_WORK_INITIALIZER(ally_drvdata.resume_work,
+						  ally_resume_work_fn, 0),
+};
+
 static const u8 asus_report_id_init[] = {
 	FEATURE_KBD_REPORT_ID,
 	FEATURE_KBD_LED_REPORT_ID1,
 	FEATURE_KBD_LED_REPORT_ID2
 };
 
+static inline int ally_dev_set_report(struct hid_device *hdev, const u8 *buf, size_t len)
+{
+	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	return hid_hw_raw_request(hdev, buf[0], dmabuf, len,
+					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+}
+
+static inline int ally_dev_get_report(struct hid_device *hdev, u8 *out, size_t len)
+{
+	return hid_hw_raw_request(hdev, HID_ALLY_GET_REPORT_ID, out, len,
+		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+}
+
+static void ally_resume_work_fn(struct work_struct *work)
+{
+	struct ally_handheld *ally = container_of(work, struct ally_handheld,
+						  resume_work.work);
+	struct input_dev *keyboard_input, *x_input;
+
+	/*
+	 * Test the very pointers that get dereferenced: probe sets
+	 * keyboard_hdev even when the interface exposes no input_dev, and
+	 * removal clears the two fields one after the other.
+	 */
+	keyboard_input = READ_ONCE(ally->keyboard_input);
+	x_input = READ_ONCE(ally->ally_x_input);
+
+	/* Force release all vendor buttons to prevent "stuck" ghosting on resume
+	 * (workaround for Ally X USB re-probing during suspend/resume)
+	 */
+	if (keyboard_input) {
+		input_report_key(keyboard_input, KEY_F16, 0);
+		input_report_key(keyboard_input, KEY_F17, 0);
+		input_report_key(keyboard_input, KEY_F18, 0);
+		input_report_key(keyboard_input, KEY_PROG1, 0);
+		input_sync(keyboard_input);
+	}
+
+	if (x_input) {
+		input_report_key(x_input, KEY_F16, 0);
+		input_report_key(x_input, KEY_F17, 0);
+		input_report_key(x_input, KEY_F18, 0);
+		input_report_key(x_input, KEY_PROG1, 0);
+		input_sync(x_input);
+	}
+}
+
+/**
+ * handle_ctrl_alt_del() - detect a left button long press.
+ * @hdev: HID device the report arrived on
+ * @ally: ally handheld structure holding the sequence state
+ * @data: raw report buffer, rewritten in place when the sequence matches
+ * @size: length of @data in bytes
+ *
+ * The Ally left button emits a sequence of ctrl+alt+del events. Capture that
+ * and emit only a single code for that single event.
+ *
+ * Return: true iff the event has been managed
+ */
+static bool handle_ctrl_alt_del(struct hid_device *hdev,
+				struct ally_handheld *ally, u8 *data, int size)
+{
+	bool time_is_past = time_after(jiffies, ally->cad_last_event_time + msecs_to_jiffies(100));
+
+	if (size < 16 || data[0] != 0x01)
+		return false;
+
+	if (ally->cad_sequence_state > 0 && time_is_past)
+		ally->cad_sequence_state = 0;
+
+	ally->cad_last_event_time = jiffies;
+
+	switch (ally->cad_sequence_state) {
+	case 0:
+		if (data[1] == 0x01 && data[2] == 0x00 && data[3] == 0x00) {
+			ally->cad_sequence_state = 1;
+			data[1] = 0x00;
+			return true;
+		}
+		break;
+	case 1:
+		if (data[1] == 0x05 && data[2] == 0x00 && data[3] == 0x00) {
+			ally->cad_sequence_state = 2;
+			data[1] = 0x00;
+			return true;
+		}
+		break;
+	case 2:
+		if (data[1] == 0x05 && data[2] == 0x00 && data[3] == 0x4c) {
+			ally->cad_sequence_state = 3;
+			data[1] = 0x00;
+			data[3] = 0x6F; // F20;
+			return true;
+		}
+		break;
+	case 3:
+		if (data[1] == 0x04 && data[2] == 0x00 && data[3] == 0x4c) {
+			ally->cad_sequence_state = 4;
+			data[1] = data[3] = 0x00;
+			return true;
+		}
+		break;
+	case 4:
+		if (data[1] == 0x00 && data[2] == 0x00 && data[3] == 0x4c) {
+			ally->cad_sequence_state = 5;
+			data[3] = 0x00;
+			return true;
+		}
+		break;
+	}
+	ally->cad_sequence_state = 0;
+	return false;
+}
+
+static bool handle_ally_event(struct hid_device *hdev, struct ally_handheld *ally,
+			      u8 *data, int size)
+{
+	struct input_dev *keyboard_input;
+	int keycode = 0;
+
+	if (size < 2)
+		return false;
+
+	if (data[0] == 0x5A) {
+		switch (data[1]) {
+		case 0x38:
+			keycode = KEY_F19;
+			break;
+		case 0xA6:
+			keycode = KEY_F16;
+			break;
+		case 0xA7:
+			keycode = KEY_F17;
+			break;
+		case 0xA8:
+			keycode = KEY_F18;
+			break;
+		default:
+			return false;
+		}
+
+		scoped_guard(mutex, &ally_data_mutex) {
+			keyboard_input = ally->keyboard_input;
+			if (keyboard_input) {
+				input_report_key(keyboard_input, keycode, 1);
+				input_sync(keyboard_input);
+				input_report_key(keyboard_input, keycode, 0);
+				input_sync(keyboard_input);
+				return true;
+			}
+		}
+	}
+	return false;
+}
+
+/**
+ * ally_gamepad_send_packet() - Send a raw packet to the gamepad device.
+ *
+ * @ally: ally handheld structure
+ * @hdev: hid device
+ * @buf: Buffer containing the packet data
+ * @len: Length of data to send
+ *
+ * Return: count of data transferred, negative if error
+ */
+static int ally_gamepad_send_packet(struct ally_handheld *ally,
+			     struct hid_device *hdev, const u8 *buf, size_t len)
+{
+	scoped_guard(mutex, &ally->intf_mutex)
+		return ally_dev_set_report(hdev, buf, len);
+}
+
+/**
+ * ally_gamepad_send_receive_packet() - Send a packet and receive the response.
+ * @ally: ally handheld structure
+ * @hdev: hid device
+ * @buf: Buffer containing the packet data to send and receive response in
+ * @len: Length of buffer
+ *
+ * Return: count of data transferred, negative if error
+ */
+static int ally_gamepad_send_receive_packet(struct ally_handheld *ally,
+					    struct hid_device *hdev,
+					    u8 *buf, size_t len)
+{
+	int ret;
+
+	scoped_guard(mutex, &ally->intf_mutex) {
+		ret = ally_dev_set_report(hdev, buf, len);
+		if (ret >= 0) {
+			memset(buf, 0, len);
+			ret = ally_dev_get_report(hdev, buf, len);
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * ally_alloc_cmd() - Construct a command buffer for the gamepad
+ * @cmd: Command code to send
+ * @payload: Optional payload data to include in the command
+ * @payload_size: Size of the payload data
+ *
+ * The constructed buffer is 64 bytes long, and it is the caller
+ * responsibility to free the buffer using kfree().
+ *
+ * Returns the pointer of newly allocated buffer containing the command,
+ * or NULL on allocation failure.
+ */
+static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
+{
+	u8 *hidbuf = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
+
+	if (!hidbuf)
+		return NULL;
+
+	hidbuf[0] = HID_ALLY_SET_REPORT_ID;
+	hidbuf[1] = HID_ALLY_FEATURE_CODE_PAGE;
+	hidbuf[2] = cmd;
+	hidbuf[3] = payload_size;
+
+	if (payload_size > 0 && payload)
+		memcpy(&hidbuf[4], payload, payload_size);
+
+	return hidbuf;
+}
+
+/*
+ * This should be called before any remapping attempts,
+ * and on driver init/resume, after the asus handshake
+ * has been performed on the configuration endpoint.
+ */
+static int ally_gamepad_check_ready(struct ally_handheld *ally, struct hid_device *hdev)
+{
+	u8 payload[] = { 0x00 };
+	int ret;
+
+	for (int i = 0; i < HID_ALLY_READY_MAX_TRIES; i++) {
+		u8 *buf __free(kfree) = ally_alloc_cmd(CMD_CHECK_READY, payload, sizeof(payload));
+		if (!buf)
+			return -ENOMEM;
+
+		ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+		if (ret < 0) {
+			hid_dbg(hdev, "ROG Ally check %d/%d failed: %d\n", i,
+				HID_ALLY_READY_MAX_TRIES, ret);
+			continue;
+		}
+
+		if (buf[2] == CMD_CHECK_READY)
+			return 0;
+
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
+	ep = intf->cur_altsetting->endpoint;
+	if (!ep)
+		return -ENODEV;
+
+	return ep->desc.bEndpointAddress;
+}
+
+struct ally_x_input_report {
+	uint16_t x, y;
+	uint16_t rx, ry;
+	uint16_t z, rz;
+	uint8_t buttons[3];
+} __packed;
+
+/* The hatswitch outputs integers, we use them to index this X|Y pair */
+static const int hat_values[][2] = {
+	{ 0, 0 }, { 0, -1 }, { 1, -1 }, { 1, 0 },   { 1, 1 },
+	{ 0, 1 }, { -1, 1 }, { -1, 0 }, { -1, -1 },
+};
+
+/* Return true if event was handled, otherwise false */
+static bool ally_x_raw_event(struct input_dev *input, struct hid_device *hdev,
+			    struct hid_report *report, u8 *data, int size)
+{
+	struct ally_x_input_report *in_report;
+	u8 byte;
+
+	if (!input)
+		return false;
+
+	if (size < 1)
+		return false;
+
+	if (data[0] == 0x5A) {
+		input_report_key(input, KEY_PROG1, data[1] == 0x38);
+		input_report_key(input, KEY_F16, data[1] == 0xA6);
+		input_report_key(input, KEY_F17, data[1] == 0xA7);
+		input_report_key(input, KEY_F18, data[1] == 0xA8);
+		input_sync(input);
+
+		return data[1] == 0xA6 || data[1] == 0xA7 || data[1] == 0xA8 || data[1] == 0x38;
+	}
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
+	input_report_abs(input, ABS_X, in_report->x - 32768);
+	input_report_abs(input, ABS_Y, in_report->y - 32768);
+	input_report_abs(input, ABS_RX, in_report->rx - 32768);
+	input_report_abs(input, ABS_RY, in_report->ry - 32768);
+	input_report_abs(input, ABS_Z, in_report->z);
+	input_report_abs(input, ABS_RZ, in_report->rz);
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
+	/* The hatswitch byte is device-controlled; treat anything the table
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
+static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev)
+{
+	struct input_dev *input_dev = devm_input_allocate_device(&hdev->dev);
+
+	if (!input_dev)
+		return ERR_PTR(-ENOMEM);
+
+	input_dev->id.bustype = hdev->bus;
+	input_dev->id.vendor = hdev->vendor;
+	input_dev->id.product = hdev->product;
+	input_dev->id.version = hdev->version;
+	input_dev->uniq = hdev->uniq;
+	input_dev->name = "ASUS ROG Ally X Gamepad";
+
+	input_set_drvdata(input_dev, hdev);
+
+	return input_dev;
+}
+
+static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *ally)
+{
+	struct input_dev *input = ally_x_alloc_input_dev(hdev);
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
+	input_set_capability(input, EV_KEY, KEY_PROG1);
+	input_set_capability(input, EV_KEY, KEY_F16);
+	input_set_capability(input, EV_KEY, KEY_F17);
+	input_set_capability(input, EV_KEY, KEY_F18);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
+
+	ret = input_register_device(input);
+	if (ret) {
+		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
+		goto ally_x_setup_input_err;
+	}
+
+	ally->ally_x_input = input;
+
+	return 0;
+ally_x_setup_input_err:
+	return ret;
+}
+
+static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
+{
+	int ret;
+
+	/*
+	 * This function assumes the asus-specific initialization
+	 * to have been performed already at this point.
+	 */
+	ret = ally_gamepad_check_ready(ally, hdev);
+	if (ret < 0) {
+		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
+		return ret;
+	}
+
+	/* Failure at this point is non-critical */
+	ret = ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
+				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
+	if (ret < 0)
+		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
+
+	return 0;
+}
+
+static bool hid_asus_ally_raw_event(struct hid_device *hdev, struct ally_handheld *ally,
+			struct hid_report *report, u8 *data, int size)
+{
+	struct input_dev *x_input;
+	struct hid_device *x_hdev;
+
+	if (!ally)
+		return false;
+
+	switch (ally_get_endpoint_address(hdev)) {
+	case HID_ALLY_X_INTF_IN:
+		scoped_guard(mutex, &ally_data_mutex) {
+			x_input = ally->ally_x_input;
+			x_hdev = ally->ally_x_hdev;
+		}
+		if (ally_x_raw_event(x_input, x_hdev, report, data, size))
+			return true;
+		break;
+	case HID_ALLY_INTF_CFG_IN:
+		if (handle_ally_event(hdev, ally, data, size))
+			return true;
+		break;
+	case HID_ALLY_INTF_KEYBOARD_IN:
+		if (handle_ctrl_alt_del(hdev, ally, data, size))
+			return false;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/*
+ * Initialize ROG Ally HID extension: this module works alongside
+ * the main Asus HID driver to handle Ally-specific features
+ * and quirks.
+ *
+ * returns:
+ * Either an ally_handheld struct pointer on success, or an ERR_PTR on failure.
+ * The caller is not expected to use the returned pointer, but it should
+ * check for errors by using IS_ERR and PTR_ERR and pass to other functions
+ * NULL if there was an error.
+ */
+static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
+{
+	int ret = 0, ep = ally_get_endpoint_address(hdev);
+	struct hid_input *hidinput;
+
+	if (ep < 0)
+		return ERR_PTR(ep);
+
+	scoped_guard(mutex, &ally_data_mutex)
+		switch (ep) {
+		case HID_ALLY_INTF_CFG_IN:
+			ally_drvdata.cfg_hdev = hdev;
+			ret = hid_asus_ally_init(hdev, &ally_drvdata);
+			if (ret < 0) {
+				ally_drvdata.cfg_hdev = NULL;
+				return ERR_PTR(ret);
+			}
+
+			break;
+		case HID_ALLY_X_INTF_IN:
+			ally_drvdata.ally_x_hdev = hdev;
+			/* This will create and populate ally_x_input */
+			ret = ally_x_setup_input(hdev, &ally_drvdata);
+			if (ret) {
+				hid_err(hdev, "Failed to create Ally X gamepad device.\n");
+				ally_drvdata.ally_x_hdev = NULL;
+				return ERR_PTR(ret);
+			}
+			break;
+		case HID_ALLY_INTF_KEYBOARD_IN:
+			ally_drvdata.keyboard_hdev = hdev;
+			if (!list_empty(&hdev->inputs)) {
+				hidinput = list_first_entry(&hdev->inputs, struct hid_input, list);
+				ally_drvdata.keyboard_input = hidinput->input;
+			}
+			break;
+		default:
+			/* This is normally supposed to happen */
+			break;
+		}
+
+	return &ally_drvdata;
+}
+
+static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *ally)
+{
+	if (!ally)
+		return;
+
+	/*
+	 * Any of the three interfaces can own an input_dev the resume work
+	 * reports through, and they are torn down in an arbitrary order, so
+	 * drain it before clearing anything. Cancel outside ally_data_mutex so
+	 * a handler that wants the mutex cannot deadlock against us.
+	 */
+	cancel_delayed_work_sync(&ally->resume_work);
+
+	scoped_guard(mutex, &ally_data_mutex) {
+		if (ally->ally_x_hdev == hdev) {
+			ally->ally_x_input = NULL;
+			ally->ally_x_hdev = NULL;
+		}
+
+		/*
+		 * The keyboard interface is torn down before the config one, and
+		 * its input_dev is freed with it. handle_ally_event() and
+		 * ally_resume_work_fn() both report keys through it from the
+		 * config endpoint, so drop the references here or they dangle.
+		 */
+		if (ally->keyboard_hdev == hdev) {
+			ally->keyboard_input = NULL;
+			ally->keyboard_hdev = NULL;
+		}
+	}
+}
+
+static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handheld *ally)
+{
+	int ep = ally_get_endpoint_address(hdev);
+	int ret;
+
+	if (!ally)
+		return -EINVAL;
+
+	if (ep != HID_ALLY_INTF_CFG_IN)
+		return 0;
+
+	ret = hid_asus_ally_init(hdev, ally);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /*
  * Send events to asus-wmi driver for handling special keys
  */
@@ -505,6 +1187,17 @@ static int asus_raw_event(struct hid_device *hdev,
 	if (drvdata->quirks & QUIRK_MEDION_E1239T)
 		return asus_e1239t_event(drvdata, data, size);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		/*
+		 * Return -1 to suppress further processing by the generic HID
+		 * input parser for reports we fully handle for the Gamepad (0x0B).
+		 * If we let 0x0B fallthrough then the default parser creates a
+		 * generic gamepad causing Steam Input overlaps (i.e. L1 stuck on screenshot).
+		 */
+		if (hid_asus_ally_raw_event(hdev, drvdata->rog_ally, report, data, size))
+			return -1;
+	}
+
 	/*
 	 * Skip these report ID, the device emits a continuous stream associated
 	 * with the AURA mode it is in which looks like an 'echo'.
@@ -1254,6 +1947,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0x5f: asus_map_key_clear(KEY_PROG2);	break; /* S-shaped programmable key */
 		case 0x6b: asus_map_key_clear(KEY_F21);		break; /* ASUS touchpad toggle */
 		case 0x38: asus_map_key_clear(KEY_PROG1);	break; /* ROG key */
+		case 0x93: asus_map_key_clear(KEY_PROG1);	break; /* ROG Ally X AC button */
 		case 0xba: asus_map_key_clear(KEY_PROG2);	break; /* Fn+C ASUS Splendid */
 		case 0x5c: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Space Power4Gear */
 		case 0x99: asus_map_key_clear(KEY_PROG4);	break; /* Fn+F5 "fan" symbol */
@@ -1266,7 +1960,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xa5: asus_map_key_clear(KEY_F15);		break; /* ROG Ally left back */
 		case 0xa6: asus_map_key_clear(KEY_F16);		break; /* ROG Ally QAM button */
 		case 0xa7: asus_map_key_clear(KEY_F17);		break; /* ROG Ally ROG long-press */
-		case 0xa8: asus_map_key_clear(KEY_F18);		break; /* ROG Ally ROG long-press-release */
+		case 0xa8: asus_map_key_clear(KEY_F18);		break;
 
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
@@ -1379,6 +2073,8 @@ static int asus_initialize_reports(struct hid_device *hdev)
 static int __maybe_unused asus_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	int ep;
 
 	/*
 	 * If we have a backlight listener registered, restore the previous state,
@@ -1388,6 +2084,12 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
 
+	if (ally && (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)) {
+		ep = ally_get_endpoint_address(hdev);
+		if (ep == HID_ALLY_INTF_CFG_IN)
+			schedule_delayed_work(&ally->resume_work, msecs_to_jiffies(500));
+	}
+
 	return 0;
 }
 
@@ -1399,21 +2101,28 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 	ret = asus_initialize_reports(hdev);
 	if (ret) {
 		hid_err(hdev, "Asus initialize reports failed: %d\n", ret);
-		goto asus_reset_resume_err;
+		return ret;
 	}
 
 	if (drvdata->tp)
 		return asus_start_multitouch(hdev);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		ret = hid_asus_ally_reset_resume(hdev, drvdata->rog_ally);
+		if (ret) {
+			hid_err(hdev, "Failed to resume ROG Ally HID extensions: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
-asus_reset_resume_err:
-	return ret;
 }
 
 static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hid_report_enum *rep_enum;
 	struct asus_drvdata *drvdata;
+	struct ally_handheld *ally;
 	struct hid_report *rep;
 	bool is_vendor = false;
 	int ret;
@@ -1530,6 +2239,15 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		(asus_kbd_register_leds(hdev)))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+		ally = hid_asus_ally_probe(hdev);
+		if (IS_ERR(ally))
+			hid_err(hdev, "Failed to initialize ROG Ally HID extensions: %ld\n",
+				PTR_ERR(ally));
+		else
+			drvdata->rog_ally = ally;
+	}
+
 	/*
 	 * For ROG keyboards, skip rename for consistency and ->input check as
 	 * some devices do not have inputs.
@@ -1573,6 +2291,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
+		hid_asus_ally_remove(hdev, drvdata->rog_ally);
+
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 }
-- 
2.47.3

