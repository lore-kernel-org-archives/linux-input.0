Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544864;
	b=v/eNEJf22esXMgUIYJxnMovRu8sTHB58Zy12cQYufvEpeaYis56e8rjxm+rRZo0Qccpo
	 I3Jq4xZzTNHrLvfHzWsKf2fbnW2XDeNGQMdj/f9DUWlsQEy6TAfCy+i9vztCtY69bNRiY
	 YdrxSUqOdaAdh7tt8lea3j0HtN4nxVI58UqgsidJ6P/jZrX9SUNOKEvxt+RsZI3YFa9jp
	 AciDUq9FljCxFjgKDUwzZo5L77JyZyEW9Wc0Cp9lhqH6Kca94T2KjQ4KZ53P7nVPyO/0b
	 zK42YVhyle4DmwhWyZ8tmf8rsj1k4HZnMtQBiC/12RKRomx1SQ4IoFm1cjbe1tDvBuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:From:Date:
	 Subject:To:Cc;
	bh=ZaK6Ve0FWm9HASTt/HfEkT3fAh1V8UmLHkJAB1mCpuk=;
	b=BaAO2dxFn2lCmC4OPrEs0DQib40jSrgPfjtNDP5JdRUfmSohR6kgYlFZ5U6xWlzg4kb0
	 ukPQ+opIRZejqv/6ccFcy1fzLVbNW2qb7IDnHSQommnD3iPumraIldJ/W3TfS2+bLNM5c
	 lr28+FKAwX7AbTH/nqIqCcy0wgpLbV2/grf95CwbWxoDKjfMrd8Bzekf29y9nyVx+5jO4
	 drUL5wSpRdL8hojizeAzcjm5b4bt/qMd6/aHOLehYiZhEUQqNCMhizCPnrLXGW0avHFgZ
	 JBXA/gEAVSSHq8pkpW1egxPSfgY0rReYvhgoS9t0caj9XZfuQlO4DgfYULago8WTQmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+vfbjBT;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FE606A325
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 14:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94FE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+vfbjBT
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so961036a91.3
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544863; x=1794149663; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaK6Ve0FWm9HASTt/HfEkT3fAh1V8UmLHkJAB1mCpuk=;
        b=N+vfbjBTQw5MgnedYRYVhNa5Kq0xdQxO2HsfjK3w1ua4x4WM+M5xDz2MqfCiCu6QR1
         YH7aUeFvat4JZvzOBc4Va3KnyI9nCd3Kfe6pI1BefjcwRb0S64nmziabJgUK2qjv2386
         5Z8DNLciXwapkHQM5/hCI8PlVg3QRL9TO1IkzMOg+v2Mlq4lgaaOc02OOU8ZxwJJSSka
         H0ood/WPPoKv3eOpXqjmLiz4u03UuJCwdbkacnzJNa/avdo9DBlk5mUTIOvbA7rufuTa
         Nxm2suGyMCzd8TbeY7MAwciVwBSto5V/Cg4xHRKeSs7k/8SqqWJWs8n2f/faOi1vJKNi
         A6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544863; x=1794149663;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaK6Ve0FWm9HASTt/HfEkT3fAh1V8UmLHkJAB1mCpuk=;
        b=aWKjCpMi4pdaVOfn+3S7Vfy5nxov+TJtmpY1u/QB3kWKD0nH/Lsp2lE5C0Eg0hBG16
         hp3cI1Q8nYlXzQRwnO/WX6tepU4vD3AEAEN+SIHcw/5ZZDnEftDrp5p9t6KnKh1L+hs0
         2mwDLLQKEJtHUAM6udZEETb9Zv2/eADZaHLwJdag//rgjjU8ZOCwiLn+hVHrVbhydNAe
         n1PP0v/EFHll+NWBrEOlbsquj6iZlPODhPXAiVBArV/ULevdbaCsYyhrFvHC4ghZltpG
         0JJ7UHujZuzqivmCBV8O4XBFqp03MSsfNQmGcrD78H031m7d09HpCd+W+stNFBKISYNE
         R1qg==
X-Gm-Message-State: APuU4Z/FgZr9sJZ4lWZommsRm/NrA03TGveEd8FpekfB9AUFW7T4ok6u
	oW+zSxjaNKV7XhkCR+D5QwQ4A0c5+ocJE2WWOSL5+nQb4s4Uedu4LrBwTZefHH92
