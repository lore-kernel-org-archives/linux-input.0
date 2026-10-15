Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4A374E6C
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101756; cv=none; b=BxwD4r7yRSEBh1M7jR64MdJwBkAxAu7OHlrkOYxyNlob04Zh8N3Mj5bLUh59YqfRMBYKXtrTim6LVQUxUYmcPSexOxqwx2t3N1lf01soZmYJmZxMLnCi1FSmll3uRJWlAoTKown/qer39ycp8u9QoFdLpUYeWNl5C4+Z90dEVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101756; c=relaxed/simple;
	bh=S8eHpVUS6B61VROw/dxrUELqWDGGjjBFU22H9OLDhYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=le7gcL4TZUChcEb4w147OvBRx9BWWqNQR+ltgcUw/tm8wEPvcl8GFH8RfpfN1oSMMtH5VmO68cPglTOUY762u0yVEYekPq3ubjK3/wm69yYi5Ca1LolaggF9EqeRRzseD557hf5s11caxagvZglHdQhxWEVaFFTnOVJA4dNJG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCKiCilY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCKiCilY"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd623dfe420so1993734a12.0
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792101752; x=1792706552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMcSJ6B46gotcrtc8p7TVxbrxHOM0hhS7qPLqCwKo28=;
        b=MCKiCilYaqn0A5wUnAwQaxbQAOUHIGFZyjir+yjWxpo4rkoD5DD/J5b8ecRHEJJXDh
         aJKRNdQnpr+HBHECt3DsFHcxGmi6Ode5l99jnAt6nea3fCyxo06hGOvXXEWV2pbUUR0o
         nvfNHLyJ4s1JLtS3B3qmD7z1RM5Fij0F32ysTZD1IonqRkDYmYEfWIgxM+MGuTtcyECK
         iCJ2JgHuY7rBVU3aM6CFyiD+sZgHXb5QJgNXGaH16crxko3yyBZVWuZVFD31XCJs7DWZ
         9lP0T+SfBduaRFSNBIAX1aqjkzim0kEDOZ/2cMeEBcOW77zbn0zyEhC72TivFw16koQd
         lIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101752; x=1792706552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMcSJ6B46gotcrtc8p7TVxbrxHOM0hhS7qPLqCwKo28=;
        b=2NeX+5bejhKHBZTiTU5yd+hiEKzthYbEmK3ReF0YhktyyP5MfT53pGwNCcO3LNb827
         KxIZIUP8zErw7XYfp8fhY07oShEXafArjkaypkkmQ1zMY3qIPJZANRgOGoOldhckN+Sv
         nTc2ihL2B+n/6cXEy8OIcOGCS+MM2ZJBG4Ds1v2P+cc2z9VaYyPbVrh3puLaWZN5KroC
         X7GEi9H3DNUW6SgNEZZ4aLq+hyOW6fuBdGfVuFDDM80lbDgNzQZp52kJg4AzcKhUfPme
         Zl6ISSq1lTnP8o2wg0z3ElA+kWx2dVtpPKoyBx71CYQSXwhujzBAjCrhJ4FylZ+1ACWx
         90VA==
X-Forwarded-Encrypted: i=1; AKwUvBwng/gc0BB9u8SIyElsZ5f9QAOe61Uk5XQav4rsObUt/KIqzZVVlgip6jYpBGbg03Yo1pQKIzQ1YpVqcA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLpJRvknnclTfqKjK9NlQ0umQ75xsPyid+yQo1Q8n7X63ikvwWk
	qCDTVNwIlMaOvns7kqETUh/zIWT/loLxxGcTWN11B3DJJ19PoN1SOiYY
X-Gm-Gg: AYBFou3kLCAX2jem1uBtUE1Y+5EMxpQrgdH4CJL1gqauRoEHqgckKH24bzm6sppRPAq
	vT+X1/zGC+vIvqTMB2YPrNIAnrGbFkcYbWr6+GrjI4LRZEWCbO5v6oyU/uaAJJAsrAyzvy5zlDt
	jCoXOrf9M1yFzX4mUKPf2wfQP3wWqavFkx/00P751QYARaIKTeas8s2qNGGbDfrwBd7L2aSPhqC
	SRup+s1okNZdPKO51Pb9thkEmaBJ/EtuxwimAJorcUZfWheTmGepyiXGJGZXxuWUn/yLxHMcDBX
	NVicTUpDe/XYhTIsN+LyJ3HhgjKhlIV7FS+EbRrG+lQDO5kGB9XPI10BI0BkfbtnCmnb7DsodQR
	4CTllDF68rwqA8QJ+xA1iAbE+dxw4qnLxth4aKLvbH5XGA4KhIYNZ/JZ4OTPgWSAlcxBJgRoFMw
	CPCpGSRhVFQ5Vjbp9t7OONpMh6lG/xJMLaDihOqVzZyZUROuNqGr6ORVIsLeDeDwpwf+LD5IPGL
	jXBxb+X5w1/5DXtA2c9vVleCHKXYJ/FnncsqiwdSkp1+CQ2fkv+vb6tFSOdu+NXSDqq4Ho+b01Q
	60T7aGq7e4teVq0IdOgacJzDzDQfTZOLIzQ=
