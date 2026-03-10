Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A192DF6EA
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120036; cv=none; b=sJe7opKG3CcuNACqTI/+GyrIscyWU8lxuwbZdg7isnlafB9vNOhNqZWKMbhvhZqgYxw4JvGafU9V4XQ/nSRTiQvx6J9dm2mQKmHclS3fS6WfwX0aNktVQexrJGkK1vd5aNwMSri1J+iNmLKxFSC6XuFbQpgKDXfAbJMyMNjg/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120036; c=relaxed/simple;
	bh=4RTUv3sqakp3Pp7XTatzkcME425o18yzp80nNobKRQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVF/caoJE+rT1ru+uXhS7++WtkTeRSjGKtB0zWeyqvXJbLsL+gwi6T1h7wFp7G6Y79RK0dEkd4cFI5QNm+EatuJvh818Q4/tAkYi2sfFY/UztFE1sUx0Ei4GxKWa03Z2mqmoiH9L7fyw6b9WhkfyTKBpB6F/NY95D2j/Lwdq7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=jxPbk13t; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="jxPbk13t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120034; bh=4RTUv3sqakp3Pp7XTatzkcME425o18yzp80nNobKRQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxPbk13t+DdQ5oQUgYdSaEJgIijCIbHG3YGoKFALBwewf9a73Of9Liz02J5otMUeG
	 9MzC+3PGZaHRwdkB3w+EcrMhQPoBoqmDHTnjcRuXRkz+2h3ghJ8j1n/Xrb+Rj2mLMo
	 1IvOl1MKK2znEoT7vmWEr7bpM21RSMD7LMbT7vQ6Eihat7VmCtIpCvgDwdUR+VyJBu
	 GvElQP8R2nkINtp1RVp4458rM1i5JE9ZPsXpS7RGUObgtpngS5App7gwrzusgsBr+a
	 cDZgsmJC3MCcwcmgSBEEUhDM+eWyQAgxQDtPfxQxAyi8w9a/IeuD4cQ0kQ4ZNq1Bcn
	 uyugfU5WJ0eQQ==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id E7A9AA0CF;
	Mon, 09 Mar 2026 22:20:33 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 06/10] Input: xbox_gip - Add arcade stick support
Date: Mon,  9 Mar 2026 22:20:00 -0700
Message-ID: <20260310052017.1289494-7-vi@endrift.com>
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

This adds support for the arcade stick device type. Currently I'm only
aware of one Xbox controller that uses this device type, the Razer Atrox,
so testing coverage is limited.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/Makefile           |   2 +-
 drivers/input/joystick/gip/gip-arcade-stick.c | 169 ++++++++++++++++++
 drivers/input/joystick/gip/gip-core.c         |   6 +-
 drivers/input/joystick/gip/gip.h              |   4 +-
 4 files changed, 176 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/joystick/gip/gip-arcade-stick.c

