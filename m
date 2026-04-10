Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF9345CDA
	for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849117; cv=none; b=lXHXy4N7DkVlS8fNyVP4skL8GTtp6cQ0A00wtb1v6//2aRhOkV98K1dLlgerJDNeJ0/z7IkOKsxh95Vjb/2t9gktD9Q7/1zetL370WKYrtwOuXx1S9H6mS0cp4t8FaGjp9AyO9GK5IEHFYXIOOPpCJ+O4C93u89KHB020kQVqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849117; c=relaxed/simple;
	bh=HyGNKjUaw8UHRjJdnt6VyhCrwMTZ6pcFQiVCJDVCsuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njGNDZkIH6+i9Aa4zy/fhRSlnbsJ4gbCHqI/RMhE6vgO/2PwNe92Mc5dyk4M+sZMWyCoxPNM4Ky+L44/WVw0JwZS6SN/bDpnJa+IyM1flR5r8OZ6yny/7zisK+tzyiLwTP4PUeNv4KLNFQCqNzL/EQf7Rn/vMInJpWoB7v5aOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUCn68kt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUCn68kt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso25682115e9.1
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849114; x=1776453914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmYI2M5dHslYk9GTB/2ip8+v8uMXE6KQ+B9xsHJTP0o=;
        b=YUCn68kty2lsbkxERxHHaJCYWht//gcwM/7bosagoURJbtXOxMYTEwq0nXi0xEorb1
         slx1/tUlSOVOH178wFnpyeLi7lWIPi159l5rW7iNJ+eTFckSwPVOnvmZsVa/SjTNYi7n
         ge4Ra6frblJd6DaOHYHtBPgoPkAouRDCta2vyHcjhErMPnPKWF6lBpu+CFcvzhJBwYgS
         VUDJQRxC7ZhScmq44P//5T4IIzuaqDXWrNSQXcBNFbPK44tRNMrvltkMvwzh6v+3km7r
         IQBG2ueHqZ2zRSn7kWsw+NBkZfHQQ0+aIw4hlxAQ4x5cDB9PokH7X/S0pXRxrnfuKhaG
         QB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849114; x=1776453914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmYI2M5dHslYk9GTB/2ip8+v8uMXE6KQ+B9xsHJTP0o=;
        b=e7rN8Q1LOLRvJh/eWMgpLfm9+u5S7LX76+OMRXxHeaXwF6hn2XJq7XmZ9PPoqQPiVT
         StaBUIe7ium2GDirkTUAeDHxsRTTEjTpJtpDaeDOboWGT3UnyL304OMtluwsO75FeH9R
         0xAQB3ITkdmzRk0GLMN3Asj5t8qIt52cH3VyLTYIq2OGxLef6TtAO+ZunNd5Nq6rm/2z
         ttScNs4molwBmWoyqi3nlDAgNXbMjDuRAfdkKlk4IkGWbCz9fs75Orv1ACsSQtkRnf16
         2Ex2BXmmwO/THhw7xLJ8Lr9vki64+bta62SSrbqf9z1qayWYOqWZ9eYkmWWjZI+hHvt2
         x9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX8x1Ye0G6/v35vg2nftVaeYzLPgb9MLEcR3SACbjKqrYwyFmER0yimLu+0EcXUnPII2lh7QwDr/6x8KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YynUs72ZEMdmp5SKCzlgUN+sSic4jbV9y3BN27/Ku0cupqZvfXm
	qiJC79i3NAJKOL0/4PMl5XqxiCSwFI9wJYUFQgrpv/y5w6GMkhVTBUQ7hNfru73eX5I=
X-Gm-Gg: AeBDiesTawiq3GwAcv3Aj21G+bPQQztv7FJaOkyDqXHLS6bmmeaBuYkRmdN/Kzf/8Yp
	odBMBOgMW8c61ARjroFVmz8uDVcZMFcLPe9MFsZF6co9xPkkWrJYX3cBf31lSRrHUlyIBgQsyT7
	hRx4zxy9Ok6XVIC83URAkM/DO0f58DcjnSITMaciMBQIV7IjW+neINtXI7yqeGbjljEjFMgXJIx
	+ukQBtIEINp1bmvOVce5IKzD8pLFDoCgo7Mh1KLSWngfmxeWU8WuXTONHghij+3eXzq7kkOQsA2
	s5rIgla3DYMIJjGrEfZTPGCzCdapsMqf3K7jN1VuH1kg8hO631Rl8X3X8cnaD7tMidibuKtXD5I
	h5EyCU6LWJ9riC6MNut6W7HVuo815PKifjxKuxAiGpp0fqEeJe9/bE58VxNcAfhb2N2i/f2WGh5
	8WO/PDZNsKry81jQSlCtgb/IYnKSsbcDU7DNoyRpP1hX9MXh/lGw==
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr50727815e9.10.1775849113569;
        Fri, 10 Apr 2026 12:25:13 -0700 (PDT)
