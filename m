Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D01FBEBC
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589645; cv=none; b=XctxzG0B1v5X1tVRvMiIdnZQHoG9HFkw9aaucYGhGksbgAm6dEqJJXSPpdRYxkVWs6hwn8f4ocqfPEYbo6K2UevlrPq5dvWFB32LpbyBfCzQipD6iYaykBwjhCo/Z4MKUMmZ+yorI+rrm+KEEam2U95Gb+OQs+lxv24rtswgQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589645; c=relaxed/simple;
	bh=aESIEwxM0gLMvBgQFVFiv/mzhsgDSflE6QsbWL34NBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJmAVu59eM9tRJPvam30adq+vDAThDgrdUng+fdt8Ziqx5mwFEfVyT94isnA2+VkeI7iusZ2eUjA5Dl2E3uDJTHonPiMK+E5oLjXxfzsGVrAff+xKrQ1txfEQ6zLlVdQkdmvQaoKbbMdwDp1hXlJL9V8ZkhBvo2LDDGdFTG4CPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgTl2FF1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgTl2FF1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2503753efso44506945ad.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589643; x=1776194443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0O7DuTZ+D85au3JMLP+CFqFmga9iJn/jwHe9ZeB2Ij0=;
        b=jgTl2FF1uRkq766OsJdFX0KlWDMap4vzQc5NYQGWvUJw/jNSm2F4pqYegSWb94kYlN
         r27eD8d91iQAYwrFUGHRsYZDGZ968QDp9FpPi9OZ6/RJloJXaIf5ReMQH4BKcFsWU0FT
         QSZ3rwkYSq9p/MeYU7/2CiFG1XGzLv/Y3SDvNygrJTgW1KrmkkQKraouuSTEOukj69u+
         bNlP0AkphSX9j3waWXqHUw3zpnAWV8Zff6yXngV5nnGMqUoHOWpviR+BeZHqiskyaQwu
         5rZK3wArTuVPLc+0Q+eGo6BesL5qxVf0OcUhKLQWS4GRBh4H8ns8shSk3ekhkbYTJSse
         EVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589643; x=1776194443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O7DuTZ+D85au3JMLP+CFqFmga9iJn/jwHe9ZeB2Ij0=;
        b=soU85BCK42PP0OhVYWBppeTPHlm7Lu0P1AUuwBJMZTIuJBZ+6BgD2AnCXAniMFj76x
         mRJzxZfSgAxfJvh4wr+i4LE4HbuKQy4zum6swMAg6aYrhQ69Rye0uPaUgmoZkPukUgh/
         jzi0w5wNvjiSr6pbf60Eaf/zk+jSHnYrq4EFkt+OgLyOraifAaiPTE1ny1mYlowSQPx2
         ghIWvCY4ZmiRV7T0zRhOUgBwH8Lz3Sp0UbgnOcY45Ra35qoJeHjRSORAGG0JdbXhyVpZ
         OtFDG23r3Bu47VOvGACKfFGKxaok/QfkGdflc605r95Y0YxyMuBHPp4U11i0LbJdq4Sd
         /JMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+DKEc1QFQPO99+dndWEj+VJuZkyHH3Y3NHha45sQYvJvVlcmETbDest7vYsMlzkfEeuJPZKSzl5cD+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YylXqu5OoGm1E0hh5o5Mpg6zmv0sAL3W6k3E5SE49S4LoD0DESB
	N+ztsQMsRxaMsoNXVnO/HACLPH/URW0cubQSOEdBXtwohib6N/BRI1oSb2f/IXzC
X-Gm-Gg: AeBDiesaCu4bCCptbV+v3BHZ8QG1NuGAMh8kEPmw+76OtBysPN77nHCCSDdf00EuX+X
	Sv3Xd7pplV1r1l2bza+FdlUx5Ewnn+B0gb55z7pRji8D8mfonrtIZla/cTp0vV0rgcd/bORFN6I
	DacH1b9sSeAg6QtSZOLBf69RGyAAPTlN+IgW5na4GI+ZG9hnUlsZ1yLdJjDZNAbzbkFcL60fbdQ
	XYvsNSZgS1tIUnxjPh5G8vLVqrXrKMkqAi+3pRpUJYLHGGPcpfyRoa4UE8sYDGWTZO4KPzTTg97
	PBbCmDI2FBa4NO6RaDolvO4G/h0BYRGHjLvSN+xXworoRiuY5xxPb5OYPJK7MkC113R8WguMBFo
	kJ+LwZ5mBE9ptQ7YezjcW7kyqk71qLSlLC/vnlCPMYdOGpGIujtq+mNLaOFSjXWU+DgPxSPIjl2
	pb5/V545j82eeKHNCYiptibeGS5HFhNNpdUJZ4s/inGhOgVGfuyJV68wN7XkMQ3+uzqp+mdSHzE
	jsLHirx2+igWoKAylt58ArJHXHlL/72gPum1++Ip3ErGSdroqsUlP3UcL2q/LkgNA==
X-Received: by 2002:a17:903:acc:b0:2b2:5042:dd22 with SMTP id d9443c01a7336-2b281935ddamr194221005ad.34.1775589643338;
        Tue, 07 Apr 2026 12:20:43 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([139.180.64.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d55fsm235782245ad.11.2026.04.07.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:20:42 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Nilton Perim Neto <niltonperimneto@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Lode Willems <me@lodewillems.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] xpad: Overhaul device data for wireless devices
Date: Wed,  8 Apr 2026 07:17:52 +1200
Message-ID: <20260407191753.178576-3-sanjay.govind9@gmail.com>
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
v4: Clear wireless state when processing device prescence change
v5: Fix typo, fix some potential race conditions with work scheduling
v6: Fix typo, address potential time-of-check time-of-use issues with presence work
v7: Explicitly check if the input device has been initialized already when processing presence changes
 drivers/input/joystick/xpad.c | 209 ++++++++++++++++++++++++++++++----
 1 file changed, 188 insertions(+), 21 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f581..018c186f78ef 100644
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
@@ -980,19 +1004,12 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
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
@@ -1000,6 +1017,15 @@ static void xpad_presence_work(struct work_struct *work)
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
 
@@ -1017,10 +1043,11 @@ static void xpad_presence_work(struct work_struct *work)
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
@@ -1028,7 +1055,65 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 
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
 
@@ -1254,7 +1339,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1495,6 +1580,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
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
@@ -1892,8 +2002,8 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
 {
 	usb_kill_urb(xpad->irq_in);
 
-	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
+	/* Cancel any pending presence work */
+	cancel_delayed_work_sync(&xpad->work);
 }
 
 static int xpad_open(struct input_dev *dev)
@@ -1945,6 +2055,11 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
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
@@ -1965,8 +2080,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
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
@@ -2106,7 +2273,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
-- 
2.53.0

