Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30238F639
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545183; cv=none; b=B1DIrIQn6sTMc+altzFX41nXXBrXK7oF+kw+spJp794bSnjMdWMVc1tgTANL2EUc63lB0URy16tdqwmZzkgqkGcfGK4u/aGy0aEZxKkcf/NeDQGDd3WqwkeEGC+Vog24JUhBI4skRKarEqwveOoPu9Q/fl2bk0ZF1jH5uQCkQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545183; c=relaxed/simple;
	bh=VzmxE1QFhQSLAdGbqYtre80ldADwx5PQfuj64jNcGG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCxscqchPr+bfoZo/Jc4GW8T9Mzsk0536QOw25rmSYzS6CQEK8IP+72mxAqaX1KLLhTMqMiwbIT5nROPlzXovPeHXdhQCHLX8a456amBfxBHQwjg7KMYfXrqAR+R28VttC6LX+TCCYKVn4qmMyr4oaw1QzrrWt8dV9nqGH+DBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9Cs8JoE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9Cs8JoE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9f316d68so19094225ad.2
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775545179; x=1776149979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=luTBe574fJaIli+cXVaMHg3qhOHP9a6MUJzfWGUyjmc=;
        b=r9Cs8JoE72aYWm8yygCUpHjIVqnX/hqAZ9tOXY0L+T+3jM0SiYi7Sx1CfHFkO+J/Du
         BZGP7874ZAiqokEMNsrwdQLnMkczQ5gZBw76q3krQdZzUhGLsK1/wh/QjXIkbau1s4dP
         cXI19NDODnMbvLdn5xQc9A0XCc44Ea09+TooQgcGsBMOXquqOWy4YHitsuGoaNOWLb6j
         z545qT1IvjACzU7j4DvjZuV245gzMOUdw4QiC1KYdREswXRsn+LEyLBhLF8AiqnKnpN5
         Q901U9/I2dSAajTG0dQIuSe4bcV9sVJie7Kvp8M5ucsIkqxCx6AihOWQuzntZKdqPQWL
         q6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545179; x=1776149979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luTBe574fJaIli+cXVaMHg3qhOHP9a6MUJzfWGUyjmc=;
        b=NsYnCUUXexnpo5Po6v2KM6NyGPa/9kQFiSJNMJj0+TGSfgFI5gJbChFHaR9Asb/NPu
         VamQrVaWBJyA3HQVMoFBKhUqRtRmxkPtPkgiu8pkSprW57uvguSplmgQ4bEmSkoFxgiV
         zINE/xJLo1w+/K0hYXeTfHoug3qiMkbgtbj150obq+ywx9B4K1xcU67gk/52oKmtNjYM
         rcW2W45068HPxCQ4+KJbrdo5UJoZLMgOoph+BUyTJYgUgRN+0Ruz1iwfDrN59brIX3cG
         SLIyyjwDBBvz9OSaE5mUZtSIcqRxA7mWhqCWJoCP/bAOZWA1/3SiA6Ks595wn89fd0SU
         RS5w==
X-Forwarded-Encrypted: i=1; AJvYcCUrbPCgJL7N8rHe5iPgq3yK7UB8BjKNCH4MqhnEk+do2VjbSO07wNYtYYWMsTYiEFIxTxokLGABhTrdjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwibG+eFreMRO9yYtYHRJ+VploKHVpwQ2ddrHrQFvX/5WlK99OB
	8Qz5RtBf9tPDDa/aIUK0Jcuh8kLH4YhiHdnpYlX4UY4X9xmD95mhmvlX
X-Gm-Gg: AeBDievzk5F9yjvMzDancOdsufxf21t2U6M/3raSl5SzZcTmSidgIm1VjuU/71Un76Y
	DmtDLnqSTkTZaZRoZlCQgc1e1VqleO6qPipZwv8L5K2PRV5SgFjjgsVaub1t0h2VzKIZHdoTSzC
	Bf5NL1GL+/IVSiNpOGxa+W02uAxxAfJ3CiB6+p2HH+YscbyZTtIX4JZbvKG7V3bmyfJ9QaEbP0k
	VsyG62dJIsCu4sAjm+P/ilSnvMfpPZqpeTrR8fEv81sLLxIYy7N49Y78q/F+WXqGapO+3nLnQtd
	DpTHixWftlsz0b25XVY+YYFLrzagjTNZ66MpqqABL3uX/aTKdHlB/CLAfO4SZ54SSxiBXrqfy7A
	OiqKUTCr3xpV9kZa5TtRY3uCuOihukLHHoBvwt5pg5VJfxvw7phQT9cVh3d0HDjmfTcsLL4Pyh6
	IfrupWCe5AeEBLGlRF4u+VGuh3GL3tXuFeymQF0Q+4ZwrjCwO5vmAAs1QzFavuzeBABNWnWITwW
	wSy1Ee2KaxoJK+meAXsqy2y9iFRdrmRxIJPhu7izbx5/HyA1ZoTMHowpKTIQQQN9Q==