Received: from localhost.localdomain ([72.255.58.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5cf2e70sm50930135e9.0.2026.04.10.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:25:13 -0700 (PDT)
From: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Subject: [PATCH] HID: usbhid: replace strlcat with better alternatives
Date: Fri, 10 Apr 2026 15:24:47 -0400
Message-Id: <20260410192447.7059-1-mahad.ibrahim.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the removal of the strlcat() API as per the KSPP,
replace the string concatenation logic in hid-core, usbkbd, and
usbmouse with struct seq_buf, which tracks the current write position
and remaining space internally. The changes implemented include:

- Replace device name and phys concatenation with seq_buf_puts().
- Include Struct seq_buf and its initialization.
- Include header file of seq_buf.
- Replace strlen() with seq_buf_used() on the string buffer which was
  tracked by seq_buf to increase speed.
- Add size_t len in files which did not have it.
- Use of strscpy with length in place of strlcat.

Testing: This driver was compiled as a module as well as in-built in
QEMU with the QEMU basic mouse, and QEMU basic keyboard. The testing was
done in the following steps.
- Add Hardware Mouse in QEMU checking the usbhid module.
- Verify dmesg string name of mouse.
- Blacklist hidusb module from auto-loading, and removing the module via
  rmmod.
- Load usbmouse module, and reattach QEMU mouse.
- Verify dmesg string name of mouse.
- Repeat same procedure on usbkbd module.

This aligns the driver with KSPP security guidelines.

Link: https://github.com/KSPP/linux/issues/370

Signed-off-by: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 17 ++++++++++-------
 drivers/hid/usbhid/usbkbd.c   | 15 ++++++++++-----
 drivers/hid/usbhid/usbmouse.c | 15 ++++++++++-----
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ddd5d77fb5a5..476308378e90 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -27,6 +27,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/string.h>
+#include <linux/seq_buf.h>
 
 #include <linux/usb.h>
 
@@ -1365,6 +1366,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usbhid_device *usbhid;
 	struct hid_device *hid;
+	struct seq_buf hid_name;
 	unsigned int n, has_in = 0;
 	size_t len;
 	int ret;
@@ -1399,7 +1401,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
 	hid->product = le16_to_cpu(dev->descriptor.idProduct);
 	hid->version = le16_to_cpu(dev->descriptor.bcdDevice);
-	hid->name[0] = 0;
+	seq_buf_init(&hid_name, hid->name, sizeof(hid->name));
 	if (intf->cur_altsetting->desc.bInterfaceProtocol ==
 			USB_INTERFACE_PROTOCOL_MOUSE)
 		hid->type = HID_TYPE_USBMOUSE;
@@ -1407,22 +1409,23 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 		hid->type = HID_TYPE_USBNONE;
 
 	if (dev->manufacturer)
-		strscpy(hid->name, dev->manufacturer, sizeof(hid->name));
+		seq_buf_puts(&hid_name, dev->manufacturer);
 
 	if (dev->product) {
 		if (dev->manufacturer)
-			strlcat(hid->name, " ", sizeof(hid->name));
-		strlcat(hid->name, dev->product, sizeof(hid->name));
+			seq_buf_puts(&hid_name, " ");
+		seq_buf_puts(&hid_name, dev->product);
 	}
 
-	if (!strlen(hid->name))
+	if (!seq_buf_used(&hid_name))
 		snprintf(hid->name, sizeof(hid->name), "HID %04x:%04x",
 			 le16_to_cpu(dev->descriptor.idVendor),
 			 le16_to_cpu(dev->descriptor.idProduct));
 
 	usb_make_path(dev, hid->phys, sizeof(hid->phys));
-	strlcat(hid->phys, "/input", sizeof(hid->phys));
-	len = strlen(hid->phys);
+	len = strnlen(hid->phys, sizeof(hid->phys));
+	strscpy(hid->phys + len, "/input", sizeof(hid->phys) - len);
+	len = strnlen(hid->phys, sizeof(hid->phys));
 	if (len < sizeof(hid->phys) - 1)
 		snprintf(hid->phys + len, sizeof(hid->phys) - len,
 			 "%d", intf->altsetting[0].desc.bInterfaceNumber);
diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 6b33e6ad0846..83d4df0d7a45 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/usb/input.h>
 #include <linux/hid.h>
+#include <linux/seq_buf.h>
 
 /*
  * Version Information
@@ -266,8 +267,10 @@ static int usb_kbd_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_kbd *kbd;
 	struct input_dev *input_dev;
+	struct seq_buf kbd_name;
 	int i, pipe, maxp;
 	int error = -ENOMEM;
+	size_t len;
 
 	interface = iface->cur_altsetting;
 
@@ -292,24 +295,26 @@ static int usb_kbd_probe(struct usb_interface *iface,
 	kbd->usbdev = dev;
 	kbd->dev = input_dev;
 	spin_lock_init(&kbd->leds_lock);
+	seq_buf_init(&kbd_name, kbd->name, sizeof(kbd->name));
 
 	if (dev->manufacturer)
-		strscpy(kbd->name, dev->manufacturer, sizeof(kbd->name));
+		seq_buf_puts(&kbd_name, dev->manufacturer);
 
 	if (dev->product) {
 		if (dev->manufacturer)
-			strlcat(kbd->name, " ", sizeof(kbd->name));
-		strlcat(kbd->name, dev->product, sizeof(kbd->name));
+			seq_buf_puts(&kbd_name, " ");
+		seq_buf_puts(&kbd_name, dev->product);
 	}
 
-	if (!strlen(kbd->name))
+	if (!seq_buf_used(&kbd_name))
 		snprintf(kbd->name, sizeof(kbd->name),
 			 "USB HIDBP Keyboard %04x:%04x",
 			 le16_to_cpu(dev->descriptor.idVendor),
 			 le16_to_cpu(dev->descriptor.idProduct));
 
 	usb_make_path(dev, kbd->phys, sizeof(kbd->phys));
-	strlcat(kbd->phys, "/input0", sizeof(kbd->phys));
+	len = strnlen(kbd->phys, sizeof(kbd->phys));
+	strscpy(kbd->phys + len, "/input0", sizeof(kbd->phys) - len);
 
 	input_dev->name = kbd->name;
 	input_dev->phys = kbd->phys;
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index 7cc4f9558e5f..b3b2abeee614 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/usb/input.h>
 #include <linux/hid.h>
+#include <linux/seq_buf.h>
 
 /* for apple IDs */
 #ifdef CONFIG_USB_HID_MODULE
@@ -110,8 +111,10 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_mouse *mouse;
 	struct input_dev *input_dev;
+	struct seq_buf mouse_name;
 	int pipe, maxp;
 	int error = -ENOMEM;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 
@@ -140,24 +143,26 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 
 	mouse->usbdev = dev;
 	mouse->dev = input_dev;
+	seq_buf_init(&mouse_name, mouse->name, sizeof(mouse->name));
 
 	if (dev->manufacturer)
-		strscpy(mouse->name, dev->manufacturer, sizeof(mouse->name));
+		seq_buf_puts(&mouse_name, dev->manufacturer);
 
 	if (dev->product) {
 		if (dev->manufacturer)
-			strlcat(mouse->name, " ", sizeof(mouse->name));
-		strlcat(mouse->name, dev->product, sizeof(mouse->name));
+			seq_buf_puts(&mouse_name, " ");
+		seq_buf_puts(&mouse_name, dev->product);
 	}
 
-	if (!strlen(mouse->name))
+	if (!seq_buf_used(&mouse_name))
 		snprintf(mouse->name, sizeof(mouse->name),
 			 "USB HIDBP Mouse %04x:%04x",
 			 le16_to_cpu(dev->descriptor.idVendor),
 			 le16_to_cpu(dev->descriptor.idProduct));
 
 	usb_make_path(dev, mouse->phys, sizeof(mouse->phys));
-	strlcat(mouse->phys, "/input0", sizeof(mouse->phys));
+	len = strnlen(mouse->phys, sizeof(mouse->phys));
+	strscpy(mouse->phys + len, "/input0", sizeof(mouse->phys) - len);
 
 	input_dev->name = mouse->name;
 	input_dev->phys = mouse->phys;
-- 
2.39.5

