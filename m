Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66062E1EFC
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787364807; cv=none; b=ZniDX750ptW/Qc6rA6zHoo4sdpLE1GeEGXGFnNhXJ+mgosVwi9m6JKS8rXc8r2KXca02IxwrKkgcEOAY7tKe5MNACulQgkbNQuzQXmC5oNOjuGM2MM34A4+9R7DrfJfJJnIw0fv+7CTqL4n8SZS9aHMyZx+R3iTgQyPuBAmuxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787364807; c=relaxed/simple;
	bh=+7grn4fW0kDFmyEgqCT2fmqBwWnHs891pgk7B9aI8V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOlNfAeNQ6Mf7LDE9lRQk5uv2GioEYWdSDFLfRgphnPaMg4hLu0FKmHbpO7pTeksMOYbo479M0aNQB17uXv037B3xT1DLKkIhlB+pxUqYlziQ9DobdvHHr6bMCBxFpZAhZ6/SIEaq65+alrMMrZh6jbkz5dqZ+2sHCQBrhyN7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=jT2EI8wS; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="jT2EI8wS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364801; bh=+7grn4fW0kDFmyEgqCT2fmqBwWnHs891pgk7B9aI8V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jT2EI8wSqr0m8MIp+s2mlK0LXEnq16TghX5FcBnNYdyLrByGO/xTEFWzP8gUlnb1p
	 9cakmP3Bvnc7SftR+pe/P3d4J5ZDIgDkwNKE6uKRdEfeAEZb3NABUmBDskA70zreCD
	 18TrwM9n9FGGJVT6j5mXWJzgoXdlYg0e5Fy1waz0O8lTNruU9XYZ+5aW+v4xmMhAsq
	 Uc/t3iy28tpOZVNjLWXQOhH2jd2uGvW+Y4FBX6xgIkQVN4Vxz/XxnIOJXFRrxAbwt6
	 cUbJcY4Kinu+Y0zooZjX3keKL1UYbXbmz4a60X+b/fbPNGTTVl+xj+d4jR+iykljUY
	 JhVKIogBXHTZg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id E41FB13208A;
	Fri, 21 Aug 2026 19:13:20 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 09/12] Input: xbox_gip - Add support for PDP guitar controllers
Date: Fri, 21 Aug 2026 19:11:33 -0700
Message-ID: <20260822021140.1149546-10-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822021140.1149546-1-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the PDP guitar controllers, namely the Fender
Jaguar and RiffMaster models. These use mostly the same protocol, but the
RiffMaster appears t use a slightly newer variant.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/Makefile         |   1 +
 drivers/input/joystick/gip/gip-core.c       |   1 +
 drivers/input/joystick/gip/gip-pdp-jaguar.c | 129 ++++++++++++++++++++
 drivers/input/joystick/gip/gip.h            |   2 +
 4 files changed, 133 insertions(+)
 create mode 100644 drivers/input/joystick/gip/gip-pdp-jaguar.c

diff --git a/drivers/input/joystick/gip/Makefile b/drivers/input/joystick/gip/Makefile
index 9ed59caec4d9..62c016d6c11e 100644
--- a/drivers/input/joystick/gip/Makefile
+++ b/drivers/input/joystick/gip/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_JOYSTICK_XBOX_GIP)	+= xbox-gip.o
 xbox-gip-y := gip-core.o gip-drivers.o gip-security.o
 # Additional device support
 xbox-gip-y += gip-arcade-stick.o
+xbox-gip-y += gip-pdp-jaguar.o
diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index da22545662e2..c03d730f2968 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -330,6 +330,7 @@ static const struct gip_driver *base_drivers[] = {
 	&gip_driver_navigation,
 	&gip_driver_gamepad,
 	&gip_driver_arcade_stick,
+	&gip_driver_pdp_jaguar,
 	NULL /* Sentinel */
 };
 
