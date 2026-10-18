Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576849BD91
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327790; cv=none; b=PXrbuuVWU/HlHj6QoLVwLvgW6cINOMYcJVhVkjcso755RP+Oju3uDvQDUNBEKEHA7vQ8I1P83v62BoImBRO68XYSNJQlJrfMVy41YEEKy/JZXjqKxY+k+yNrhIIVXOWeeyEnA3kwjVE1YiLXnr4M4fg9KKVyiGjMImWMS+z1cws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327790; c=relaxed/simple;
	bh=8Adck3iAtGOeC0ywg+PIUOdQ8ooZ+i3LYff1xgXMDkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS7/reZZALhYtRXe0RS7hqtwKKuB+SQx3lZlPyPTQmKgPX9GkYSsqUlV5Cr/BxG9jYNHU+XSVpThLOzckFqaPbvf8U6bPq8R4V4Ylqb8J4OES3qqdhBVnVVW/Sp2RijDvnvYe7oqNJcVSsTUlWiM+s7jGiMTRPaEkiUzM4RscMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n235kTK6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n235kTK6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so17640875e9.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327786; x=1792932586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AquBOoXLi95/lpXqUOSvL8SzxumACmI1IFU9uj7woHA=;
        b=n235kTK6QMeflz4fcYFsT03MZAgzWluOwTrkhWMSkar6ipDrNf36phM+2DmbXdi3D9
         ZEicEKATJ030XiaCUzB/slFOlLjuIb5Yv3flFDfaMP4GAopPrDWERiLZwj+yBNhlVxQQ
         1XNIe3F34c8tJLqbLbT4rnGECc8io9A/WjFVkXtSxcnQj/ATFvI+bwVjZdNoMmQI7vWh
         waCS7rnR9z7Q493mOZBTrRaYZ9gQ4iwj3aT+m4rF72opgWovANDZWZa+gsQUReLDk9oI
         KcDQGkRaLFqQko+pWZMo8gLpSbU2cbY25+U86Do4mS4CJH5vftGt3QaapHZzttuY2pCl
         bnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327786; x=1792932586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AquBOoXLi95/lpXqUOSvL8SzxumACmI1IFU9uj7woHA=;
        b=isYKym3XpiRRojVU5/h0z/6Hk83mhDtY7ymRCKckYzirfm+hAgbMPtyZa31FsEvux6
         q4WVKsxU71FgETh19fMVOEIeQQ0T0/V6MOLriK+vZu9WLr4I7jRZP6kcxuTBtMiSZF/F
         8hIFyHfLYfiD/Qrtg1MYGgs/JMBJ2rKhS1clIFqFWfXYUUO5nm+Lf9EnKPgI01uBKzQF
         l/vNJqZiM6RWH192chkONR/lA9TQdcnq55+8Um7GKgYFImGynxaGTsrYHiIL5OuSYo5Z
         2fYtDmPtmAYNwicwDFS/AZRrD0XDsgGUCoKsBpooTrMZf6x+NJJy/U3H2daN2NocsKp6
         te1g==
X-Forwarded-Encrypted: i=1; AKwUvBw1YaZhAitMmzY0fO0DdYAqidOvmbHCoBtFWjCSN4sE/cLkl/iEwzH3LUVJ45wzw2G887M+iD6FPdzyyw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL9STFJv61z5Xm+2qSJvHOgoHQVsHCrK71bHD7puyAZbSd+Kn9s
	MKegeHsozMpdKH0o5MJkuwgmqN63KLzj3/e+O8tNYpnC9vuQatP7AQ55
X-Gm-Gg: AYBFou38B+ymm8l3GhRERDFi7wvuPHTMvEUz4sVkogQXE98YdMhp7rJTXhrje370BU7
	yaTaQdWoGKMYU6Hhfhrcn3jm9y7OHylTJJ0LV1yGT7KNAvpqBDPa/kRHTgePqHLpr1afMm3i0JV
	EeJ1Q9/3DVNSxmD+a+g0KiXKwvSAYlbd9Momht/arKRPfhbXf/ynVu3rKrC+yLAbHv2qvgEeLsQ
	0uFlepenO7KQrop3daWUR5sUri9jsOnwp7FzOf484Ni5j4gqAL+KNMidRkco/AUi2e5tYBTxiHa
	qC+72Nlf71R4Gb0OFMOd/lKB39/w/+JBPGWCGojLXLk86Vm0xhaE4G6C1iqt8BX9jDS+Gztf/TY
	8hVhRw9VGHsNfk8YFsA0Rvfsi8/3UPDEsPCdLyENOY/RZO7Px5WjxuWy7jQxCaIYRm2nG+hcz+S
	BL1ny1lg+zrq/JaMVxmPmFr/poPiOVRJT2ioT85RtleZCMCxv31fbld9GRegfn5pA4F8NwecLF9
	LI1CJv2mKEAFloyVkH81J2k0i7D7yrj6f/eUGL2hKDGw9KT0Hts1/nb7PWN7/hWsuv+Qw==
