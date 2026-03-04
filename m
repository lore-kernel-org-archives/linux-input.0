Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF117A31C
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586300; cv=none; b=QMYxf1sE/z65zIL4Lt2hn3iwfbJKMGYnmxb2CP054fK6ciNX1CzfvTbmScjPLgvaDWSxfHHSYnb45sbAegdnA9+tL459lBnSGQZQBlIDIAZFGMkm1Md+dsNKNSmeP1dN6XctDes+USTxULiRnWAoHcgh8PzWjSDG+lbSDhorar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586300; c=relaxed/simple;
	bh=gaRuJO7wzObKSeJFzbCH5S8fe6XSRkoKw4n5enqMhmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqFZq1zrpO2asF7Ho6AT2ECOfUD7Ml/bn8CeFBX0Vm2aWp1Kl4ISiCU9QiUkygcuw8RzMoU+NSHm1giXpj9NEY3tfXYJvRgTSopIn/bLE0L9vh6vaY2Bh5lTxeFOfDIDIWkG2KpGGAMbS4OUb1aZK0uvtN+QNaSn5yJJJtKiJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVUJva0f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVUJva0f"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3597fea200dso2400780a91.3
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 17:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772586298; x=1773191098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAPoSa4AQv8RODkGu3q6FPMnaa+Z1UifihLeOdR33/Y=;
        b=NVUJva0f8UMP/xQwtPG7FerwW7qGC0rAo4krpzw6uYQd6s5FwdGHN78ZHwJJcwInwz
         fcdg6CiLSC+pBcTeJp/YwNo0IrS1cOggWLb9+FFUIElQfH7cUIeEsjhEXV6ml04FmQxF
         BubkGIn921vF+G09d9yg0uk8FzGqWG7H3sx7zB2llh1NNFPIabMzr8A6d6s2mIvAlQVM
         wfg7UByxcf/LhigCiNFD6uKv2cdNfkw/r/NP0yY9F4SP2QmKJOvWGx5XBX2eX8T5AJ+D
         7ZXwmnANgt6LrC0KiHbgzL/lhs31bsIldZYqCcSrTJaQF44Uep4eLm4Rzcbp65sj2oNL
         pwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772586298; x=1773191098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAPoSa4AQv8RODkGu3q6FPMnaa+Z1UifihLeOdR33/Y=;
        b=i8SOBBnDtja1COXw5b3pQRL7ipvBHLMyQEQKd+6cjck75TL2e5VgsFrjIEJ6eLM2e+
         J33Cybr0yggTIZCIIGB/46iP5/VXhQm6PVWwP2/IrRjKlAjXvWqJ5Zok9cBrSSqCmeMA
         Qdood0nakL4BomNfb994sWkG7d4XZfXFb+H8rviUMiGe4ncw15KNEI95Zt3YStJ3qDdW
         mI6km94djpFQoV68v+t8iUKy8rQlJy+3jsElaNZQF6/8dFAZzxn06GHA7e4Jxgemy+jH
         EbbaZ8jfCGiLlJ6mQyR6/N8cNGjD0uqYqzubHRiIE4Ynj+2+TwjuXjnW3mcoybuS0csv
         A/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6B6I+odn+Ryfdvul/Fl1xOBLNmHjq7vFLSO8XNsxkkiRxnKloZO5jfW5h6+bRWjJfV1IB7ucQxdLFOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwnR74UELWg7v45sK4LjtjbL/FIg6tLD3FOOdJK3Dj3vMYz0F
	oUwvDBNPLNmdJ2SJd77ok/7KpoWtykrs+YfWXW4RsIEqaweMcaNCDPbpWlknYmY/UtU=
