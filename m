Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79230F7EA
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035684; cv=none; b=Nh8ySFw6xlE7iIMb4y8fdVsj3mkWQx76VCTNtI+BtzsE+9/s5ENa6CLoWhgJ94cCjjNh3yAM9+NMJlP400NFEjHvt+VZz4/vTv+3JovOUFLqzdSvsBmbB04kYyAnhDTkBqg2bSA3/6kZFRZmbLrOsJ84ag9Wgjqjo0VhVfnorrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035684; c=relaxed/simple;
	bh=A3kuUoX8duVtsHI05DExDUKGRfD39wgtJ7g5QEddXME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvR6DBSv8bkBwfj3owbRoTl9G+3XOTSi+SL48aiTZ2EC9OL7pBO/cQK7yNUYZpm/WZR5vqh4uqHHVsTmwKxgNbmBH0wtc1MflzXeMUBy9AS6aSPl3SSdDJW/P8lf6j+2k3SjCOaKZp2b77Zvr+mYKPOAv4+qhukjdsea3t198fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMyzVYrX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMyzVYrX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so3723146b3a.1
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787035682; x=1787640482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QFafk+ZUbTjgUFBS5EDHLdaaFBQjeCTYHQb3YQzHHyI=;
        b=UMyzVYrXvG3OPt9sVfJbmx062/KZMlQesjMXzBLDB6/Jp5+XiGcmeHeoenpVGK7yPv
         1dU9PEfwRrMxLpfppvvLEnwIFUIsSBD+MwTxOQeJjeBdVLUlGfMXxjlstgC+8WrKNKwA
         nHFp2HZrtmiSKMRWuAi5qeBZ8oj/tYJkBKxMEIPC/NeC0oTw4Q/HoObO5oIwgHGUJ2tF
         C2cdvI3V6zcoRMkwiH5Fumt8n+rBwuuRmxITRO3ZvhCACFRsvb7oN5cPLpZwAGv4L1iH
         2FC9HrtGJAf2BPMaLrOpdrUFvUg57DYYPX+8GixFTJxBByguQ7ZO4bjl1yq5tn9+HZ7w
         2XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787035682; x=1787640482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QFafk+ZUbTjgUFBS5EDHLdaaFBQjeCTYHQb3YQzHHyI=;
        b=HFOeQPPydKLCeRFNR3yD/ODkCD0JVo6TRlC9Y3daXoMy3uCAKJwktYrfQqRoklXmA5
         ac79mMq9Ioupa41YRkCwtH3krSspJgONVcRnt+q+7xPdBNuXgqNAJaWh/raZ+hcdlHaS
         VeYuJ4kOedRjALI2Uy2S4FIo2kF2N8e76wyTHxzMkQFgZaDU8st3oIOCgc538RXqclxe
         MxO9+CoR+8XW7YraqOIZyZ+ettAAZK9H09ykxNUQfUOma0HB9/WcSuJ+5OdsfoLQR4G4
         N6KaTHEbIvzaBZH5RWIYyneLowfvIDckXPnuCXQt47uXoNe4YDgC90Sx6lw9RIWnWCKt
         OC6A==
X-Forwarded-Encrypted: i=1; AHgh+RrSzzIs0LgJcuzK6TeJdXgJdoU3AcHwKnuf/8/u0XT01SESVAWiDf9SSWPHh9mJLZNEXDZTryfRAcQbBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCRo7F4m9zLRVYxmR/+j4WSlWUfGoIQJteUax8FQ5rTqcfgP/
	pe2w/mYED5Ypj3azGdfpRn1UZICNoNLvUueywRuypC1M2+x/wcxykL1p
X-Gm-Gg: AR+sD10R2UQSxOByvMl7DeIrQ+7nTidjz4fL9awHvalQVg36EtIV0ZjNKMa5tO1JUVx
	wqvkxbUlNQ/jKHHgWiV0yBwHRHQinmI1ZN2a4sZbmOosdXfgtK+O3Rp0pL1hdMi0YiHr/fb0VTd
	mBoVLCAW6wdJ0LeVpaMSsYhS6DgBtBV2kGBTlC9eJU8o1Upzmd+AlcSCcRLAJv8kjiVTEiAozwz
	pmmHfwQ2bu7WBotzC5ivNDws2yFKGd/ZnHCskHjE2qbeioIiwVQjBBQlhd8QokrW1aFbCsTs1uo
	W07hJ4KkiQBBTqQ2yy0kauSRG7l9mOLNgWknkimd+UR8+zi/3j2ygq9PRJrQKaTeEN9OepKiDUt
	8TIGI8MMlG/+m3XjkGnDL+2L+C9BpmVpcEhgM7bEGoIVzTVZBC1NHuKEXvFLJDldtT99/KG7Hn2
	HPpxoMF19QIJ8X6j4xgtkgw046ML4Jf0evl0lyu5b8rXii/8kbIEVCouzQ7a5dlx4tTGh1abmbt
	X0mNuJlgzs+rAXcMLirxVcSaYxBnEZNbmtHpFeHXK5rZGU7i/hdSD2G8cxWzkI1bYeTuDzafasX
	sCkbT/Ws0BG0ixq/3PSWFhrpYXXYgzBXmA==