X-Received: by 2002:a05:600c:8709:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4a1d76255f6mr90960715e9.18.1792327785833;
        Sun, 18 Oct 2026 05:49:45 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:45 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v9 3/8] HID: topping: add the E2x2 OTG
Date: Sun, 18 Oct 2026 17:48:33 +0500
Message-ID: <20261018124838.129349-4-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
References: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Topping E2x2 OTG (152a:8756) puts its digital input gains, its
faders, its source selectors and its output switches behind the same
vendor protocol as the M62, in the same frames and on the same
interface, so the same transport serves it.

One thing differs. The E2x2 OTG reports without being subscribed, and
its own vendor application never sends it 0x11/0x24 or 0x11/0x26. The
subscription, the announce request and the keepalive are now reserved
for a card marked as wanting them, which is the M62.

The device table now says, for each card, which interface carries the
protocol as well as whether the card wants the subscription. It is
interface 4 on both; a card that has it elsewhere is one more entry
rather than a change to the probe.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/hid/Kconfig       | 13 ++++----
 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-quirks.c  |  1 +
 drivers/hid/hid-topping.c | 63 +++++++++++++++++++++++++--------------
 4 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index fecbbaa..9367a71 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1285,16 +1285,17 @@ config HID_TIVO
 	Say Y if you have a TiVo Slide Bluetooth remote control.
 
 config HID_TOPPING
-	tristate "Topping M62 vendor controls"
+	tristate "Topping M62 and E2x2 OTG vendor controls"
 	depends on USB_HID
 	depends on SND_USB_AUDIO
 	select CRC16
 	help
-	  The vendor protocol behind the analogue input gains, output
-	  volumes and output source selectors of the Topping M62 USB
-	  audio interface. These are not described by the USB Audio
-	  Class and are reached over the card's HID interface, so a
-	  driver is needed for them to work at all.
+	  The vendor protocol behind the input gains, output volumes and
+	  source selectors of the Topping M62 and E2x2 OTG USB audio
+	  interfaces, and the output switches of the E2x2 OTG. These are
+	  not described by the USB Audio Class and are reached over the
+	  card's HID interface, so a driver is needed for them to work
+	  at all.
 
 	  The controls themselves belong to snd-usb-audio, on the sound
 	  card it makes for the same device; this driver carries them
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1af487c..cc114e4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1478,6 +1478,7 @@
 #define USB_DEVICE_ID_TIVO_SLIDE_PRO	0x1203
 
 #define USB_VENDOR_ID_TOPPING		0x152a
+#define USB_DEVICE_ID_TOPPING_E2X2_OTG	0x8756
 #define USB_DEVICE_ID_TOPPING_M62	0x875c
 
 #define USB_VENDOR_ID_TOPRE			0x0853
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index bca22bb..5872952 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -791,6 +791,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE_PRO) },
 #endif
 #if IS_ENABLED(CONFIG_HID_TOPPING)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_E2X2_OTG) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62) },
 #endif
 #if IS_ENABLED(CONFIG_HID_TOPSEED)
diff --git a/drivers/hid/hid-topping.c b/drivers/hid/hid-topping.c
index a8854b2..7b46c4c 100644
--- a/drivers/hid/hid-topping.c
+++ b/drivers/hid/hid-topping.c
@@ -6,7 +6,10 @@
  *
  * The M62 (152a:875c) puts its analogue input gains, its output volumes
  * and its output source selectors behind a vendor protocol on a
- * HID-class interface, and exposes none of them through UAC.
+ * HID-class interface, and exposes none of them through UAC.  The E2x2
+ * OTG (152a:8756) does the same with its digital input gains, its
+ * faders, its source selectors and its output switches, on the same
+ * interface and in the same frames.
  *
  * The protocol was read off the vendor application's traffic.  Frames
  * are fifteen bytes:
@@ -22,10 +25,12 @@
  * does not verify what it receives -- this driver signs its writes
  * anyway, and validates what it reads.
  *