X-Gm-Gg: ATEYQzzELLWGfxmBaoZ+o9Pv9X4U4wHcc3Ns3/Sj7CYiop0Gt+zgfVD19sHut+j4xl8
	Hz0cPE1jmYrajMR/3el+fxC29HNZ/Actdm8wK5z47714Q+olk2n+BfNaIy/pzl58q8ryne3at5y
	QI59RDP5bTxLfTnMCmDtEdW5XMUMc1lIXXBJTBjzA7xCNF+rNX/TKW8WdvR7fAdPpVXMjCT+ZAb
	nmyc+uA0gPwjUhEtdJ5dPHafnpQIyjBrGwCgEsk8rkmkA7X3nmyqOzjfR/RirTP/y4dtu/8qTZV
	EChlJSgUy222d0dSdap1vkscST7sJ5ASIxdD5XoRYS9FjLU6caYSXJ01DkRaii+o5kJL2Ixlchs
	MXrFRHj7tpWwPZ7y0+A49/PtSnMd36uUENYuHu8ftcIHTgL5elbCis/BWweKyDlK2gVaOWxy9uB
	XuJvLkZGh3u/dFCBvwssRfs1aFd584Dbp5JlUZ7Lp8a6ItTD2W+gbIIEZG7ykHi5P2j9rW8sdCu
	ltgoy5YjuUSg5OkOXJAyvE7K8Y5ANCP9J3RErUtnf2Rxk3Wf72a+RVyEWBJdpOlZHA=
X-Received: by 2002:a17:90a:ec8e:b0:356:3cfd:3ee1 with SMTP id 98e67ed59e1d1-359a6a509camr319746a91.23.1772586298127;
        Tue, 03 Mar 2026 17:04:58 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([116.251.152.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c408389sm3937421a91.8.2026.03.03.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:04:57 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Nilton Perim Neto <niltonperimneto@gmail.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xpad: expose xinput capabilities via sysattr
Date: Wed,  4 Mar 2026 14:03:43 +1300
Message-ID: <20260304010345.1355896-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch xinput capabilities for x360 wired and wireless
and then expose them via the following attributes:

ATTRS{xpad/flags}=="3"
ATTRS{xpad/gamepad_buttons}=="ffff"
ATTRS{xpad/gamepad_lsx}=="0"
ATTRS{xpad/gamepad_lsy}=="0"
ATTRS{xpad/gamepad_lt}=="3f"
ATTRS{xpad/gamepad_rsx}=="ffc0"
ATTRS{xpad/gamepad_rsy}=="ffc0"
ATTRS{xpad/gamepad_rt}=="ff"
ATTRS{xpad/rumble_l}=="0"
ATTRS{xpad/rumble_r}=="0"
ATTRS{xpad/subtype}=="7"
ATTRS{xpad/type}=="1"

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
 drivers/input/joystick/xpad.c | 197 ++++++++++++++++++++++++++++++++--
 1 file changed, 188 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f581..70e4a7c85ab5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -94,6 +94,12 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+#define FLAG_FORCE_FEEDBACK 0x01
+#define FLAG_WIRELESS       0x02
+#define FLAG_VOICE          0x04
+#define FLAG_PLUGIN_MODULES 0x08
+#define FLAG_NO_NAVIGATION  0x10
+
 /* Send power-off packet to xpad360w after holding the mode button for this many
  * seconds
  */
@@ -747,6 +753,47 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumbleend_init),
 };
 
