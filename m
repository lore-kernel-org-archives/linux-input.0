Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790F224B04
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219364; cv=none; b=aq6WB5X9NBoGVdVFZNjgirgL0f7mOBl5ZA8Ex8pbCTm8XVWbRrV2XiAHPX0+vwkgrUd/WOWIz2JSTNbLLtF9wWZVy76haqtDe7WKRZ2G3YFPswa4q7Y9MYz0lF7dvWPOfhFeZ1ju642V+O9b5Qo438buPbE8lX3tlVVVUSQMkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219364; c=relaxed/simple;
	bh=YZAV2fCv+zHtZckQV8so+7ZE7tatCYtf4LTOqJNJgHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ+KRnOwGfoNTEXfGmm9hxSzwBkFJTBOvw3ltWzUryiYVMGi590dJeiduH5leYqWi5CINYhm8T01u21zht/e+8tYdh8n8L5MsHm0TClLX4FR/Bu/p7rshBdalerctmfug9sm9oIbSLSg1ug6+fk5+vEGXDgko3/YN+HztwDguIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoysAizb; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoysAizb"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4540798eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219360; x=1769824160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hklQKX6M0DwYqoKUXsL3kGgABpcCY86KWl+klqFSMUQ=;
        b=DoysAizbk+4hjS0zH5KJbhwD7mjOPu+FZTNxzuNrBsXBUiLLIvTCwYqfIb1AL3Opu9
         WE9IJxlQOJ3+ciwtC8tcFc+4HWwT2zR0os5YZ0hpxB+NraKi8WI7ItTkuNVNpcWBbjGM
         aqeHkJ4nHfg7MdoXLniTAqOHeyLalc7asylsNmHVxmnGyf0z4JdpWHfbcIfKwGi8nnFV
         tFL4GJ0szJxM8jZZ5mmZ+fpKeAT7xIRZmGBaCVeu3Mgdb2Unis1GqyfFC4kBjc0BMGN0
         lTudGPSkZcAkcp/Acz9wdkW9wxACRNkP2ASsjqaPQQbCDWXrDlenZIpM0NFolAsYTnRR
         31fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219360; x=1769824160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hklQKX6M0DwYqoKUXsL3kGgABpcCY86KWl+klqFSMUQ=;
        b=RjMIpLM4nxrarxG0J/+DQpMqsUOqeWmTtLQBrRTe2N7lSEuqlksrweapJmdos40USd
         4xMTHISqCqfg/ob6vcaeJgl7UoiZe+1kjtlqom6wU425dcOIUL0Fb4URkiVVCx98ngZO
         26LUY3QTjudl2fXPtdX6UyK9dlp57COqqWeBUqHWs/N+6MaFw9ln+0Em1EMs/64lS/zv
         y09lJBcSa91tOZrNPa6VD1t7EeJyuO1+I4ZcuUdqOYGvQGRjAp58TkDMpUaBj47QnRS8
         RUYk8a80qL1XsEZS9kKUAsoVvrT6mIubYduVmhN5hYi0krAJ2xSlpSxtpQLq5fHpVDsE
         IoQw==
X-Forwarded-Encrypted: i=1; AJvYcCW5z+WoN6tpCdt3tU3YIyCfZMkp9i5HUtG+6UX5E90ep2AOYg69YPOZJw141X6qDvdHT9Ty6rIbqMfsdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwKtvBAyn2aM5ziotl05EKWBGHjvlW79t7TJPlWNdAWHq8/WI
	WOXjckI84i+EMFQ9T99HID0CLoHoMcxN/sUceFAzswj5ByVxGekv4mOA
