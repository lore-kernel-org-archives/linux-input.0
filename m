Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D32F6586
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120037; cv=none; b=d84g/KAv+7XfpcOPbApJ8X9usQ5kmuwZjaXe0yY3stydjdAZ34qovqd0g0gcRsn7cAlf51dRApJQ3UzjRom572te5JFvzroadu009o3LFqK/pYibN/rHTjQr4+lElLdimbfYe4KjQihTyhNQxWBbaSoAQcm6g5vCoAD6g3f7mbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120037; c=relaxed/simple;
	bh=kESOryoxzAxt4sTkiVry0cXKrOUyoDmgFmhc2V0uTPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQZpuo1/PtS6whZiOXfNNxfyQ5FPbG5yU60+ow9g3qFuem1Nf1CVavbNviYgMrmFq4CRy/dpBRUxvWJH4Sy0F2LztiTAv1ULDyGa6pk/dAgslGbnBdzdN7vRtLYJmbouHOROSG5u8AJbxJFHkt2GjHaZ9i0bkkZa15mEyz9sSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=NEcApoOJ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="NEcApoOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120035; bh=kESOryoxzAxt4sTkiVry0cXKrOUyoDmgFmhc2V0uTPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEcApoOJaoSVnEpao+PoWg3Hzs+HbSFJ844EBLtZVN8lSJ3oTezttL2V3OyBM//ZS
	 1Adc9IPLxs0xQ1Lptk4Fnw1Jecjnd+pvEcYv4LhtSfHSM7JCNlhXcGzU+kY70IN1XB
	 JZYjpTT7BXjScRTtBMcyW2OkIYL0vZkiipiTnajVH+1Kg1B/qfaNMYNMutkh4k4FIY
	 L//hineFg1jf08t19e9UJNy33jujaQNbcTA0oYbvSidVGzNq7op6uiY7e1yD8yCQSM
	 dWBQIRyO7GSLCe9FIrMPnpN+e8Yrd8GEq/rmVllQYD3tVQaDFjRHeXwIxIJ2X0gdWC
	 G01I7t4VvT1NA==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id E574DA0B5;
	Mon, 09 Mar 2026 22:20:34 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 09/10] Input: xbox_gip - Add wheel support
Date: Mon,  9 Mar 2026 22:20:03 -0700
Message-ID: <20260310052017.1289494-10-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310052017.1289494-1-vi@endrift.com>
References: <20260310052017.1289494-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds preliminary support for racing wheel support in xbox_gip,
exposing them mapped to the newly added axes.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/Makefile      |   2 +-
 drivers/input/joystick/gip/gip-core.c    |   4 +-
 drivers/input/joystick/gip/gip-drivers.c |  10 +
 drivers/input/joystick/gip/gip-wheel.c   | 348 +++++++++++++++++++++++
 drivers/input/joystick/gip/gip.h         |   4 +
 5 files changed, 366 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/joystick/gip/gip-wheel.c

diff --git a/drivers/input/joystick/gip/Makefile b/drivers/input/joystick/gip/Makefile
index 94ce6462d7ab0..db6c9079c7e18 100644
--- a/drivers/input/joystick/gip/Makefile
+++ b/drivers/input/joystick/gip/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 obj-$(CONFIG_JOYSTICK_XBOX_GIP)	+= xbox-gip.o
-xbox-gip-y := gip-arcade-stick.o gip-core.o gip-drivers.o
+xbox-gip-y := gip-arcade-stick.o gip-core.o gip-drivers.o gip-wheel.o
diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 1164b689856e7..773d7705b7be8 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -10,7 +10,7 @@
  * - Event logging
  * - Sending fragmented messages
  * - Raw character device
- * - Wheel support
+ * - Wheel force feedback
  * - Flight stick support
  * - More arcade stick testing
  * - Arcade stick extra buttons
@@ -317,6 +317,8 @@ static const struct gip_driver* base_drivers[] = {
 	&gip_driver_navigation,
 	&gip_driver_gamepad,
 	&gip_driver_arcade_stick,
+	&gip_driver_trueforce_wheel,
+	&gip_driver_wheel,
 	NULL /* Sentinel */
 };
 
