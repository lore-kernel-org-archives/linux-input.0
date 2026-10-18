Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1A3EAC84
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357046; cv=none; b=gLad879i7kWc6Z0rYqUJC/ChTRpu4s0jUp8Lm970wLNyYVnXeLc/lgC11mdSw23/cfoqpgX5YGBHde2aeFwwA+f6Q+11ITyczaRCfSKA5u2P29G0wdW0EeJemN8XSh9r/01JKVKkJRfa4IvDiw0SsXXxMSTBqa1YWlRZTnBMvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357046; c=relaxed/simple;
	bh=bBlsWwOYyeNh1HOVP6h0sY3824l9vCgf48JsO/sMitI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbGvq5vJ8gXQYKQA+UDXHnmAliMMGF9oiRfioL3lMQs4LBLaeYkh1fYklycSP2meXXoOwJQmgqZArFPbH8UdEyS31w61OwzVhhf7qbGntrsdZXG5sEVIoP1RdZzyC8hT2HbSqP5FZHQiuEJKzhe2r5XwgMuz+gYujL+G9cCqTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoXA1Sia; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoXA1Sia"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so10498055e9.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792357042; x=1792961842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiYjDG6R9T771lCEy1yyrnltGjBuwC2FUmWto/MRdNY=;
        b=CoXA1Siae5Ns1P/HybEVSXhJPhPPL9tZ0lOGsUzgS4eAedZa9mb0FxmizeQqjql7qB
         fh1Z0weJLJh+QY1FTAsankRjKGAor8KaxqCSDtZXVm/MX+T7Z10YXmJWlu9ZRsph2NHy
         xGVoMziyF7XJSDF+NpiNr4nJLkhEesS65u/Z3JtQVT6nOgIaKls6hwXQr49G5CcE3/en
         FYDm75wBKkZeqL+JhiVkFQ0xwwKRmpW0lM7raBSmcbinOJ0PECNoY4nKesRGu7IGJMsT
         J+X7c7mxKN+v2VJ4iKJhheD8zE0Bi3GEQwLX11fyXfDjaPeHZ+OShUkQwOJv7E4LQa/C
         /3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357042; x=1792961842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiYjDG6R9T771lCEy1yyrnltGjBuwC2FUmWto/MRdNY=;
        b=lFhcvrB4NJT/+xpcrHBPaOfRNXXgLJHDrB7Syu6/7B7CuaWKm10brsk17IxSrYhOs8
         0SL04TGz3KGhPNKWSizabaS0q0Uax/YtvYDL2d2miS904TA0OnXnm8PBHprtWhtyR75K
         5V+nacFK+s6fazj0evncoXq9pisMzgjY3EVm3ggwP6M618Hkpue7BDETq6JIrhAbNgpQ
         VTQTQphhQB7KXnTODkBdNdWKmeHZ8lIyp4WwEXvgZRf867/l5vGtcPD+//si2yO35YcW
         P9IZdrVztxrm1lHaMQVgmDhtZ/a0iWm+b1OTH0ciWTcHnD+RfkaJpuqxwU/swVO1s5qs
         qifg==
X-Forwarded-Encrypted: i=1; AKwUvBw6h7HiS1hxXaVhanYuKxrGUm2lkKosZQO0SeKsS+bwmqPHLWyfLVMEboIp9l1G+yrQz2rO97zPPESSJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIM3P2BQNkge5mI6EztjNCe30BE9IeTgTc3N3QblBjCpsb8SsM6
	pCIjgoa17QyBRIORI8b61p56cmPTJSNo51Dc6VwX95GjWUdVxoDsYz1ESzfOt+z5HsN1qLs+
