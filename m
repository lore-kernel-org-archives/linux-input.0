Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D639794A
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038505; cv=none; b=ABKCggQvniXavxhOhqenz4F8nKPLZmXYczNANAZOethgdU1mqbAPGssdVGO7zO/8s2p2kLD9GhS80WLJ978hnZk9FUmIkU6BB293DTZBP0RxQ504x6jwYM0REU/usFEkt4QxGU0CFMkJnGmFqSofKwQzMLFupGZJA8itASlVOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038505; c=relaxed/simple;
	bh=0z0gTdzoPcPrh3eZRI1686pp6b8s3zg8HJAqtnjRmsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu+fHUB9tIDeJm+akOyjdg1KwBf1DJJb2p+Q0DoGpOoXmVHsR31d4L1CvXIS1qh6r7rv5LMiK4wE4AOhTnrYbce3myVhGpglurz9hCX0zKnFufWdcR1oQQHrIJQkETWbcaoybdtpYzE1I75T6aMtscemGYdpJHDQdDWGLZyRa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7TQCeaw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7TQCeaw"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84eb992a881so3269308b3a.2
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787038494; x=1787643294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9T7KEDvoqKG+U4UzPWx4jpA0TMt+PJFCC2frFJ9DG0A=;
        b=C7TQCeawOXP3mqLuoT4sK39f1hPwQjKiBB/zTSPhRmN+nlR5vJGMWSKN8aBMAxQ950
         bXkf1LlzhuR2dqtHjAReCyBzbsAWgbJnUzdx2rGJUbaYuj4v+noH3ploFRT8ShEgh36x
         Ep0kc6tj4XoYO/QD2+6jBt3uWV4PMeWjw9szTsv7KdD/PZW64y37WNXohkcIvRU+V6Za
         sQYjtQN2FeVrvPca9wdUioGmi7zLKVg5vMxDYfpOtUwh/PhkYsWbnTYIaSpKusdWkUoR
         42FiMDAKkXNQrgX5j+M3EJ0Tg0XBGWWwgG73NfL48VLH8lG2KmP83Q/X4CXEw/SVZmHK
         WPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787038494; x=1787643294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9T7KEDvoqKG+U4UzPWx4jpA0TMt+PJFCC2frFJ9DG0A=;
        b=n/GqDcRSWpNQB567tEUqbSh2sq+nf11f9MvD7O16Ir5kPmxQcixIGUy5JzeXz8kbN3
         U/dUePExUeid+iTlDzf7sxeGRbEmGGBotUgxXlT4JtTgk6t82EcCpF6csqm1RgqxK7zk
         9XnXifaAz9id+XZbSrcHtRH+Pmxjy0naWJto+wNlqC9yU9IGpO3eeOa3DnucMH+qE5GV
         FymsN3lHuIxyIPqW30QjCPf/Xdi0fhiK4xA5phDUWEZdiafufWXL8SSwLph3BlXgISf/
         q7Pl5rOfFhfAtYCXD454JUnpsP8pEVgoRtW6V+cG4ziV/8q0RBvf5QAcwceI+HDztjN8
         l/Dg==
X-Forwarded-Encrypted: i=1; AHgh+RpcRIm6+qznQml5ImIUF2VsJhklk+BOEbtNOpHEfUsg5QUe5eRTH7+/9nWXfJ/rApxBj2BEGqaeUlNIdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd12umvp6RJ9eBitgmVydRB+HnKB7edHikH+RijMipx4T7dG4y
	oc+1y5METv1C72J9HSarHgJn0jUXyxOXnoHxJoMNjGph1SRh0eE6gbmK
X-Gm-Gg: AR+sD11gE/kcgghQZILr+gXAPwENhQhViRG66jnFq+1L2h9RbH5FSH8e2sZeCEiDn/W
	za5IaJ+hJxFoqNGURjxrykMFfJxQwJuVoGZDR5zRnyZmEr7LD36vrtnfD2BOx2QtJ+jrSPHQY06
	RjTauYTHor7Eft6UBVBHTtQmVILDKUDGRx0vsuqlNcXZDGM38fNLgSWe0EWCewPpEnqZZUXNsmK
	5/ebR+UXg68Nz9Tw+YMNvw/7emrM4WR583z6FV08P1ESZPfp0ELYTX0iMaYDRJQwpdbBLcUO3gq
	/1ygaRMQo2xVKYNlZIBBGqhbPUWEnJUgmayvhGjPtdTmGNQgeKN4WK3duUw7Dqq0SGhIpeB4Gy4
	Nw1X8uyEItrenv42wPsgSRLTzCLEEBlWQ+2/8ZRmvxC4E916KQgzqMULVtcvN3n2DsxJH/GFWku
	75YZ8Yaof+Zd8rTUPal72AJIgEPs/5uXCzEaCR3ieAAyegoHCc6Qh3ihiJaxCUkdG+EIvyTa2iK
	vejjwauQhR+a0j2FPiTu7su/oo/yD7Fm3IOAZs6AlC2HTmF1GwJRVJzsNb4ZCEDwHE4kBXyiqeE
	6Q7Jco1vDX7f/YjT9fy/i+w=
X-Received: by 2002:a05:6a20:1609:b0:3c1:657:4c95 with SMTP id adf61e73a8af0-3cc71ae4f6amr34464161637.15.1787038493557;
        Tue, 18 Aug 2026 00:34:53 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([14.137.23.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c3876c9sm14307366eec.24.2026.08.18.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:34:52 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Kees Cook <kees@kernel.org>,
	Shengyu Qu <wiagn233@outlook.com>,
	Kyohei Kadota <lufia@lufia.org>,
	Elliot Tester <elliotctester@gmail.com>
Cc: Dmitriy Zharov <contact@zharov.dev>,
	Zoltan Illes <zoliviragh@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8] xpad: Overhaul device data for wireless devices
Date: Tue, 18 Aug 2026 19:32:00 +1200
Message-ID: <20260818073159.909188-4-sanjay.govind9@gmail.com>
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
v2: Delay marking device as present until after capabilities or timeout
v3: Fix issues when receiving incorrect or missing link and capabilities reports
v4: Clear wireless state when processing device prescence change
v5: Fix typo, fix some potential race conditions with work scheduling
v6: Fix typo, address potential time-of-check time-of-use issues with presence work
v7: Explicitly check if the input device has been initialized already when processing presence changes
v8: Clear presence state when suspending, always clear x360w flags when calling xpad_deinit_input
 drivers/input/joystick/xpad.c | 210 ++++++++++++++++++++++++++++++----
 1 file changed, 189 insertions(+), 21 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2da0b7f1722a..4abc57a72524 100644
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
@@ -1923,6 +2033,11 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 
 static void xpad_deinit_input(struct usb_xpad *xpad)
 {
+	xpad->wireless_vid = 0;
+	xpad->wireless_pid = 0;
+	xpad->wireless_version = 0;
+	xpad->flags = 0;
+	xpad->sub_type = 0;
 	if (xpad->input_created) {
 		xpad->input_created = false;
 		xpad_led_disconnect(xpad);
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
@@ -2267,6 +2434,7 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 */
 		if (auto_poweroff && xpad->pad_present)
 			xpad360w_poweroff_controller(xpad);
+		xpad->pad_present = false;
 	} else {
 		guard(mutex)(&input->mutex);
 
-- 
2.55.0

