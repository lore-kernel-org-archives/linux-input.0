Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387D2836A6
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387719; cv=none; b=LU7eYBH3WrGqT7aP7O8J6AKbEH93rtlTejbMIzqAT+gnPirYVfYCHnPx7P4Lj7SJBm3EHxIkvnVxA3O+ZBwwdYE4KIGvpsNLXWC/Pu7f17izDQJEao1y2HUzpXLPPKknEWQ5YR0rqXFiSQur+DTJLqzsaUPU7TK5Y/rRQqD3Ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387719; c=relaxed/simple;
	bh=GgEdS01djtvyT8ifwFDhef72E6cCjq5GA0rPX5E4oZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgHFKqSMtUvbX6CbRfh2tDiv7EcRGRKsU04vzlPIEfhhOQSmj/QTy2sGdHxtSqBx/zCxeX5pddQH2XH+EllHM/yVinANY4au5s1Khuai8wXII0WjDbO7r1BhvU/4yCZcfGJwdLSyRwArrA/tSYuBtPXHgtFohDU03H3BFQZGE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTj8zp+8; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTj8zp+8"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ee990e8597so5754604eec.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 21:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387717; x=1778992517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Jpd/GKI4LUhFhEW7AvVW2vl/MUioKrwAeiH0GhW6Y=;
        b=NTj8zp+8Tw7yGoetkTj8AvRvs/J7OrWJypU9Wrp1m1WMPIWTh9eO6QjQ+UXSHzYG4w
         wSo4VCsXq2qDh0bJ/bu76P+eWSxyF41QaoC1aFYgU27lQ0T2hCNC6TRIqGM7QtI2ZEXp
         lvYR4300KQvqVhg6Iar9yrsbRECwoluoiclEDoLbcdZdPveMwzNjjT5VJo/2oppoEy8w
         HVQMJgxqmcBUY1V7vqE2ZPJ6jORz2DaEacKdHccN9TFfpAYZ4QNxpCe2Hbvz4qBAj/lD
         tPtEY/e6kDkBN125JP6VufnQ+IPDGf/S73urqL3gpFpE6jbFBNpzjI3Eybrpzu4DPC8+
         WkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387717; x=1778992517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44Jpd/GKI4LUhFhEW7AvVW2vl/MUioKrwAeiH0GhW6Y=;
        b=Bh9Xxr0WCHxBPtIZx5nq6sOI14/KGzGDENUgAXCVWJnfKCB9GHdDLrB+dLmEajt+Zp
         q8N7Q0bHUHRXehysvgRNzHpU45W1PCf6gZjmAuD9w/VMW99A5mNNa2obahScyawXXCvO
         eAM1WbMNcDV/dRuq6ttHKqg1L73CGjDwjNONHZbcUmHaHAUux6izX8270Bdnut3OaQWL
         GrbWNs7xvJ6JCWmIvH5IXslg7atGdLEn9CoRn16wwjoqPhf51VsaMzTFaqySLO6np9lQ
         VpTNYkVzcuPs46xRSrPEHorPTP/Lz5qRJh9J52X9JLkWGdlXhtPPKKOAg+f/vKaf8g0D
         xkJg==
X-Forwarded-Encrypted: i=1; AFNElJ/eV002oG/rX8buS8z0IyVEPC1UKNxyK+s9m8z2oS1qmaH5F1uITRHfBcowVg0xqBEi1M5FYGuJ4cEGcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eSkfJStdpZzqpKA7erjIOCZ+7oJm4hvjRGomnZMGetIwrjhR
	C3BuPsDsOqhc9uuCtZ79x5gl6S1wPYHyd9lrerKmUgmHfI8H6KVnRhCq