diff --git a/drivers/input/joystick/gip/gip-pdp-jaguar.c b/drivers/input/joystick/gip/gip-pdp-jaguar.c
new file mode 100644
index 000000000000..ec0e9d811d12
--- /dev/null
+++ b/drivers/input/joystick/gip/gip-pdp-jaguar.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Drivers for GIP PDP Jaguar-style guitars
+ *
+ * Copyright (c) 2026 Valve Software
+ */
+
+#include <linux/unaligned.h>
+#include "gip.h"
+
+#define GIP_QUIRK_PDP_HAS_RIGHT_STICK	BIT(31)
+
+static int gip_setup_pdp_jaguar_input(struct gip_attachment *attachment, struct input_dev *input)
+{
+	/*
+	 * Despite having the navigation controller GUID, we don't want to use
+	 * those mappings. Instead, we use the xone mappings for compatibility
+	 * reasons.
+	 */
+
+	/* Lower fret */
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY2);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY3);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY4);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY5);
+	/* Upper fret */
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY6);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY7);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY8);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY9);
+	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY10);
+
+	input_set_capability(input, EV_KEY, BTN_START);
+	input_set_capability(input, EV_KEY, BTN_SELECT);
+
+	/* Whammy bar */
+	input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
+	/* Tilt */
+	input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
+
+	input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
+	input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
+
+	if (attachment->quirks & GIP_QUIRK_PDP_HAS_RIGHT_STICK) {
+		input_set_capability(input, EV_KEY, BTN_THUMBR);
+		input_set_abs_params(input, ABS_RX, -32768, 32767, 16, 128);
+		input_set_abs_params(input, ABS_RY, -32768, 32767, 16, 128);
+	}
+
+	return 0;
+}
+
+static int gip_handle_pdp_jaguar_report(struct gip_attachment *attachment,
+	struct input_dev *input, const uint8_t *bytes, int num_bytes)
+{
+	bool lower;
+
+	if (num_bytes < 4) {
+		gip_dbg(attachment, "Discarding too-short input report\n");
+		return -EINVAL;
+	}
+
+	input_report_key(input, BTN_START, bytes[0] & BIT(2));
+	input_report_key(input, BTN_SELECT, bytes[0] & BIT(3));
+
+	if (num_bytes >= 7 && (bytes[5] || bytes[6])) {
+		/* Newer report version on the RiffMaster */
+		input_report_key(input, BTN_TRIGGER_HAPPY1, bytes[5] & BIT(0));
+		input_report_key(input, BTN_TRIGGER_HAPPY2, bytes[5] & BIT(1));
+		input_report_key(input, BTN_TRIGGER_HAPPY3, bytes[5] & BIT(2));
+		input_report_key(input, BTN_TRIGGER_HAPPY4, bytes[5] & BIT(3));
+		input_report_key(input, BTN_TRIGGER_HAPPY5, bytes[5] & BIT(4));
+
+		input_report_key(input, BTN_TRIGGER_HAPPY6, bytes[6] & BIT(0));
+		input_report_key(input, BTN_TRIGGER_HAPPY7, bytes[6] & BIT(1));
+		input_report_key(input, BTN_TRIGGER_HAPPY8, bytes[6] & BIT(2));
+		input_report_key(input, BTN_TRIGGER_HAPPY9, bytes[6] & BIT(3));
+		input_report_key(input, BTN_TRIGGER_HAPPY10, bytes[6] & BIT(4));
+	} else {
+		lower = bytes[1] & BIT(6);
+		input_report_key(input, BTN_TRIGGER_HAPPY1, !lower && (bytes[0] & BIT(4)));
+		input_report_key(input, BTN_TRIGGER_HAPPY2, !lower && (bytes[0] & BIT(5)));
+		input_report_key(input, BTN_TRIGGER_HAPPY3, !lower && (bytes[0] & BIT(7)));
+		input_report_key(input, BTN_TRIGGER_HAPPY4, !lower && (bytes[0] & BIT(6)));
+		input_report_key(input, BTN_TRIGGER_HAPPY5, !lower && (bytes[1] & BIT(4)));
+
+		input_report_key(input, BTN_TRIGGER_HAPPY6, lower && (bytes[0] & BIT(4)));
+		input_report_key(input, BTN_TRIGGER_HAPPY7, lower && (bytes[0] & BIT(5)));
+		input_report_key(input, BTN_TRIGGER_HAPPY8, lower && (bytes[0] & BIT(7)));
+		input_report_key(input, BTN_TRIGGER_HAPPY9, lower && (bytes[0] & BIT(6)));
+		input_report_key(input, BTN_TRIGGER_HAPPY10, lower && (bytes[1] & BIT(4)));
+	}
+
+	input_report_abs(input, ABS_Y, bytes[2]);
+	input_report_abs(input, ABS_Z, bytes[3]);
+
+	input_report_abs(input, ABS_HAT0X,
+		!!(bytes[1] & BIT(3)) - !!(bytes[1] & BIT(2)));
+	input_report_abs(input, ABS_HAT0Y,
+		!!(bytes[1] & BIT(1)) - !!(bytes[1] & BIT(0)));
+
+	if ((attachment->quirks & GIP_QUIRK_PDP_HAS_RIGHT_STICK) && num_bytes >= 14) {
+		input_report_key(input, BTN_THUMBR, bytes[1] & BIT(6));
+		input_report_abs(input, ABS_RX, (int16_t)get_unaligned_le16(&bytes[10]));
+		input_report_abs(input, ABS_RY, ~(int16_t)get_unaligned_le16(&bytes[12]));
+	}
+
+	return 0;
+}
+
+const struct gip_driver gip_driver_pdp_jaguar = {
+	.types = (const char *const[]) { "PDP.Xbox.Guitar.Jaguar", NULL },
+	.guid = GUID_INIT(0x1a266af6, 0x3a46, 0x45e3, 0xb9, 0xb6,
+		0x0f, 0x2c, 0x0b, 0x2c, 0x1e, 0xbe),
+
+	.quirks = (const struct gip_quirks[]) {
+		/* PDP RiffMaster */
+		{ GIP_VID_PDP, GIP_PID_PDP_RIFFMASTER, 0,
+			.quirks = GIP_QUIRK_PDP_HAS_RIGHT_STICK, },
+
+		{0},
+	},
+	.probe = NULL,
+	.remove = NULL,
+	.init = NULL,
+	.setup_input = gip_setup_pdp_jaguar_input,
+	.handle_input_report = gip_handle_pdp_jaguar_report,
+};
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 1cc0a98717ba..23c23982658e 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -40,6 +40,7 @@
 #define GIP_PID_XBOX_WIRELESS			0x0b12
 
 #define GIP_PID_PDP_ROCK_CANDY	0x0246
+#define GIP_PID_PDP_RIFFMASTER	0x0248
 
 #define GIP_PID_BDA_XB1_CLASSIC		0x581a
 #define GIP_PID_BDA_XB1_FUSION_PRO	0x591a
@@ -412,4 +413,5 @@ void gip_security_release(struct gip_security *security);
 extern const struct gip_driver gip_driver_navigation;
 extern const struct gip_driver gip_driver_gamepad;
 extern const struct gip_driver gip_driver_arcade_stick;
+extern const struct gip_driver gip_driver_pdp_jaguar;
 #endif
-- 
2.54.0

