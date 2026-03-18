Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AD346E56;
	Wed, 18 Mar 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825214; cv=none; b=EKm4ksHUxU/PpKF/5w7ZfVTp1KgQF/1f+wX3Kwv6Kpy9XbrixNo+U0tPnU4W8JqbPcPT02rkgAHiXcAR33UlHBuro78kUZkw8PmZW3149gnZBEPpVkKHSUHDRUAZ80V6TWSGsxebEQAfHgyLeqOGL9pfvoGgjZQotkEcn8k5Thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825214; c=relaxed/simple;
	bh=p8TM90r5gf/sqVmE8YlDpMBRxDp8j1cmd5bqFX1pqE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bjx4YZlbjRfdtQfW6PtimwE2c9wMSVPIWZTlOKe+TPMJ6ksffByGWnzLEqZGfdGr1DDFw3iOKhhXaTOMM0cJjpxLwZ5ouUBWexQiJPKl+v93V62MrO4Ysj0q+mg1ArpR4wh/lgNFbXrDkpXEzDcrAj6tp4ZK+NSFqTWzJ4o21VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MAPMUM8x; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MAPMUM8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=i0
	6aL62inD/1Fdie+/OoLINYJZHJ/OEGix0QNe8SMIg=; b=MAPMUM8xY+2kx0r8El
	d4RFnKAtFiVDcSuIsCRaHNmTAecI3h0TnFzLbWADB2vv0HfIEkKGuFO1l+iKTrI9
	flhOVFTCscvyUG0NpkAowsYXpJVmZ3TndEy2rj1BneNm62f7yCuwXy1ov1peCrs2
	KwjtbWt1fXG0V6mB+erDqPJBo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXvx6ibLppEjCaBg--.45257S2;
	Wed, 18 Mar 2026 17:13:08 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH] HID: huawei: fix CD30 keyboard report descriptor issue
Date: Wed, 18 Mar 2026 17:12:49 +0800
Message-Id: <20260318091249.217283-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXvx6ibLppEjCaBg--.45257S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr18Cw1xur45XF4xZrWrKrg_yoW7KF45pF
	4DurWvkr4DJw1ag3yj934UCrW5K3Z2yFyfZrWfGw4YgayxAFWktrn3t3y5Xr1rXrW8J3W2
	qryF9rW7KFWq93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioq2AUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzQRNG2m6bKRKLgAA3g

From: Miao Li <limiao@kylinos.cn>

When the Huawei CD30 USB keyboard undergoes 500 reboot cycles,
initialization may fail due to a report descriptor problem.
The error log is as follows:
[pid:175,cpu0,kworker/0:1,6]usb 1-1.2.2: new low-speed USB device number 6 using xhci-hcd
[pid:175,cpu0,kworker/0:1,9]usb 1-1.2.2: New USB device found, idVendor=12d1, idProduct=109b, bcdDevice= 1.03
[pid:175,cpu0,kworker/0:1,0]usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[pid:175,cpu0,kworker/0:1,1]usb 1-1.2.2: Product: HUAWEI USB Wired Keyboard
[pid:175,cpu0,kworker/0:1,2]usb 1-1.2.2: Manufacturer: HUAWEI
[pid:175,cpu0,kworker/0:1,4]input: HUAWEI HUAWEI USB Wired Keyboard as /devices/platform/efc00000.hisi_usb/efc00000.dwc3/xhci-hcd.1.auto/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2:1.0/0003:12D1:109B.0002/input/input6
[pid:175,cpu0,kworker/0:1,5]hid-generic 0003:12D1:109B.0002: input,hidraw1: USB HID v1.10 Keyboard [HUAWEI HUAWEI USB Wired Keyboard] on usb-xhci-hcd.1.auto-1.2.2/input0
[pid:175,cpu0,kworker/0:1,9]hid-generic 0003:12D1:109B.0003: collection stack underflow
[pid:175,cpu0,kworker/0:1,0]hid-generic 0003:12D1:109B.0003: item 0 0 0 12 parsing failed
[pid:175,cpu0,kworker/0:1,1]hid-generic: probe of 0003:12D1:109B.0003 failed with error -22
...
When encountering such a situation, fix it with the correct report descriptor.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/hid/Kconfig      |  7 ++++
 drivers/hid/Makefile     |  1 +
 drivers/hid/hid-huawei.c | 82 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h    |  3 ++
 4 files changed, 93 insertions(+)
 create mode 100644 drivers/hid/hid-huawei.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a..2fab4964d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1435,6 +1435,13 @@ config HID_KUNIT_TEST
 
 	  If in doubt, say "N".
 