X-Gm-Gg: AYBFou3cEkP+Vn0bIDr1OR9pWIMn3CKk+NZEp8rmZ5Kq1hCXX9XtNWl6TaIDEhaG2fd
	JrUg9HMWmnUqtDyU5WWa8qPjWdeMJHjc98Ls0E+JWxrTm6dWZjYBSJbZCx/vrS+CqvvBr39AW+Q
	gdZ7R2TZ0AGMAVpBfE/mTlzNq4nehdNgxYsueU75MQhHQeD2RCVIYzLZYy6UHsdofG7QqGMn4nl
	1gwnxeCn+2DxPS2JWXE9BtNUb1wHmtjSDF1yVumZrIb5xtBDx02cZHJkICcz3VzMVJBeXr3NkqJ
	xZbnVPJjVz9qOHXP9M7Z4OFFG5HJuAKyWbpdBzCtzfYsMC++Mp41J9b3xC71C3UtiyAhhOg2uu+
	LxV3RdRg6Ow3pzOvAN2L+ks9nNLyJGzLQkkr6BcAmXk3BP2gNmFPPXNkfl2FKOR8gwQ0Bl9u00G
	15MY9CmEQ2SLYfwhSbhiB+YvPvh58WF5zz+76Tl83pDh3EThzIyrGZLvqwDIBp2gGli0nHJ7lwl
	GmbOQaLfkpsJIHJhNfVhMM6IUi2jmzjR2cj/B9MDyBhC/D+mM3PRj9Zzud7sibO+Z1P9KdfqdB8
	HIq74nWN6d+gCuSUkS7y1utv9nXMaKNXB+GtolR3Irim+fJ3
X-Received: by 2002:a17:90b:3e89:b0:3a7:9045:fe29 with SMTP id 98e67ed59e1d1-3ae895362e9mr6437089a91.4.1793544862155;
        Sun, 01 Nov 2026 06:54:22 -0800 (PST)
Received: from [127.0.1.1] ([240e:b8f:977f:f400:ec2a:b15e:fef8:70a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm9981301a91.11.2026.11.01.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:54:21 -0800 (PST)
Message-ID: <6ae7529d.10abdf86.7545b.3e9a@mx.google.com>
From: Liang Haowen <nbg2974@gmail.com>
Date: Sun, 1 Nov 2026 22:30:00 +0800
Subject: [PATCH] HID: add driver for EWEADN G5 mice
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

EWEADN G5 mice (YJX-CHIP receivers 0xa8a5:2255, replacement units
and the wired mouse 0xa8a4:2255) send motion and buttons in a
9-byte vendor report on interface 0. The report descriptor the
firmware ships does not describe that data: the 0xa8a5 receivers
declare vendor usages with no mouse mapping, and the 0xa8a4 units
declare a standard mouse report the firmware then does not send.
Either way the stock input path produces no pointer events, and
there is no Linux driver from the vendor.

The report itself is a plain mouse report: buttons, int16 dx and
dy, an int8 wheel. Replace the descriptor at parse time with one
that describes exactly that report, so hid-core can parse the
frames with no custom event handling. Interface 1 (keyboard) and
interface 2 (vendor configuration) keep hid-generic.

Both device IDs bind with the fixed-up descriptor, and motion
events flow through the stock input path. This also makes the
userspace relay used until now (github.com/NB-Group/g5moused)
unnecessary.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Liang Haowen <nbg2974@gmail.com>
---
 drivers/hid/Kconfig      |   9 +++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-eweadn.c | 120 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/hid/hid-eweadn.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc0..3946f75 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -380,6 +380,15 @@ config HID_EVISION
 	applying customization using userspace programs.
 	Support for some EVision devices requiring report descriptor fixups.
 
+config HID_EWEADN
+	tristate "EWEADN G5 mice support"
+	depends on USB_HID
+	help
+	Support for EWEADN G5 wireless mice (YJX-CHIP 0xa8a5:2255 receivers,
+	0xa8a4 replacement units and the wired mouse). The stock report
+	descriptor does not describe the reports the firmware sends, so
+	the pointer is dead without this fixup.
+
 config HID_EZKEY
 	tristate "Ezkey BTC 8193 keyboard"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 43a8eb0..2db5b5d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_HID_ELAN)		+= hid-elan.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_ELO)		+= hid-elo.o
 obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