X-Received: by 2002:a05:6a00:995:b0:84e:24f:2667 with SMTP id d2e1a72fcca58-84fde14ff17mr27868124b3a.8.1787035681438;
        Mon, 17 Aug 2026 23:48:01 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([14.137.23.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e26sm13632719eec.22.2026.08.17.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:48:00 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Zoltan Illes <zoliviragh@gmail.com>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Kyohei Kadota <lufia@lufia.org>,
	Elliot Tester <elliotctester@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Dmitriy Zharov <contact@zharov.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 RESEND] xpad: Overhaul device data for wireless devices
Date: Tue, 18 Aug 2026 18:45:56 +1200
Message-ID: <20260818064557.872622-3-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.55.0
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
 drivers/input/joystick/xpad.c | 209 ++++++++++++++++++++++++++++++----
 1 file changed, 188 insertions(+), 21 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2da0b7f1722a..45f56798f9e1 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/usb/input.h>
 #include <linux/usb/quirks.h>
 
@@ -60,6 +61,22 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+#define FLAG_FORCE_FEEDBACK	0x01
+
+#define SUBTYPE_GAMEPAD			 0x01
+#define SUBTYPE_WHEEL			 0x02
+#define SUBTYPE_ARCADE_STICK	 0x03
+#define SUBTYPE_FLIGHT_STICK	 0x04
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
@@ -775,8 +792,13 @@ struct usb_xpad {
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
@@ -787,6 +809,8 @@ static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
+
 
 /*
  *	xpad_process_packet
@@ -960,19 +984,12 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 static void xpad_presence_work(struct work_struct *work)
 {
-	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work.work);
 	int error;
-
-	if (xpad->pad_present) {
-		error = xpad_init_input(xpad);
-		if (error) {
-			/* complain only, not much else we can do here */
-			dev_err(&xpad->dev->dev,
-				"unable to init device: %d\n", error);
-		} else {
-			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
-		}
-	} else {
+	/* Check if the pad presence has changed */
+	if (xpad->pad_present == xpad->input_created)
+		return;
+	if (xpad->input_created) {
 		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
 		synchronize_rcu();
 		/*
@@ -980,6 +997,15 @@ static void xpad_presence_work(struct work_struct *work)
 		 * using input device we can get rid of it.
 		 */
 		xpad_deinit_input(xpad);
+	} else {
+		error = xpad_init_input(xpad);
+		if (error) {
+			/* complain only, not much else we can do here */
+			dev_err(&xpad->intf->dev,
+				"unable to init device: %d\n", error);
+		} else {
+			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
+		}
 	}
 }
 
@@ -997,10 +1023,11 @@ static void xpad_presence_work(struct work_struct *work)
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev;
 	bool present;
+	u16 parsed_vid;
 
 	/* Presence change */
 	if (data[0] & 0x08) {
@@ -1008,7 +1035,65 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 
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
+				mod_delayed_work(system_percpu_wq,
+						 &xpad->work, msecs_to_jiffies(500));
+			} else {
+				mod_delayed_work(system_percpu_wq, &xpad->work, 0);
+			}
+		}
+	}
+
+	/* Link report */
+	if (len >= 26 && data[0] == 0x00 && data[1] == 0x0F) {
+		xpad->sub_type = data[25] & 0x7f;
+
+		/* Decode vendor id from link report */
+		parsed_vid = ((data[0x16] & 0xf) | data[0x18] << 4) << 8 | data[0x17];
+
+		/*
+		 * If the link report doesn't provide a proper vid, it sets the vid to 1.
+		 * In that case we zero out wireless_vid, so that we fall back to the vid
+		 * from the receiver instead.
+		 */
+		if (parsed_vid == 1)
+			parsed_vid = 0;
+
+		/*
+		 * x360w controllers on windows put the subtype into the product
+		 * for wheels and gamepads, but it makes sense to do it for all
+		 * subtypes. This will be used if the capabilities report
+		 * doesn't provide us with a product id later.
+		 */
+		xpad->wireless_vid = parsed_vid;
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
+	if (len >= 21 && data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12) {
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
 
@@ -1234,7 +1319,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1475,6 +1560,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
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
@@ -1872,8 +1982,8 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
 {
 	usb_kill_urb(xpad->irq_in);
 
-	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
+	/* Cancel any pending presence work */
+	cancel_delayed_work_sync(&xpad->work);
 }
 
 static int xpad_open(struct input_dev *dev)
@@ -1925,6 +2035,11 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 {
 	if (xpad->input_created) {
 		xpad->input_created = false;
+		xpad->wireless_vid = 0;
+		xpad->wireless_pid = 0;
+		xpad->wireless_version = 0;
+		xpad->flags = 0;
+		xpad->sub_type = 0;
 		xpad_led_disconnect(xpad);
 		input_unregister_device(xpad->dev);
 	}
@@ -1945,8 +2060,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
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
+		case SUBTYPE_FLIGHT_STICK:
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
@@ -2086,7 +2253,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
-- 
2.55.0