X-Gm-Gg: AZuq6aL56ELIMGUttpNapEpOhUZpzCessC9ju/spZdtGn4eaxuNr1Oh1b0m7hsJey01
	Yn15rIyNjB4JSgH2/Thp2/2cGZe4XP/CEvdbuGv6i16cH3Lf0LGv+v1+X4umUIoVWS++EXCnO2Z
	ClgBbvSwNLVJk0homYcQqTcPJzrPDh58HOnp6gBiS96/G5/KxzqX7YHxjXtLZJ31UgFTuXXJh74
	VvCS3RNTghV8FgtMulU8dd/B6RzZh4ctm/9UejKYRQEJMO86ezcxVFOw3Pg6fNCajMnVqNsMegd
	sEmfM+0fln9QsDqTwWI4ETpfD8lbjA091L3SvN0YREhLUg0POTBM8UW4vrQMS24vhFEgY7o0+hA
	rj9Cr1p5abBlMa0XOVbgQl/rWyWDRD2tfsiLch58Pyka1yv6RSd3fEOW4aQtAf4ueexoM9JN/8w
	bFPyiAGC6FsMK7KdArred8jbPfmfQhLbORFcIQSUC/ezOPaewDLUc1fWnZoCxgz4A=
X-Received: by 2002:a05:7300:2310:b0:2b7:1e86:35ee with SMTP id 5a478bee46e88-2b739b71179mr2222242eec.28.1769219360136;
        Fri, 23 Jan 2026 17:49:20 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:19 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/16] HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver
Date: Sat, 24 Jan 2026 01:49:01 +0000
Message-ID: <20260124014907.991265-11-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124014907.991265-1-derekjohn.clark@gmail.com>
References: <20260124014907.991265-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds initial framework for a new HID driver, hid-lenovo-go-s, along with
a uevent to report the firmware version for the MCU.

This driver primarily provides access to the configurable settings of the
Lenovo Legion Go S controller. It will attach if the controller is in
xinput or dinput mode. Non-configuration raw reports are forwarded to
ensure the other endpoints continue to function as normal.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
V3:
  - Include Mario's SOB tag
---
 MAINTAINERS                   |   1 +
 drivers/hid/Kconfig           |  12 ++
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-ids.h         |   4 +
 drivers/hid/hid-lenovo-go-s.c | 293 ++++++++++++++++++++++++++++++++++
 5 files changed, 311 insertions(+)
 create mode 100644 drivers/hid/hid-lenovo-go-s.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c6396be68ff1..723598010189 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14140,6 +14140,7 @@ M:	Derek J. Clark <derekjohn.clark@gmail.com>
 M:	Mark Pearson <mpearson-lenovo@squebb.ca>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	drivers/hid/hid-lenovo-go-s.c
 F:	drivers/hid/hid-lenovo-go.c
 F:	drivers/hid/hid-lenovo.c
 
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 74ac6793b29a..2b1a9fa93758 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -633,6 +633,18 @@ config HID_LENOVO_GO
 	and Legion Go 2 Handheld Console Controllers. Say M here to compile this
 	driver as a module. The module will be called hid-lenovo-go.
 
+config HID_LENOVO_GO_S
+	tristate "HID Driver for Lenovo Legion Go S Controller"
+	depends on USB_HID
+	select LEDS_CLASS
+	select LEDS_CLASS_MULTICOLOR
+	help
+	Support for Lenovo Legion Go S Handheld Console Controller.
+
+	Say Y here to include configuration interface support for the Lenovo Legion Go
+	S. Say M here to compile this driver as a module. The module will be called
+	hid-lenovo-go-s.
+
 config HID_LETSKETCH
 	tristate "Letsketch WP9620N tablets"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 11435bce4e47..ef9169974bf0 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_HID_KYSONA)	+= hid-kysona.o
 obj-$(CONFIG_HID_LCPOWER)	+= hid-lcpower.o
 obj-$(CONFIG_HID_LENOVO)	+= hid-lenovo.o
 obj-$(CONFIG_HID_LENOVO_GO)	+= hid-lenovo-go.o
