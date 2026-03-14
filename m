Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F61275B18
	for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773474690; cv=none; b=HWYoFe19xPVLmpAgeny+VHLfPPO7biaWCuh+3FkrHiZSE27QHGYikUIRRndkBVxhTg8kgC6pdGW9TWZgKStmf5sDHCcKWaub8xLjMQIFU7WEhElC4AxL0Htsn5dvmq9GOycb5kRhEASVXa1bhBHHmUeg4QI70mGJxd+Os8EApz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773474690; c=relaxed/simple;
	bh=2F8H55rYZ/j2cKInESmasrnF63FUKxVPCPnL+zkPMYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWaFLYqAamhhSUwgFK7Fb7RuQD2pdHyPGL0u0aDzCkZHPS0f26axNDu0t6eITLdltp3o3rBj42NzfnBtGmeq373DoMsFnaE5iE+AGGqLk/xcqLoqJOQ7gCY5+T5rHgcQ4jghsPupDCd6kqEPHxlnZOFRFeVim4ze8nMwfRjBhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7X1rr1w; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7X1rr1w"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1368647a12.1
        for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773474688; x=1774079488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U45jrujbw5JJI0xF9tm4sefL6UUjJiPpRTs8obNU44E=;
        b=l7X1rr1wbB/KLWcjxdD+evIl38o0XfHBqrGtABhrPtMjWFexhNOMwfYPkIBijHVAVx
         PAfhpTNIiP5wjy7e522xKYBAbWQrtRxq5JPyk4rr7jLY2eBKe06MkFLNWE+PZocMquL/
         3ft/6KltiiPUGjgcLc8RD3YDQqSjS+XZiOsUzIPswa9eNAh/zvUBLmMrT/tZUD68vxM2
         9fQ9GaLTkr6NyvlUaQb/C19f1BYE96HCJULPmCu5cPmXbpDQPcDdW76Sp0QSM4w2FE0x
         DcDQt07B/4pHxiTe3kSG6jgSX3LHWkJYoeCFuDaHFGcSMIB2vlzy5odhEIYxEivuV9MD
         Po/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773474688; x=1774079488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U45jrujbw5JJI0xF9tm4sefL6UUjJiPpRTs8obNU44E=;
        b=cqNYdmougtWEp4mMsWEKvgZg0TsamEg2PCXYXEWCGtuq82gOLXzG30ne17TJGzKzOs
         XJ/ok9GI2rODiUl3Rq/paEadNBFjzInq5fbjFDvMKjiPFQdH00EuxMOKrMIe1BLHcDv0
         6ukfLjXIgxBxAPCL0pc7prBO3EtZEjc/c0O8Hm8dTnXPxHjinY63jhY3W8V4HrFWsK79
         TfkiFPSu0ZhTySC/4UiqmIwl5tIrtYeSYQERvs3IQ5Z0P/FvoILiobHk/iLmLmKiFhtd
         V3FWC0HPv4x2158/nLYQFdFGBmTSkjqDSMfmPmPc97LJa/I7OKNg+Zkf4H1cgR08XNbE
         /pHw==
X-Forwarded-Encrypted: i=1; AJvYcCXU7ZQEOj7xD7nJ5EAef9o7JqiB+LyiyK3Bg3VdQSrJV0zH+kCYm/R9/tVNmBvsVLtUkho52G6L8bi9tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08VTVgfbxoLHdAvdGFCiQ5cC9K1O8u49MXFe/IZxE97nxO+vH
	XDl5hYvCy1JDVj/+NEMLAsvP570sojkNJLB4Z2NW4xu1YvOsU15eBR2O
X-Gm-Gg: ATEYQzyTSo0ce8absCvmPjaQ6R9pdNcOsj0qkpykafJGqGDEQD84BFtFZpsTfVZjfj3
	lW5uktFtglUFzdTGrK2KoTBrwXTtqSZ8cjIvR9DWp0ucUi0wrjMEng6PrPewDRW6G35jRy0+ZX7
	vDIpZmqcVGqN6CKbe2z4wkNA0WGuYj4rSKf3aAQ0aY9YIR7tmnMUuabuNt0uJQ7322s0rkhNl+z
	TrGMxFwFnHGTdmGz3gy/4L4ejh7KPJ3ZFRwtJ4QZvoS/UhoMRwLdkuQZw29Gn/qJd8ySVv2hXgB
	glmp1tdnWekUFYkBn0Vz9WbOQ2pdhEBwzoEDLthVGRTI0M8nBqrYP1KBVVTj0979j5wqh79hlBu
	YKI3dncmJ//ilbpus4q2M9HStoj4xJA/uvOS5ffMPk7IURnE6C9ZmoDi41ys5LopwbLa/BZfbvv
	0oao3jBmqa01sD1vE5SzEgmVX9pIyLvKilNvl7UJNiI0L3he22rwhAtvdtex0Y0KoB9LuKPTEaJ
	EyS2D3YxNCmCquVrNKAk+a/SsNzkb927IvFLu2XMjDwFrWldiHBxXr8KlBn40qu9lM=