diff --git a/drivers/input/joystick/gip/gip-drivers.c b/drivers/input/joystick/gip/gip-drivers.c
index f5507e6215a94..e15f580d371d8 100644
--- a/drivers/input/joystick/gip/gip-drivers.c
+++ b/drivers/input/joystick/gip/gip-drivers.c
@@ -140,6 +140,11 @@ static int gip_setup_navigation_input(struct gip_attachment *attachment, struct
 	input_set_capability(input, EV_KEY, BTN_TR);
 	input_set_capability(input, EV_KEY, BTN_TL);
 
+	if (attachment->quirks & GIP_QUIRK_FORCE_GAMEPAD_SB) {
+		input_set_capability(input, EV_KEY, BTN_THUMBR);
+		input_set_capability(input, EV_KEY, BTN_THUMBL);
+	}
+
 	attachment->dpad_as_buttons = dpad_as_buttons;
 	if (attachment->dpad_as_buttons) {
 		input_set_capability(input, EV_KEY, BTN_DPAD_UP);
@@ -191,6 +196,11 @@ static int gip_handle_navigation_report(struct gip_attachment *attachment,
 		input_report_key(input, BTN_TR, bytes[1] & BIT(5));
 	}
 
+	if (attachment->quirks & GIP_QUIRK_FORCE_GAMEPAD_SB) {
+		input_report_key(input, BTN_THUMBL, bytes[1] & BIT(6));
+		input_report_key(input, BTN_THUMBR, bytes[1] & BIT(7));
+	}
+
 	return 0;
 }
 
diff --git a/drivers/input/joystick/gip/gip-wheel.c b/drivers/input/joystick/gip/gip-wheel.c
new file mode 100644
index 0000000000000..34e7795f16534
--- /dev/null
+++ b/drivers/input/joystick/gip/gip-wheel.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Drivers for GIP racing wheel devices
+ *
+ * Copyright (c) 2025 Valve Software
+ *
+ * This driver is based on the Microsoft GIP spec at:
+ * https://aka.ms/gipdocs
+ * https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gipusb/e7c90904-5e21-426e-b9ad-d82adeee0dbc
+ */
+#include "gip.h"
+
+/* Wheel vendor messages */
+#define GIP_CMD_SET_APPLICATION_MEMORY	0x0b
+#define GIP_CMD_SET_EQUATIONS_STATES	0x0c
+#define GIP_CMD_SET_EQUATION 0x0d
+
+/* Wheel-specific flags */
+#define GIP_WHEEL_HAS_POWER		BIT(3)
+#define GIP_WHEEL_HANDBRAKE_CONN	BIT(4)
+#define GIP_WHEEL_CLUTCH_CONN		BIT(5)
+#define GIP_WHEEL_BRAKE_CONN		BIT(6)
+#define GIP_WHEEL_THROTTLE_CONN		BIT(7)
+
+#define GIP_HSHIFTER_NONE	0
+#define GIP_HSHIFTER_2POS	1 /* 2 position, no neutral */
+#define GIP_HSHIFTER_2POS_N	2 /* 2 position, neutral */
+#define GIP_HSHIFTER_RTL_1TL	3 /* Reverse top left, first top left */
+#define GIP_HSHIFTER_RTL_1BL	4 /* Reverse top left, first bottom left */
+#define GIP_HSHIFTER_RBL	5 /* Reverse bottom left */
+#define GIP_HSHIFTER_RTR	6 /* Reverse top right */
+#define GIP_HSHIFTER_RBR	7 /* Reverse bottom right */
+
+struct gip_wheel_info {
+	uint8_t shifter_type: 3;
+	uint8_t max_gear: 5;
+	uint16_t angle_setting;
+	uint16_t max_angle;
+	uint16_t max_throttle;
+	uint16_t max_brake;
+	uint16_t max_clutch;
+	uint8_t max_handbrake;
+	int8_t value_retries;
+};
+
+struct gip_initial_reports_request {
+	uint8_t type;
+	uint8_t data[2];
+};
+
+static int gip_wheel_probe(struct gip_attachment *attachment)
+{
+	struct gip_wheel_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info)
+		return -ENOMEM;
+	attachment->driver_data = info;
+
+	return 0;
+}
+
+static void gip_wheel_remove(struct gip_attachment *attachment)
+{
+	kfree(attachment->driver_data);
+	attachment->driver_data = NULL;
+}
+
+static int gip_wheel_init(struct gip_attachment *attachment)
+{
+	struct gip_initial_reports_request request = { 0 };
+	int rc = gip_send_vendor_message(attachment,
+		GIP_CMD_INITIAL_REPORTS_REQUEST, 0, &request,
+		sizeof(request));
+
+	if (rc < 0)
+		return rc;
+
+	return GIP_INIT_NO_INPUT;
+}
+
+static int gip_setup_wheel_input(struct gip_attachment *attachment, struct input_dev* input)
+{
+	int rc = gip_driver_navigation.setup_input(attachment, input);
+	struct gip_wheel_info *info = attachment->driver_data;
+
+	if (rc < 0)
+		return rc;
+
+	if (!info)
+		return -ENODEV;
+
+	input_set_abs_params(input, ABS_WHEEL, -info->max_angle - 1, info->max_angle, 0, 0);
+	input_abs_set_res(input, ABS_WHEEL, info->angle_setting);
+	if (info->max_throttle)
+		input_set_abs_params(input, ABS_GAS, 0, info->max_throttle, 0, 0);
+
+	if (info->max_brake)
+		input_set_abs_params(input, ABS_BRAKE, 0, info->max_brake, 0, 0);
+
+	if (info->max_clutch)
+		input_set_abs_params(input, ABS_CLUTCH, 0, info->max_clutch, 0, 0);
+
+	if (info->max_handbrake)
+		input_set_abs_params(input, ABS_HANDBRAKE, 0, info->max_handbrake, 0, 0);
+
+	if (info->shifter_type)
+		input_set_abs_params(input, ABS_SHIFTER, -1, info->max_gear, 0, 0);
+
+	return 0;
+}
+
+static int gip_handle_wheel_ll_input_report(struct gip_attachment *attachment,
+	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
+{
+	int rc = 0;
+	struct gip_wheel_info *info = attachment->driver_data;
+
+	if (num_bytes < 17)
+		return -EINVAL;
+
+	if (!info)
+		return -ENODEV;
+
+	info->max_gear = bytes[11] & 0x1F;
+	info->shifter_type = bytes[11] >> 5;
+	info->angle_setting = bytes[13];
+	info->angle_setting |= bytes[14] << 8;
+
+	if (info->angle_setting && info->max_angle) {
+		if (info->value_retries-- > 0)
+			return 0;
+
+		rc = gip_setup_input_device(attachment);
+	} else {
+		return 0;
+	}
+
+	if (rc < 0)
+		return rc;
+
+	/* Now that we're done configuring, fall back to default handler */
+	attachment->vendor_handlers[GIP_LL_INPUT_REPORT] = NULL;
+
+	return 0;
+}
+
+static int gip_handle_wheel_report(struct gip_attachment *attachment,
+	struct input_dev *input, const uint8_t *bytes, int num_bytes)
+{
+	int32_t axis;
+	uint8_t connections;
+	struct gip_wheel_info *info = attachment->driver_data;
+	int rc = gip_driver_navigation.handle_input_report(attachment, input, bytes, num_bytes);
+
+	if (rc < 0)
+		return rc;
+
+	if (!info)
+		return -ENODEV;
+
+	if (num_bytes < 17)
+		return -EINVAL;
+
+	axis = bytes[2];
+	axis |= bytes[3] << 8;
+	input_report_abs(input, ABS_WHEEL, axis - 0x8000);
+
+	connections = bytes[16];
+
+	if (attachment->quirks & GIP_QUIRK_WHEEL_FORCE_HANDBRAKE)
+		connections |= GIP_WHEEL_HANDBRAKE_CONN;
+
+	if (connections & GIP_WHEEL_THROTTLE_CONN) {
+		axis = bytes[4];
+		axis |= bytes[5] << 8;
+		input_report_abs(input, ABS_GAS, axis);
+	} else {
+		input_report_abs(input, ABS_GAS, 0);
+	}
+
+	if (connections & GIP_WHEEL_BRAKE_CONN) {
+		axis = bytes[6];
+		axis |= bytes[7] << 8;
+		input_report_abs(input, ABS_BRAKE, axis);
+	} else {
+		input_report_abs(input, ABS_BRAKE, 0);
+	}
+
+	if (connections & GIP_WHEEL_CLUTCH_CONN) {
+		axis = bytes[8];
+		axis |= bytes[9] << 8;
+		input_report_abs(input, ABS_CLUTCH, axis);
+	} else {
+		input_report_abs(input, ABS_CLUTCH, 0);
+	}
+
+	if (connections & GIP_WHEEL_HANDBRAKE_CONN)
+		input_report_abs(input, ABS_HANDBRAKE, bytes[10]);
+	else
+		input_report_abs(input, ABS_HANDBRAKE, 0);
+
+	if (info->shifter_type)
+		input_report_abs(input, ABS_SHIFTER, (int8_t)bytes[12]);
+
+	return 0;
+}
+
+static int gip_handle_wheel_ll_static_configuration(struct gip_attachment *attachment,
+	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
+{
+	struct gip_wheel_info *info = attachment->driver_data;
+
+	if (!info)
+		return -ENODEV;
+
+	if (num_bytes < 11)
+		return -EINVAL;
+
+	info->max_angle = BIT(bytes[0]) - 1;
+	info->max_throttle = BIT(bytes[1]) - 1;
+	info->max_brake = BIT(bytes[2]) - 1;
+	info->max_clutch = BIT(bytes[3]) - 1;
+	info->max_handbrake = BIT(bytes[4]) - 1;
+
+	if (info->angle_setting && info->max_angle && info->value_retries <= 0)
+		return gip_setup_input_device(attachment);
+
+	return 0;
+}
+
+const struct gip_driver gip_driver_wheel = {
+	.types = (const char* const[]) {
+		"Windows.Xbox.Input.Wheel",
+		"Microsoft.Xbox.Input.Wheel",
+		NULL
+	},
+	.guid = GUID_INIT(0x646979cf, 0x6b71, 0x4e96, 0x8d, 0xf9,
+		0x59, 0xe3, 0x98, 0xd7, 0x42, 0x0c),
+
+	.quirks = (const struct gip_quirks[]) {
+		/* Thrustmaster T128X GIP Racing Wheel */
+		{ 0x044f, 0xb69c, 0,
+			.quirks = GIP_QUIRK_FORCE_GAMEPAD_SB | GIP_QUIRK_WHEEL_FORCE_HANDBRAKE, },
+
+		{0},
+	},
+
+	.probe = gip_wheel_probe,
+	.remove = gip_wheel_remove,
+	.init = gip_wheel_init,
+	.setup_input = gip_setup_wheel_input,
+	.handle_input_report = gip_handle_wheel_report,
+	.vendor_handlers = {
+		[GIP_LL_INPUT_REPORT] = gip_handle_wheel_ll_input_report,
+		[GIP_LL_STATIC_CONFIGURATION] = gip_handle_wheel_ll_static_configuration,
+	},
+};
+
+struct gip_trueforce_wheel_state {
+	struct gip_wheel_info wheel_info; /* This field must be first for type punning */
+	int8_t dial;
+};
+
+static int gip_trueforce_wheel_probe(struct gip_attachment *attachment)
+{
+	struct gip_trueforce_wheel_state *state = kzalloc(sizeof(*state), GFP_KERNEL);
+
+	if (!state)
+		return -ENOMEM;
+	attachment->driver_data = state;
+	/* The shifter won't show up until the second input report */
+	state->wheel_info.value_retries = 1;
+
+	return 0;
+}
+
+static void gip_trueforce_wheel_remove(struct gip_attachment *attachment)
+{
+	kfree(attachment->driver_data);
+	attachment->driver_data = NULL;
+}
+
+static int gip_setup_trueforce_wheel_input(struct gip_attachment *attachment,
+	struct input_dev* input)
+{
+	int rc = gip_driver_wheel.setup_input(attachment, input);
+
+	if (rc < 0)
+		return rc;
+
+	input_set_capability(input, EV_KEY, BTN_THUMBL);
+	input_set_capability(input, EV_KEY, BTN_THUMBR);
+	input_set_capability(input, EV_KEY, KEY_KPPLUS);
+	input_set_capability(input, EV_KEY, KEY_KPMINUS);
+	input_set_capability(input, EV_KEY, KEY_KPENTER);
+	input_set_capability(input, EV_REL, REL_DIAL);
+
+	return 0;
+}
+
+static int gip_handle_trueforce_wheel_report(struct gip_attachment *attachment,
+	struct input_dev *input, const uint8_t *bytes, int num_bytes)
+{
+	int rc = gip_driver_wheel.handle_input_report(attachment, input, bytes, num_bytes);
+	struct gip_trueforce_wheel_state *state = attachment->driver_data;
+	int dial;
+
+	if (rc < 0)
+		return rc;
+
+	if (num_bytes < 18)
+		return -EINVAL;
+
+	dial = bytes[17] >> 5;
+
+	input_report_key(input, BTN_THUMBL, bytes[17] & BIT(0));
+	input_report_key(input, BTN_THUMBR, bytes[17] & BIT(1));
+	input_report_key(input, KEY_KPPLUS, bytes[17] & BIT(2));
+	input_report_key(input, KEY_KPMINUS, bytes[17] & BIT(3));
+	input_report_key(input, KEY_KPENTER, bytes[17] & BIT(4));
+	if (dial == 0 && state->dial == 7)
+		input_report_rel(input, REL_DIAL, -1);
+	else if (dial == 7 && state->dial == 0)
+		input_report_rel(input, REL_DIAL, 1);
+	else
+		input_report_rel(input, REL_DIAL,
+			state->dial - dial);
+	state->dial = dial;
+
+	return 0;
+}
+
+const struct gip_driver gip_driver_trueforce_wheel = {
+	.types = (const char *const[]) { "Logi.Xbox.Input.TrueForceWheel", NULL },
+	.guid = GUID_INIT(0x6ca319e5, 0x0bc0, 0x41be, 0x83, 0x19,
+		0x6b, 0xb7, 0x10, 0x81, 0xec, 0x55),
+
+	.probe = gip_trueforce_wheel_probe,
+	.remove = gip_trueforce_wheel_remove,
+	.init = gip_wheel_init,
+	.setup_input = gip_setup_trueforce_wheel_input,
+	.handle_input_report = gip_handle_trueforce_wheel_report,
+	.vendor_handlers = {
+		[GIP_LL_INPUT_REPORT] = gip_handle_wheel_ll_input_report,
+		[GIP_LL_STATIC_CONFIGURATION] = gip_handle_wheel_ll_static_configuration,
+	},
+};
+
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 6e5ab8f357aaa..3b5cab96dc0b7 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -31,6 +31,8 @@
 #define GIP_QUIRK_NO_HELLO		BIT(0)
 #define GIP_QUIRK_NO_IMPULSE_VIBRATION	BIT(1)
 #define GIP_QUIRK_SWAP_LB_RB		BIT(2)
+#define GIP_QUIRK_FORCE_GAMEPAD_SB	BIT(3)
+#define GIP_QUIRK_WHEEL_FORCE_HANDBRAKE	BIT(31)
 
 #define GIP_FEATURE_CONTROLLER				BIT(0)
 #define GIP_FEATURE_CONSOLE_FUNCTION_MAP		BIT(1)
@@ -319,4 +321,6 @@ int gip_send_vendor_message(struct gip_attachment *attachment,
 extern const struct gip_driver gip_driver_navigation;
 extern const struct gip_driver gip_driver_gamepad;
 extern const struct gip_driver gip_driver_arcade_stick;
+extern const struct gip_driver gip_driver_wheel;
+extern const struct gip_driver gip_driver_trueforce_wheel;
 #endif
-- 
2.53.0

