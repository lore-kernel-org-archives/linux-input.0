Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFA332EBC
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571170; cv=none; b=lRIZ+lpe+6pxsuagDXKsC77DfWabuuSF640699y/w8DQoYUTLhbhwGkmjGv5FuXFOedg53pA7nWiqGyA+c3gZAIhI5CPz1PDtk4+dA1Di/I8yeBBmeMuNJBdCQUzjRIFmDf2n3FxMcnfP1LMtvLBDPYaecHVrm/yVw0fltnLInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571170; c=relaxed/simple;
	bh=eGdoSv0ZQao2sy6vJIavc++ikRNmW6/ATvDSNrQ1bL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuiLLetPx1fQr/HizUtji2Tw4fMUFfKLNGA6f/ko3iGeEjNApuBWo333w2hssQJHNwOURS7DCSCasQ1zkBPdJKTYGLpBiIfeWob5scBYryDLioQmm6O6NFaK0F9ODtz8qT1d1L3ltNEa6/mV9/LoPespEUMndD/k90t29COsruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHMcMQX6; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHMcMQX6"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2baa6ec5638so820625eec.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771571166; x=1772175966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVV4EM0yFjLFfGJDxNQyyIdAK6RL+8nKptT+3DYibjE=;
        b=SHMcMQX6V4BbzR5DTEtl7M0euK0DC2u0zJOXAnB8kRwFTYVdyZsMes6GxetAoF8tDe
         tYnNT8oYvp8UEaI/UQ8C4rWnRwREgfhavLY1b82VHyAg08c06/k9mML5OsHRLwuAbVlC
         rol/1WQA+boDDdAtf+dmRkVdbQlEERNzLok0r8qQ4rZqqC8I/jtyyi20TpAP4BuEOS6N
         olil2wo52lEIslh1l9ogNaUDSaJ0GTUgEvEL/Q3AA2FjJ4i+iDiQs5Vn4PU2bgUtwBIl
         JsUTYvMZGugiD9LNXDfU/k0gkD53TsvLJEQYfqD84Hr181m3gKitz/hie5OwZbcEsK7n
         pZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771571166; x=1772175966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVV4EM0yFjLFfGJDxNQyyIdAK6RL+8nKptT+3DYibjE=;
        b=tQ7rDhbVyWAKKGktUpkWqAX356Xtjp3bMPGs/Sptcm0GaB+t7BtKxX8gWl5SQ42JF/
         pXvqUGEsfg59lf0czMGv/rVvTl0Nnb8zJEG6F40ZodsBBjTe0WXHpiGNh5unPLr40JT2
         Og3CprWrHBzZ3TQp9Dl++xjENbN6qL9hakQ44pQlDfWgkIyMc50q2pbZcsQ5IP6zmmdU
         yBV1CEHEWCuBVMTME3LfzoIjJZxtNG042LuvToNKV0Pw7wNI9KmskZ+0fBDYXE+hhNKc
         AM9nH0FCAmJLAK0yUK5PRsNky7ecy/+05VFlq5XPZdUxnLrlLT7gereNGzuaYOO/sR06
         YZeA==
X-Forwarded-Encrypted: i=1; AJvYcCVwJ3xOn8IUksarfgMM4b+RtT9wQjHul7PemHWuH/2nB2OvGJtv8RXsjvRVw/m9XMymiWZYpL/kdx/vSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylFyXEyjhQJNHJCrJ718a2Y4Ys18ORAVIgehm6ZsTgeL/EqUsC
	Zx/2mJ997xTgoKsoWOlVoxH9MiIISRy/vfW4AyKa35KasoLabqYvnHpZ
