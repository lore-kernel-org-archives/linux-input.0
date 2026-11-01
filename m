Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793549804;
	b=Jeew4Vh2Co5COnGEu+752rrZ8NSHFha1uiK7sjGrOIDfPJgIQqCGheEgybnpMXx2RTW3
	 EdqBRQAEjfM35iEDut6Xxz4/1N4w7MIXqur3ZRDjYICTEeNw2yV5NwhrpAHudpRaD3jIV
	 CEPcCsglTdrO45DlH+sJh4jSwvzsPjd791sQ/tP/wMJmo1ZDElqxIZvlMqpzQyW09ShSF
	 y2HX8krRe10T0cQc2rXAMZY8n1Qh9VvVjObz63N2h3rb3oUiZPhbrypi8UompQF3L0FWZ
	 lUUA8bWMjCmiL4fDVbk9lArA5RkiueFqOGMy+tZgAS5zuW42n2w9BEyFMVEnaBMxsgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793549804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:From:Date:
	 Subject:To:Cc;
	bh=6THh7F6nBjzSz+Rxrs3fif4OsCA3u70Fp8Ebrrr1YAU=;
	b=vXmWRhZgXBlnJtNTWQfcygjsaUZpSw1pMwJx2AQTANdPdCRGg2ahW0a07eaVGuxxFO1s
	 Q/Nu1fokhdoXNziov4NhrdBcJ7rDo/JiQ57jkn6gSPZkG2aM9w36rTTb/d6neuaksPI58
	 rbGx/YnGXff5I+SSwLnzaGcU7updaqDrZPOO88XVuXSieZIcdMftuEZn29bGZhLWX5090
	 yL6jngGeSJtvPK1t0dIPYjjiP1bJ+500H2K4Pwjl4PTqYYtrLh41FmQITPa/IciZ7fYl1
	 In7HFTUPXMuDV7NRMU8qDgPHAIWkaVQJAlhTUY84Gi1EOotTK8UumLhaQM0XNCHjPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="d/DzgEdQ";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2067606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 16:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2067606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/DzgEdQ
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea138a3497so13092655ad.2
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793549803; x=1794154603; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6THh7F6nBjzSz+Rxrs3fif4OsCA3u70Fp8Ebrrr1YAU=;
        b=d/DzgEdQnYHW12btRMZSdtruP97Dodu64CW4cxiDFTi323eS0X1d6eRrr1dBU0z3Uz
         TYG8j7PLnft4q9VpXa0JfUDM8cCUyViM5qV9pLlA5ky5RttpW3R+yL+xzgARfkYwlwmV
         saThSnSwOMkeLkoXhMCPKB/IK6Y8IbcUGJTHs66jPegu0hLyU4cnSWdH5vb4CxfutcWx
         A/O4r3o31QcenM6TwF29N6B8qm0sx1itAjxKfm/zp7hawFsqHJj2KKbEycJYaVDQ7Q/H
         WTJUNuCNjAxRhqDXh0oP0y0uVOVmfpMHcLlp4NcYnYD3jFI79UoRa29iws695ecwnIGG
         dJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793549803; x=1794154603;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6THh7F6nBjzSz+Rxrs3fif4OsCA3u70Fp8Ebrrr1YAU=;
        b=0/ogF5r3pExy6VyIDEEdSHaQoryLBZOkgjSHagC+Ol2oNOEY8vtc2hqjrgPbkiyeLO
         kPVr+LQt3vqbt8i1GyQs+PqvM17axz9j4kXCgdfPVnqjlIAMzQGNcl4o1H4aCj9FRWmr
         +sq2ZH356lUW8IkOFDW/dxFbSFkzl8lrsJQ5yIWVJ6fqTRLN+1YTYg4892ee8WT05voD
         9eEOVj2pfTk2kpsdiWFWUWFQGRmVUP+HdEDYm5z15BAGitoS6iabjU/VLPxyAzrFSraD
         1piEN6dDtGId5S6oX6JZKcdOwEokxna7tYUhu7WT/H6h9dl3U12T+z6vfmLA6IB6ikjt
         p9IQ==
X-Gm-Message-State: APuU4Z+eAV93ZjuP1PRlM+NE8H0vT1O3HtyFf74p+OzP1YXBajYWuTDo
	+wVo94YFMpeNUcTV8srBym73hxucIQi4tjYD2rWcDW/t/QcfRFVVs0rFucVirbn2