X-Gm-Gg: AYBFou3RS+HhEpdnVpYPFmmEEwt85wapFUm2krEGqYbgiLIDtS45X0eavXltERUoGZr
	i2zhkh/sWrMvA9BEHSzdgw+AWuL77Q7t2szMJaeKMFk5NW55ED17unoHMCy6mrhnlt29gZcejRa
	tlfdNLWRaIVvbxUyTJci2d1odhCgsW2yrqLBTjddPOfroq6eqv26+1GJGrCKGYPLY8O3xkIlae7
	lsndGWJFbiuZ37huNZcNigGfr62dDR4LJ0LaIyf6pnrxQLhwfjT7i1tcVgzFcgX87UsnpTKs6Ir
	xEseKmJQ1EJfN7ZX47MzXJfZ0QLrsYzdlR1EjdqgQxcKreNA8sPNRjDOBvzowPKFREA04wyAh56
	XFOzbLxZw1ZdxSIYGPp2v/v9tADLvd4fzGsOM4UDl48ZJm/fchDoJBatf1yzCpOqt0VHoj1ER/N
	keblQWRLUP9/ZPOdM/R2h2b7FcfyXlj3hRrWYGfmG0hBxF/81AFuUqwuOHl3Ug6MZXN9SxFF1U9
	NdCggNt1ovVIV2H+pb5PqlJOWYF2otA72KWCHA5beHYf7kD4vVRDq0Ng/JcbGnk7S0fhKBwbYf/
	CTM0
X-Received: by 2002:a05:600d:1:b0:4a1:d893:263e with SMTP id 5b1f17b1804b1-4a1d89329e4mr109621325e9.28.1792357041345;
        Sun, 18 Oct 2026 13:57:21 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm18496263f8f.30.2026.10.18.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:57:20 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v10 1/8] HID: topping: transport for the M62's vendor controls
Date: Mon, 19 Oct 2026 01:57:03 +0500
Message-ID: <20261018205711.168291-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018205711.168291-1-mikhail.v.gavrilov@gmail.com>
References: <20261018205711.168291-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Topping M62 is a USB audio interface whose analogue input gains,
output volumes and output source selectors are not described by the USB
Audio Class. They live behind a vendor protocol on a HID-class
interface, spoken by Topping's M Control Center, which has no Linux
build. What UAC does expose on the capture side is a digital trim after
the converter, which cannot buy signal-to-noise: raising it lifts the
converter's own floor with the signal. So on Linux the only gain worth
setting is unreachable, and a measurement application has to ask a
human to set it by hand on the front panel.

The protocol was read off the vendor application's traffic. Frames are
fifteen bytes:

	22 33 | 20 01 01 | TT | PP | s32 value BE | CRC16 BE | 66 77

with TT a target, PP a property of that target, and the checksum
CRC-16/MODBUS over bytes 2..10, most significant byte first. Reports
from the device are the same frame plus one pad byte. The vendor
application sends 00 00 in place of the checksum and the device accepts
it, so the device does not verify what it receives; this driver signs
its writes anyway and validates what it reads.

The card is silent until subscribed. One write of 0x11/0x24 starts the
notification stream, and it lapses unless repeated: the vendor
application sends it every two seconds and so does this driver. After
that the card reports what a hand does to its hardware -- jack states,
mutes, battery, and every turn of a front-panel knob.

The control pipe is not an option: GET_REPORT and SET_REPORT stall with
EPIPE for every report type, so the interrupt endpoints are the only
route. The report descriptor describes nothing worth having -- a
Generic Desktop application collection, eight usages stretched over
sixteen unnamed bytes in and out, no report ID -- so hid-generic makes
an input device with an ABS_MISC axis out of it and nothing else. Hence
the hid_have_special_driver entry, and HID_CONNECT_HIDRAW here with no
input device.

This driver is the transport and owns no controls. The controls belong
on the sound card that plays the audio, and they have to outlive this
driver's binding: a module reload that took them off the card would
renumber them, while a stored alsactl state and a sound server holding
the card both key on what was there. So they live in snd-usb-audio,
added in the following patch, and the two drivers meet through the
component framework with the audio side as the master. At bind this
driver fills in the struct topping_component it is handed -- the
header is new here, in the shape of struct drm_audio_component -- with
the one operation the controls need, sending a frame, and from then on
passes every valid frame the card reports to the audio side, which
decides what each one means. At unbind it tells the audio side first,
so that nothing is inside the operation when it goes. Without the audio
half this driver binds, subscribes and passes nothing on, which is
harmless.

