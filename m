Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5833ADA1
	for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035082; cv=none; b=b8arE7RGjiVOKuQS11YxbQwXwY/1kWs9rVCxaKFRy0EMRbyTkM5YOEtjQJytntdq6+XO7Zf22muRfonABvJqy8b33UNrrai0UjJ9gW1hF51Cf4E99HlxAVxZPfAThZusnO6/D/QlanEE5Qwctg2rAs1knVbZAhgMXcAQKWai0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035082; c=relaxed/simple;
	bh=rTF7CrWaDCkFx1R2VIKVMLx3DayfDzRHegT7M+Cyz08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMvpmWnjidNeO2oRFYvlzkfK7+4jOeXxww6ZmQN4GAe5NKJXWfYTN1f425wYfEZrLxReU16fQ/0RN+D/5Zi2gThiA3jtZPoTLUPwaarZmZc5dTvzacXEtSyEIkajRIT70n7yhqfQsSU+5H/jZ2Sxf0rrEChRP23UYu8Ze/ayu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ83Zvc3; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ83Zvc3"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-823c56765fdso3198792b3a.1
        for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772035081; x=1772639881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsZYB29iP53RlNA6or+fhJlMEAO1yptSiNSXw/b8CnI=;
        b=LQ83Zvc3xjetRBOsjQH4AAYUoVyyo6Ze2ABL8OHH495ZBTeCgUvk7I31rrUs7vYGEg
         SP/UE9CYmex82SYfuh5mz+rXstDj148hap+8yT1aWd6g9M9lnFi9ropv4CpGiyhaAXiu
         T4iN0Pb6eMenf8wc7dlEkGLwBO8AYrO/qsz0Y03xccfF9iqHNI4rlnynMn+qbBYjkbj7
         02aHfB6XG7lmu0Io1Z4xCXHXDXQaGJXyuKn/Kngf2IPklYtUBIJmplk71ugWB5bdbC84
         g6xo+IPvCbkcYtKA58vZ1STTgHMVvN2ZVHH2OySg+kKe9KZzxMdG7DDQAtUT2u/H5VR3
         3TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772035081; x=1772639881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsZYB29iP53RlNA6or+fhJlMEAO1yptSiNSXw/b8CnI=;
        b=kPCyXAy29JX1Qbw8UqEiVElL+d6XrKJTUw3gAcJhFjCd4l0R3Hsuc78k2FTB0s3OBM
         FDf3y1LZJKJwfdwXubGT98DK9Q0ZuOeDHAlmQXXQrAo2HGscLA+0MFwf1EAe88zBZ706
         ZPvrGsVXbEl9zIeifksNyhIBA+790wMYY/AWHm4cbDXEPunKWbfTsNMEOHbt4Ua4AgoL
         lgm+H1lUzKUL9mvznAXu5AUzujFbrXKznIC+WeNW3XNPJknBcfC2xNh4T0BNuXH9z4vt
         6gpWAID6RpmispSp7orWO1UV+2F00cQupb94dOaC//kRGS6PGAZSCJibMSLa5ZOlbSAZ
         U5bQ==
X-Gm-Message-State: AOJu0YzCXA0GjTOfBRXEmGvSYgeY8vNO22kb6jKOFCnxwIRPjgi9I4uB
	S3Lwmmla1LEquCeaPg2fTK0rL0aw3DRhXIyb2sddJZg2zNOziBZBNwDIPkupkPzexf8=
X-Gm-Gg: ATEYQzx+8Lr9xrvjhU5yB388nHAD5Lngr5hkClFvr6kodIzaMLNJSDJWapi+0VTHOPT
	Tnj6wh96eNnytCf+PnmD9YYYjhsnVE3QoG9DFklrMobYvGIZPIBBXp89/G4sxtw+AbObk9D0E5o
	zOGeNUKKmGAiS+sW7qInLkwfn1lGHO6zfuxT0D6Arfm5xc4ov1LJJ+PdhfFyZw8iNiJrqZY2mEL
	uxEF3bnWqgUcnvhf7TOhHux1q1OcZG+VPdWc+gb4xv8Tz6rFrzYJW/txAm8p7L5C/zKc9Q+5TuF
	5+al1ZvmojtNaVqzsE5ll8PxhzxM5GOK+9mj4Mp6QBM1W7sKCLnNXmd2LNyV4kVzOYGFzYph/ns
	gG1GSNaQ3ivJD4AaMP/lcc+9unn/475FDObup0SJ2GWKcpAEUgfCM1kLg1CpDp0+UbVj3wBmg9u
	v9m7BNyggEoveY3KlG/xOzTgUGzGDZK5NxJA9VnMRTwgplESJpELNVU9ZX2woCtxggAFnE9N5dc
	DNp86MM5HdZBl4iZd/1eFtRXotB61Rve7iPADdOUaU=
X-Received: by 2002:a05:6a20:9f96:b0:35e:8b76:c960 with SMTP id adf61e73a8af0-39545fbe266mr14306776637.48.1772035080892;
        Wed, 25 Feb 2026 07:58:00 -0800 (PST)
