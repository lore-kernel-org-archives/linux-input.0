Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF380FE3
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238821; cv=none; b=VjlCdgBfD44NUGKS2DhveaOabTOCIOFQxcDkRXn5/RT1vM5Uu2e427kxJCXK18c39E7YRutKWK7AZiy8fTxbAoz753qctV9jhnEaY3D+Vi24+A0cklmoWYK4yrT2JNgtnC9tDNHc2Gki+B7ifkJf089Bpu6HMseEhqTWeKVrNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238821; c=relaxed/simple;
	bh=Sbm/fPSO/OowzxSNV6zi0aDU42cLOUdY3i17kKcBHKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK4LGpwSk/gAp14GwpFdCgxjovYDvr6fIZYJefv14/QIdIXzlFtUbLw1WRFwrlLZhEix1sXUuLyvpASda++moovMuPToca7e0cH6ld7Wk2WagugqAik+EyHB+QMtXJ7eDSCg4/OFIAbDjLW0EhNmX6yJFROQ/ioteHdQ23pA1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTx0Oxsc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTx0Oxsc"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebd52488cso2638591e87.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238817; x=1787843617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWnrIk20T6fTLYmK9j7MbAAAQibqvLV5mGakVK14x7I=;
        b=nTx0OxscUEUBK/SRrfDZ98IzbjgwTXaYkg3iJaNdlSESwy/sQ0LYcXA9lzSbnM+Erz
         /7sopCG60OoCyn+eA+9VTx0euG2FypPt2rSNlvVFr6r98SktSo0RtXPMyd3QmRVdGg6f
         UnSujz9XUVWNGW4dYgxOGcvVcFptS27szZn3OQ4z+juCFYc+RqbL8kFMMW2TwwK0NznA
         NavIyfvhRM3yryMJA9Uai/sdT86TSaMSf2fCa+l2HV/rm5txyjDAs4/KaR0ag0NdZ+R6
         nOX+E6/fbBrXwhPx3t3O062pC2Innan9alhRHIRqiRlSblGBzF5tbyrsUHShA0EwzOlA
         7zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238817; x=1787843617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWnrIk20T6fTLYmK9j7MbAAAQibqvLV5mGakVK14x7I=;
        b=TCaKVpMUJGMA3tgyYBraaFP4R32NiG3jPy8s8LN4vvnwsQepOayJf/8/wLlRGhjzMw
         hPQQzUgndR8VguCty6WqQE4B8NZMZ+Flgd/I5i/ZnCu2J0uhgGnd3ILzR/uVzJhtWiqA
         /tve8Pb0am4llQ/9JPJA6lcj7ZIOqthd0oeZ610eVU2/SW/jPfH6EGbrpXKpaEJ+57MC
         GHlEbrNQmOt4k8QhmJUYJmX+30F/KQhmvnYXtFRkZsBjRPcSypVy/Cygh8pKnsi/8dF3
         ynflDiLFvltMQ0z+RIN6gK9m90h8OtH/GtNTAoIqHlnOlneNhzwyhqcsMLLNmvwG5c85
         6wSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJy6Lz5AHN3rW+pIVcLgXJtTw8ozLxUMCU+c+3v/iVvPVdGOUY7QL2QQ9CdFbI26eHs5R6z1wCAyZxBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaRkiflhBqflFt8dnWNUJptpNY8oZ0mp1T21Ny8QUONyUwKli
	QpKxjmiqmY/4v9XKfCRlCHW9R12YH5/6+OfKQDpUD6C5DjdgSbPufFX5
X-Gm-Gg: AR+sD10Ma/zUCQNgYJsd1yhuMVZX1U8AvGSdbCvrvqT9+kGb3jYou87m5SPNec6cHbS
	ZsME4DQFcR9UHlToLfafXTeimIuZ/7wVvXT8k274C+u8eCXFhwil87yCPazc1qsTLP1grfYn4zw
	ATQ5d/1numbBGIcuBfvzQvd7xpTBYNfTKXFxZZuAv/Uz3xVnysL1Am0/6UBOnmozrapkYWERfkG
	PrXfEYjDG85KSI6AN3dwzSj6Tj6w+uGnVaYKnS6ZZYoWZAGZnHkOThzxLdWk7XVz3UBCPet6vbS
	TJUa+czm1RG8RMJkAi+grI9T1436WA/ppFgzwgjF6Ovq95XeUGIzM42pKxLSku8jfVvegUb2vCf
	MyR7WWxpIA7awrxihWFitIii5JuoQeLqLHHwVCDZLOG7I8NziAHaaKU6wY2a13jO8DcyFdakIa/
	4srz5EiDr2ZZo2FEgcOL0ZDFrbm43liCxPs4zIVLhz1oK5Q3+lDKj4BXaGa41EtqliQn57GYANo
	+kLMuyLsvzJVcYESl6MbZhD6rlmIA5H69hJLyGGEQ12WAeTLruxOt5eu5AG
