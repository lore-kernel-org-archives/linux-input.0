Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546733;
	b=wNdY4AfL98Mfn4Bd2JifdVNLuiEUCrUJ/5CIllMHCcCRUMatEfWuTpDnwoJRjk6PJJuq
	 mVi4tVmiM8f4CGTahPkYeLIpaRvJYDrRXLTwliBTEX6KXac4NdimfIX4n9IN4ZijyemE+
	 fe3YgX43Xl0QQYdHkGqLs977l37hgw3XItlqEyS5/7kaArKip9KhmMtXxPerj3REiFe8y
	 7KeDKpR/b9gn5KPkh3EmX8G351FVwE/djm3lZcvMwOD5FVSf+jnvXfo6fryVZ+MSRB72A
	 gsVwF1GupCxEZZd0VMG0FKqpTxt4yv2dU8aWijOkGMncShHXbjaxooQJD8t09qBMGPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:From:Date:
	 Subject:To:Cc;
	bh=0v0stUZN3ZL7HM38zY+SltnrcUBbWB8aAKMU/nF0ov4=;
	b=puTDspfLmPAWB/GZdZXcvf4ZPZyreuZoNs9YgCE/hYBxpOcz9kSE7PDwSmo5kZgyVnAp
	 ONYeYXTVEuHTgmiErAPsyXw8Of5Q4Hi7zkFZfU+UouWExY9LH+Ue0l/YR787uibU7Tazu
	 srN4D5uSFYkujcBN8okPzmUFXnJETTMO/zNRuyM8RiqS5NzhQ8zmAW3e87ii80/MUKTWr
	 jUW6Fr2e/AfmY620xOnL5ioOruVsAPXmGdokOshzncpZRxIL8IkvHR9l3JNa96WryYGJD
	 KYfGPRsEo7QTPbJSNuxzX9WFuR2nScWLhpMJCwJcCnlvWqA9NMQ0vRk+yFIWFgamk2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sH+DtX0O;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF9606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59DF9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sH+DtX0O
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea7190aea1so10412715ad.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546733; x=1794151533; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0v0stUZN3ZL7HM38zY+SltnrcUBbWB8aAKMU/nF0ov4=;
        b=sH+DtX0OE3nlIYCD00DrlytcGgeOGYJ/X9cV8BTx6iWMwuS/BHAbBgTN2VWtP6JnUA
         EYuy3XN9bxRy5VpHPDakfzR1DfsVj5DVCVtsPx3clvBjQ+6+HSzwtz0pMObcrTEUrJQL
         SzY4Hp2xY+fCPYwExhlRnF2DsUZmJ22RUUWJbL9Noi4V31b0AWLXvvVtGrPKbU2h+yrB
         ex/DYSDU36rh2oqJ85pDVYeq1L9nhHMPcHiuBew4pFuNpX4Ywb2yc80qAAL1knZVRCxj
         19/GI5XLguI1tlMu4pMyuRHpwQqkyic5HL4y8BO+hjEwhS0rdD06SJ9HxYIRj2n9vV9T
         ssUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546733; x=1794151533;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0v0stUZN3ZL7HM38zY+SltnrcUBbWB8aAKMU/nF0ov4=;
        b=kKPcPiNREDEsLBMk3ZeDdrGKddbrrMm5ptFdbD4k4pqxOsjjQC9ZbGVx1jQKUdlyeg
         aLRVLZAnsZ4VlDZD7TEdeTcyGpjZGdwFuDuo5TkQaz6CDoKi9ZocjXx1UgLigblrzuvc
         oGI5ynMkUa7zbes9g+t7LI0kWzwXFNafju2RgUoWdg9DYJEFECbaiDh8tbWNe6ccfY3i
         FYtUnhYCSgGOpBvVW8unNjRUhOAZhWOM1mFt85LDTdNy08xVHso/7WajaS7OoZaFE9jT
         zeEltWdaZDc7VCIsUEqD3Gv5SR+BueQx0OsAD0WueMLlbx9/TprW73OlsVDXD5yqo9f7
         j0Tg==
X-Gm-Message-State: APuU4Z/DAkG5ld6nsjbNivZ46iebB0W0pdhnIAEsVtvkl+WC1TDFU+LC
	CUdsOJ9HgufwRVqi9ojK9Dc2DTVewex+IEM4m92Ut88SsNOHacLPpsd351TGR69D
X-Gm-Gg: AYBFou2QAHHsDvh8X+s0KMXoXrB6jkroJ6E77nZIdtIHD0/VO8Kj+20yfsdCLCEsGS9
	dkDhcSVy9MMQukVEfCC/4CPfOF/aJv+Q5TJZCpIcQfFcY+fbgNu/0UtncbkWbein8ECcokj7MkC
	muwCeElnVLDmqmlQGfWkJ6abRX2x0iE60FPUb7cXbdNV+kiUFZ/QXkXzYZHoT5v/0JWdQ0ZcyzG
	XQm0wx3fgEs12HZbJ4RAo/jsk6Gvz2OdB5NjEH9jVDbGzM5QO5pNPZD/qdhBATo/vUBIUlo20Ag
	KWZHG99v2AehmLMKG5jNluiTyDkH2jj+bWkRpkern4CCyV7DZ61PZySifYfByqSru6I7dJHPMAq
	4cP8ee4cjBeZnWUfKFSQGvxkKAxapFde0+Vq7sYyXODJX0s8Fw19bgLhDFpMZwQS8e/vhL5mRwm
	gt38RF2O5o1FoiY47JnC2NfLtWO48hSBjOBTnH8OupbShaOHmf5Vbk+w44mTL6tX7xQAmUsjKon
	ps+8NbhJi+TKliwZq3LMT7Rwli+YctjUOfRGhYhKmMnLClnXNO1KWZC06xI6Oev2ZITEvHHG11G
	/OFfQ1l6oQ6J1jGrw65IFo5C1Lw=
X-Received: by 2002:a17:903:2442:b0:2e2:c90f:968c with SMTP id d9443c01a7336-2eb3646a99fmr67950175ad.44.1793546732104;
        Sun, 01 Nov 2026 07:25:32 -0800 (PST)
Received: from [127.0.1.1] ([240e:b8f:977f:f400:ec2a:b15e:fef8:70a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm18747375ad.40.2026.11.01.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:25:29 -0800 (PST)
Message-ID: <6ae759e9.4b0417f2.1062f7.b196@mx.google.com>
From: Liang Haowen <nbg2974@gmail.com>
Date: Sun, 1 Nov 2026 23:40:00 +0800
Subject: [PATCH v2] HID: add driver for EWEADN G5 mice
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
 drivers/hid/Kconfig      |   9 +++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-eweadn.c | 129 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
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
index 0000000..79a9a15
--- /dev/null
+++ b/drivers/hid/hid-eweadn.c
@@ -0,0 +1,129 @@
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
+static int eweadn_probe(struct hid_device *hdev,
+			const struct hid_device_id *id)
+{
+	int ret;
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
+	.probe = eweadn_probe,
+};
+module_hid_driver(eweadn_driver);
+
+MODULE_AUTHOR("Liang Haowen <nbg2974@gmail.com>");
+MODULE_DESCRIPTION("HID driver for EWEADN G5 mice");
+MODULE_LICENSE("GPL");
-- 
2.55.0