Received: from Slifer ([112.208.65.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b72603dfsm13966622a12.28.2026.02.25.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:58:00 -0800 (PST)
From: Karl Cayme <kcayme@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Cayme <kcayme@gmail.com>
Subject: [PATCH v1] HID: rakk: add support for Rakk Dasig X side buttons
Date: Wed, 25 Feb 2026 23:56:45 +0800
Message-ID: <20260225155645.83981-1-kcayme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rakk Dasig X gaming mouse has a faulty HID report descriptor that
declares USAGE_MAXIMUM=3 (buttons 1-3) while actually sending 5 button
bits (REPORT_COUNT=5). This causes the kernel to ignore side buttons
(buttons 4 and 5).

Fix by patching the descriptor to set USAGE_MAXIMUM=5 in the
report_fixup callback.

The mouse uses Telink vendor ID 0x248a with three product IDs for USB
direct (0xfb01), wireless dongle (0xfa02), and Bluetooth (0x8266)
connection modes. All three variants have the same bug at byte offset 17.

Signed-off-by: Karl Cayme <kcayme@gmail.com>
---
 drivers/hid/Kconfig    |  8 +++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-ids.h  |  5 +++
 drivers/hid/hid-rakk.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 drivers/hid/hid-rakk.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a5f2..930ea0773169 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -755,6 +755,14 @@ config HID_MEGAWORLD_FF
 	Say Y here if you have a Mega World based game controller and want
 	to have force feedback support for it.
 
+config HID_RAKK
+	tristate "Rakk support"
+	help
+	  Support for Rakk gaming peripherals.
+
+	  Fixes the HID report descriptor of the Rakk Dasig X mouse,
+	  which declares only 3 buttons instead of 5.
+
 config HID_REDRAGON
 	tristate "Redragon keyboards"
 	default !EXPERT
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e01838239ae6..7800613f5b2b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
 obj-$(CONFIG_HID_PLAYSTATION)	+= hid-playstation.o
 obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
 obj-$(CONFIG_HID_PXRC)		+= hid-pxrc.o
+obj-$(CONFIG_HID_RAKK)		+= hid-rakk.o
 obj-$(CONFIG_HID_RAPOO) += hid-rapoo.o
 obj-$(CONFIG_HID_RAZER)	+= hid-razer.o
 obj-$(CONFIG_HID_REDRAGON)	+= hid-redragon.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3e299a30dcde..68fab837e8b3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1369,6 +1369,11 @@
 #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5_017	0x73f6
 #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5	0x81a7
 
+#define USB_VENDOR_ID_TELINK				0x248a
+#define USB_DEVICE_ID_TELINK_RAKK_DASIG_X		0xfb01
+#define USB_DEVICE_ID_TELINK_RAKK_DASIG_X_DONGLE	0xfa02
+#define USB_DEVICE_ID_TELINK_RAKK_DASIG_X_BT		0x8266
+
 #define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
 #define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA	0x0855
 
diff --git a/drivers/hid/hid-rakk.c b/drivers/hid/hid-rakk.c
new file mode 100644
index 000000000000..c2b969ce7259
--- /dev/null
+++ b/drivers/hid/hid-rakk.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  HID driver for Rakk devices
+ *
+ *  Copyright (c) 2025 Karl Cayme
+ *
+ *  The Rakk Dasig X gaming mouse has a faulty HID report descriptor that
+ *  declares USAGE_MAXIMUM = 3 (buttons 1-3) while actually sending 5 button
+ *  bits (REPORT_COUNT = 5). This causes the kernel to ignore side buttons
+ *  (buttons 4 and 5). This driver fixes the descriptor so all 5 buttons
+ *  are properly recognized across 3 modes (wired, dongle, and Bluetooth).
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include "hid-ids.h"
+
+/*
+ * The faulty byte is at offset 17 in the report descriptor for all three
+ * connection modes (USB direct, wireless dongle, and Bluetooth).
+ *
+ * Bytes 16-17 are: 0x29 0x03 (USAGE_MAXIMUM = 3)
+ * The fix changes byte 17 to 0x05 (USAGE_MAXIMUM = 5).
+ *
+ * Original descriptor bytes 0-17:
+ *   05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 03
+ *                                                       ^^
+ *   Should be 0x05 to declare 5 buttons instead of 3.
+ */
+#define RAKK_RDESC_USAGE_MAX_OFFSET	17
+#define RAKK_RDESC_USAGE_MAX_ORIG	0x03
+#define RAKK_RDESC_USAGE_MAX_FIXED	0x05
+#define RAKK_RDESC_USB_SIZE		193
+#define RAKK_RDESC_DONGLE_SIZE		150
+#define RAKK_RDESC_BT_SIZE		89
+
+static const __u8 *rakk_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				      unsigned int *rsize)
+{
+	if ((*rsize == RAKK_RDESC_USB_SIZE ||
+	     *rsize == RAKK_RDESC_DONGLE_SIZE ||
+	     *rsize == RAKK_RDESC_BT_SIZE) &&
+	    rdesc[RAKK_RDESC_USAGE_MAX_OFFSET] == RAKK_RDESC_USAGE_MAX_ORIG) {
+		hid_info(hdev, "fixing Rakk Dasig X button count (3 -> 5)\n");
+		rdesc[RAKK_RDESC_USAGE_MAX_OFFSET] = RAKK_RDESC_USAGE_MAX_FIXED;
+	}
+
+	return rdesc;
+}
+
+static const struct hid_device_id rakk_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TELINK,
+			 USB_DEVICE_ID_TELINK_RAKK_DASIG_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TELINK,
+			 USB_DEVICE_ID_TELINK_RAKK_DASIG_X_DONGLE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_TELINK,
+			       USB_DEVICE_ID_TELINK_RAKK_DASIG_X_BT) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, rakk_devices);
+
+static struct hid_driver rakk_driver = {
+	.name = "rakk",
+	.id_table = rakk_devices,
+	.report_fixup = rakk_report_fixup,
+};
+module_hid_driver(rakk_driver);
+
+MODULE_DESCRIPTION("HID driver for Rakk Dasig X mouse - fix side button support");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Cayme");
-- 
2.53.0