X-Received: by 2002:a05:6512:10cf:b0:5ae:b260:cf47 with SMTP id 2adb3069b0e04-5b4789448cdmr4757847e87.10.1787238817106;
        Thu, 20 Aug 2026 08:13:37 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788f5a60sm1333617e87.77.2026.08.20.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:13:36 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [RFC 2/2] HID: topping: driver for the M62's vendor control channel
Date: Thu, 20 Aug 2026 20:13:29 +0500
Message-ID: <20260820151329.18332-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
References: <87y0eaxz39.wl-tiwai@suse.de>
 <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alternative to doing this as a snd-usb-audio mixer quirk, written
so the two can be compared rather than argued about.

The device and the protocol are the same: fifteen-byte frames carrying
a target, a property and a signed value, CRC-16/MODBUS over the middle,
one write to subscribe and one to make the device announce its state,
after which every change arrives unasked, front panel presses included.
That part is if anything smaller here than in the quirk -- usbhid owns
the endpoints, so hid_hw_output_report replaces a hand-built interrupt
URB out and raw_event replaces the one in, and the interface needs no
claiming because this driver is what binds to it. The control table is
identical, so adding a knob is still adding a row.

WHERE THIS ROAD RUNS OUT is the reason to write it. These are mixer
controls for an audio device, and the audio device's card belongs to
snd-usb-audio. A HID driver cannot put an element there: there is no
interface for it, and inventing one means exporting from sound/usb both
a lookup from struct usb_device to the card and an add-element call --
and then answering, for a single device, what happens when the two
drivers probe in either order, and when either disconnects first, given
that the element would live in one module and its private data in
another.

So this driver does what a HID driver can do alone: it registers a card
of its own. That works, and the cost is visible from userspace rather
than theoretical -- one physical device appears as two cards, the gains
land on a card with no PCM beside them, and anything that looks for a
device's mixer next to its streams (alsamixer -c, UCM profiles,
PipeWire's device model) does not find them there.

hid_hw_start is called with no connect mask on purpose. The report
descriptor is a Generic Desktop application collection with eight
unnamed usages and no report ID, so hid-generic would build an input
device for a mouse that does not exist.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 MAINTAINERS               |   6 +
 drivers/hid/Kconfig       |  13 ++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-topping.c | 382 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 405 insertions(+)
 create mode 100644 drivers/hid/hid-topping.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2b7ed2..ec302fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27349,6 +27349,12 @@ S:	Maintained
 W:	https://tomoyo.sourceforge.net/
 F:	security/tomoyo/
 
+TOPPING M62 HID CONTROL DRIVER
+M:	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-topping.c
+
 TOPSTAR LAPTOP EXTRAS DRIVER
 M:	Herton Ronaldo Krzesinski <herton@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index aa7fa11..712390a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1283,6 +1283,19 @@ config HID_TIVO
 	help
 	Say Y if you have a TiVo Slide Bluetooth remote control.
 
+config HID_TOPPING
+	tristate "Topping M62 vendor control channel"
+	depends on USB_HID
+	depends on SND
+	help
+	  Say Y here if you have a Topping M62 audio interface and want
+	  its analogue input gains and output volumes as ALSA mixer
+	  controls. The device keeps them behind a vendor protocol on a
+	  HID interface and exposes none of them through USB audio.
+
+	  Note that the controls appear on a card of this driver's own,
+	  not on the card snd-usb-audio creates for the same device.
+
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink, BTC Emprex, Conceptronic remote control support"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b..6e1f8fc 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o hid-thrustmaster.o
 obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
+obj-$(CONFIG_HID_TOPPING)	+= hid-topping.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TOPRE)	+= hid-topre.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 341bf58..092b2a9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1470,6 +1470,9 @@
 #define USB_DEVICE_ID_TIVO_SLIDE	0x1201
 #define USB_DEVICE_ID_TIVO_SLIDE_PRO	0x1203
 