+obj-$(CONFIG_HID_LENOVO_GO_S)	+= hid-lenovo-go-s.o
 obj-$(CONFIG_HID_LETSKETCH)	+= hid-letsketch.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-lg-g15.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 309e15580a38..eee1091125ca 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -723,6 +723,10 @@
 #define USB_DEVICE_ID_ITE8595		0x8595
 #define USB_DEVICE_ID_ITE_MEDION_E1239T	0xce50
 
+#define USB_VENDOR_ID_QHE		0x1a86
+#define USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT 0xe310
+#define USB_DEVICE_ID_LENOVO_LEGION_GO_S_DINPUT 0xe311
+
 #define USB_VENDOR_ID_JABRA		0x0b0e
 #define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
 #define USB_DEVICE_ID_JABRA_SPEAK_510	0x0420
diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
new file mode 100644
index 000000000000..3e9041e746df
--- /dev/null
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for Lenovo Legion Go S devices.
+ *
+ *  Copyright (c) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/array_size.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
+
+#include "hid-ids.h"
+
+#define GO_S_CFG_INTF_IN	0x84
+#define GO_S_PACKET_SIZE	64
+
+struct hid_gos_cfg {
+	unsigned char *buf;
+	struct delayed_work gos_cfg_setup;
+	struct completion send_cmd_complete;
+	struct hid_device *hdev;
+	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+} drvdata;
+
+struct command_report {
+	u8 cmd;
+	u8 sub_cmd;
+	u8 data[63];
+} __packed;
+
+struct version_report {
+	u8 cmd;
+	u32 version;
+	u8 reserved[59];
+} __packed;
+
+enum mcu_command_index {
+	GET_VERSION = 0x01,
+	GET_MCU_ID,
+	GET_GAMEPAD_CFG,
+	SET_GAMEPAD_CFG,
+	GET_TP_PARAM,
+	SET_TP_PARAM,
+	GET_RGB_CFG = 0x0f,
+	SET_RGB_CFG,
+	GET_PL_TEST = 0xdf,
+};
+
+#define FEATURE_NONE 0x00
+
+static int hid_gos_version_event(u8 *data)
+{
+	struct version_report *ver_rep = (struct version_report *)data;
+
+	drvdata.hdev->firmware_version = get_unaligned_le32(&ver_rep->version);
+	return 0;
+}
+
+static u8 get_endpoint_address(struct hid_device *hdev)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_host_endpoint *ep;
+
+	if (intf) {
+		ep = intf->cur_altsetting->endpoint;
+		if (ep)
+			return ep->desc.bEndpointAddress;
+	}
+
+	return -ENODEV;
+}
+
+static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
+			     u8 *data, int size)
+{
+	struct command_report *cmd_rep;
+	int ep, ret;
+
+	if (size != GO_S_PACKET_SIZE)
+		goto passthrough;
+
+	ep = get_endpoint_address(hdev);
+	if (ep != GO_S_CFG_INTF_IN)
+		goto passthrough;
+
+	cmd_rep = (struct command_report *)data;
+
+	switch (cmd_rep->cmd) {
+	case GET_VERSION:
+		ret = hid_gos_version_event(data);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
+		GO_S_PACKET_SIZE, data);
+
+	complete(&drvdata.send_cmd_complete);
+	return ret;
+
+passthrough:
+	/* Forward other HID reports so they generate events */
+	hid_input_report(hdev, HID_INPUT_REPORT, data, size, 1);
+	return 0;
+}
+
+static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
+			    u8 *data, size_t len)
+{
+	u8 header[] = { command, index };
+	size_t header_size = ARRAY_SIZE(header);
+	size_t total_size = header_size + len;
+	int timeout = 5;
+	int ret;
+
+	/* PL_TEST commands can take longer because they go out to another device */
+	if (command == GET_PL_TEST)
+		timeout = 200;
+
+	guard(mutex)(&drvdata.cfg_mutex);
+	memcpy(drvdata.buf, header, header_size);
+	memcpy(drvdata.buf + header_size, data, len);
+	memset(drvdata.buf + total_size, 0, GO_S_PACKET_SIZE - total_size);
+
+	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
+		GO_S_PACKET_SIZE, drvdata.buf);
+
+	ret = hid_hw_output_report(hdev, drvdata.buf, GO_S_PACKET_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = ret == GO_S_PACKET_SIZE ? 0 : -EINVAL;
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
+							msecs_to_jiffies(timeout));
+
+	if (ret == 0) /* timeout occurred */
+		ret = -EBUSY;
+	if (ret > 0) /* timeout/interrupt didn't occur */
+		ret = 0;
+
+	reinit_completion(&drvdata.send_cmd_complete);
+	return ret;
+}
+
+static void cfg_setup(struct work_struct *work)
+{
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, GET_VERSION, FEATURE_NONE, 0, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve MCU Version: %i\n", ret);
+		return;
+	}
+}
+
+static int hid_gos_cfg_probe(struct hid_device *hdev,
+			     const struct hid_device_id *_id)
+{
+	unsigned char *buf;
+	int ret;
+
+	buf = devm_kzalloc(&hdev->dev, GO_S_PACKET_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, &drvdata);
+	drvdata.buf = buf;
+	drvdata.hdev = hdev;
+	mutex_init(&drvdata.cfg_mutex);
+
+	init_completion(&drvdata.send_cmd_complete);
+
+	/* Executing calls prior to returning from probe will lock the MCU. Schedule
+	 * initial data call after probe has completed and MCU can accept calls.
+	 */
+	INIT_DELAYED_WORK(&drvdata.gos_cfg_setup, &cfg_setup);
+	ret = schedule_delayed_work(&drvdata.gos_cfg_setup,
+				    msecs_to_jiffies(2));
+	if (!ret) {
+		dev_err(&hdev->dev,
+			"Failed to schedule startup delayed work\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void hid_gos_cfg_remove(struct hid_device *hdev)
+{
+	guard(mutex)(&drvdata.cfg_mutex);
+	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+	hid_set_drvdata(hdev, NULL);
+}
+
+static int hid_gos_probe(struct hid_device *hdev,
+			 const struct hid_device_id *id)
+{
+	int ret, ep;
+
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP | HID_QUIRK_MULTI_INPUT;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "Parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "Failed to start HID device\n");
+		return ret;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "Failed to open HID device\n");
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	ep = get_endpoint_address(hdev);
+	if (ep != GO_S_CFG_INTF_IN) {
+		dev_dbg(&hdev->dev,
+			"Started interface %x as generic HID device.\n", ep);
+		return 0;
+	}
+
+	ret = hid_gos_cfg_probe(hdev, id);
+	if (ret)
+		dev_err_probe(&hdev->dev, ret,
+			      "Failed to start configuration interface");
+
+	dev_dbg(&hdev->dev, "Started Legion Go S HID Device: %x\n", ep);
+	return ret;
+}
+
+static void hid_gos_remove(struct hid_device *hdev)
+{
+	int ep = get_endpoint_address(hdev);
+
+	switch (ep) {
+	case GO_S_CFG_INTF_IN:
+		hid_gos_cfg_remove(hdev);
+		break;
+	default:
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+
+		break;
+	}
+}
+
+static const struct hid_device_id hid_gos_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
+			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
+			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_DINPUT) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, hid_gos_devices);
+static struct hid_driver hid_lenovo_go_s = {
+	.name = "hid-lenovo-go-s",
+	.id_table = hid_gos_devices,
+	.probe = hid_gos_probe,
+	.remove = hid_gos_remove,
+	.raw_event = hid_gos_raw_event,
+};
+module_hid_driver(hid_lenovo_go_s);
+
+MODULE_AUTHOR("Derek J. Clark");
+MODULE_DESCRIPTION("HID Driver for Lenovo Legion Go S Series gamepad.");
+MODULE_LICENSE("GPL");
-- 
2.52.0