+obj-$(CONFIG_HID_EWEADN)	+= hid-eweadn.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
diff --git a/drivers/hid/hid-eweadn.c b/drivers/hid/hid-eweadn.c
new file mode 100644
index 0000000..6aacfc5
--- /dev/null
+++ b/drivers/hid/hid-eweadn.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HID driver for EWEADN G5 mice (YJX-CHIP a8a5:2255 / a8a4:2255).
+ *
+ * The mouse reports motion and buttons in a vendor-defined report
+ * (id 0x02) on interface 0. The report descriptor the firmware
+ * ships does not describe that data: the original 0xa8a5 receivers
+ * declare vendor usages with no mouse mapping, and the 0xa8a4 units
+ * declare a standard mouse report that the firmware then does not
+ * send. Either way the stock input path produces no pointer events.
+ * The report itself is a plain mouse report:
+ *
+ *   [1] buttons, 5 bits
+ *   [2] unused
+ *   [3] dx, int16 LE
+ *   [5] dy, int16 LE
+ *   [7] wheel, int8
+ *   [8] unused
+ *
+ * The descriptor below describes exactly that report, so hid-core
+ * can parse the frames without any custom event handling.
+ * Interface 1 (keyboard) and interface 2 (vendor configuration) are
+ * left to hid-generic.
+ *
+ * 0xa8a5 is the original receiver, 0xa8a4 the replacement units
+ * first seen in October 2026 and the mouse itself on its USB cable.
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+static __u8 eweadn_rdesc[] = {
+	0x05, 0x01,		/* Usage Page (Generic Desktop) */
+	0x09, 0x02,		/* Usage (Mouse) */
+	0xA1, 0x01,		/* Collection (Application) */
+	0x85, 0x02,		/*   Report ID (2) */
+	0x09, 0x01,		/*   Usage (Pointer) */
+	0xA1, 0x00,		/*   Collection (Physical) */
+	0x05, 0x09,		/*     Usage Page (Button) */
+	0x19, 0x01,		/*     Usage Minimum (1) */
+	0x29, 0x05,		/*     Usage Maximum (5) */
+	0x15, 0x00,		/*     Logical Minimum (0) */
+	0x25, 0x01,		/*     Logical Maximum (1) */
+	0x75, 0x01,		/*     Report Size (1) */
+	0x95, 0x05,		/*     Report Count (5) */
+	0x81, 0x02,		/*     Input (Data,Var,Abs) */
+	0x95, 0x0B,		/*     Report Count (11), padding to byte */
+	0x81, 0x03,		/*     Input (Cnst,Var,Abs) */
+	0x05, 0x01,		/*     Usage Page (Generic Desktop) */
+	0x09, 0x30,		/*     Usage (X) */
+	0x09, 0x31,		/*     Usage (Y) */
+	0x16, 0x00, 0x80,	/*     Logical Minimum (-32768) */
+	0x26, 0xFF, 0x7F,	/*     Logical Maximum (32767) */
+	0x75, 0x10,		/*     Report Size (16) */
+	0x95, 0x02,		/*     Report Count (2) */
+	0x81, 0x06,		/*     Input (Data,Var,Rel) */
+	0x09, 0x38,		/*     Usage (Wheel) */
+	0x15, 0x81,		/*     Logical Minimum (-127) */
+	0x25, 0x7F,		/*     Logical Maximum (127) */
+	0x75, 0x08,		/*     Report Size (8) */
+	0x95, 0x01,		/*     Report Count (1) */
+	0x81, 0x06,		/*     Input (Data,Var,Rel) */
+	0x95, 0x01,		/*     Report Count (1), trailing pad */
+	0x81, 0x03,		/*     Input (Cnst,Var,Abs) */
+	0xC0,			/*   End Collection */
+	0xC0,			/* End Collection */
+};
+
+static const __u8 *eweadn_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				       unsigned int *rsize)
+{
+	hid_info(hdev, "fixing up EWEADN G5 mouse report descriptor\n");
+	*rsize = sizeof(eweadn_rdesc);
+	return eweadn_rdesc;
+}
+
+static int eweadn_probe(struct hid_device *hdev,
+			const struct hid_device_id *id)
+{
+	struct usb_interface *intf;
+	int ret;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
+		return -ENODEV;	/* keyboard and config stay on hid-generic */
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id eweadn_devices[] = {
+	{ HID_USB_DEVICE(0xa8a5, 0x2255) },		/* original receiver */
+	{ HID_USB_DEVICE(0xa8a4, 0x2255) },		/* replacement unit, wired mouse */
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, eweadn_devices);
+
+static struct hid_driver eweadn_driver = {
+	.name = "eweadn",
+	.id_table = eweadn_devices,
+	.report_fixup = eweadn_report_fixup,
+	.probe = eweadn_probe,
+};
+module_hid_driver(eweadn_driver);
+
+MODULE_AUTHOR("Liang Haowen <nbg2974@gmail.com>");
+MODULE_DESCRIPTION("HID driver for EWEADN G5 mice");
+MODULE_LICENSE("GPL");
-- 
2.55.0