X-Received: by 2002:a05:6a21:6f8b:b0:398:a440:e3bc with SMTP id adf61e73a8af0-398ecdfc03dmr5865315637.66.1773474687889;
        Sat, 14 Mar 2026 00:51:27 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([116.251.152.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb649a8sm3563670a12.18.2026.03.14.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 00:51:27 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Nilton Perim Neto <niltonperimneto@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xpad: Overhaul device data for wireless devices
Date: Sat, 14 Mar 2026 20:50:32 +1300
Message-ID: <20260314075034.1488655-2-sanjay.govind9@gmail.com>
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
 drivers/input/joystick/xpad.c | 138 +++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f581..2490eb21a534 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -94,6 +94,22 @@
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
@@ -795,6 +811,9 @@ struct usb_xpad {
 	int xtype;			/* type of xbox device */
 	int packet_type;		/* type of the extended packet */
 	int pad_nr;			/* the order x360 pads were attached */
+	u8 sub_type;
+	u16 flags;
+	u16 wireless_vid;
 	const char *name;		/* name of the device */
 	struct work_struct work;	/* init/remove device from callback */
 	time64_t mode_btn_down_ts;
@@ -807,6 +826,8 @@ static void xpad_deinit_input(struct usb_xpad *xpad);
 static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
+static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad);
+
 
 /*
  *	xpad_process_packet
@@ -1026,12 +1047,46 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 	if (data[0] & 0x08) {
 		present = (data[1] & 0x80) != 0;
 
-		if (xpad->pad_present != present) {
+		/* delay prescence until after we get the link report */
+		if (!present && xpad->pad_present) {
 			xpad->pad_present = present;
 			schedule_work(&xpad->work);
 		}
 	}
 
+	/* Link report */
+	if (data[0] == 0x00 && data[1] == 0x0F) {
+		xpad->sub_type = data[25] & 0x7f;
+
+		/* Decode vendor id from link report */
+		xpad->wireless_vid = ((data[0x16] & 0xf) | data[0x18] << 4) << 8 | data[0x17];
+
+		if ((data[25] & 0x80) != 0)
+			xpad->flags |= FLAG_FORCE_FEEDBACK;
+
+		if (!xpad->pad_present) {
+			xpad->pad_present = true;
+			schedule_work(&xpad->work);
+		}
+		xpad_inquiry_pad_capabilities(xpad);
+	}
+
+	/* Capabilities report */
+	if (data[0] == 0x00 && data[1] == 0x05 && data[5] == 0x12) {
+		xpad->flags |= data[20];
+		/*
+		 * A bunch of vendors started putting vids and pids
+		 * into capabilities data because they can't be
+		 * retrieved by xinput easliy.
+		 * Not all of them do though, so check the vids match
+		 * before extracting that info.
+		 */
+		if (((data[11] << 8) | data[10]) == xpad->wireless_vid) {
+			xpad->dev->id.product = (data[13] << 8) | data[12];
+			xpad->dev->id.version = (data[15] << 8) | data[14];
+		}
+	}
+
 	/* Valid pad data */
 	if (data[1] != 0x1)
 		return;
@@ -1495,6 +1550,31 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
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
@@ -1965,8 +2045,60 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	usb_to_input_id(xpad->udev, &input_dev->id);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		/* x360w controllers and the receiver have different ids */
-		input_dev->id.product = 0x02a1;
+		/*
+		 * x360w controllers on windows put the subtype into the product
+		 * for wheels and gamepads, but it makes sense to do it for all
+		 * subtypes
+		 */
+		input_dev->id.product = 0x02a0 + xpad->sub_type;
+		/* If the Link report has provided a vid, it won't be set to 1 */
+		if (xpad->wireless_vid != 1)
+			input_dev->id.vendor = xpad->wireless_vid;
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
-- 
2.53.0