Interface 3 is Application Specific / DFU and is never touched: a stray
write there can leave the card unusable. Only interface 4 grows a
component.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/Kconfig       |  20 ++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   3 +
 drivers/hid/hid-topping.c | 498 ++++++++++++++++++++++++++++++++++++++
 include/sound/topping.h   |  57 +++++
 6 files changed, 582 insertions(+)
 create mode 100644 drivers/hid/hid-topping.c
 create mode 100644 include/sound/topping.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c43e824..fecbbaa 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1284,6 +1284,26 @@ config HID_TIVO
 	help
 	Say Y if you have a TiVo Slide Bluetooth remote control.
 
+config HID_TOPPING
+	tristate "Topping M62 vendor controls"
+	depends on USB_HID
+	depends on SND_USB_AUDIO
+	select CRC16
+	help
+	  The vendor protocol behind the analogue input gains, output
+	  volumes and output source selectors of the Topping M62 USB
+	  audio interface. These are not described by the USB Audio
+	  Class and are reached over the card's HID interface, so a
+	  driver is needed for them to work at all.
+
+	  The controls themselves belong to snd-usb-audio, on the sound
+	  card it makes for the same device; this driver carries them
+	  to the card, so both are needed. The card works without this
+	  one; its vendor controls simply never appear.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-topping.
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
index cb7f16d..1af487c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1477,6 +1477,9 @@
 #define USB_DEVICE_ID_TIVO_SLIDE	0x1201
 #define USB_DEVICE_ID_TIVO_SLIDE_PRO	0x1203
 
+#define USB_VENDOR_ID_TOPPING		0x152a
+#define USB_DEVICE_ID_TOPPING_M62	0x875c
+
 #define USB_VENDOR_ID_TOPRE			0x0853
 #define USB_DEVICE_ID_TOPRE_REALFORCE_R2_108			0x0148
 #define USB_DEVICE_ID_TOPRE_REALFORCE_R2_87			0x0146
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 96a36c5..bca22bb 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -790,6 +790,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE_PRO) },
 #endif
+#if IS_ENABLED(CONFIG_HID_TOPPING)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62) },
+#endif
 #if IS_ENABLED(CONFIG_HID_TOPSEED)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE_2) },