X-Received: by 2002:a17:90b:4f4c:b0:3ac:7377:fd48 with SMTP id 98e67ed59e1d1-3ac73780712mr5865531a91.56.1792101752340;
        Thu, 15 Oct 2026 15:02:32 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([139.180.93.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm6055580a91.14.2026.10.15.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 15:02:31 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Kees Cook <kees@kernel.org>,
	Shengyu Qu <wiagn233@outlook.com>,
	Kyohei Kadota <lufia@lufia.org>,
	Elliot Tester <elliotctester@gmail.com>,
	Dmitriy Zharov <contact@zharov.dev>,
	Zoltan Illes <zoliviragh@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: [PATCH v9] xpad: Overhaul device data for wireless devices
Date: Fri, 16 Oct 2026 11:01:28 +1300
Message-ID: <20261015220126.102766-3-sanjay.govind9@gmail.com>
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

To make sure this information is available when the input device is
created, delay creating it until 500ms after the pad is reported as
present. Some devices never send a capabilities report, so the
timeout ensures they are still initialized.

Note that this changes the ids reported to userspace: wireless pads
were previously all reported as 045e:02a1. They now report the pad's
own vendor id, and a product id of 0x02a0 + subtype, unless the pad
provides its own product id in its capabilities data. This matches
Windows for gamepads (0x02a1) and wheels (0x02a2). Windows reports
all other subtypes as 0x02a9, but as Linux has no other way to expose
the xinput subtype to userspace, the subtype is kept in the product
id for those too. SDL has already been updated to handle this:
https://github.com/libsdl-org/SDL/commit/fdc5efe1cbbcbffda016fbab9d5d9083ba040470

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
v2: Delay marking device as present until after capabilities or timeout
v3: Fix issues when receiving incorrect or missing link and capabilities reports
v4: Clear wireless state when processing device prescence change
v5: Fix typo, fix some potential race conditions with work scheduling
v6: Fix typo, address potential time-of-check time-of-use issues with presence work
v7: Explicitly check if the input device has been initialized already when processing presence changes
v8: Clear presence state when suspending, always clear x360w flags when calling xpad_deinit_input
    https://lore.kernel.org/linux-input/20260818073159.909188-4-sanjay.govind9@gmail.com/
v9: Track a pad generation so a pad that is replaced before the presence
    work runs gets a fresh input device instead of keeping the old one.
    Clear x360w state on the disconnect event rather than in
    xpad_deinit_input, so it can't wipe a new pad's link report.
    Reschedule presence work whenever the input device doesn't match the
    presence state, replacing the v8 suspend change.
    Only take pid/version from the capabilities report when the link
    report provided a vid. Send the capabilities request from its own
    output packet slot. Mask the high vid nibble.
---
 drivers/input/joystick/xpad.c | 241 ++++++++++++++++++++++++++++++----
 1 file changed, 219 insertions(+), 22 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..bcad597b29b4 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/usb/input.h>
 #include <linux/usb/quirks.h>
 
@@ -60,6 +61,26 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+/*
+ * Capability flags reported by x360w pads. Bit 0 matches
+ * XINPUT_CAPS_FFB_SUPPORTED, which is also set from the link report.
+ */
+#define FLAG_FORCE_FEEDBACK	0x01
+
+#define SUBTYPE_GAMEPAD			0x01
+#define SUBTYPE_WHEEL			0x02
+#define SUBTYPE_ARCADE_STICK		0x03
+#define SUBTYPE_FLIGHT_STICK		0x04
+#define SUBTYPE_DANCE_PAD		0x05
+#define SUBTYPE_GUITAR			0x06
+#define SUBTYPE_GUITAR_ALTERNATE	0x07
+#define SUBTYPE_DRUM_KIT		0x08
+#define SUBTYPE_GUITAR_BASS		0x0B
+#define SUBTYPE_RB_KEYBOARD		0x0F
+#define SUBTYPE_ARCADE_PAD		0x13
+#define SUBTYPE_TURNTABLE		0x17
+#define SUBTYPE_PRO_GUITAR		0x19
+
 /* Send power-off packet to xpad360w after holding the mode button for this many
  * seconds
  */
@@ -734,9 +755,10 @@ struct xpad_output_packet {
 #define XPAD_OUT_CMD_IDX	0
 #define XPAD_OUT_FF_IDX		1
 #define XPAD_OUT_LED_IDX	(1 + IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF))
-#define XPAD_NUM_OUT_PACKETS	(1 + \
+#define XPAD_OUT_CAPS_IDX	(1 + \
 				 IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF) + \
 				 IS_ENABLED(CONFIG_JOYSTICK_XPAD_LEDS))
+#define XPAD_NUM_OUT_PACKETS	(XPAD_OUT_CAPS_IDX + 1)
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
@@ -746,6 +768,8 @@ struct usb_xpad {
 
 	bool pad_present;
 	bool input_created;
+	unsigned int pad_gen;		/* bumped every time an x360w pad goes away */
+	unsigned int input_gen;		/* pad_gen the input device was created for */
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
@@ -773,8 +797,13 @@ struct usb_xpad {
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
@@ -785,6 +814,7 @@ static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
 
 /*
  *	xpad_process_packet
@@ -958,19 +988,16 @@ static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 
 static void xpad_presence_work(struct work_struct *work)
 {
-	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work.work);
+	unsigned int gen;
 	int error;
 
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
+	/*
+	 * Tear down the input device if the pad went away, or if it was
+	 * replaced by a (possibly different) pad since the device was created.
+	 */
+	if (xpad->input_created &&
+	    (!xpad->pad_present || xpad->input_gen != READ_ONCE(xpad->pad_gen))) {
 		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
 		synchronize_rcu();
 		/*
@@ -979,6 +1006,19 @@ static void xpad_presence_work(struct work_struct *work)
 		 */
 		xpad_deinit_input(xpad);
 	}
+
+	if (xpad->pad_present && !xpad->input_created) {
+		gen = READ_ONCE(xpad->pad_gen);
+		error = xpad_init_input(xpad);
+		if (error) {
+			/* complain only, not much else we can do here */
+			dev_err(&xpad->intf->dev,
+				"unable to init device: %d\n", error);
+		} else {
+			xpad->input_gen = gen;
+			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
+		}
+	}
 }
 
 /*
@@ -995,18 +1035,98 @@ static void xpad_presence_work(struct work_struct *work)
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
 		present = (data[1] & 0x80) != 0;
 
-		if (xpad->pad_present != present) {
+		if (xpad->pad_present && !present) {
+			/* Forget everything we learned about the old pad */
+			WRITE_ONCE(xpad->pad_gen, xpad->pad_gen + 1);
+			xpad->sub_type = 0;
+			xpad->flags = 0;
+			xpad->wireless_vid = 0;
+			xpad->wireless_pid = 0;
+			xpad->wireless_version = 0;
+		}
+
+		/*
+		 * Also reschedule if the input device does not match the
+		 * presence state, e.g. because pending work was cancelled
+		 * on suspend.
+		 */
+		if (xpad->pad_present != present ||
+		    xpad->input_created != present) {
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
+		parsed_vid = ((data[0x16] & 0xf) | (data[0x18] & 0xf) << 4) << 8 |
+			     data[0x17];
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
+		xpad->flags = 0;
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
+		 * retrieved by xinput easily.
+		 * Not all of them do though, so check the vids match
+		 * before extracting that info. A vid of 0 means the link
+		 * report did not provide one, so there is nothing to match.
+		 */
+		if (xpad->wireless_vid &&
+		    get_unaligned_le16(data + 10) == xpad->wireless_vid &&
+		    get_unaligned_le16(data + 12)) {
+			xpad->wireless_pid = get_unaligned_le16(data + 12);
+			xpad->wireless_version = get_unaligned_le16(data + 14);
 		}
 	}
 
@@ -1232,7 +1352,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
@@ -1473,6 +1593,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 	return xpad_try_sending_next_out_packet(xpad);
 }
 
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad)
+{
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CAPS_IDX];
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
@@ -1870,8 +2015,8 @@ static void xpad360w_stop_input(struct usb_xpad *xpad)
 {
 	usb_kill_urb(xpad->irq_in);
 
-	/* Make sure we are done with presence work if it was scheduled */
-	flush_work(&xpad->work);
+	/* Cancel any pending presence work */
+	cancel_delayed_work_sync(&xpad->work);
 }
 
 static int xpad_open(struct input_dev *dev)
@@ -1943,8 +2088,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
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
@@ -2084,7 +2281,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->delay_init = true;
 
 	xpad->packet_type = PKT_XB;
-	INIT_WORK(&xpad->work, xpad_presence_work);
+	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {

base-commit: 29ee387509a184c3bfff9e26831aacc7b2edc02a
-- 
2.55.0