X-Gm-Gg: Acq92OGbmF+FchTMjEHUbuIrlbEMyyCFGUVcoiLKRwB0EOjk47LfPMJWcUFfMsf8HBM
	3njKFJZmw5tpS11a8vVAogh02sJbai4CudzunYqa5bScUVeiDitNIo65pEZo5ovv/TKFPGhDD12
	ByKy656cKx+t7+ExXIxclhcpX9Kr7zGK7g2t1IDZV42CjufbDvGxTYY7IvIdxG80WrnvS3EycYW
	5J1mpPDkz7nPzCpJoUMvAk1LUwBch1AbgHGK8Lp8cVg17am3BTnhL2uJyb8iv+wGe0btfrcVC6S
	Nt/vKurvBkpRiwcdt47f7T7OU6T8CLzOGVira2PMnavnTzIcS+va+Z+ezQVOJohSRt2U9E7jUM4
	QWlSVwjxKuaCmDtugsdcXkw2lgFXc5qkNp5QXOW/4Ui1JLrkd6JiQhB54ZKrKl/G9AfyBQQtvHi
	F+FKWaXaaV7GXIAzTOzHVI9z3oD5KHu1chD/I762+GD5v19naDRPZGwbkRzkUhf50mE/MM6GJTG
	ubQLeFnt5UlM0A=
X-Received: by 2002:a05:7301:5792:b0:2e6:e504:5435 with SMTP id 5a478bee46e88-2f5493978dcmr10081543eec.12.1778387716469;
        Sat, 09 May 2026 21:35:16 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885be8esm8667953eec.22.2026.05.09.21.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:35:16 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] HID: hid-msi-claw: Add MSI Claw configuration driver
Date: Sun, 10 May 2026 04:35:07 +0000
Message-ID: <20260510043510.442807-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510043510.442807-1-derekjohn.clark@gmail.com>
References: <20260510043510.442807-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds configuration HID driver for the MSI Claw series of handheld PC's.
In this initial patch add the initial driver outline and attributes for
changing the gamepad mode, M-key behavior, and add a WO reset function.

Sending the SWITCH_MODE and RESET commands causes a USB disconnect in
the device. The completion will therefore never get hit and would trigger
an -EIO. To avoid showing the user an error for every write to these
attrs a bypass for the completion handling is introduced when timeout ==
0.

The initial version of this patch was written by Denis Benato, which
contained the initial reverse-engineering and implementation for the
gamepad mode switching. This work was later expanded by Zhouwang Huang
to include more gamepad modes. Finally, I refactored the drivers data
in/out flow and overall format to conform to kernel driver best
practices and style guides. Claude was used as an initial reviewer of
this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 MAINTAINERS                |   6 +
 drivers/hid/Kconfig        |  12 +
 drivers/hid/Makefile       |   1 +
 drivers/hid/hid-ids.h      |   6 +
 drivers/hid/hid-msi-claw.c | 538 +++++++++++++++++++++++++++++++++++++
 5 files changed, 563 insertions(+)
 create mode 100644 drivers/hid/hid-msi-claw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f6517bf4f97..5de5e62d9c92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17965,6 +17965,12 @@ S:	Odd Fixes
 F:	Documentation/devicetree/bindings/net/ieee802154/mrf24j40.txt
 F:	drivers/net/ieee802154/mrf24j40.c
 
+MSI CLAW HID DRIVER
+M:	Derek J. Clark <derekjohn.clark@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-msi-claw.c
+
 MSI EC DRIVER
 M:	Nikita Kravets <teackot@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 10c12d8e6557..0cbe10ad6367 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -492,6 +492,18 @@ config HID_GT683R
 	Currently the following devices are know to be supported:
 	  - MSI GT683R
 
+config HID_MSI_CLAW
+	tristate "MSI Claw Gamepad Support"
+	depends on USB_HID
+	select LEDS_CLASS
+	select LEDS_CLASS_MULTICOLOR
+	help
+	Support for the MSI Claw RGB and controller configuration
+
+	Say Y here to include configuration interface support for the MSI Claw Line
+	of Handheld Console Controllers. Say M here to compile this driver as a
+	module. The module will be called hid-msi-claw.
+
 config HID_KEYTOUCH
 	tristate "Keytouch HID devices"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 07dfdb6a49c5..c1dea89f1e87 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
 obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
 obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