diff --git a/drivers/hid/hid-topping.c b/drivers/hid/hid-topping.c
new file mode 100644
index 0000000..2e50b36
--- /dev/null
+++ b/drivers/hid/hid-topping.c
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Vendor protocol for Topping interfaces behind a HID channel
+ *
+ * Copyright (c) 2026 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+ *
+ * The M62 (152a:875c) puts its analogue input gains, its output volumes
+ * and its output source selectors behind a vendor protocol on a
+ * HID-class interface, and exposes none of them through UAC.
+ *
+ * The protocol was read off the vendor application's traffic.  Frames
+ * are fifteen bytes:
+ *
+ *	22 33 | 20 01 01 | TT | PP | s32 value BE | CRC16 BE | 66 77
+ *
+ * with TT a target (an input, an output, or the device itself), PP a
+ * property of that target, and the checksum CRC-16/MODBUS over bytes
+ * 2..10 stored most significant byte first.  Reports arriving from the
+ * device are the same frame plus one trailing pad byte; an idle poll
+ * returns sixteen zeroes.  The vendor application sends 00 00 in place
+ * of the checksum and the device accepts it, so the device evidently
+ * does not verify what it receives -- this driver signs its writes
+ * anyway, and validates what it reads.
+ *
+ * The device says nothing until it is subscribed: one write of
+ * 0x11/0x24 starts the notification stream, after which every change,
+ * including a front panel button, arrives unsolicited.  A second
+ * write, 0x11/0x26, makes the device announce what it reports at all.
+ *
+ * The control pipe is not an option: GET_REPORT and SET_REPORT both
+ * stall with EPIPE for every report type, so the interrupt endpoints
+ * are the only route.  The report descriptor describes nothing worth
+ * having -- a Generic Desktop application collection, eight usages
+ * stretched over sixteen unnamed bytes in and out, no report ID -- so
+ * this driver takes HID_CONNECT_HIDRAW and no input device.
+ *
+ * THE CONTROLS ARE NOT THIS DRIVER'S.  They live in snd-usb-audio, on
+ * the card that plays the audio, and outlive any binding of this
+ * driver.  This driver is the transport: it registers a component, the
+ * M62 mixer quirk is the master, and at bind this driver fills in the
+ * struct topping_component it is handed with the one operation the
+ * controls need -- send a frame -- and from then on passes on every
+ * frame the card reports.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/component.h>
+#include <linux/crc16.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/unaligned.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include <sound/topping.h>
+
+#include "hid-ids.h"
+
+#define TOPPING_FRAME_LEN	15	/* what we send */
+#define TOPPING_REPORT_LEN	16	/* what arrives, one pad byte more */
+
+/*
+ * The M62 presents two non-audio interfaces.  Interface 3 is
+ * Application Specific / DFU and is never touched here.  Interface 4
+ * carries the control protocol and is the only one this driver takes.
+ */
+#define M62_VENDOR_IFNUM	4
+
+/* device-scope properties */
+#define TOPPING_TT_DEVICE	0x11
+#define TOPPING_PP_SUBSCRIBE	0x24
+#define TOPPING_PP_ANNOUNCE	0x26
+
+/*
+ * THE SUBSCRIPTION LAPSES.  The vendor application repeats 0x11/0x24
+ * every two seconds for as long as it is running, and a device that
+ * hears nothing stops reporting -- which is why a listener that
+ * subscribed once saw the meters and not much else.  Nothing in the
+ * frame says "keep alive"; it is simply the same subscribe again.
+ */
+#define TOPPING_KEEPALIVE_MS	2000
+
+struct topping_hid {
+	struct hid_device *hdev;
+	struct usb_interface *intf;	/* for runtime PM */
+
+	/*
+	 * The audio side, while it has this driver bound, and NULL
+	 * otherwise.  Frames arrive before it is there and after it has
+	 * gone, so everything that passes one on reads this under lock.
+	 */
+	struct topping_component *comp;
+	spinlock_t lock;		/* guards comp */
+
+	struct delayed_work keepalive;
+};
+
+/* ------------------------------------------------------------------ */
+/* the wire								*/
+/* ------------------------------------------------------------------ */
+
+static void topping_build(u8 *f, u8 target, u8 prop, s32 value)
+{
+	u16 crc;
+
+	f[0] = 0x22;
+	f[1] = 0x33;
+	f[2] = 0x20;
+	f[3] = 0x01;
+	f[4] = 0x01;
+	f[5] = target;
+	f[6] = prop;
+	put_unaligned_be32(value, f + 7);
+	crc = crc16(0xffff, f + 2, 9);
+	put_unaligned_be16(crc, f + 11);
+	f[13] = 0x66;
+	f[14] = 0x77;
+}
+
+/*
+ * The frame goes out as it is; waking the device is the CALLER's
+ * business.  A write asked for by the audio side takes a runtime PM
+ * reference first, which wakes what is asleep.  The keepalive and the
+ * resume path deliberately do not: the first because a sleeping device
+ * has no subscription worth renewing -- resume renews it -- and the
+ * second because it IS the resume.
+ *
+ * That division is also what keeps the keepalive out of a deadlock.
+ * If it woke the device itself, a runtime suspend arriving at the same
+ * moment would wait in cancel_delayed_work_sync() for a worker that was
+ * in turn waiting for that suspend to finish.
+ *
+ * usbhid drops a leading zero byte, taking it for a report ID this
+ * device does not use, and sends the rest on the interrupt OUT
+ * endpoint.  So the fifteen bytes that reach the card are the frame
+ * and nothing else.
+ */
+static int topping_send(struct topping_hid *th, u8 target, u8 prop,
+			s32 value)
+{
+	/*
+	 * NOIO rather than KERNEL: this is called from the resume path
+	 * too, where reclaim can wait on a block device that has not
+	 * woken yet.
+	 */
+	u8 *buf __free(kfree) = kzalloc(TOPPING_REPORT_LEN, GFP_NOIO);
+	int err;
+
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = 0;			/* the report ID usbhid will drop */
+	topping_build(buf + 1, target, prop, value);
+
+	err = hid_hw_output_report(th->hdev, buf, TOPPING_FRAME_LEN + 1);
+	if (err >= 0)
+		return 0;
+
+	/*
+	 * A cable pulled out of a running card produces one of these per
+	 * write until the disconnect arrives, and none of them says
+	 * anything about this driver: ENODEV and ESHUTDOWN are the
+	 * device already gone, EPROTO and EILSEQ the bus falling apart
+	 * on the way there.  Anything else is worth a line.
+	 */
+	if (err != -ENODEV && err != -ESHUTDOWN &&
+	    err != -EPROTO && err != -EILSEQ)
+		hid_err(th->hdev, "write %02x/%02x failed: %d\n",
+			target, prop, err);
+	return err;
+}
+
+/*
+ * The one operation the audio side is given.  It wakes the device
+ * first; the resume that can run on this very thread as a result only
+ * schedules the audio side's write-back, so it takes no lock a caller
+ * here may be holding.
+ *
+ * The write-back after a resume comes through here too, close behind
+ * the resume itself, and usbhid allocates its URB with GFP_KERNEL --
+ * hence the NOIO scope round the send, for the reason given there.
+ */
+static int topping_write(struct device *dev, u8 target, u8 prop, s32 value)
+{
+	struct topping_hid *th = hid_get_drvdata(to_hid_device(dev));
+	unsigned int noio;
+	int err;
+
+	if (usb_autopm_get_interface(th->intf) < 0)
+		return -EIO;
+
+	noio = memalloc_noio_save();
+	err = topping_send(th, target, prop, value);
+	memalloc_noio_restore(noio);
+
+	usb_autopm_put_interface(th->intf);
+	return err;
+}
+
+static const struct topping_ops topping_hid_ops = {
+	.write	= topping_write,
+};
+
+/*
+ * What was the URB completion handler, minus everything usbhid now
+ * owns: there is no resubmit here and no bus-noise status to sort
+ * through.  What is left is the check of the frame.  Which frames
+ * mean anything is the audio side's business, so every valid one is
+ * passed on, the meters included.
+ *
+ * Runs in the interrupt handler's context, which is why the audio side
+ * is reached under a spinlock.
+ */
+static int topping_raw_event(struct hid_device *hdev,
+			     struct hid_report *report, u8 *data, int size)
+{
+	struct topping_hid *th = hid_get_drvdata(hdev);
+
+	if (size < TOPPING_FRAME_LEN)
+		return 0;
+	if (data[0] != 0x22 || data[1] != 0x33 ||
+	    data[13] != 0x66 || data[14] != 0x77)
+		return 0;
+	if (get_unaligned_be16(data + 11) != crc16(0xffff, data + 2, 9))
+		return 0;
+
+	/*
+	 * Under the lock that topping_unbind() takes to clear th->comp,
+	 * so a frame cannot reach an audio side that has already been
+	 * told this driver is going.
+	 */
+	guard(spinlock_irqsave)(&th->lock);
+	if (th->comp)
+		th->comp->audio_ops->report(th->comp, data[5], data[6],
+					    get_unaligned_be32(data + 7));
+	return 0;
+}
+
+static void topping_keepalive(struct work_struct *work)
+{
+	struct topping_hid *th = container_of(work, struct topping_hid,
+					      keepalive.work);
+	int err;
+
+	err = topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	if (err == -ENODEV || err == -ESHUTDOWN)
+		return;		/* the device has gone; nothing to renew */
+
+	schedule_delayed_work(&th->keepalive,
+			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+}
+
+/* ------------------------------------------------------------------ */
+/* component								*/
+/* ------------------------------------------------------------------ */
+
+static int topping_bind(struct device *dev, struct device *master,
+			void *master_data)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct topping_hid *th = hid_get_drvdata(hdev);
+	struct topping_component *comp = master_data;
+
+	comp->dev = &hdev->dev;
+	comp->ops = &topping_hid_ops;
+
+	/*
+	 * Published only now: until this store every frame stops here,
+	 * and from it on every frame reaches the audio side, which keeps
+	 * what it is told whether or not its controls exist yet.
+	 */
+	scoped_guard(spinlock_irqsave, &th->lock)
+		th->comp = comp;
+
+	/*
+	 * Subscribe and ask for the state HERE rather than at probe:
+	 * before this point there is nobody to pass the answer to.  The
+	 * card answers in two waves -- the jacks at once, the gain of a
+	 * connected input about 5 s later -- so nothing here waits for
+	 * them: each value arrives through .raw_event() on its own.
+	 */
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	schedule_delayed_work(&th->keepalive,
+			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+	return 0;
+}
+
+static void topping_unbind(struct device *dev, struct device *master,
+			   void *master_data)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct topping_hid *th = hid_get_drvdata(hdev);
+	struct topping_component *comp;
+
+	/*
+	 * Taken away under the lock, so that once this scope ends no
+	 * frame and no resume can reach the audio side.  Clearing it also
+	 * stops topping_resume() from restarting the keepalive, which
+	 * makes the cancel below final.
+	 *
+	 * @master_data is deliberately unused.  The audio side cannot look
+	 * its own context up while its devres is unwinding, so it passes
+	 * NULL; the structure to clear is the one this driver was handed
+	 * at bind, and it is right here.
+	 */
+	scoped_guard(spinlock_irqsave, &th->lock) {
+		comp = th->comp;
+		th->comp = NULL;
+	}
+
+	if (!comp)
+		return;
+
+	cancel_delayed_work_sync(&th->keepalive);
+
+	/*
+	 * The audio side stops writing before the operation goes: once
+	 * this returns, nothing is inside topping_write() on its behalf
+	 * and nothing will enter it.
+	 */
+	comp->audio_ops->unbound(comp);
+	comp->ops = NULL;
+	comp->dev = NULL;
+}
+
+static const struct component_ops topping_component_ops = {
+	.bind	= topping_bind,
+	.unbind	= topping_unbind,
+};
+
+/* ------------------------------------------------------------------ */
+/* HID									*/
+/* ------------------------------------------------------------------ */
+
+static int topping_probe(struct hid_device *hdev,
+			 const struct hid_device_id *id)
+{
+	struct topping_hid *th;
+	int err;
+
+	if (!hid_is_usb(hdev))
+		return -ENODEV;
+
+	th = devm_kzalloc(&hdev->dev, sizeof(*th), GFP_KERNEL);
+	if (!th)
+		return -ENOMEM;
+
+	th->hdev = hdev;
+	th->intf = to_usb_interface(hdev->dev.parent);
+	if (th->intf->cur_altsetting->desc.bInterfaceNumber !=
+	    M62_VENDOR_IFNUM)
+		return -ENODEV;
+
+	spin_lock_init(&th->lock);
+	INIT_DELAYED_WORK(&th->keepalive, topping_keepalive);
+	hid_set_drvdata(hdev, th);
+
+	err = hid_parse(hdev);
+	if (err)
+		return err;
+
+	/*
+	 * HIDRAW and no input device.  The descriptor would only make a
+	 * nonexistent pointer, while a hidraw node is how this protocol
+	 * was read in the first place and how the parts not exposed as
+	 * controls -- the mixer matrix, the mutes, the EQ -- stay
+	 * reachable.
+	 */
+	err = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (err)
+		return err;
+
+	err = hid_hw_open(hdev);
+	if (err)
+		goto err_stop;
+
+	/*
+	 * Reports are dropped for the whole of probe unless this is called,
+	 * and component_add() below can bind synchronously when the audio
+	 * side is already there -- which subscribes, and the device answers
+	 * at once.  Without this the identification wave is thrown away.
+	 */
+	hid_device_io_start(hdev);
+
+	err = component_add(&hdev->dev, &topping_component_ops);
+	if (err)
+		goto err_close;
+
+	return 0;
+
+err_close:
+	hid_hw_close(hdev);
+err_stop:
+	hid_hw_stop(hdev);
+	return err;
+}
+
+static void topping_remove(struct hid_device *hdev)
+{
+	struct topping_hid *th = hid_get_drvdata(hdev);
+
+	/* Runs topping_unbind() first if the audio side is bound. */
+	component_del(&hdev->dev, &topping_component_ops);
+
+	/*
+	 * Unconditionally, and after component_del(): if the audio side
+	 * had already unbound, the cancel there has been and gone, and
+	 * a resume in between could have restarted the work.  This is
+	 * the last point before devm frees th, so nothing may outlive
+	 * it.
+	 */
+	cancel_delayed_work_sync(&th->keepalive);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static int topping_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct topping_hid *th = hid_get_drvdata(hdev);
+
+	cancel_delayed_work_sync(&th->keepalive);
+	return 0;
+}
+
+static int topping_resume(struct hid_device *hdev)
+{
+	struct topping_hid *th = hid_get_drvdata(hdev);
+	unsigned int noio;
+
+	/*
+	 * Nothing to report to yet, and nothing the card needs told:
+	 * the next bind does the subscribing.
+	 */
+	scoped_guard(spinlock_irqsave, &th->lock)
+		if (!th->comp)
+			return 0;
+
+	/*
+	 * Without I/O reclaim: usbhid's own usb_interrupt_msg() allocates
+	 * a URB with GFP_KERNEL, so asking for the frame buffer politely
+	 * is not enough, and reclaim here can wait on a block device that
+	 * has not woken yet.
+	 *
+	 * Subscribing again is not a formality: the device stops
+	 * reporting to a host it has not heard from, and asking for the
+	 * state refreshes what may have gone stale while the panel was
+	 * reachable and this driver was not.
+	 */
+	noio = memalloc_noio_save();
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	memalloc_noio_restore(noio);
+
+	/*
+	 * Tested again under the lock topping_unbind() takes to clear it,
+	 * so an unbind racing this function can neither be told of a
+	 * resume after it has gone nor leave work behind that nothing
+	 * will cancel.  The audio side only schedules its write-back
+	 * from here; the writes themselves come later, through
+	 * topping_write().
+	 */
+	scoped_guard(spinlock_irqsave, &th->lock) {
+		if (th->comp) {
+			th->comp->audio_ops->resumed(th->comp);
+			schedule_delayed_work(&th->keepalive,
+					      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+		}
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id topping_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, topping_devices);
+
+static struct hid_driver topping_driver = {
+	.name		= "topping",
+	.id_table	= topping_devices,
+	.probe		= topping_probe,
+	.remove		= topping_remove,
+	.raw_event	= topping_raw_event,
+	.suspend	= pm_ptr(topping_suspend),
+	.resume		= pm_ptr(topping_resume),
+	.reset_resume	= pm_ptr(topping_resume),
+};
+module_hid_driver(topping_driver);
+
+MODULE_DESCRIPTION("Topping vendor control protocol");
+MODULE_AUTHOR("Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/sound/topping.h b/include/sound/topping.h
new file mode 100644
index 0000000..c3ca02f
--- /dev/null
+++ b/include/sound/topping.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Topping vendor controls -- what hid-topping and the M62 mixer quirk in
+ * snd-usb-audio hand each other at component bind.
+ *
+ * The audio side owns this structure and the controls.  The HID driver,
+ * which speaks the card's vendor protocol, fills in @dev and @ops when it
+ * binds and clears them when it unbinds, and passes on what the card
+ * reports through @audio_ops.  The shape is that of struct
+ * drm_audio_component, which joins HD-audio to the graphics drivers.
+ */
+#ifndef __SOUND_TOPPING_H
+#define __SOUND_TOPPING_H
+
+#include <linux/types.h>
+
+struct device;
+struct topping_component;
+
+/**
+ * struct topping_ops - what the HID driver offers
+ * @write: send one frame to the card, waking it first if it is
+ *	runtime-suspended.  May sleep.  Returns 0 or a negative error.
+ */
+struct topping_ops {
+	int (*write)(struct device *dev, u8 target, u8 prop, s32 value);
+};
+
+/**
+ * struct topping_audio_ops - what the audio side asks to be told
+ * @report: a valid frame arrived from the card.  Called in atomic context
+ *	for every frame, the meters included.
+ * @resumed: the card was resumed and subscribed again.  Called in atomic
+ *	context.
+ * @unbound: the HID driver is unbinding.  @ops goes away when this
+ *	returns, so nothing may be inside it by then.  May sleep.
+ */
+struct topping_audio_ops {
+	void (*report)(struct topping_component *comp, u8 target, u8 prop,
+		       s32 value);
+	void (*resumed)(struct topping_component *comp);
+	void (*unbound)(struct topping_component *comp);
+};
+
+/**
+ * struct topping_component - where the two drivers meet
+ * @dev: the HID device, while it is bound
+ * @ops: set by the HID driver at bind, cleared at unbind
+ * @audio_ops: set by the audio side before the first bind
+ */
+struct topping_component {
+	struct device *dev;
+	const struct topping_ops *ops;
+	const struct topping_audio_ops *audio_ops;
+};
+
+#endif /* __SOUND_TOPPING_H */
-- 
2.43.0