X-Gm-Gg: AZuq6aI/Yh283IYWNFUwK7EBtud4rnSRNgxoLtxCH1cPXK6jg2ouLoIEy9UeMxHos0z
	iQbKb8+i1nvithPz3G/yXhcJpfuAzj2n4ZNR7/NvIGTrrdXn7FH7Zn7chLVzF/zBWWsG9a9o/Uo
	pYbHXKEH0VY0nTanZp7Fh+nx/0wvPBRYRKSmC4w+WUVWV5duXplZL8g3wABe5N8lSh0o1xEyyY3
	FWTMf5s6MkbOEn1or3uM1VppGWcysvCnydUYz6IsSbH3N4mfe8M6CcVSfO7G35ILqq6Sk4HKF/X
	3p1hevL7q5sFKxqT1LDDB47I26zFjOMLU26/5yU1ehL+zDpssJllLnkm9/0LlDTeMf9XTFkemZJ
	GivErHc8FSoXXLIvK6c+/8EohAKuEQ65tFqgZu+AuLdWliqISkzVKMebbCvls3lgWKSdJEE+6OF
	pL/MfMpcCF2R3A0LNrZ3DrnrUYXC8S9W5n5SrLzV0dHoqYfofGzpNhigsqEYncunNX8HWlvb49A
	a51ZrSPSvX5hw==
X-Received: by 2002:a05:7301:6505:b0:2ba:7c92:82fb with SMTP id 5a478bee46e88-2bd60769b84mr2019330eec.5.1771571165722;
        Thu, 19 Feb 2026 23:06:05 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm22163335eec.23.2026.02.19.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 23:06:05 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/16] HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver
Date: Fri, 20 Feb 2026 07:05:23 +0000
Message-ID: <20260220070533.4083667-11-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
References: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
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

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
  - Use dmabuf per request instead of devm allocated static buffer.
    Resolves bug with side effects during suspend.
  - Remove unnecessary HID quirks and return to HID_CONNECT_HIDRAW.
  - Adjust delayed work time to 5ms to fix some side effects during
    resume when the MCU disconnects in some circumstances.
  - Cleaner formatting on multiple debug messages.
v3:
  - Include Mario's SOB tag
---
 MAINTAINERS                   |   1 +
 drivers/hid/Kconfig           |  12 ++
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-ids.h         |   4 +
 drivers/hid/hid-lenovo-go-s.c | 287 ++++++++++++++++++++++++++++++++++
 5 files changed, 305 insertions(+)
 create mode 100644 drivers/hid/hid-lenovo-go-s.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9db6292c62ec6..1d0468906788a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14318,6 +14318,7 @@ M:	Derek J. Clark <derekjohn.clark@gmail.com>
 M:	Mark Pearson <mpearson-lenovo@squebb.ca>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	drivers/hid/hid-lenovo-go-s.c
 F:	drivers/hid/hid-lenovo-go.c
 F:	drivers/hid/hid-lenovo.c
 
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d6c31a2cbaf3b..8a04a69b8f259 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -634,6 +634,18 @@ config HID_LENOVO_GO
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
index 11435bce4e475..ef9169974bf00 100644
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
index bd41ddbbbee15..486d8baae0257 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -729,6 +729,10 @@
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
index 0000000000000..20eb472d7a247
--- /dev/null
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for Lenovo Legion Go S devices.
+ *
+ *  Copyright (c) 2026 Derek J. Clark <derekjohn.clark@gmail.com>
+ *  Copyright (c) 2026 Valve Corporation
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
+	unsigned char *dmabuf __free(kfree) = NULL;
+	u8 header[] = { command, index };
+	size_t header_size = ARRAY_SIZE(header);
+	int timeout, ret;
+
+	if (header_size + len > GO_S_PACKET_SIZE)
+		return -EINVAL;
+
+	guard(mutex)(&drvdata.cfg_mutex);
+	/* We can't use a devm_alloc reusable buffer without side effects during suspend */
+	dmabuf = kzalloc(GO_S_PACKET_SIZE, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	memcpy(dmabuf, header, header_size);
+	memcpy(dmabuf + header_size, data, len);
+
+	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
+		GO_S_PACKET_SIZE, dmabuf);
+
+	ret = hid_hw_output_report(hdev, dmabuf, GO_S_PACKET_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = ret == GO_S_PACKET_SIZE ? 0 : -EINVAL;
+	if (ret)
+		return ret;
+
+	/* PL_TEST commands can take longer because they go out to another device */
+	timeout = (command == GET_PL_TEST) ? 200 : 5;
+	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
+							msecs_to_jiffies(timeout));
+
+	if (ret == 0) /* timeout occurred */
+		ret = -EBUSY;
+
+	reinit_completion(&drvdata.send_cmd_complete);
+	return 0;
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
+	int ret;
+
+	hid_set_drvdata(hdev, &drvdata);
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
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "Parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
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