+struct xpad_x360_gamepad_descriptor {
+	u8 bLength;
+	u8 bDescriptorType;
+	u8 reserved;
+	u8 type;
+	u8 subType;
+	u8 reserved2;
+	u8 bEndpointAddressIn;
+	u8 bMaxDataSizeIn;
+	u8 reserved3[5];
+	u8 bEndpointAddressOut;
+	u8 bMaxDataSizeOut;
+	u8 reserved4[2];
+} __packed;
+
+struct x360_capabilities {
+	u8 type;
+	u8 subType;
+	struct {
+		u8 id;
+		u8 rsize;
+		u16 buttons;
+		u8 leftTrigger;
+		u8 rightTrigger;
+		u16 leftThumbX;
+		u16 leftThumbY;
+		u16 rightThumbX;
+		u16 rightThumbY;
+		u8 reserved[4];
+		u16 flags;
+	} gamepad;
+	struct {
+		u8 id;
+		u8 rsize;
+		u8 padding;
+		u16 leftMotorSpeed;
+		u16 rightMotorSpeed;
+		u8 padding2[3];
+	} vibration;
+} __packed;
+
 struct xpad_output_packet {
 	u8 data[XPAD_PKT_LEN];
 	u8 len;
@@ -795,6 +842,7 @@ struct usb_xpad {
 	int xtype;			/* type of xbox device */
 	int packet_type;		/* type of the extended packet */
 	int pad_nr;			/* the order x360 pads were attached */
+	struct x360_capabilities capabilities; /* capabilities of the device */
 	const char *name;		/* name of the device */
 	struct work_struct work;	/* init/remove device from callback */
 	time64_t mode_btn_down_ts;
@@ -802,11 +850,63 @@ struct usb_xpad {
 	bool delayed_init_done;
 };
 
+#define XPAD_SHOW(name, object) \
+static ssize_t name##_show(struct device *dev,\
+			   struct device_attribute *attr,\
+			   char *buf)\
+{\
+	struct usb_xpad *xpad = input_get_drvdata(to_input_dev(dev));\
+\
+	return sysfs_emit(buf, "%x\n", xpad->capabilities.object);\
+} \
+\
+static DEVICE_ATTR_RO(name)
+
+XPAD_SHOW(subtype, subType);
+XPAD_SHOW(type, type);
+XPAD_SHOW(flags, gamepad.flags);
+XPAD_SHOW(gamepad_buttons, gamepad.buttons);
+XPAD_SHOW(gamepad_lt, gamepad.leftTrigger);
+XPAD_SHOW(gamepad_rt, gamepad.rightTrigger);
+XPAD_SHOW(gamepad_lsx, gamepad.leftThumbX);
+XPAD_SHOW(gamepad_lsy, gamepad.leftThumbY);
+XPAD_SHOW(gamepad_rsx, gamepad.rightThumbX);
+XPAD_SHOW(gamepad_rsy, gamepad.rightThumbY);
+XPAD_SHOW(rumble_l, vibration.leftMotorSpeed);
+XPAD_SHOW(rumble_r, vibration.rightMotorSpeed);
+
+static struct attribute *xpad_attrs[] = {
+	&dev_attr_type.attr,
+	&dev_attr_subtype.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_gamepad_buttons.attr,
+	&dev_attr_gamepad_lt.attr,
+	&dev_attr_gamepad_rt.attr,
+	&dev_attr_gamepad_lsx.attr,
+	&dev_attr_gamepad_lsy.attr,
+	&dev_attr_gamepad_rsx.attr,
+	&dev_attr_gamepad_rsy.attr,
+	&dev_attr_rumble_l.attr,
+	&dev_attr_rumble_r.attr,
+	NULL
+};
+
+static struct attribute_group xpad_group = {
+	.attrs = xpad_attrs,
+	.name = "xpad"
+};
+
+static const struct attribute_group *xpad_groups[] = {
+	&xpad_group,
+	NULL,
+};
+
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
 
 /*
  *	xpad_process_packet
@@ -1032,6 +1132,29 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 		}
 	}
 
+	/* Link report */
+	if (data[0] == 0x00 && data[1] == 0x0F) {
+		xpad->capabilities.subType = data[25] & 0x7f;
+		xpad->capabilities.gamepad.flags = FLAG_WIRELESS;
+		if ((data[25] & 0x80) != 0)
+			xpad->capabilities.gamepad.flags |= FLAG_FORCE_FEEDBACK;
+		xpad_inquiry_pad_capabilities(xpad);
+	}
+
+	/* Capabilities report */
+	if (data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12) {
+		xpad->capabilities.gamepad.buttons = (data[7] << 8) | data[6];
+		xpad->capabilities.gamepad.leftTrigger = data[8];
+		xpad->capabilities.gamepad.rightTrigger = data[9];
+		xpad->capabilities.gamepad.leftThumbX = (data[11] << 8) | data[10];
+		xpad->capabilities.gamepad.leftThumbY = (data[13] << 8) | data[12];
+		xpad->capabilities.gamepad.rightThumbX = (data[15] << 8) | data[14];
+		xpad->capabilities.gamepad.rightThumbY = (data[17] << 8) | data[16];
+		xpad->capabilities.gamepad.flags |= data[20];
+		xpad->capabilities.vibration.leftMotorSpeed = data[18];
+		xpad->capabilities.vibration.rightMotorSpeed = data[19];
+	}
+
 	/* Valid pad data */
 	if (data[1] != 0x1)
 		return;
@@ -1495,6 +1618,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 	return xpad_try_sending_next_out_packet(xpad);
 }
 
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad)
+{
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+
+	guard(spinlock_irqsave)(&xpad->odata_lock);
+
+	packet->data[0] = 0x00;
+	packet->data[1] = 0x00;
+	packet->data[2] = 0x02;
+	packet->data[3] = 0x80;
+	packet->data[4] = 0x00;
+	packet->data[5] = 0x00;
+	packet->data[6] = 0x00;
+	packet->data[7] = 0x00;
+	packet->data[8] = 0x00;
+	packet->data[9] = 0x00;
+	packet->data[10] = 0x00;
+	packet->data[11] = 0x00;
+	packet->len = 12;
+	packet->pending = true;
+
+	return xpad_try_sending_next_out_packet(xpad);
+}
+
 static int xpad_start_xbox_one(struct usb_xpad *xpad)
 {
 	int error;
@@ -1808,25 +1956,37 @@ static int xpad_start_input(struct usb_xpad *xpad)
 		}
 	}
 	if (xpad->xtype == XTYPE_XBOX360) {
-		/*
-		 * Some third-party controllers Xbox 360-style controllers
-		 * require this message to finish initialization.
-		 */
-		u8 dummy[20];
-
 		error = usb_control_msg_recv(xpad->udev, 0,
 					     /* bRequest */ 0x01,
 					     /* bmRequestType */
 					     USB_TYPE_VENDOR | USB_DIR_IN |
-						USB_RECIP_INTERFACE,
+					     USB_RECIP_INTERFACE,
 					     /* wValue */ 0x100,
 					     /* wIndex */ 0x00,
-					     dummy, sizeof(dummy),
+					     &xpad->capabilities.gamepad,
+					     sizeof(xpad->capabilities.gamepad),
 					     25, GFP_KERNEL);
 		if (error)
 			dev_warn(&xpad->dev->dev,
-				 "unable to receive magic message: %d\n",
+				 "unable to receive input capabilities: %d\n",
 				 error);
+
+		if (xpad->capabilities.gamepad.flags & FLAG_FORCE_FEEDBACK) {
+			error = usb_control_msg_recv(xpad->udev, 0,
+						     /* bRequest */ 0x01,
+						     /* bmRequestType */
+						     USB_TYPE_VENDOR | USB_DIR_IN |
+						     USB_RECIP_INTERFACE,
+						     /* wValue */ 0x00,
+						     /* wIndex */ 0x00,
+						     &xpad->capabilities.vibration,
+						     sizeof(xpad->capabilities.vibration),
+						     25, GFP_KERNEL);
+			if (error)
+				dev_warn(&xpad->dev->dev,
+					 "unable to receive vibration capabilities: %d\n",
+					 error);
+		}
 	}
 
 	return 0;
