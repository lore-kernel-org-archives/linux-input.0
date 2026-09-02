Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5AE349CE7
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311070; cv=none; b=CGFMPbeC6MciBRWs1dIpRSgfbhbfBPRoiPAUkCDLbfGWoAn/FYoy/Ls5e13frrC0+sQKc2pYbED4keVvZ6TV/V++XvlPDcFJFAeSz0+o+wfVsX6HLER3/llB2AKKXdH90cV6xO+cUl+K7HvAPisRoY5X2xs6kYfkXgImCai2qk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311070; c=relaxed/simple;
	bh=4N9xEYaWGIwtdtzZ1MwEyzCv4GJJ9CsDkyUf4+FnCo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlwK2S1/U9enYinP0IfAz7dndXoEcxqtqDTRIicUA4zG7sFWF4kZbBmcFcg34Tw1464OCVfrl2bMoLk8FWEfnYZdA8dlWirLmaMW27XWDM88f/y/MHVL3jhhqpqJRtVw5YtQUUvVw0v94rdSUAVYxsCqBss2y1zmSQmi/z7Gv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=zSqmNrbB; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="zSqmNrbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311061; bh=4N9xEYaWGIwtdtzZ1MwEyzCv4GJJ9CsDkyUf4+FnCo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zSqmNrbB+xM8m3AcpYRINmJGP1vm3C+sE2VDNyCYwYV4R2mD1oi2Lu3sk8HprhSyj
	 iMP/QYTpY9W5RnmDAcEBnGEa+Qu/HnxS0PzSi0KkRC5+MoGjbDQXiRI+6UAOlXnV+G
	 lWjx77jVlKO/trCVTh7RVmNkOobumq+JnSykUQLu5OGdqidGxxelLpi+TaJaR77f19
	 N6V1wwLYzM37z2M6/6fRQZ+X2Nosh0+O7IfujP/4esXoVCBOwADFgvubdvwRl97YJc
	 kEKPq/Qn/KQqw5MDL3KLI5y2VMqUOgIs27PATMNVbB5wowtOXRIg2QJoBhE+dsMikL
	 ijCAK47n1k7tA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0BD8313208D;
	Tue, 01 Sep 2026 18:04:21 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 12/12] Input: xbox_gip - Add wheel support
Date: Tue,  1 Sep 2026 18:02:33 -0700
Message-ID: <20260902010237.865772-13-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902010237.865772-1-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
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
 drivers/input/joystick/gip/Makefile      |   1 +
 drivers/input/joystick/gip/gip-core.c    |   4 +-
 drivers/input/joystick/gip/gip-drivers.c |  10 +
 drivers/input/joystick/gip/gip-wheel.c   | 349 +++++++++++++++++++++++
 drivers/input/joystick/gip/gip.h         |   6 +
 5 files changed, 369 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/joystick/gip/gip-wheel.c

diff --git a/drivers/input/joystick/gip/Makefile b/drivers/input/joystick/gip/Makefile
index 62c016d6c11e..7d4209eb32c3 100644
--- a/drivers/input/joystick/gip/Makefile
+++ b/drivers/input/joystick/gip/Makefile
@@ -5,3 +5,4 @@ xbox-gip-y := gip-core.o gip-drivers.o gip-security.o
 # Additional device support
 xbox-gip-y += gip-arcade-stick.o
 xbox-gip-y += gip-pdp-jaguar.o
+xbox-gip-y += gip-wheel.o
diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 166fc420ffb2..d285fc777be2 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -8,7 +8,7 @@
  * - Audio device support
  * - Event logging
  * - Raw character device
- * - Wheel support
+ * - Wheel force feedback
  * - Flight stick support
  * - More arcade stick testing
  * - Arcade stick extra buttons
@@ -331,6 +331,8 @@ static const struct gip_driver *base_drivers[] = {
 	&gip_driver_gamepad,
 	&gip_driver_arcade_stick,
 	&gip_driver_pdp_jaguar,
+	&gip_driver_trueforce_wheel,
+	&gip_driver_wheel,
 	NULL /* Sentinel */
 };
 
