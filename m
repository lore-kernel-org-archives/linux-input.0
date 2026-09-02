Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AC33CEBD
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311068; cv=none; b=FiDF+vwfXZYRna5w1KEfLHd6/cD4Y0IO9YKKsHyxyq2MCHXBnhQ9o0s/nN+M1uSP4ngTfftibNY43v30tuDku1kIQRVeBI7tV1sKYQL3thjhIb3FC6PM5YejnG7+PjSeGfwXdDiIbu1RzFQzaYxZHQqbR92asYrqlodx9htZ96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311068; c=relaxed/simple;
	bh=2+Nj3qJ2qG0iuHF7AFBZ1Gpnte4K6n+OeNhzOo2jlYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnsJnTjO/rQ1ecUrjrsVfNQp9xn3LzqATXGPaJDihlUVD7OAaQELTLPV+/kvQmU17vHQ2fHu5UFHQfDwidKskQXVuY4zaN4zXNYsNqz7z1E6GyC34NMEvCmp94EAcUBC+rcrONflLGwdHAlVngAkNwn1lJCMEvi80SucJBbuxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Hw0gDJfr; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Hw0gDJfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311059; bh=2+Nj3qJ2qG0iuHF7AFBZ1Gpnte4K6n+OeNhzOo2jlYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hw0gDJfrX19QX1TSiZdqgf3tIPiQudh+2LKKdcxnOPsNtyBKg6NQs0q0ZlgfPjLlP
	 +P5VONGIH9uGu8GFPKoHx31TVj4iUii1KXsc2kMQsa82JH0gEGYaDZK5ZKTG5MJJaF
	 lX/xOxkoF1GR/OGtMo8VKD5o4yjS4L/tqPEI0/QerYzAApadjfF3BWqzUeIhTdKTqX
	 Yedt2ddaRAtxuIsKUPIT5QEqQU+C3hHcqOLBgztauh1Pw1uvJf4u4RBmEUJalpJOqJ
	 JOZ1yzjM7sHyXh2Wp6HUpM8asqUZ9BEv7K7zevJIRy9FQNBl7PPBXDv3LHFLR6vpZJ
	 rWjM855rerYsA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id B402A132038;
	Tue, 01 Sep 2026 18:04:19 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 08/12] Input: xbox_gip - Add arcade stick support
Date: Tue,  1 Sep 2026 18:02:29 -0700
Message-ID: <20260902010237.865772-9-vi@endrift.com>
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

This adds support for the arcade stick device type. Currently I'm only
aware of one Xbox controller that uses this device type, the Razer Atrox,
so testing coverage is limited.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/Makefile           |   2 +
 drivers/input/joystick/gip/gip-arcade-stick.c | 173 ++++++++++++++++++
 drivers/input/joystick/gip/gip-core.c         |   6 +-
 drivers/input/joystick/gip/gip.h              |   4 +-
 4 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 drivers/input/joystick/gip/gip-arcade-stick.c

diff --git a/drivers/input/joystick/gip/Makefile b/drivers/input/joystick/gip/Makefile
index a5ad301a9063..9ed59caec4d9 100644
--- a/drivers/input/joystick/gip/Makefile
+++ b/drivers/input/joystick/gip/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_JOYSTICK_XBOX_GIP)	+= xbox-gip.o
 # Base driver
 xbox-gip-y := gip-core.o gip-drivers.o gip-security.o
+# Additional device support
+xbox-gip-y += gip-arcade-stick.o
diff --git a/drivers/input/joystick/gip/gip-arcade-stick.c b/drivers/input/joystick/gip/gip-arcade-stick.c
new file mode 100644
index 000000000000..11ededfab855
--- /dev/null
+++ b/drivers/input/joystick/gip/gip-arcade-stick.c
@@ -0,0 +1,173 @@
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
+
+#include <linux/unaligned.h>
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
+	uint16_t actuator_bias;
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
+static int gip_setup_arcade_stick_input(struct gip_attachment *attachment, struct input_dev *input)
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
+	if (info->actuator_bias > 0) {
+		input_set_abs_params(input, ABS_X,
+			-info->actuator_bias, info->actuator_bias - 1, 0, 0);
+		input_set_abs_params(input, ABS_Y,
+			-info->actuator_bias, info->actuator_bias - 1, 0, 0);
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
+	struct input_dev *input, const uint8_t *bytes, int num_bytes)
+{
+	struct gip_arcade_stick_info *info = attachment->driver_data;
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
+		gip_dbg(attachment, "Discarding too-short input report\n");
+		return -EINVAL;
+	}
+
+	if (info->actuator_bias > 0) {
+		input_report_abs(input, ABS_X, get_unaligned_le16(&bytes[2]) - info->actuator_bias);
+		input_report_abs(input, ABS_Y, get_unaligned_le16(&bytes[4]) - info->actuator_bias);
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
+		(const struct gip_arcade_stick_static_coniguration *)bytes;
+	struct gip_arcade_stick_info *info = attachment->driver_data;
+
+	if (!info)
+		return -ENODEV;
+
+	if (num_bytes < 4)
+		return -EINVAL;
+
+	attachment->extra_buttons = clamp(config->button_count, 6, 38) - 6;
+	if (config->actuator_bits)
+		info->actuator_bias = BIT(min(config->actuator_bits, 16) - 1);
+	else
+		info->actuator_bias = 0;
+
+	if (config->vibration_motor_support == GIP_VIBRATION_NO_MOTOR)
+		attachment->features &= ~GIP_FEATURE_MOTOR_CONTROL;
+
+	gip_dbg(attachment, "Arcade stick with report version %u, %u buttons, %u actuator bits\n",
+		config->report_version, config->button_count, config->actuator_bits);
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
index db4d2956e7d9..e8075a99306d 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -10,7 +10,8 @@
  * - Raw character device
  * - Wheel support
  * - Flight stick support
- * - Arcade stick support
+ * - More arcade stick testing
+ * - Arcade stick extra buttons
  * - Split into driver-per-attachment GIP-as-a-bus approach drivers
  *
  * This driver is based on the Microsoft GIP spec at:
@@ -328,6 +329,7 @@ struct gip_direct_motor {
 static const struct gip_driver *base_drivers[] = {
 	&gip_driver_navigation,
 	&gip_driver_gamepad,
+	&gip_driver_arcade_stick,
 	NULL /* Sentinel */
 };
 
@@ -1566,7 +1568,7 @@ static int gip_handle_command_raw_report(struct gip_attachment *attachment,
 	return 0;
 }
 
-static int gip_setup_input_device(struct gip_attachment *attachment)
+int gip_setup_input_device(struct gip_attachment *attachment)
 {
 	struct input_dev *input;
 	int rc;
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 0abd44ada89f..f44a312ae0c9 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -403,6 +403,8 @@ static inline struct device *gip_security_dev(struct gip_security *security)
 	return gip_attachment_dev(container_of(security, struct gip_attachment, security));
 }
 
+int gip_setup_input_device(struct gip_attachment *attachment);
+
 bool gip_supports_vendor_message(struct gip_attachment *attachment, uint8_t command, bool upstream);
 
 int gip_send_system_message(struct gip_attachment *attachment,
@@ -418,6 +420,4 @@ void gip_security_release(struct gip_security *security);
 extern const struct gip_driver gip_driver_navigation;
 extern const struct gip_driver gip_driver_gamepad;
 extern const struct gip_driver gip_driver_arcade_stick;
-extern const struct gip_driver gip_driver_wheel;
-extern const struct gip_driver gip_driver_flight_stick;
 #endif
-- 
2.54.0