@@ -1953,6 +2113,7 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 static int xpad_init_input(struct usb_xpad *xpad)
 {
 	struct input_dev *input_dev;
+	struct xpad_x360_gamepad_descriptor *input_desc;
 	int i, error;
 
 	input_dev = input_allocate_device();
@@ -1962,11 +2123,29 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	xpad->dev = input_dev;
 	input_dev->name = xpad->name;
 	input_dev->phys = xpad->phys;
+	xpad->capabilities.subType = 1;
+	xpad->capabilities.type = 1;
+	xpad->capabilities.gamepad.flags = 0;
+	xpad->capabilities.gamepad.buttons = 0xFFFF;
+	xpad->capabilities.gamepad.leftTrigger = 0xFF;
+	xpad->capabilities.gamepad.rightTrigger = 0xFF;
+	xpad->capabilities.gamepad.leftThumbX = 0xFFC0;
+	xpad->capabilities.gamepad.leftThumbY = 0xFFC0;
+	xpad->capabilities.gamepad.rightThumbX = 0xFFC0;
+	xpad->capabilities.gamepad.rightThumbY = 0xFFC0;
+	xpad->dev->dev.groups = xpad_groups;
 	usb_to_input_id(xpad->udev, &input_dev->id);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		/* x360w controllers and the receiver have different ids */
 		input_dev->id.product = 0x02a1;
+		xpad->capabilities.gamepad.flags = FLAG_WIRELESS;
+	}
+
+	if (xpad->xtype == XTYPE_XBOX360 &&
+	    usb_get_extra_descriptor(xpad->intf->cur_altsetting, 0x21, &input_desc) == 0) {
+		xpad->capabilities.subType = input_desc->subType;
+		xpad->capabilities.type = input_desc->type;
 	}
 
 	input_dev->dev.parent = &xpad->intf->dev;
-- 
2.53.0