+config HID_HUAWEI
+	tristate "Huawei HID devices support"
+	depends on USB_HID
+	help
+	  Support for huawei cd30 keyboard or other hid devices
+	  that need fix-ups to work properly.
+
 endmenu
 
 source "drivers/hid/bpf/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e01838239..616ff2185 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
 obj-$(CONFIG_HID_VIEWSONIC)	+= hid-viewsonic.o
 obj-$(CONFIG_HID_VRC2)		+= hid-vrc2.o
+obj-$(CONFIG_HID_HUAWEI)	+= hid-huawei.o
 
 wacom-objs			:= wacom_wac.o wacom_sys.o
 obj-$(CONFIG_HID_WACOM)		+= wacom.o
diff --git a/drivers/hid/hid-huawei.c b/drivers/hid/hid-huawei.c
new file mode 100644
index 000000000..6a616bf21
--- /dev/null
+++ b/drivers/hid/hid-huawei.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  HID driver for some huawei "special" devices
+ *
+ * Copyright (c) 2026 Miao Li <limiao@kylinos.cn>
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+static const __u8 huawei_cd30_kbd_rdesc_fixed[] = {
+	0x05, 0x01,		/* Usage Page (Generic Desktop)		*/
+	0x09, 0x80,		/* Usage (System Control)		*/
+	0xa1, 0x01,		/* Collection (Application)		*/
+	0x85, 0x01,		/*   Report ID (1)			*/
+	0x19, 0x81,		/*   Usage Minimum (System Power Down)	*/
+	0x29, 0x83,		/*   Usage Maximum (System Wake Up)	*/
+	0x15, 0x00,		/*   Logical Minimum (0)		*/
+	0x25, 0x01,		/*   Logical Maximum (1)		*/
+	0x75, 0x01,		/*   Report Size (1 bit)		*/
+	0x95, 0x03,		/*   Report Count (3)			*/
+	0x81, 0x02,		/*   Input (Data,Var,Abs)		*/
+	0x95, 0x05,		/*   Report Count (5)			*/
+	0x81, 0x01,		/*   Input (Cnst,Ary,Abs)		*/
+	0xc0,			/* End Collection			*/
+	0x05, 0x0c,		/* Usage Page (Consumer)		*/
+	0x09, 0x01,		/* Usage (Consumer Control)		*/
+	0xa1, 0x01,		/* Collection (Application)		*/
+	0x85, 0x02,		/*   Report ID (2)			*/
+	0x19, 0x00,		/*   Usage Minimum (0)			*/
+	0x2a, 0x3c, 0x02,	/*   Usage Maximum (0x023C)		*/
+	0x15, 0x00,		/*   Logical Minimum (0)		*/
+	0x26, 0x3c, 0x02,	/*   Logical Maximum (0x023C)		*/
+	0x95, 0x01,		/*   Report Count (1)			*/
+	0x75, 0x10,		/*   Report Size (16 bits)		*/
+	0x81, 0x00,		/*   Input (Data,Ary,Abs)		*/
+	0xc0			/* End Collection			*/
+};
+
+static const __u8 *huawei_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				  unsigned int *rsize)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
+	switch (hdev->product) {
+	case USB_DEVICE_ID_HUAWEI_CD30KBD:
+		if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
+			if (*rsize != sizeof(huawei_cd30_kbd_rdesc_fixed) ||
+				memcmp(huawei_cd30_kbd_rdesc_fixed, rdesc,
+					sizeof(huawei_cd30_kbd_rdesc_fixed)) != 0) {
+				hid_info(hdev, "Replacing Huawei cd30 keyboard report descriptor.\n");
+				*rsize = sizeof(huawei_cd30_kbd_rdesc_fixed);
+				return huawei_cd30_kbd_rdesc_fixed;
+			}
+		}
+		break;
+	}
+
+	return rdesc;
+}
+
+static const struct hid_device_id huawei_devices[] = {
+	/* HUAWEI cd30 keyboard */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUAWEI, USB_DEVICE_ID_HUAWEI_CD30KBD)},
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, huawei_devices);
+
+static struct hid_driver huawei_driver = {
+	.name = "huawei",
+	.id_table = huawei_devices,
+	.report_fixup = huawei_report_fixup,
+};
+module_hid_driver(huawei_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miao Li <limiao@kylinos.cn>");
+MODULE_DESCRIPTION("HID driver for some huawei \"special\" devices");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ab7640b1..35df11561 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1581,4 +1581,7 @@
 #define USB_VENDOR_ID_JIELI_SDK_DEFAULT		0x4c4a
 #define USB_DEVICE_ID_JIELI_SDK_4155		0x4155
 
+#define USB_VENDOR_ID_HUAWEI			0x12d1
+#define USB_DEVICE_ID_HUAWEI_CD30KBD		0x109b
+
 #endif
-- 
2.25.1