diff --git a/drivers/input/joystick/gip/gip-drivers.c b/drivers/input/joystick/gip/gip-drivers.c
index 74bc858e71cc..7ba11b19c8ee 100644
--- a/drivers/input/joystick/gip/gip-drivers.c
+++ b/drivers/input/joystick/gip/gip-drivers.c
@@ -142,6 +142,11 @@ static int gip_setup_navigation_input(struct gip_attachment *attachment, struct
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
@@ -193,6 +198,11 @@ static int gip_handle_navigation_report(struct gip_attachment *attachment,
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
index 000000000000..e6810f10c3eb
--- /dev/null
+++ b/drivers/input/joystick/gip/gip-wheel.c
@@ -0,0 +1,349 @@
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
+
+#include <linux/unaligned.h>
+#include "gip.h"
+
+#define GIP_QUIRK_WHEEL_FORCE_HANDBRAKE	BIT(31)
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
+static int gip_setup_wheel_input(struct gip_attachment *attachment, struct input_dev *input)
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
+	info->angle_setting = get_unaligned_le16(&bytes[13]);
+
+	gip_dbg(attachment,
+		"Racing wheel with %u max gear, %u degree rotation\n",
+		info->max_gear, info->angle_setting);
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
+	input_report_abs(input, ABS_WHEEL, get_unaligned_le16(&bytes[2]) - info->max_angle - 1);
+
+	connections = bytes[16];
+
+	if (attachment->quirks & GIP_QUIRK_WHEEL_FORCE_HANDBRAKE)
+		connections |= GIP_WHEEL_HANDBRAKE_CONN;
+
+	if (connections & GIP_WHEEL_THROTTLE_CONN)
+		input_report_abs(input, ABS_GAS, get_unaligned_le16(&bytes[4]));
+	else
+		input_report_abs(input, ABS_GAS, 0);
+
+	if (connections & GIP_WHEEL_BRAKE_CONN)
+		input_report_abs(input, ABS_BRAKE, get_unaligned_le16(&bytes[6]));
+	else
+		input_report_abs(input, ABS_BRAKE, 0);
+
+	if (connections & GIP_WHEEL_CLUTCH_CONN)
+		input_report_abs(input, ABS_CLUTCH, get_unaligned_le16(&bytes[8]));
+	else
+		input_report_abs(input, ABS_CLUTCH, 0);
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
+	info->max_angle = BIT(min(bytes[0], 16)) / 2 - 1;
+	info->max_throttle = BIT(min(bytes[1], 16)) - 1;
+	info->max_brake = BIT(min(bytes[2], 16)) - 1;
+	info->max_clutch = BIT(min(bytes[3], 16)) - 1;
+	info->max_handbrake = BIT(min(bytes[4], 8)) - 1;
+
+	gip_dbg(attachment,
+		"Racing wheel with precision: %u bits angle, %u bits throttle, %u bits brake,\n",
+		bytes[0], bytes[1], bytes[2]);
+	gip_dbg(attachment,
+		"%u bits clutch, %u bits handbrake\n", bytes[3], bytes[4]);
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
+		{ GIP_VID_THRUSTMASTER, GIP_PID_THRUSTMASTER_T128X, 0,
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
+	/* The shifter won't show in the first few input reports */
+	state->wheel_info.value_retries = 3;
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
+	struct input_dev *input)
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
index 7d4628dea684..204a66629164 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -28,10 +28,13 @@
 #define MAX_OUT_MESSAGES 8
 #define MAX_OUT_FRAGMENTS 2
 
+#define GIP_VID_THRUSTMASTER	0x044f
 #define GIP_VID_MICROSOFT	0x045e
 #define GIP_VID_PDP		0x0e6f
 #define GIP_VID_BDA		0x24c6
 
+#define GIP_PID_THRUSTMASTER_T128X	0xb69c
+
 #define GIP_PID_XBOX_ONE_1573			0x02d1
 #define GIP_PID_XBOX_ONE_1697			0x02dd
 #define GIP_PID_XBOX_ELITE			0x02e3
@@ -50,6 +53,7 @@
 #define GIP_QUIRK_NO_IMPULSE_VIBRATION	BIT(1)
 #define GIP_QUIRK_SWAP_LB_RB		BIT(2)
 #define GIP_QUIRK_SKIP_SECURITY		BIT(3)
+#define GIP_QUIRK_FORCE_GAMEPAD_SB	BIT(4)
 /*
  * Driver-specific quirks should start from 31 and go downwards to avoid
  * conflicts with newly-added core quirks
@@ -422,4 +426,6 @@ extern const struct gip_driver gip_driver_navigation;
 extern const struct gip_driver gip_driver_gamepad;
 extern const struct gip_driver gip_driver_arcade_stick;
 extern const struct gip_driver gip_driver_pdp_jaguar;
+extern const struct gip_driver gip_driver_wheel;
+extern const struct gip_driver gip_driver_trueforce_wheel;
 #endif
-- 
2.54.0

