Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840E1ACEDE;
	Tue,  2 Jun 2026 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364946; cv=none; b=RTuzqvqukidT6OmE8mLF/jAWFs2wWez3ZsbAg3z3w1dHZGuDpzIYzJckGAZdrQJ9XoDDWrP+/HHHanvwNI9S+ewDjHbFhs9l8qFalU24wthIfo3gYjxyffSyuIlYTD/R7sxCdMIms0/hv1tsXybH24g+pjWOoPCm/ae69mFWoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364946; c=relaxed/simple;
	bh=wnF1heJbBlLvdq8C/beCoH5VXz4FdA5bf60F9F86fQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JS4HSgeyxbtVPgIYJHLC4W3D9aRjcQ1N15vezyXh7653Q4Vr7LDJqmIusf0UeZ68GkQJYrZfQ50uf2+qZo8lD39l88yWayFHjQH07lciPfwgCjxsDXEWQOiAiMpAN2V2fNIsu6A5bMyyq5E6QmjZjalUp9bomZNQ5FDXqmU8kzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MnkDr39R; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MnkDr39R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780364924;
	bh=UN5zPWn0uN8JzzeI98EPSs6ubSqSctrsvd+UUhNckNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MnkDr39ReOtHwC2bKKsB6iwz+ydzOVutqbOo7PkybX+LHcMVgLseeDSaP4et+DhRR
	 RK9jTGbQP7BlZ7RgHLXxi11O0Mqg7gODOPHJIRSQhEiTW5yTlq8ypn9LJIV2iLRZ7E
	 1Natz7z5DhYniI47+rg7mxDcSCFjLnRShlWgNw/E=
X-QQ-mid: zesmtpsz8t1780364919t4b32c3ad
X-QQ-Originating-IP: C64eDZ0OMW20Ijn4wwlOxhb/MqZNcGhz8ym3NIWOPlk=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Jun 2026 09:48:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5798188003343830360
EX-QQ-RecipientCnt: 6
From: Xu Rao <raoxu@uniontech.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] HID: usbhid: switch HIDBP devices to boot protocol
Date: Tue,  2 Jun 2026 09:48:35 +0800
Message-ID: <A49C63267F00CDA8+20260602014835.2624940-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OM4amKHspT9JghnZQwG+eJMejArdHjTT7D4UeU+KTukwNU3d2Qo+Odu/
	mNCWEczk/It5l1dUfckBX1Zcwt3FRk/WTD5h9s77ktVaht+XSRPXD+56xajfnXUHXul5Tsq
	Z+S9C7RjqfzCUddQP5zu0hD83tvMU5dlGHKYw9nGPjoGbiAdZ27Ki3Xh15OKb0shsMX6yPn
	1Y5ZYHLSrXI5KoMjlLSicXwYkcZ9jV7oUZWuK49yEedySQTRkgHH1xlfaqGP78uIqCboldL
	JZ5nNRZ2DaEHQCbajeymcbR6kHrGxIqMC8RnbyeCjGMFV1MgjnMT23b5KEi5fx7zjONVAzf
	lsSEA49A5Z60hHCK50iVjn99A6k4r3BstMGu69yNaoXPfuwAHPs8Tn5ux0CPR1KYvO5MgpK
	SC33znmh1c/uGnwlN9DtScHVQw1dPcKKNim11Mjq84rFwoY9dzmHf2HAxGHUv3O2oEiGg4l
	90/YUkL69vTBFMgzfekQKSLLn3Zyo1ydDlWkVDFKgwIoOGcmI1ZMaG4cSDh7MPWr9/b3PtU
	7it+rQj7UWNkMjvyb5YHSJ4TBI4nPZFi26Bqx3QrvXRV4Ti9MY7QA/IB9Fj7800u3W4vFHG
	v1qOW/+rtwMVIzZUWh2lMLsstTtFylAzYNsPCzHvNd81Z62esQmgJroGNy23dm1IgUkshnI
	GhT9YCh5kB6+fxAnxEAaQdvqmhsvb5p2r/oupIjCL1SFeiGXDw0eg6x2oY6bhmw4AH/prdC
	RONHbcBXPp1F0AKwV/datqb7XQfTjHGennfaM/YQebbLUKjhrkNQgKWYRCFBXYqrrREwr8n
	DhkzUamwO6IpnETbjt66rYTxwmSuDHMw3hxlcPDw/QRXJ/TEQpzjIGhF+MNpyrhX1EV+/ag
	nS02iEwu8cxtpiYwlNjiiGrCod9uagKxyanG1nRTqbCEKr38vKA+rE+oGKd2Ygc2KV9N73r
	mqur7j+bcXgjgo4pCSIgrNSvwdqkjdW+FrpwtcZynQG0uyo48Jb6XohSf
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