- * The device says nothing until it is subscribed: one write of
- * 0x11/0x24 starts the notification stream, after which every change,
- * including a front panel button, arrives unsolicited.  A second
- * write, 0x11/0x26, makes the device announce what it reports at all.
+ * The M62 says nothing until it is subscribed: one write of 0x11/0x24
+ * starts the notification stream, after which every change, including
+ * a front panel button, arrives unsolicited.  A second write, 0x11/0x26,
+ * makes the device announce what it reports at all.  The E2x2 OTG
+ * reports without being asked, and its own vendor application never
+ * sends it either of the two, so neither does this driver.
  *
  * The control pipe is not an option: GET_REPORT and SET_REPORT both
  * stall with EPIPE for every report type, so the interrupt endpoints
@@ -37,12 +42,13 @@
  * THE CONTROLS ARE NOT THIS DRIVER'S.  They live in snd-usb-audio, on
  * the card that plays the audio, and outlive any binding of this
  * driver.  This driver is the transport: it registers a component, the
- * M62 mixer quirk is the master, and at bind this driver fills in the
+ * card's mixer quirk is the master, and at bind this driver fills in the
  * struct topping_component it is handed with the one operation the
  * controls need -- send a frame -- and from then on passes on every
  * frame the card reports.
  */
 
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/component.h>
 #include <linux/crc16.h>
@@ -63,11 +69,14 @@
 #define TOPPING_REPORT_LEN	16	/* what arrives, one pad byte more */
 
 /*
- * The M62 presents two non-audio interfaces.  Interface 3 is
- * Application Specific / DFU and is never touched here.  Interface 4
- * carries the control protocol and is the only one this driver takes.
+ * hid_device_id.driver_data: in the low byte, the interface that carries
+ * the control protocol and the only one this driver takes, and above it
+ * what the card wants.  Both cards present two non-audio interfaces:
+ * interface 3 is Application Specific / DFU and is never touched here,
+ * and interface 4 carries the protocol.
  */
-#define M62_VENDOR_IFNUM	4
+#define TOPPING_IFNUM		GENMASK(7, 0)
+#define TOPPING_SUBSCRIBE	BIT(8)	/* wants 0x11/0x24 and its renewal */
 
 /* device-scope properties */
 #define TOPPING_TT_DEVICE	0x11
@@ -95,6 +104,7 @@ struct topping_hid {
 	struct topping_component *comp;
 	spinlock_t lock;		/* guards comp */
 
+	bool subscribe;			/* TOPPING_SUBSCRIBE */
 	struct delayed_work keepalive;
 };
 
@@ -282,10 +292,12 @@ static int topping_bind(struct device *dev, struct device *master,
 	 * connected input about 5 s later -- so nothing here waits for
 	 * them: each value arrives through .raw_event() on its own.
 	 */
-	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
-	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
-	schedule_delayed_work(&th->keepalive,
-			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+	if (th->subscribe) {
+		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+		schedule_delayed_work(&th->keepalive,
+				      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+	}
 	return 0;
 }
 
@@ -352,8 +364,9 @@ static int topping_probe(struct hid_device *hdev,
 	th->hdev = hdev;
 	th->intf = to_usb_interface(hdev->dev.parent);
 	if (th->intf->cur_altsetting->desc.bInterfaceNumber !=
-	    M62_VENDOR_IFNUM)
+	    (id->driver_data & TOPPING_IFNUM))
 		return -ENODEV;
+	th->subscribe = id->driver_data & TOPPING_SUBSCRIBE;
 
 	spin_lock_init(&th->lock);
 	INIT_DELAYED_WORK(&th->keepalive, topping_keepalive);
@@ -451,10 +464,12 @@ static int topping_resume(struct hid_device *hdev)
 	 * state refreshes what may have gone stale while the panel was
 	 * reachable and this driver was not.
 	 */
-	noio = memalloc_noio_save();
-	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
-	topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
-	memalloc_noio_restore(noio);
+	if (th->subscribe) {
+		noio = memalloc_noio_save();
+		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+		memalloc_noio_restore(noio);
+	}
 
 	/*
 	 * Tested again under the lock topping_unbind() takes to clear it,
@@ -467,8 +482,9 @@ static int topping_resume(struct hid_device *hdev)
 	scoped_guard(spinlock_irqsave, &th->lock) {
 		if (th->comp) {
 			th->comp->audio_ops->resumed(th->comp);
-			schedule_delayed_work(&th->keepalive,
-					      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+			if (th->subscribe)
+				schedule_delayed_work(&th->keepalive,
+						      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 		}
 	}
 
@@ -476,7 +492,10 @@ static int topping_resume(struct hid_device *hdev)
 }
 
 static const struct hid_device_id topping_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_E2X2_OTG),
+	  .driver_data = 4 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62),
+	  .driver_data = 4 | TOPPING_SUBSCRIBE },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, topping_devices);
-- 
2.43.0