X-Received: by 2002:a17:903:40cc:b0:2b2:9f9f:fe6b with SMTP id d9443c01a7336-2b29f9fff92mr80948015ad.40.1775545179479;
        Mon, 06 Apr 2026 23:59:39 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([139.180.64.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274f8867csm165860985ad.54.2026.04.06.23.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 23:59:38 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nilton Perim Neto <niltonperimneto@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] xpad: Overhaul device data for wireless devices
Date: Tue,  7 Apr 2026 18:57:39 +1200
Message-ID: <20260407065740.2035240-3-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xbox 360 wireless controllers expose information in the link and
capabilities reports.

Extract and use the vendor id for wireless controllers, and use
the subtype to build a nicer device name and product id.

Some xbox 360 controllers put a vid and pid into the stick capability
data, so check if this was done, and pull the vid, pid and revision from
there.

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
v2: Delay marking device as present until after capabilities or timeout
v3: Fix issues when receiving incorrect or missing link and capabilities reports
 drivers/input/joystick/xpad.c | 174 ++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f581..18c355aff80f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -68,6 +68,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/usb/input.h>
 #include <linux/usb/quirks.h>
 
@@ -94,6 +95,22 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+#define FLAG_FORCE_FEEDBACK	0x01
+
+#define SUBTYPE_GAMEPAD			 0x01
+#define SUBTYPE_WHEEL			 0x02
+#define SUBTYPE_ARCADE_STICK	 0x03
+#define SUBTYPE_FLIGHT_SICK		 0x04
+#define SUBTYPE_DANCE_PAD		 0x05
+#define SUBTYPE_GUITAR			 0x06
+#define SUBTYPE_GUITAR_ALTERNATE 0x07
+#define SUBTYPE_DRUM_KIT		 0x08
+#define SUBTYPE_GUITAR_BASS		 0x0B
+#define SUBTYPE_RB_KEYBOARD		 0x0F
+#define SUBTYPE_ARCADE_PAD		 0x13
+#define SUBTYPE_TURNTABLE		 0x17
+#define SUBTYPE_PRO_GUITAR		 0x19
+
 /* Send power-off packet to xpad360w after holding the mode button for this many
  * seconds
  */
@@ -795,8 +812,13 @@ struct usb_xpad {
 	int xtype;			/* type of xbox device */
 	int packet_type;		/* type of the extended packet */
 	int pad_nr;			/* the order x360 pads were attached */
+	u8 sub_type;
+	u16 flags;
+	u16 wireless_vid;
+	u16 wireless_pid;
+	u16 wireless_version;
 	const char *name;		/* name of the device */
-	struct work_struct work;	/* init/remove device from callback */
+	struct delayed_work work;	/* init/remove device from callback */
 	time64_t mode_btn_down_ts;
 	bool delay_init;		/* init packets should be delayed */
 	bool delayed_init_done;
@@ -807,6 +829,8 @@ static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
+
 
 /*
  *	xpad_process_packet
@@ -980,7 +1004,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 static void xpad_presence_work(struct work_struct *work)
 {
-	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work.work);
 	int error;
 
 	if (xpad->pad_present) {
@@ -1017,7 +1041,7 @@ static void xpad_presence_work(struct work_struct *work)
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev;
 	bool present;
@@ -1028,7 +1052,62 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 
 		if (xpad->pad_present != present) {
 			xpad->pad_present = present;
-			schedule_work(&xpad->work);
+			if (present) {
+				/*
+				 * Delay marking device as present, so we can make sure
+				 * we have received all the information from the capabilities
+				 * report. Some devices don't send one, so the delay
+				 * guarantees that these devices are still initialized.
+				 */
+				schedule_delayed_work(&xpad->work, msecs_to_jiffies(500));
+			} else {
+				schedule_delayed_work(&xpad->work, 0);
+			}
+		}
+	}
+
+	/* Link report */
+	if (data[0] == 0x00 && data[1] == 0x0F && len >= 26) {
+		xpad->sub_type = data[25] & 0x7f;
+
+		/* Decode vendor id from link report */
+		xpad->wireless_vid = ((data[0x16] & 0xf) | data[0x18] << 4) << 8 | data[0x17];
+
+		/*
+		 * If the link report doesn't provide a proper vid, it sets the vid to 1.
+		 * In that case we zero out wireless_vid, so that we fall back to the vid
+		 * from the receiver instead.
+		 */
+		if (xpad->wireless_vid == 1)
+			xpad->wireless_vid = 0;
+		/*
+		 * x360w controllers on windows put the subtype into the product
+		 * for wheels and gamepads, but it makes sense to do it for all
+		 * subtypes. This will be used if the capabilities report
+		 * doesn't provide us with a product id later.
+		 */
+		xpad->wireless_pid = 0x02a0 + xpad->sub_type;
+		xpad->wireless_version = 0;
+
+		if ((data[25] & 0x80) != 0)
+			xpad->flags |= FLAG_FORCE_FEEDBACK;
+
+		xpad_inquiry_pad_capabilities(xpad);
+	}
+
+	/* Capabilities report */
+	if (data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12 && len >= 20) {
+		xpad->flags |= data[20];
+		/*
+		 * A bunch of vendors started putting vids and pids
+		 * into capabilities data because they can't be
+		 * retrieved by xinput easliy.
+		 * Not all of them do though, so check the vids match
+		 * before extracting that info.
+		 */
+		if (get_unaligned_le16(data + 10) == xpad->wireless_vid) {
+			xpad->wireless_pid = get_unaligned_le16(data + 12);
+			xpad->wireless_version = get_unaligned_le16(data + 14);
 		}
 	}
 