diff --git a/drivers/input/joystick/gip/Makefile b/drivers/input/joystick/gip/Makefile
index a75e0cace0f92..94ce6462d7ab0 100644
--- a/drivers/input/joystick/gip/Makefile
+++ b/drivers/input/joystick/gip/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 obj-$(CONFIG_JOYSTICK_XBOX_GIP)	+= xbox-gip.o
-xbox-gip-y := gip-core.o gip-drivers.o
+xbox-gip-y := gip-arcade-stick.o gip-core.o gip-drivers.o
diff --git a/drivers/input/joystick/gip/gip-arcade-stick.c b/drivers/input/joystick/gip/gip-arcade-stick.c
new file mode 100644
index 0000000000000..c9ee3483e02d8
--- /dev/null
+++ b/drivers/input/joystick/gip/gip-arcade-stick.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Drivers for GIP arcade sticks
+ *
+ * Copyright (c) 2025 Valve Software
+ *
+ * This driver is based on the Microsoft GIP spec at:
+ * https://aka.ms/gipdocs
+ * https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gipusb/e7c90904-5e21-426e-b9ad-d82adeee0dbc
+ */
+#include "gip.h"
+
+enum gip_arcade_stick_vibration_motor_support {
+	GIP_VIBRATION_NO_MOTOR = 0,
+	GIP_VIBRATION_SINGLE_MOTOR = 1,
+	GIP_VIBRATION_DUAL_MOTOR = 2,
+};
+
+struct gip_arcade_stick_info {
+	uint8_t vibration_motor;
+	uint8_t actuator_bits;
+};
+
+struct gip_arcade_stick_static_coniguration {
+	uint8_t button_count;
+	uint8_t report_version;
+	uint8_t vibration_motor_support;
+	uint8_t actuator_bits;
+};
+
+static int gip_arcade_stick_probe(struct gip_attachment *attachment)
+{
+	struct gip_arcade_stick_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info)
+		return -ENOMEM;
+
+	attachment->quirks |= GIP_QUIRK_SWAP_LB_RB;
+	attachment->driver_data = info;
+
+	return 0;
+}
+
+static void gip_arcade_stick_remove(struct gip_attachment *attachment)
+{
+	kfree(attachment->driver_data);
+	attachment->driver_data = NULL;
+}
+
+static int gip_init_arcade_stick(struct gip_attachment *attachment)
+{
+	if (gip_supports_vendor_message(attachment, GIP_CMD_INITIAL_REPORTS_REQUEST, false)) {
+		uint8_t request = GIP_LL_STATIC_CONFIGURATION;
+		int rc = gip_send_vendor_message(attachment, GIP_CMD_INITIAL_REPORTS_REQUEST, 0,
+			&request, sizeof(request));
+
+		if (rc < 0)
+			return rc;
+
+		return GIP_INIT_NO_INPUT;
+	}
+
+	return 0;
+}
+
+static int gip_setup_arcade_stick_input(struct gip_attachment *attachment, struct input_dev* input)
+{
+	struct gip_arcade_stick_info *info = attachment->driver_data;
+	int rc;
+
+	if (!info)
+		return -ENODEV;
+
+	rc = gip_driver_navigation.setup_input(attachment, input);
+	if (rc < 0)
+		return rc;
+
+	if (info->actuator_bits > 0) {
+		input_set_abs_params(input, ABS_X, 0, (1 << info->actuator_bits) - 1, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, (1 << info->actuator_bits) - 1, 0, 0);
+	}
+
+	if (attachment->extra_buttons >= 1)
+		input_set_capability(input, EV_KEY, BTN_TR2);
+
+	if (attachment->extra_buttons >= 2)
+		input_set_capability(input, EV_KEY, BTN_TL2);
+	return 0;
+}
+
+static int gip_handle_arcade_stick_report(struct gip_attachment *attachment,
+	struct input_dev* input, const uint8_t *bytes, int num_bytes)
+{
+	struct gip_arcade_stick_info *info = attachment->driver_data;
+	int16_t axis;
+	int rc;
+
+	if (!info)
+		return -ENODEV;
+
+	rc = gip_driver_navigation.handle_input_report(attachment, input, bytes, num_bytes);
+	if (rc < 0)
+		return rc;
+
+	if (num_bytes < 6) {
+		dev_dbg(GIP_DEV(attachment), "Discarding too-short input report\n");
+		return -EINVAL;
+	}
+
+	if (info->actuator_bits > 0) {
+		axis = bytes[2];
+		axis |= bytes[3] << 8;
+		input_report_abs(input, ABS_X, axis);
+
+		axis = bytes[4];
+		axis |= bytes[5] << 8;
+		input_report_abs(input, ABS_Y, axis);
+	}
+
+	if (num_bytes >= 19) {
+		/* Extra button 6 */
+		input_report_key(input, BTN_TR2, bytes[18] & BIT(6));
+		/* Extra button 7 */
+		input_report_key(input, BTN_TL2, bytes[18] & BIT(7));
+	}
+
+	return 0;
+}
+
+static int gip_handle_arcade_stick_ll_static_configuration(struct gip_attachment *attachment,
+	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
+{
+	const struct gip_arcade_stick_static_coniguration *config =
+		(const struct gip_arcade_stick_static_coniguration*)bytes;
+	struct gip_arcade_stick_info *info = attachment->driver_data;
+
+	if (!info)
+		return -ENODEV;
+
+	if (num_bytes < 4)
+		return -EINVAL;
+
+	attachment->extra_buttons = clamp(config->button_count, 6, 38) - 6;
+	info->actuator_bits = min(config->actuator_bits, 8);
+
+	if (config->vibration_motor_support == GIP_VIBRATION_NO_MOTOR)
+		attachment->features &= ~GIP_FEATURE_MOTOR_CONTROL;
+
+	return gip_setup_input_device(attachment);
+}
+
+const struct gip_driver gip_driver_arcade_stick = {
+	.types = (const char* const[]) {
+		"Windows.Xbox.Input.ArcadeStick",
+		"Microsoft.Xbox.Input.ArcadeStick",
+		NULL
+	},
+	.guid = GUID_INIT(0x332054cc, 0xa34b, 0x41d5, 0xa3, 0x4a,
+		0xa6, 0xa6, 0x71, 0x1e, 0xc4, 0xb3),
+
+	.probe = gip_arcade_stick_probe,
+	.remove = gip_arcade_stick_remove,
+	.init = gip_init_arcade_stick,
+	.setup_input = gip_setup_arcade_stick_input,
+	.handle_input_report = gip_handle_arcade_stick_report,
+	.vendor_handlers = {
+		[GIP_LL_STATIC_CONFIGURATION] = gip_handle_arcade_stick_ll_static_configuration,
+	},
+};
diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 89f8e0ed47344..1164b689856e7 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -12,7 +12,8 @@
  * - Raw character device
  * - Wheel support
  * - Flight stick support
- * - Arcade stick support
+ * - More arcade stick testing
+ * - Arcade stick extra buttons
  * - Split into driver-per-attachment GIP-as-a-bus approach drivers
  *
  * This driver is based on the Microsoft GIP spec at:
@@ -315,6 +316,7 @@ struct gip_direct_motor {
 static const struct gip_driver* base_drivers[] = {
 	&gip_driver_navigation,
 	&gip_driver_gamepad,
+	&gip_driver_arcade_stick,
 	NULL /* Sentinel */
 };
 
@@ -1344,7 +1346,7 @@ static int gip_handle_command_raw_report(struct gip_attachment *attachment,
 	return 0;
 }
 
-static int gip_setup_input_device(struct gip_attachment *attachment)
+int gip_setup_input_device(struct gip_attachment *attachment)
 {
 	struct input_dev *input;
 	int rc;
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index dd77f16b00fd8..6e5ab8f357aaa 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -307,6 +307,8 @@ static inline struct device *gip_device_dev(struct gip_device *device)
 	return &device->udev->dev;
 }
 
+int gip_setup_input_device(struct gip_attachment *attachment);
+
 bool gip_supports_vendor_message(struct gip_attachment *attachment, uint8_t command, bool upstream);
 
 int gip_send_system_message(struct gip_attachment *attachment,
@@ -317,6 +319,4 @@ int gip_send_vendor_message(struct gip_attachment *attachment,
 extern const struct gip_driver gip_driver_navigation;
 extern const struct gip_driver gip_driver_gamepad;
 extern const struct gip_driver gip_driver_arcade_stick;
-extern const struct gip_driver gip_driver_wheel;
-extern const struct gip_driver gip_driver_flight_stick;
 #endif
-- 
2.53.0