usbkbd and usbmouse are HID Boot Protocol drivers. They do not
parse report descriptors before decoding interrupt reports; instead,
they interpret input data as the fixed boot keyboard and boot mouse
formats.

The HID specification defines SET_PROTOCOL as the class request
to select report or boot protocol. Boot subclass devices may power
up or return from reset in report protocol, and hosts are expected
to select the protocol they intend to use.

Do not depend on firmware or a previous driver to leave the
interface in boot protocol. Send SET_PROTOCOL(BOOT) during probe
before the interrupt URB can be opened.

Keep failures non-fatal. Some devices may reject the request while
still sending boot-compatible reports. For those devices, the
existing driver behavior is preferable.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/hid/usbhid/usbkbd.c   | 22 ++++++++++++++++++++++
 drivers/hid/usbhid/usbmouse.c | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 6b33e6ad0846..f3b83f0396c8 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -233,6 +233,26 @@ static void usb_kbd_close(struct input_dev *dev)
 	usb_kill_urb(kbd->irq);
 }

+static void usb_kbd_set_boot_protocol(struct usb_device *dev,
+				      struct usb_interface *iface)
+{
+	struct usb_host_interface *interface = iface->cur_altsetting;
+	int error;
+
+	/*
+	 * usbkbd does not parse report descriptors. Make the device produce
+	 * the fixed boot report format that the driver decodes.
+	 */
+	error = usb_control_msg_send(dev, 0, HID_REQ_SET_PROTOCOL,
+				     USB_DIR_OUT | USB_TYPE_CLASS |
+				     USB_RECIP_INTERFACE, HID_BOOT_PROTOCOL,
+				     interface->desc.bInterfaceNumber, NULL, 0,
+				     USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (error < 0)
+		dev_dbg(&iface->dev, "failed to set boot protocol: %d\n",
+			error);
+}
+
 static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
 {
 	if (!(kbd->irq = usb_alloc_urb(0, GFP_KERNEL)))
@@ -289,6 +309,8 @@ static int usb_kbd_probe(struct usb_interface *iface,
 	if (usb_kbd_alloc_mem(dev, kbd))
 		goto fail2;

+	usb_kbd_set_boot_protocol(dev, iface);
+
 	kbd->usbdev = dev;
 	kbd->dev = input_dev;
 	spin_lock_init(&kbd->leds_lock);
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index 7cc4f9558e5f..c1b9d95f957e 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -103,6 +103,26 @@ static void usb_mouse_close(struct input_dev *dev)
 	usb_kill_urb(mouse->irq);
 }

+static void usb_mouse_set_boot_protocol(struct usb_device *dev,
+					struct usb_interface *intf)
+{
+	struct usb_host_interface *interface = intf->cur_altsetting;
+	int error;
+
+	/*
+	 * usbmouse does not parse report descriptors. Make the device produce
+	 * the fixed boot report format that the driver decodes.
+	 */
+	error = usb_control_msg_send(dev, 0, HID_REQ_SET_PROTOCOL,
+				     USB_DIR_OUT | USB_TYPE_CLASS |
+				     USB_RECIP_INTERFACE, HID_BOOT_PROTOCOL,
+				     interface->desc.bInterfaceNumber, NULL, 0,
+				     USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (error < 0)
+		dev_dbg(&intf->dev, "failed to set boot protocol: %d\n",
+			error);
+}
+
 static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -138,6 +158,8 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 	if (!mouse->irq)
 		goto fail2;

+	usb_mouse_set_boot_protocol(dev, intf);
+
 	mouse->usbdev = dev;
 	mouse->dev = input_dev;

--
2.50.1

