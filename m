Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED487223DE9
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774097580; cv=none; b=Jh7/dYzoHAsBNWzPBjQe1IoOIPNIyW6sTU/AxEGLc+1WAubEGaGADmdRCtmJWLLtJ5wreW4WkEy7bGRbWbbml5wKpDcsJGGwLCzl6IqptLOtozHZjxMLGKB3T7YMNpila2zFkneupz8DYevJxK3mfJFEYAIQ9gspH7RjRDPyYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774097580; c=relaxed/simple;
	bh=sGREo2lCnMvgHUNpx+aa4USCEqKuOLpnkIbOEyl36D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StflWntNtXmitA5JbxomSQcdng7nRTEyuAk2AOAUZqWO1xcdXe56lo4LR8guHhssNWv9h1VXXzJjifgIVpuWprTABT2jnQuvih8dT8wYs8bC/RpbwI8YdrX2cW3TyUypcmYJGb+bow4XgiMT+urTDFKMreKpHSg82zr2/cGCyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSWT431/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSWT431/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c763c294cccso665708a12.1
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774097578; x=1774702378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMzDWQMEvY2hUXHfVPDP28vF18R5tNL2pT9Gw8m7UTo=;
        b=PSWT431/ilk0jaR1V8KYxGy8QezHerx5cKMu96SZBhG/wi40p7SXIorvQsPsexvbWH
         A6/vV9lOm3oajN45SznnzMB4rw4JT5Tz3i5UTpSfMD6/KfH5r61G0l+4O/Vyl3OVhrsZ
         zhwy/Mga7gEy1WTKJ2DuwM9Ddfns21CIXI38on5yZpxODDc5R63MmNivU82nlTNVuxaz
         MYvFtk3JJlzgWVnBr5SY/2s8m6D6ttJmzMKz6ROFOuBcLHhagXDXbU6WuAmJEK810vSD
         +g0svt3BSJe4PfhfzoBTjCxedh10ozqsNwgC2x8SUF0EWQBIojWyw/xHUHtHmvEdX1RY
         xjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774097578; x=1774702378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMzDWQMEvY2hUXHfVPDP28vF18R5tNL2pT9Gw8m7UTo=;
        b=VE5oNluGWXLAlkULVpMfR6M8a03sQ53yDkF1k+vtDhYbhDjluuxW6v+mnyJQBW//E0
         E1HUXltj7mU04iYBqzuspD8cA503oTXJ8y4C3z5EwZSQvFG95x7Ag6iezImbu3nw/D4M
         r3oPbCUJ3usJ+UYL4yyP0r76UbgFWY4jupbMoO2ovjo0HFO1fuzBTi1HcZ2mb0ZoKshg
         yZWn37D2Iyk2spGc+9CsZqGl/EvYLylqCR+vkzSouTPyJTaKEsK6Uj2/5DNWs++Pe123
         77eY0F4cWhSCl3fpagJxMAoTdBsCw8qAEJkKRf5Xsd1DiGZ+dq3irc9ro46umNpxMihq
         mFNg==
X-Gm-Message-State: AOJu0YxlcjIOxa/18nrJ5ZeQdymN3zVq/az1AF8EwtDg2cVnioaUCJzS
	8vX+ZEcW+W4ZgXWaKuDFdlzxf8MuCJVmv8qG3iFYFurivfToGeRcyoYs
X-Gm-Gg: ATEYQzy0nioPhi6WGcWvfVgQSrtHqah2ag5yeLRZ/yLfRCG/z5LSE223L7K/cxYdbNc
	K5vgRgKRqsl2GS0D8iwPwLwwaGXpWHuXJP5EXXYJUTvS1HHtPdoNjtc8OpjQ2b8CeX5Rxu6DmYO
	rqlyotvcyp6utGYz4zvCvVLNqYUpLGqg2SFieAnUJXQN7wvrA8L6baB5wTK8jiO70RyMYzhj3HE
	PMe2nTwF/ABmMEKnjooQHdUFFrQfI7cINVmYEk4a3aoGAzkPOhW8gdkvhGjt3X7eBLFYHJQ1bFv
	UC9AGGraPesowDbrbzBLRfMJgVfEGiuunj+7u2Pg7Kq5Al3BTFw5YBoRIsEmPdlibcvLR5dYpLN
	mDsE4vQzeSPzjwSYXKu6HPa89oQ9AT51oJy4oCC0l6cFNQ3fbfn4zQ3ZrDjRJvtIzR04g0usvkL
	hwGHjgCwNDS8vtjCX2kKtjVTHthbE48xUR6C1Nzq6lT/L9G2/eupsaEvOsRzEewnjlbHqWKPxgO
	RBP5Kpq9xbeV2C1WjbeClzysMGqukJmq6yh5mWgKVZd6VY=
X-Received: by 2002:a17:903:124f:b0:2b0:659e:97bb with SMTP id d9443c01a7336-2b0827cf462mr64016495ad.46.1774097578025;
        Sat, 21 Mar 2026 05:52:58 -0700 (PDT)
Received: from Slifer ([2001:4454:704:ab00:6b46:1f77:2fd9:fc56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354772fsm51833785ad.28.2026.03.21.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 05:52:57 -0700 (PDT)
From: Karl Cayme <kcayme@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxhid@cosmicgizmosystems.com,
	Karl Cayme <kcayme@gmail.com>
Subject: [PATCH v2] HID: rakk: add support for Rakk Dasig X side buttons
Date: Sat, 21 Mar 2026 20:42:49 +0800
Message-ID: <20260321124759.608492-1-kcayme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3284f00a-bea0-4141-a009-b367f527c466@cosmicgizmosystems.com>
References: <3284f00a-bea0-4141-a009-b367f527c466@cosmicgizmosystems.com>
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

Suggested-by: Terry Junge <linuxhid@cosmicgizmosystems.com> 
Signed-off-by: Karl Cayme <kcayme@gmail.com>
---
Hi,

Thanks for the feedback. I updated the patch with your suggestion to
check PIDs.

Best,
Karl

v2 Changes:
  - included PID checking alongside descriptor size in report_fixup

 drivers/hid/Kconfig    |  9 +++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-ids.h  |  5 +++
 drivers/hid/hid-rakk.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/hid/hid-rakk.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a5f2..11c48cb1c6a6 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -755,6 +755,15 @@ config HID_MEGAWORLD_FF
 	Say Y here if you have a Mega World based game controller and want
 	to have force feedback support for it.
 
+config HID_RAKK
+	tristate "Rakk support"
+	help
+	  Support for Rakk gaming peripherals.
+
+	  Fixes the HID report descriptor of the Rakk Dasig X mouse,
+	  which declares USAGE_MAXIMUM=3 (buttons 1-3) while actually
+	  sending 5 button bits. This causes side buttons to be ignored.
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
index 000000000000..c59ea47b8996
--- /dev/null
+++ b/drivers/hid/hid-rakk.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  HID driver for Rakk devices
+ *
+ *  Copyright (c) 2026 Karl Cayme
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
+				     unsigned int *rsize)
+{
+	if (((*rsize == RAKK_RDESC_USB_SIZE &&
+	      hdev->product == USB_DEVICE_ID_TELINK_RAKK_DASIG_X) ||
+	     (*rsize == RAKK_RDESC_DONGLE_SIZE &&
+	      hdev->product == USB_DEVICE_ID_TELINK_RAKK_DASIG_X_DONGLE) ||
+	     (*rsize == RAKK_RDESC_BT_SIZE &&
+	      hdev->product == USB_DEVICE_ID_TELINK_RAKK_DASIG_X_BT)) &&
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