@@ -1254,7 +1333,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1495,6 +1574,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
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
@@ -1893,7 +1997,7 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
 	usb_kill_urb(xpad->irq_in);
 
 	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
+	flush_delayed_work(&xpad->work);
 }
 
 static int xpad_open(struct input_dev *dev)
@@ -1965,8 +2069,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	usb_to_input_id(xpad->udev, &input_dev->id);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		/* x360w controllers and the receiver have different ids */
-		input_dev->id.product = 0x02a1;
+		if (xpad->wireless_vid)
+			input_dev->id.vendor = xpad->wireless_vid;
+		if (xpad->wireless_pid)
+			input_dev->id.product = xpad->wireless_pid;
+		else
+			/* Default product id for x360w controllers */
+			input_dev->id.product = 0x02a1;
+		if (xpad->wireless_version)
+			input_dev->id.version = xpad->wireless_version;
+		switch (xpad->sub_type) {
+		case SUBTYPE_GAMEPAD:
+			input_dev->name = "Xbox 360 Wireless Controller";
+			break;
+		case SUBTYPE_WHEEL:
+			input_dev->name = "Xbox 360 Wireless Wheel";
+			break;
+		case SUBTYPE_ARCADE_STICK:
+			input_dev->name = "Xbox 360 Wireless Arcade Stick";
+			break;
+		case SUBTYPE_FLIGHT_SICK:
+			input_dev->name = "Xbox 360 Wireless Flight Stick";
+			break;
+		case SUBTYPE_DANCE_PAD:
+			input_dev->name = "Xbox 360 Wireless Dance Pad";
+			break;
+		case SUBTYPE_GUITAR:
+			input_dev->name = "Xbox 360 Wireless Guitar";
+			break;
+		case SUBTYPE_GUITAR_ALTERNATE:
+			input_dev->name = "Xbox 360 Wireless Alternate Guitar";
+			break;
+		case SUBTYPE_GUITAR_BASS:
+			input_dev->name = "Xbox 360 Wireless Bass Guitar";
+			break;
+		case SUBTYPE_DRUM_KIT:
+			/* Vendors used force feedback flag to differentiate these */
+			if (xpad->flags & FLAG_FORCE_FEEDBACK)
+				input_dev->name = "Xbox 360 Wireless Guitar Hero Drum Kit";
+			else
+				input_dev->name = "Xbox 360 Wireless Rock Band Drum Kit";
+			break;
+		case SUBTYPE_RB_KEYBOARD:
+			input_dev->name = "Xbox 360 Wireless Rock Band Keyboard";
+			break;
+		case SUBTYPE_ARCADE_PAD:
+			input_dev->name = "Xbox 360 Wireless Arcade Pad";
+			break;
+		case SUBTYPE_TURNTABLE:
+			input_dev->name = "Xbox 360 Wireless DJ Hero Turntable";
+			break;
+		case SUBTYPE_PRO_GUITAR:
+			input_dev->name = "Xbox 360 Wireless Rock Band Pro Guitar";
+			break;
+		}
 	}
 
 	input_dev->dev.parent = &xpad->intf->dev;
@@ -2106,7 +2262,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
-- 
2.53.0