X-Gm-Gg: AYBFou1LqsdNJBv8f5SAcP8JBhxYYt79yqkKddoj0BapebH6RCl9nBQn9LZ1usuYjUv
	m1BCWLSgEjdoNi/x+2nGprvqbyrUdlu7A6szpwEAOJvHyt/LEeFvFQPc50VqFVMSrPOtoFaNi1n
	Fq2V8BXRiS3Cbz+vd3ZUYU48smrlTXEkWMtZrSOLTzNUG8hoJXIalLGGIFR0ysBdhL/J3dBkZ13
	MjsSXM49q74oacJl2cukozDav4Uobif7PLKXl/E6+7Grfk5ix6ULdhv32q0jwTEvGY4BC1QKn0d
	2gB8ooPvgipHpJb9udtUo+xbcAWwLhxkbrjIaaHhI8RMG3HfC6jLfSxH9G+3R8PQttmWzJcawgj
	1mv2EUXhQ2Fk+mUkp12bFaVVw1Kx7u+mMcJj1Rhhcs3jrzS/8RaulKhr+vA6VqYpmghmXBfnitK
	sU2EUY6qhpI5B5NK+lKxuEivvVrI6WWKyd3TQ8yZAv8YU8z/wvUlBS33wUivNrEyIyE3IJjSJwz
	NAR04uLUQpasRTkoARTYkDHqDGi05pG9Ne5XhuBNEtZ1ztnM5oqQftNxRjAsIufyLiAHQ7fRrKy
	PaXudxb2y+5QzesuHlVtZKOCuAc=
X-Received: by 2002:a17:903:2ecc:b0:2e9:9c65:1aff with SMTP id d9443c01a7336-2eb364d70e3mr82709215ad.45.1793549802662;
        Sun, 01 Nov 2026 08:16:42 -0800 (PST)
Received: from [127.0.1.1] ([240e:b8f:977f:f400:ec2a:b15e:fef8:70a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39278e13sm18776455ad.45.2026.11.01.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:16:40 -0800 (PST)
Message-ID: <6ae765e8.ab241434.2b11c5.b8fd@mx.google.com>
From: Liang Haowen <nbg2974@gmail.com>
Date: Mon, 2 Nov 2026 00:20:00 +0800
Subject: [PATCH v3] HID: add driver for EWEADN G5 mice
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
frames with no custom event handling. The keyboard and
vendor-configuration interfaces bind to this driver too and keep
their own descriptors untouched.

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
Changes in v3, from the review of v2:

- Include "hid-ids.h": the id_table uses USB_VENDOR_ID_YJXCHIP and
  USB_DEVICE_ID_YJXCHIP_MOUSE, and nothing else pulls that header
  in, so the driver does not build without it.

- Drop the custom probe callback: it duplicated what the HID bus
  default already does for drivers without a probe, like the other
  fixup-only drivers.

Changes in v2, from the review of v1:

- Bind all interfaces of the composite device instead of returning
  -ENODEV for the non-mouse ones: hid-generic steps aside for any
  registered driver whose id_table matches, so rejecting them left
  the keyboard and vendor-configuration interfaces with no driver
  at all. Only the mouse interface gets the fixed-up descriptor
  now; the others keep their own.

- Guard the USB interface lookup with hid_is_usb(): a virtual HID
  device created through /dev/uhid can claim BUS_USB with matching
  vendor and product IDs, and casting its parent would dereference
  memory that is not a usb_interface.

- Use the USB_VENDOR_ID_YJXCHIP macro for the original receiver.
---
 drivers/hid/Kconfig      |   9 ++++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-eweadn.c | 109 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
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
index 0000000..00ae860
--- /dev/null
+++ b/drivers/hid/hid-eweadn.c
@@ -0,0 +1,109 @@
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
+ * can parse the frames without any custom event handling. The
+ * keyboard and vendor-configuration interfaces bind to this driver
+ * too and keep their own descriptors untouched.
+ *
+ * 0xa8a5 is the original receiver, 0xa8a4 the replacement units
+ * first seen in October 2026 and the mouse itself on its USB cable.
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "hid-ids.h"
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
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return rdesc;
+
+	/*
+	 * Only the mouse interface carries the vendor report; the
+	 * keyboard and vendor-configuration interfaces keep their
+	 * own descriptors.
+	 */
+	intf = to_usb_interface(hdev->dev.parent);
+	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
+		return rdesc;
+
+	hid_info(hdev, "fixing up EWEADN G5 mouse report descriptor\n");
+	*rsize = sizeof(eweadn_rdesc);
+	return eweadn_rdesc;
+}
+
+static const struct hid_device_id eweadn_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE) },
+	{ HID_USB_DEVICE(0xa8a4, 0x2255) },	/* replacement unit, wired mouse */
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, eweadn_devices);
+
+static struct hid_driver eweadn_driver = {
+	.name = "eweadn",
+	.id_table = eweadn_devices,
+	.report_fixup = eweadn_report_fixup,
+};
+module_hid_driver(eweadn_driver);
+
+MODULE_AUTHOR("Liang Haowen <nbg2974@gmail.com>");
+MODULE_DESCRIPTION("HID driver for EWEADN G5 mice");
+MODULE_LICENSE("GPL");
-- 
2.55.0