+#define USB_VENDOR_ID_TOPPING		0x152a
+#define USB_DEVICE_ID_TOPPING_M62	0x875c
+
 #define USB_VENDOR_ID_TOPRE			0x0853
 #define USB_DEVICE_ID_TOPRE_REALFORCE_R2_108			0x0148
 #define USB_DEVICE_ID_TOPRE_REALFORCE_R2_87			0x0146
diff --git a/drivers/hid/hid-topping.c b/drivers/hid/hid-topping.c
new file mode 100644
index 0000000..9d58bce
--- /dev/null
+++ b/drivers/hid/hid-topping.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for the Topping M62's vendor control channel
+ *
+ * Copyright (c) 2026 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+ *
+ * The same device and the same protocol as the snd-usb-audio mixer
+ * quirk this is meant to be compared against; only the road differs.
+ * Here the vendor channel is taken as what it claims to be -- a HID
+ * interface -- and the driver rides usbhid instead of claiming the
+ * interface for the audio driver.
+ *
+ * The protocol: fifteen-byte frames,
+ *
+ *	22 33 | 20 01 01 | TT | PP | s32 value BE | CRC16 BE | 66 77
+ *
+ * a target TT, a property PP of it, CRC-16/MODBUS over bytes 2..10
+ * stored big-endian. Reports arriving are the same plus a pad byte.
+ * One write of 0x11/0x24 subscribes, one of 0x11/0x26 makes the device
+ * announce its whole state, and every later change arrives unasked,
+ * including a front panel press.
+ *
+ * WHERE THIS ROAD RUNS OUT, which is the point of writing it: these
+ * are mixer controls for an audio device, and the audio device's card
+ * belongs to snd-usb-audio. A HID driver cannot put a control there.
+ * There is no interface for it, and inventing one means exporting from
+ * sound/usb both a way to find the card behind a struct usb_device and
+ * a way to add an element to it -- and then answering, for a single
+ * device, what happens when the two drivers probe in either order and
+ * when either disconnects first, since the control's private data
+ * would live in this module while the element lives in that card.
+ *
+ * So this driver does what a HID driver CAN do by itself: it makes a
+ * card of its own. That works, and it is exactly the wart to weigh --
+ * one physical device shows up twice in userspace, the gains land on a
+ * card that has no PCM, and anything that looks for a device's mixer
+ * beside its streams (alsamixer -c, UCM, PipeWire) does not find them
+ * there.
+ */
+
+#include <linux/crc16.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "hid-ids.h"
+
+#define TOPPING_FRAME_LEN	15
+#define TOPPING_REPORT_LEN	16
+
+#define TOPPING_TT_DEVICE	0x11
+#define TOPPING_PP_SUBSCRIBE	0x24
+#define TOPPING_PP_ANNOUNCE	0x26
+
+static const DECLARE_TLV_DB_SCALE(topping_tlv_gain, 0, 100, 0);
+
+static const unsigned int topping_tlv_out_9[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0, 0, SNDRV_CTL_TLVD_DB_SCALE_ITEM(SNDRV_CTL_TLVD_DB_GAIN_MUTE, 0, 1),
+	1, 19, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-8800, 200, 0),
+	20, 61, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5100, 100, 0),
+	62, 99, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-950, 50, 0),
+};
+
+static const unsigned int topping_tlv_out_0[] = {
+	TLV_DB_RANGE_HEAD(3),
+	0, 0, SNDRV_CTL_TLVD_DB_SCALE_ITEM(SNDRV_CTL_TLVD_DB_GAIN_MUTE, 0, 1),
+	1, 79, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-8800, 100, 0),
+	80, 99, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-950, 50, 0),
+};
+
+/* identical to the quirk's: a knob is a row */
+struct topping_ctl_desc {
+	const char *name;
+	u8 target;
+	u8 target_pair;
+	u8 prop;
+	int min, max;
+	const unsigned int *tlv;
+};
+
+static const struct topping_ctl_desc topping_m62_ctls[] = {
+	{ "Mic-1 Analog Capture Volume", 0x21, 0, 0x04, 0, 88,
+	  topping_tlv_gain },
+	{ "Mic-2 Analog Capture Volume", 0x22, 0, 0x04, 0, 88,
+	  topping_tlv_gain },
+	{ "Aux Capture Volume", 0x23, 0, 0x04, 0, 99,
+	  topping_tlv_out_9 },
+	{ "Bluetooth Capture Volume", 0x25, 0, 0x04, 0, 99,
+	  topping_tlv_out_0 },
+	{ "Headphone Playback Volume", 0x64, 0x63, 0x03, 0, 99,
+	  topping_tlv_out_9 },
+	{ "OTG Playback Volume", 0x62, 0x61, 0x03, 0, 99,
+	  topping_tlv_out_0 },
+};
+
+#define TOPPING_NUM_CTLS	ARRAY_SIZE(topping_m62_ctls)
+
+struct topping_hid {
+	struct hid_device *hdev;
+	struct snd_card *card;
+	spinlock_t lock;	/* guards val[] against raw_event */
+	int val[TOPPING_NUM_CTLS];
+	struct snd_kcontrol *kctl[TOPPING_NUM_CTLS];
+};
+
+static void topping_build(u8 *f, u8 target, u8 prop, s32 value)
+{
+	f[0] = 0x22;
+	f[1] = 0x33;
+	f[2] = 0x20;
+	f[3] = 0x01;
+	f[4] = 0x01;
+	f[5] = target;
+	f[6] = prop;
+	put_unaligned_be32(value, f + 7);
+	put_unaligned_be16(crc16(0xffff, f + 2, 9), f + 11);
+	f[13] = 0x66;
+	f[14] = 0x77;
+}
+
+static int topping_send(struct topping_hid *th, u8 target, u8 prop,
+			s32 value)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(TOPPING_FRAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	topping_build(buf, target, prop, value);
+	err = hid_hw_output_report(th->hdev, buf, TOPPING_FRAME_LEN);
+	kfree(buf);
+	if (err < 0)
+		hid_err(th->hdev, "write %02x/%02x failed: %d\n",
+			target, prop, err);
+	return err;
+}
+
+static int topping_index_of(u8 target, u8 prop)
+{
+	int i;
+
+	for (i = 0; i < TOPPING_NUM_CTLS; i++)
+		if (topping_m62_ctls[i].target == target &&
+		    topping_m62_ctls[i].prop == prop)
+			return i;
+	return -1;
+}
+
+static int topping_raw_event(struct hid_device *hdev,
+			     struct hid_report *report, u8 *f, int size)
+{
+	struct topping_hid *th = hid_get_drvdata(hdev);
+	unsigned long flags;
+	int idx, value;
+
+	if (size < TOPPING_FRAME_LEN)
+		return 0;
+	if (f[0] != 0x22 || f[1] != 0x33 || f[13] != 0x66 || f[14] != 0x77)
+		return 0;
+	if (get_unaligned_be16(f + 11) != crc16(0xffff, f + 2, 9))
+		return 0;
+
+	idx = topping_index_of(f[5], f[6]);
+	if (idx < 0)
+		return 0;
+
+	value = get_unaligned_be32(f + 7);
+	if (value < topping_m62_ctls[idx].min ||
+	    value > topping_m62_ctls[idx].max)
+		return 0;
+
+	spin_lock_irqsave(&th->lock, flags);
+	if (th->val[idx] == value) {
+		spin_unlock_irqrestore(&th->lock, flags);
+		return 0;
+	}
+	th->val[idx] = value;
+	spin_unlock_irqrestore(&th->lock, flags);
+
+	if (th->kctl[idx])
+		snd_ctl_notify(th->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &th->kctl[idx]->id);
+	return 0;
+}
+
+static int topping_ctl_info(struct snd_kcontrol *kctl,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	int idx = kctl->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = topping_m62_ctls[idx].min;
+	uinfo->value.integer.max = topping_m62_ctls[idx].max;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int topping_ctl_get(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct topping_hid *th = snd_kcontrol_chip(kctl);
+	unsigned long flags;
+
+	spin_lock_irqsave(&th->lock, flags);
+	ucontrol->value.integer.value[0] = th->val[kctl->private_value];
+	spin_unlock_irqrestore(&th->lock, flags);
+	return 0;
+}
+
+static int topping_ctl_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct topping_hid *th = snd_kcontrol_chip(kctl);
+	int idx = kctl->private_value;
+	const struct topping_ctl_desc *d = &topping_m62_ctls[idx];
+	unsigned long flags;
+	int value, err;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < d->min || value > d->max)
+		return -EINVAL;
+
+	spin_lock_irqsave(&th->lock, flags);
+	if (th->val[idx] == value) {
+		spin_unlock_irqrestore(&th->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&th->lock, flags);
+
+	err = topping_send(th, d->target, d->prop, value);
+	if (err < 0)
+		return err;
+	if (d->target_pair) {
+		err = topping_send(th, d->target_pair, d->prop, value);
+		if (err < 0)
+			return err;
+	}
+
+	spin_lock_irqsave(&th->lock, flags);
+	th->val[idx] = value;
+	spin_unlock_irqrestore(&th->lock, flags);
+	return 1;
+}
+
+static int topping_add_ctls(struct topping_hid *th)
+{
+	struct snd_kcontrol_new tmpl = {
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.info = topping_ctl_info,
+		.get = topping_ctl_get,
+		.put = topping_ctl_put,
+	};
+	struct snd_kcontrol *kctl;
+	int i, err;
+
+	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
+		tmpl.name = topping_m62_ctls[i].name;
+		tmpl.private_value = i;
+		tmpl.tlv.p = topping_m62_ctls[i].tlv;
+		kctl = snd_ctl_new1(&tmpl, th);
+		if (!kctl)
+			return -ENOMEM;
+		err = snd_ctl_add(th->card, kctl);
+		if (err < 0)
+			return err;
+		th->kctl[i] = kctl;
+	}
+	return 0;
+}
+
+static int topping_probe(struct hid_device *hdev,
+			 const struct hid_device_id *id)
+{
+	struct topping_hid *th;
+	int err;
+
+	th = devm_kzalloc(&hdev->dev, sizeof(*th), GFP_KERNEL);
+	if (!th)
+		return -ENOMEM;
+	th->hdev = hdev;
+	spin_lock_init(&th->lock);
+	hid_set_drvdata(hdev, th);
+
+	err = hid_parse(hdev);
+	if (err)
+		return err;
+
+	/*
+	 * No connect mask: the report descriptor describes a Generic
+	 * Desktop application collection with eight unnamed usages, so
+	 * letting hid-generic have it would create an input device for a
+	 * mouse that does not exist.
+	 */
+	err = hid_hw_start(hdev, 0);
+	if (err)
+		return err;
+
+	err = hid_hw_open(hdev);
+	if (err)
+		goto stop;
+
+	/*
+	 * A CARD OF ITS OWN, because the device's real card belongs to
+	 * snd-usb-audio and nothing lets an outside module add an
+	 * element to it. This is the cost of the HID road, and it is
+	 * visible from userspace: two cards for one device.
+	 */
+	err = snd_card_new(&hdev->dev, SNDRV_DEFAULT_IDX1, "ToppingCtl",
+			   THIS_MODULE, 0, &th->card);
+	if (err < 0)
+		goto close;
+
+	strscpy(th->card->driver, "Topping", sizeof(th->card->driver));
+	strscpy(th->card->shortname, "Topping M62 control",
+		sizeof(th->card->shortname));
+	strscpy(th->card->longname, "Topping M62 vendor control channel",
+		sizeof(th->card->longname));
+
+	err = topping_add_ctls(th);
+	if (err < 0)
+		goto free_card;
+
+	err = snd_card_register(th->card);
+	if (err < 0)
+		goto free_card;
+
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	return 0;
+
+free_card:
+	snd_card_free(th->card);
+close:
+	hid_hw_close(hdev);
+stop:
+	hid_hw_stop(hdev);
+	return err;
+}
+
+static void topping_remove(struct hid_device *hdev)
+{
+	struct topping_hid *th = hid_get_drvdata(hdev);
+
+	/*
+	 * The card first: its elements call into this module, and the
+	 * hid device under them is about to stop answering.
+	 */
+	if (th->card)
+		snd_card_free(th->card);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id topping_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, topping_devices);
+
+static struct hid_driver topping_driver = {
+	.name = "topping",
+	.id_table = topping_devices,
+	.probe = topping_probe,
+	.remove = topping_remove,
+	.raw_event = topping_raw_event,
+};
+module_hid_driver(topping_driver);
+
+MODULE_DESCRIPTION("HID driver for the Topping M62 vendor control channel");
+MODULE_AUTHOR("Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0