+obj-$(CONFIG_HID_MSI_CLAW)	+= hid-msi-claw.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 933b7943bdb5..6d0d34806931 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1047,7 +1047,13 @@
 #define USB_DEVICE_ID_MOZA_R16_R21_2	0x0010
 
 #define USB_VENDOR_ID_MSI		0x1770
+#define USB_VENDOR_ID_MSI_2		0x0db0
 #define USB_DEVICE_ID_MSI_GT683R_LED_PANEL 0xff00
+#define USB_DEVICE_ID_MSI_CLAW_XINPUT	0x1901
+#define USB_DEVICE_ID_MSI_CLAW_DINPUT	0x1902
+#define USB_DEVICE_ID_MSI_CLAW_DESKTOP	0x1903
+#define USB_DEVICE_ID_MSI_CLAW_BIOS	0x1904
+
 
 #define USB_VENDOR_ID_NATIONAL_SEMICONDUCTOR 0x0400
 #define USB_DEVICE_ID_N_S_HARMONY	0xc359
diff --git a/drivers/hid/hid-msi-claw.c b/drivers/hid/hid-msi-claw.c
new file mode 100644
index 000000000000..7a3cd940ec49
--- /dev/null
+++ b/drivers/hid/hid-msi-claw.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for MSI Claw Handheld PC gamepads.
+ *
+ *  Provides configuration support for the MSI Claw series of handheld PC
+ *  gamepads. Multiple iterations of the device firmware has led to some
+ *  quirks for how certain attributes are handled. The original firmware
+ *  did not support remapping of the M1 (right) and M2 (left) rear paddles.
+ *  Additionally, the MCU RAM address for writing configuration data has
+ *  changed twice. Checks are done during probe to enumerate these variances.
+ *
+ *  Copyright (c) 2026 Zhouwang Huang <honjow311@gmail.com>
+ *  Copyright (c) 2026 Denis Benato <denis.benato@linux.dev>
+ *  Copyright (c) 2026 Valve Corporation
+ */
+
+#include <linux/array_size.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/kobject.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+#define CLAW_OUTPUT_REPORT_ID	0x0f
+#define CLAW_INPUT_REPORT_ID	0x10
+
+#define CLAW_PACKET_SIZE	64
+
+#define CLAW_DINPUT_CFG_INTF_IN	0x82
+#define CLAW_XINPUT_CFG_INTF_IN	0x83
+
+enum claw_command_index {
+	CLAW_COMMAND_TYPE_READ_PROFILE =		0x04,
+	CLAW_COMMAND_TYPE_READ_PROFILE_ACK =		0x05,
+	CLAW_COMMAND_TYPE_ACK =				0x06,
+	CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA =		0x21,
+	CLAW_COMMAND_TYPE_SYNC_TO_ROM =			0x22,
+	CLAW_COMMAND_TYPE_SWITCH_MODE =			0x24,
+	CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE =		0x26,
+	CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK =		0x27,
+	CLAW_COMMAND_TYPE_RESET_DEVICE =		0x28,
+};
+
+enum claw_gamepad_mode_index {
+	CLAW_GAMEPAD_MODE_XINPUT =	0x01,
+	CLAW_GAMEPAD_MODE_DINPUT =	0x02,
+	CLAW_GAMEPAD_MODE_DESKTOP =	0x04,
+};
+
+static const char * const claw_gamepad_mode_text[] = {
+	[CLAW_GAMEPAD_MODE_XINPUT] =	"xinput",
+	[CLAW_GAMEPAD_MODE_DINPUT] =	"dinput",
+	[CLAW_GAMEPAD_MODE_DESKTOP] =	"desktop",
+};
+
+enum claw_mkeys_function_index {
+	CLAW_MKEY_FUNCTION_MACRO,
+	CLAW_MKEY_FUNCTION_COMBO,
+	CLAW_MKEY_FUNCTION_DISABLED,
+};
+
+static const char * const claw_mkeys_function_text[] = {
+	[CLAW_MKEY_FUNCTION_MACRO] =	"macro",
+	[CLAW_MKEY_FUNCTION_COMBO] =	"combination",
+	[CLAW_MKEY_FUNCTION_DISABLED] =	"disabled",
+};
+
+struct claw_command_report {
+	u8 report_id;
+	u8 padding[2];
+	u8 header_tail;
+	u8 cmd;
+	u8 data[59];
+} __packed;
+
+struct claw_drvdata {
+	/* MCU General Variables */
+	struct completion send_cmd_complete;
+	struct delayed_work cfg_resume;
+	struct delayed_work cfg_setup;
+	struct hid_device *hdev;
+	struct mutex cfg_mutex; /* mutex for synchronous data */
+	int endpoint;
+
+	/* Gamepad Variables */
+	enum claw_mkeys_function_index mkeys_function;
+	enum claw_gamepad_mode_index gamepad_mode;
+};
+
+static int get_endpoint_address(struct hid_device *hdev)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_host_endpoint *ep;
+
+	ep = intf->cur_altsetting->endpoint;
+	if (ep)
+		return ep->desc.bEndpointAddress;
+
+	return -ENODEV;
+}
+
+static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
+				   struct claw_command_report *cmd_rep)
+{
+	if (cmd_rep->data[0] >= ARRAY_SIZE(claw_gamepad_mode_text) ||
+	    cmd_rep->data[1] >= ARRAY_SIZE(claw_mkeys_function_text))
+		return -EINVAL;
+
+	drvdata->gamepad_mode = cmd_rep->data[0];
+	drvdata->mkeys_function = cmd_rep->data[1];
+
+	return 0;
+}
+
+static int claw_raw_event(struct hid_device *hdev, struct hid_report *report,
+			  u8 *data, int size)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct claw_command_report *cmd_rep;
+	int ret = 0;
+
+	if (size != CLAW_PACKET_SIZE)
+		return 0;
+
+	if (drvdata->endpoint != CLAW_XINPUT_CFG_INTF_IN &&
+	    drvdata->endpoint != CLAW_DINPUT_CFG_INTF_IN)
+		return 0;
+
+	cmd_rep = (struct claw_command_report *)data;
+
+	if (cmd_rep->report_id != CLAW_INPUT_REPORT_ID || cmd_rep->header_tail != 0x3c)
+		return 0;
+
+	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
+		CLAW_PACKET_SIZE, data);
+
+	switch (cmd_rep->cmd) {
+	case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
+		ret = claw_gamepad_mode_event(drvdata, cmd_rep);
+		break;
+	case CLAW_COMMAND_TYPE_ACK:
+		break;
+	default:
+		dev_dbg(&hdev->dev, "Unknown command: %x\n", cmd_rep->cmd);
+		return 0;
+	}
+
+	complete(&drvdata->send_cmd_complete);
+	return ret;
+}
+
+static int mcu_property_out(struct hid_device *hdev, u8 index, u8 *data,
+			    size_t len, unsigned int timeout)
+{
+	unsigned char *dmabuf __free(kfree) = NULL;
+	u8 header[] = { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	size_t header_size = ARRAY_SIZE(header);
+	int ret;
+
+	if (header_size + len > CLAW_PACKET_SIZE)
+		return -EINVAL;
+
+	/* We can't use a devm_alloc reusable buffer without side effects during suspend */
+	dmabuf = kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	memcpy(dmabuf, header, header_size);
+	if (data && len)
+		memcpy(dmabuf + header_size, data, len);
+
+	/* Don't hold a mutex when timeout=0, those commands cause USB disconnect */
+	if (timeout) {
+		guard(mutex)(&drvdata->cfg_mutex);
+		reinit_completion(&drvdata->send_cmd_complete);
+	}
+
+	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
+		CLAW_PACKET_SIZE, dmabuf);
+
+	ret = hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = ret == CLAW_PACKET_SIZE ? 0 : -EIO;
+	if (ret)
+		return ret;
+
+	if (timeout) {
+		ret = wait_for_completion_interruptible_timeout(&drvdata->send_cmd_complete,
+								msecs_to_jiffies(timeout));
+
+		dev_dbg(&hdev->dev, "Remaining timeout: %u\n", ret);
+		if (ret >= 0) /* preserve errors */
+			ret = ret == 0 ? -EBUSY : 0; /* timeout occurred : time remained */
+	}
+
+	return ret;
+}
+
+static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 data[2] = { 0x00, drvdata->mkeys_function };
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(claw_gamepad_mode_text); i++) {
+		if (claw_gamepad_mode_text[i] && sysfs_streq(buf, claw_gamepad_mode_text[i])) {
+			ret = i;
+			break;
+		}
+	}
+	if (ret < 0)
+		return ret;
+
+	data[0] = ret;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data, ARRAY_SIZE(data), 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t gamepad_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret, i;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 8);
+	if (ret)
+		return ret;
+
+	i = drvdata->gamepad_mode;
+
+	if (!claw_gamepad_mode_text[i] || claw_gamepad_mode_text[i][0] == '\0')
+		return sysfs_emit(buf, "unsupported\n");
+
+	return sysfs_emit(buf, "%s\n", claw_gamepad_mode_text[i]);
+}
+static DEVICE_ATTR_RW(gamepad_mode);
+
+static ssize_t gamepad_mode_index_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(claw_gamepad_mode_text); i++) {
+		if (!claw_gamepad_mode_text[i] || claw_gamepad_mode_text[i][0] == '\0')
+			continue;
+		count += sysfs_emit_at(buf, count, "%s ", claw_gamepad_mode_text[i]);
+	}
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(gamepad_mode_index);
+
+static ssize_t mkeys_function_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 data[2] = { drvdata->gamepad_mode, 0x00 };
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(claw_mkeys_function_text); i++) {
+		if (claw_mkeys_function_text[i] && sysfs_streq(buf, claw_mkeys_function_text[i])) {
+			ret = i;
+			break;
+		}
+	}
+	if (ret < 0)
+		return ret;
+
+	data[1] = ret;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data, ARRAY_SIZE(data), 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t mkeys_function_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret, i;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 8);
+	if (ret)
+		return ret;
+
+	i = drvdata->mkeys_function;
+
+	if (i >= ARRAY_SIZE(claw_mkeys_function_text))
+		return sysfs_emit(buf, "unsupported\n");
+
+	return sysfs_emit(buf, "%s\n", claw_mkeys_function_text[i]);
+}
+static DEVICE_ATTR_RW(mkeys_function);
+
+static ssize_t mkeys_function_index_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	int i, count = 0;
+
+	for (i = 0; i < ARRAY_SIZE(claw_mkeys_function_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", claw_mkeys_function_text[i]);
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(mkeys_function_index);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = mcu_property_out(hdev, CLAW_COMMAND_TYPE_RESET_DEVICE, NULL, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribute *attr,
+					    int n)
+{
+	struct hid_device *hdev = to_hid_device(kobj_to_dev(kobj));
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata) {
+		dev_warn(&hdev->dev,
+			 "Failed to get drvdata from kobj. Gamepad attributes are not available.\n");
+		return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute *claw_gamepad_attrs[] = {
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
+	&dev_attr_mkeys_function.attr,
+	&dev_attr_mkeys_function_index.attr,
+	&dev_attr_reset.attr,
+	NULL,
+};
+
+static const struct attribute_group claw_gamepad_attr_group = {
+	.attrs = claw_gamepad_attrs,
+	.is_visible = claw_gamepad_attr_is_visible,
+};
+
+static void claw_remove(struct hid_device *hdev);
+
+static void cfg_setup_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work, work);
+	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, cfg_setup);
+	int ret;
+
+	ret = mcu_property_out(drvdata->hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 8);
+	if (ret) {
+		dev_err(&drvdata->hdev->dev,
+			"Failed to setup device, can't read gamepad mode: %d\n", ret);
+		claw_remove(drvdata->hdev);
+	}
+
+	/* Add sysfs attributes after we get the device state */
+	ret = sysfs_create_group(&drvdata->hdev->dev.kobj, &claw_gamepad_attr_group);
+	if (ret) {
+		dev_err(&drvdata->hdev->dev,
+			"Failed to setup device, can't create gamepad attrs: %d\n", ret);
+		claw_remove(drvdata->hdev);
+	}
+
+	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
+}
+
+static void cfg_resume_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work, work);
+	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, cfg_resume);
+	u8 data[2] = { drvdata->gamepad_mode, drvdata->mkeys_function };
+	int ret;
+
+	ret = mcu_property_out(drvdata->hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data,
+			       ARRAY_SIZE(data), 0);
+	if (ret)
+		dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode settings: %d\n", ret);
+}
+
+static int claw_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct claw_drvdata *drvdata;
+	struct usb_interface *intf;
+	struct usb_device *udev;
+	int ret;
+
+	if (!hid_is_usb(hdev)) {
+		ret = -ENODEV;
+		goto err_probe;
+	}
+
+	intf = to_usb_interface(hdev->dev.parent);
+	udev = interface_to_usbdev(intf);
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		ret = -ENOMEM;
+		goto err_probe;
+	}
+
+	mutex_init(&drvdata->cfg_mutex);
+
+	hid_set_drvdata(hdev, drvdata);
+	drvdata->hdev = hdev;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		goto err_probe;
+
+	/* Set quirk to create separate input devices per HID application */
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP | HID_QUIRK_MULTI_INPUT;
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		goto err_probe;
+
+	/* For non-control interfaces (keyboard/mouse), allow userspace to grab the devices. */
+	drvdata->endpoint = get_endpoint_address(hdev);
+	if (drvdata->endpoint != CLAW_XINPUT_CFG_INTF_IN &&
+	    drvdata->endpoint != CLAW_DINPUT_CFG_INTF_IN)
+		return 0;
+
+	/* For control interface: open the HID transport for sending commands. */
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto err_stop_hw;
+
+	init_completion(&drvdata->send_cmd_complete);
+
+	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
+	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
+	schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));
+
+	return 0;
+
+err_stop_hw:
+	hid_hw_stop(hdev);
+err_probe:
+	return dev_err_probe(&hdev->dev, ret, "Failed to init configuration device\n");
+}
+
+static void claw_remove(struct hid_device *hdev)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata)
+		return;
+
+	if (drvdata->endpoint == CLAW_XINPUT_CFG_INTF_IN ||
+	    drvdata->endpoint == CLAW_DINPUT_CFG_INTF_IN) {
+		sysfs_remove_group(&hdev->dev.kobj, &claw_gamepad_attr_group);
+		cancel_delayed_work_sync(&drvdata->cfg_setup);
+		cancel_delayed_work_sync(&drvdata->cfg_resume);
+		hid_hw_close(hdev);
+	}
+
+	hid_hw_stop(hdev);
+}
+
+static int claw_resume(struct hid_device *hdev)
+{
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	/* MCU can take up to 500ms to be ready after resume */
+	schedule_delayed_work(&drvdata->cfg_resume, msecs_to_jiffies(500));
+
+	return 0;
+}
+
+static const struct hid_device_id claw_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_XINPUT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_DINPUT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_DESKTOP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI_2, USB_DEVICE_ID_MSI_CLAW_BIOS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, claw_devices);
+
+static struct hid_driver claw_driver = {
+	.name		= "hid-msi-claw",
+	.id_table	= claw_devices,
+	.raw_event	= claw_raw_event,
+	.probe		= claw_probe,
+	.remove		= claw_remove,
+	.resume		= claw_resume,
+};
+module_hid_driver(claw_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Denis Benato <denis.benato@linux.dev>");
+MODULE_AUTHOR("Zhouwang Huang <honjow311@gmail.com>");
+MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_DESCRIPTION("HID driver for MSI Claw Handheld PC gamepads");
-- 
2.53.0

