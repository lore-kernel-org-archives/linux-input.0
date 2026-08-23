Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5153515C8
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494953; cv=none; b=aYlvykSLkapGlCyEkzLVrOwVbTq0QG30Z70Pz9lY7yEBun8SyhWoeuS+h3C3JJ8d/laUO9mquy3knHJ/gMz8wkRY1rq8KcnYgYZMdIR69f6UbuEud/NVthi3YTCch0ZNh5TG6keJAhXcfxwp432XbLZyJQNtnluKJPwhw6rvAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494953; c=relaxed/simple;
	bh=GZFoGIP0RfKmKfg9wX9nH68x2uVKSU75UfUr/UfgrvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWDCUsBZAcq6O8RT1IXfr/TwSGtPBrQHJnUSReyWUr2zeZEC+oRo+AonFgTfnIfe0pVsIGKcrxg/8yf5xHi7tgL5msOtNdBCoPD/jd/k5HpVDtaGHxCm5lTbYqDtN9HBZgmgAFLwSK9JaXNzMAxGpg51JN0Shc5Z75t9GY+yVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjL1Zd7i; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjL1Zd7i"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so2005791e87.1
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787494945; x=1788099745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nV8QAssY/Tb7Ouye0mPSb4ZhDRSkq0GmXOZCNwdGEBg=;
        b=PjL1Zd7iNnxpzYEgKvlCsOpcg4IkYfgnAkfaHHHQPGPzayecFMjmgwHX/5rWFP14vs
         9oW14tF13CGEBvfhUwHNJkOwNhRKyfqNzJjdY30hcQjc72d9vKZFZ9a1hFux3uovfq8+
         XRzMbRTAEKQGbJNctNhENQMftM6MEb4xv19H20SFN08+8f7u+cldFF1J+gCjmOw/xlwM
         Qtv6nCY0MrejoZ15L2qGL2pZEscsrnOlkN3+npk2DZXiBB3PhYxS7N/0tyrdm6un/AW1
         FQklwf+ybQGamigRbUKxW7IR2LA/JwvDJDlW4AZS9TkWCpbq5n3bU+Hq04cKJYhYSB8B
         YEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494945; x=1788099745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nV8QAssY/Tb7Ouye0mPSb4ZhDRSkq0GmXOZCNwdGEBg=;
        b=cWFuY/uDPOztT0nhzX/AKtc5xw+UKNFb3RP6aJjbzoMPQwBamw6rREIihotX2D1w17
         KWdt/x6h2FLQ6yrasyGm0hMDwxj8Oo7thI1Zuz4IOWygKzuMCuTF3tKUTZltCRXpJu2w
         2g/a8EfGeYuxRCKo0td8Nq8/635cNcNUmyVoJ2C+5r8jLrOlUqq/Uh0pb/g497d8zarZ
         nFuuTMF0V4PMzU2/zeRIAp4QDdWOkH0e4DuP9m83iGw1yDs5HvlQOKyTa0ecOh6SFBJD
         k5LctaMHU5PDSlN2iqeD6oZP3TFLt4TX6dmHY0KSpQZBqq8qjjG1SWfLMv13D/xHFbel
         zuRQ==
X-Forwarded-Encrypted: i=1; AHgh+RotGrBd1f/cNkNaPK8T9X9IAlA2reQ21Zkot/fCzbBABiisydImd10L31DdR2i2UYU+OGZvd+57OyJbKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kiKsaIniOm5W8z0C55AuO+QSytWRJtgOC+t/OKwO6v192lzEzY
	kYAxxhO6gx18+lgtx0FhUeVJNkMBMjSm5h9unsWzOqWcIiQrLKCmsaWs
X-Gm-Gg: AR+sD12Lulit02V0plGJKx2TsOAlwM/S3aVnhXqKPR+1p/3xHkNLyu1qXfyQmZC/tgJ
	1Hz0E3f90MVakPUsvP+bQNva5G0gQcHH7QDfjyUNtTVJRloNdNlio1TZWXnbvNt1OR8IvSMYO17
	KN3Ur+hWLW632mvdJgUqMBvR22f7qh85tEacZswyi2UQ9F91uI0J9ah8SEPviiIanpvtx7xMyio
	/xyBw4Hsm0uNfxNk/GY1SXER3Y3Gu2FXirXMN7QOVFOKzYIkuhIem3T01dL4C6rd3Z+ebdc1tKv
	mP3/hAQNwbQhQl5x4PSHJHV7Eg+2l3uFujVHP2W6prMdKcUixg+m873MoQoxIccYSUVUI+Hm3X5
	0AIcucmyJB7a5Kwn3WhwWXv8fPmIkthwM24sOq05wjNehXDGBseWMnoFcA6eqoL/jNj0H+o6mFB
	r2nT+7PoFa8O/SseepyGZfj644hjXU4pwLcUgbfzZC/S7j6HiB3L5HI9ED+mHVcZWlXTDEdk+ln
	XJ4jeZ31ve61m5onKSkDWvwIfXxeQwRVXtjYAAlX/GGGXpBiYWpTFA2XsG6BQ==
X-Received: by 2002:a05:6512:2528:b0:5b0:1b78:495d with SMTP id 2adb3069b0e04-5b48b8b548fmr3120990e87.24.1787494944347;
        Sun, 23 Aug 2026 07:22:24 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2b73sm1006644e87.23.2026.08.23.07.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:22:23 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 1/2] ALSA: usb-audio: expose the Topping M62's analogue gains as mixer controls
Date: Sun, 23 Aug 2026 19:22:15 +0500
Message-ID: <20260823142216.79704-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
References: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
 <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M62 (152a:875c) keeps its analogue input gains and its output
volumes behind a vendor protocol on a HID-class interface, and exposes
none of them through UAC. What UAC does offer on the capture side is a
digital trim after the converter, which cannot buy signal-to-noise:
raising it lifts the converter's own floor along with the signal. A
noise-floor ladder against the card shows exactly that, so on Linux
today the one knob worth setting is the one that cannot be reached, and
a measurement has to begin by asking a human to touch the front panel.

The protocol was read off the vendor application's traffic, the way
mixer_scarlett2.c describes reading Focusrite's. Frames are fifteen
bytes -- start magic, a constant, a target, a property, a signed 32-bit
big-endian value, CRC-16/MODBUS over the middle stored big-endian, end
magic -- and rebuilding all 2619 captured frames from that description
reproduces them byte for byte. The device says nothing until it is
subscribed; one write starts the stream, a second makes it announce its
whole state, after which every change arrives unsolicited, including a
front panel press. So the controls are populated by asking rather than
by caching what was written, which matters here because the vendor
application on another host pushes its own cached state onto the card
on connect.

The control pipe cannot carry this: GET_REPORT and SET_REPORT stall
with EPIPE for every report type, so the interrupt endpoints on the HID
interface are the only route and this driver has to own that interface.
hid_ignore_list keeps usbhid away. Nothing is lost by that: the report
descriptor the device offers is a fig leaf -- a Generic Desktop
application collection, eight unnamed usages, sixteen bytes in and out,
no report ID -- so hid-generic can only make a nonexistent mouse of it.

The controls are a table: a name, the target and property that carry
the knob, the second target that must be written in step with it, the
range and the scale. Adding a knob is adding a row. Six rows here --
the two microphone preamps in whole decibels, AUX and Bluetooth on the
input side, headphone and OTG on the output side -- and the outputs
come in pairs because the device answers on only one of each pair and
the other would drift away unheard.

The two volume tapers are measured, not guessed: index 0 is mute, index
99 the maximum, the step is 0.5 dB above -10 dB and 1 dB below it, and
the family that must cover 97 dB in 98 steps takes 2 dB below -52 dB as
well. Both express as DB_RANGE. The microphone preamps are ordinary
1 dB steps from 0 to 88.

One thing a mixer quirk cannot do for itself: usb_audio_driver is
private to card.c, so claiming an interface the audio class knows
nothing about needs a helper there. snd_usb_claim_iface() is that
helper, and it is the only change outside the new file and its
dispatch.

Seven rows. OTG IN was the one gap when this was first posted -- it has
no front panel control, so it never announced itself and its property
was unknown; a capture of the vendor application moving it named it as
target 0x27, and its taper is the same family as Bluetooth, confirmed
by the indices the application dwelt on matching the decibels it
displayed.

The subscription lapses, so it is renewed: the vendor application
repeats the same subscribe every two seconds for as long as it runs,
and a device that hears nothing stops reporting. A listener that
subscribed once got the meters and the identification block and then
very little; one that kept repeating got the gains too, about five
seconds in. Nothing in the frame says "keep alive" and nothing
acknowledges it -- it is the subscribe again -- so a plain periodic
write does it. Two seconds is what the vendor uses; the device
presumably tolerates longer, but there is no reason to find the edge.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 MAINTAINERS               |   6 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   2 +
 sound/usb/Makefile        |   1 +
 sound/usb/card.c          |  14 ++
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 511 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 sound/usb/usbaudio.h      |   3 +
 9 files changed, 552 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c31a32a2c748..86447da07a6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27435,6 +27435,12 @@ S:	Maintained
 W:	https://tomoyo.sourceforge.net/
 F:	security/tomoyo/
 
+TOPPING M62 MIXER DRIVER
+M:	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+F:	sound/usb/mixer_topping.*
+
 TOPSTAR LAPTOP EXTRAS DRIVER
 M:	Herton Ronaldo Krzesinski <herton@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 341bf587863b..092b2a942b4c 100644
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
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 8a0b51d47040..3c156d1420d1 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -981,6 +981,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_WTP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
 #endif
+	/* the M62's vendor control channel, driven by snd-usb-audio */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPPING, USB_DEVICE_ID_TOPPING_M62) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
 	{ }
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index e62794a87e73..151b481df795 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -14,6 +14,7 @@ snd-usb-audio-y := 	card.o \
 			mixer_quirks.o \
 			mixer_scarlett.o \
 			mixer_scarlett2.o \
+			mixer_topping.o \
 			mixer_us16x08.o \
 			mixer_s1810c.o \
 			pcm.o \
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 24112e491779..e99b9341086f 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -325,6 +325,20 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	return 0;
 }
 
+/*
+ * Claim an interface of this device for snd-usb-audio.
+ *
+ * A mixer quirk may need an interface the audio class knows nothing
+ * about -- a vendor control channel that happens to wear the HID class,
+ * for instance -- and cannot claim it itself, because usb_audio_driver
+ * is private to this file.
+ */
+int snd_usb_claim_iface(struct snd_usb_audio *chip, struct usb_interface *iface)
+{
+	return usb_driver_claim_interface(&usb_audio_driver, iface,
+					  USB_AUDIO_IFACE_UNUSED);
+}
+
 /*
  * parse audio control descriptor and create pcm/midi streams
  */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a1f5592cc5d5..10f33026cdff 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -36,6 +36,7 @@
 #include "mixer_quirks.h"
 #include "mixer_scarlett.h"
 #include "mixer_scarlett2.h"
+#include "mixer_topping.h"
 #include "mixer_us16x08.h"
 #include "mixer_s1810c.h"
 #include "helper.h"
@@ -4531,6 +4532,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_fcp_init(mixer);
 		break;
 
+	case USB_ID(0x152a, 0x875c): /* Topping M62 */
+		err = snd_topping_init(mixer);
+		break;
+
 	case USB_ID(0x041e, 0x323b): /* Creative Sound Blaster E1 */
 		err = snd_soundblaster_e1_switch_create(mixer);
 		break;
diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
new file mode 100644
index 000000000000..3405f28dec66
--- /dev/null
+++ b/sound/usb/mixer_topping.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Mixer controls for Topping interfaces behind a vendor HID channel
+ *
+ * Copyright (c) 2026 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+ *
+ * The M62 (152a:875c) puts its analogue input gains and its output
+ * volumes behind a vendor protocol on a HID-class interface, and
+ * exposes nothing of them through UAC.  What UAC does expose on the
+ * capture side is a digital trim AFTER the converter, which cannot buy
+ * signal-to-noise: raising it lifts the converter's own floor with the
+ * signal.  So the only knob worth automating is unreachable, and a
+ * measurement application on Linux has to ask a human to set it by
+ * hand on the front panel.
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
+ * write, 0x11/0x26, makes the device announce its whole state, which
+ * is how the controls are populated without caching what we wrote.
+ *
+ * Note that the control pipe is not an option here: GET_REPORT and
+ * SET_REPORT both stall with EPIPE for every report type, so the
+ * interrupt endpoints on the HID interface are the only route and this
+ * driver has to own that interface.  hid_ignore_list keeps usbhid off
+ * it; the report descriptor it would bind to describes nothing anyway
+ * (a Generic Desktop application collection with eight unnamed usages
+ * and no report ID), so no HID functionality is lost.
+ */
+
+#include <linux/crc16.h>
+#include <linux/unaligned.h>
+#include <linux/init.h>
+#include <linux/cleanup.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/tlv.h>
+
+#include "usbaudio.h"
+#include "mixer.h"
+#include "mixer_topping.h"
+
+#define TOPPING_FRAME_LEN	15	/* what we send */
+#define TOPPING_REPORT_LEN	16	/* what arrives, one pad byte more */
+#define TOPPING_EP_BUF		64	/* the endpoints' packet size */
+
+/* device-scope properties */
+#define TOPPING_TT_DEVICE	0x11
+#define TOPPING_PP_SUBSCRIBE	0x24
+#define TOPPING_PP_ANNOUNCE	0x26
+
+/*
+ * The two volume tapers, measured against the vendor application's own
+ * readout: index 0 is always mute, index 99 always the maximum, the
+ * step is 0.5 dB above -10 dB and 1 dB below it, and the family that
+ * has to cover 97 dB in 98 steps takes 2 dB below -52 dB as well.
+ */
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
+/*
+ * One row per knob.  A row is the whole description of a control: what
+ * to call it, which target and property carry it, the second target
+ * that has to be written in step with the first, the range, and the
+ * scale.  Adding a knob is adding a row.
+ *
+ * The outputs come in pairs and the device announces only the second
+ * of each pair, so both are written and the second is the one listened
+ * for.
+ */
+struct topping_ctl_desc {
+	const char *name;
+	u8 target;		/* the target that reports */
+	u8 target_pair;		/* written too, or 0 */
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
+	{ "OTG Capture Volume", 0x27, 0, 0x04, 0, 99,
+	  topping_tlv_out_0 },
+	{ "Headphone Playback Volume", 0x64, 0x63, 0x03, 0, 99,
+	  topping_tlv_out_9 },
+	{ "OTG Playback Volume", 0x62, 0x61, 0x03, 0, 99,
+	  topping_tlv_out_0 },
+};
+
+struct topping_mixer {
+	struct usb_mixer_interface *mixer;
+	struct usb_interface *iface;
+	const struct topping_ctl_desc *ctls;
+	int num_ctls;
+	struct urb *urb;
+	u8 *inbuf;
+	dma_addr_t inbuf_dma;
+	unsigned int pipe_in, pipe_out;
+	int interval;
+	struct delayed_work keepalive;
+	spinlock_t lock;	/* guards val[] against the URB */
+	int *val;
+	struct snd_kcontrol **kctl;
+};
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
+static int topping_send(struct topping_mixer *tm, u8 target, u8 prop,
+			s32 value)
+{
+	u8 *buf __free(kfree) = kzalloc(TOPPING_EP_BUF, GFP_KERNEL);
+	int err, actual;
+
+	if (!buf)
+		return -ENOMEM;
+	topping_build(buf, target, prop, value);
+	err = usb_interrupt_msg(tm->mixer->chip->dev, tm->pipe_out,
+				buf, TOPPING_FRAME_LEN, &actual, 1000);
+	if (err < 0)
+		usb_audio_err(tm->mixer->chip,
+			      "Topping: write %02x/%02x failed: %d\n",
+			      target, prop, err);
+	return err;
+}
+
+/* -1 when this frame is not one of ours */
+static int topping_index_of(struct topping_mixer *tm, u8 target, u8 prop)
+{
+	int i;
+
+	for (i = 0; i < tm->num_ctls; i++)
+		if (tm->ctls[i].target == target && tm->ctls[i].prop == prop)
+			return i;
+	return -1;
+}
+
+static void topping_urb_complete(struct urb *urb)
+{
+	struct topping_mixer *tm = urb->context;
+	const u8 *f = urb->transfer_buffer;
+	int idx, value, err;
+	bool changed;
+
+	if (urb->status)
+		return;		/* resubmitted below only when running */
+	if (urb->actual_length < TOPPING_FRAME_LEN)
+		goto resubmit;
+	if (f[0] != 0x22 || f[1] != 0x33 || f[13] != 0x66 || f[14] != 0x77)
+		goto resubmit;
+	if (get_unaligned_be16(f + 11) != crc16(0xffff, f + 2, 9))
+		goto resubmit;
+
+	idx = topping_index_of(tm, f[5], f[6]);
+	if (idx < 0)
+		goto resubmit;		/* a meter, or something unnamed */
+
+	value = get_unaligned_be32(f + 7);
+	if (value < tm->ctls[idx].min || value > tm->ctls[idx].max)
+		goto resubmit;
+
+	changed = false;
+	scoped_guard(spinlock_irqsave, &tm->lock) {
+		if (tm->val[idx] != value) {
+			tm->val[idx] = value;
+			changed = true;
+		}
+	}
+
+	if (changed && tm->kctl[idx])
+		snd_ctl_notify(tm->mixer->chip->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE,
+			       &tm->kctl[idx]->id);
+
+resubmit:
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0 && err != -ENODEV && err != -ESHUTDOWN)
+		usb_audio_err(tm->mixer->chip,
+			      "Topping: cannot resubmit: %d\n", err);
+}
+
+/*
+ * THE SUBSCRIPTION LAPSES. The vendor application repeats 0x11/0x24
+ * every two seconds for as long as it is running, and a device that
+ * hears nothing stops reporting -- which is why a listener that
+ * subscribed once saw the meters and not much else. Nothing in the
+ * frame says "keep alive"; it is simply the same subscribe again.
+ */
+#define TOPPING_KEEPALIVE_MS	2000
+
+static void topping_keepalive(struct work_struct *work)
+{
+	struct topping_mixer *tm = container_of(work, struct topping_mixer,
+						keepalive.work);
+
+	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	schedule_delayed_work(&tm->keepalive,
+			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+}
+
+static int topping_ctl_info(struct snd_kcontrol *kctl,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct topping_mixer *tm = elem->head.mixer->private_data;
+	int idx = elem->control;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = tm->ctls[idx].min;
+	uinfo->value.integer.max = tm->ctls[idx].max;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int topping_ctl_get(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct topping_mixer *tm = elem->head.mixer->private_data;
+
+	guard(spinlock_irqsave)(&tm->lock);
+	ucontrol->value.integer.value[0] = tm->val[elem->control];
+	return 0;
+}
+
+static int topping_ctl_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct topping_mixer *tm = mixer->private_data;
+	const struct topping_ctl_desc *d = &tm->ctls[elem->control];
+	int value, err;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < d->min || value > d->max)
+		return -EINVAL;
+
+	scoped_guard(spinlock_irqsave, &tm->lock)
+		if (tm->val[elem->control] == value)
+			return 0;
+
+	err = topping_send(tm, d->target, d->prop, value);
+	if (err < 0)
+		return err;
+	if (d->target_pair) {
+		/*
+		 * The device announces only one of a pair, so the other
+		 * would drift away unheard.
+		 */
+		err = topping_send(tm, d->target_pair, d->prop, value);
+		if (err < 0)
+			return err;
+	}
+
+	scoped_guard(spinlock_irqsave, &tm->lock)
+		tm->val[elem->control] = value;
+	return 1;
+}
+
+static const struct snd_kcontrol_new topping_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	.info = topping_ctl_info,
+	.get = topping_ctl_get,
+	.put = topping_ctl_put,
+};
+
+static int topping_add_ctl(struct topping_mixer *tm, int idx)
+{
+	struct usb_mixer_elem_info *elem;
+	struct snd_kcontrol *kctl;
+	int err;
+
+	elem = kzalloc_obj(*elem);
+	if (!elem)
+		return -ENOMEM;
+
+	elem->head.mixer = tm->mixer;
+	elem->head.id = 0;
+	elem->control = idx;
+	elem->channels = 1;
+	elem->val_type = USB_MIXER_BESPOKEN;
+
+	kctl = snd_ctl_new1(&topping_ctl, elem);
+	if (!kctl) {
+		kfree(elem);
+		return -ENOMEM;
+	}
+	kctl->private_free = snd_usb_mixer_elem_free;
+	kctl->tlv.p = tm->ctls[idx].tlv;
+	strscpy(kctl->id.name, tm->ctls[idx].name, sizeof(kctl->id.name));
+
+	err = snd_usb_mixer_add_control(&elem->head, kctl);
+	if (err < 0)
+		return err;
+
+	tm->kctl[idx] = kctl;
+	return 0;
+}
+
+static void topping_private_free(struct usb_mixer_interface *mixer)
+{
+	struct topping_mixer *tm = mixer->private_data;
+
+	if (!tm)
+		return;
+	cancel_delayed_work_sync(&tm->keepalive);
+	if (tm->urb) {
+		usb_kill_urb(tm->urb);
+		usb_free_coherent(mixer->chip->dev, TOPPING_EP_BUF,
+				  tm->inbuf, tm->inbuf_dma);
+		usb_free_urb(tm->urb);
+	}
+	kfree(tm->val);
+	kfree(tm->kctl);
+	kfree(tm);
+	mixer->private_data = NULL;
+}
+
+/* the HID interface, by class rather than by a number in a comment */
+static struct usb_interface *topping_find_iface(struct snd_usb_audio *chip,
+						int *ep_in, int *ep_out,
+						int *interval)
+{
+	struct usb_device *dev = chip->dev;
+	struct usb_host_interface *alts;
+	struct usb_interface *iface;
+	int i, e;
+
+	for (i = 0; i < 256; i++) {
+		iface = usb_ifnum_to_if(dev, i);
+		if (!iface)
+			continue;
+		alts = &iface->altsetting[0];
+		if (alts->desc.bInterfaceClass != USB_CLASS_HID)
+			continue;
+		*ep_in = *ep_out = 0;
+		for (e = 0; e < alts->desc.bNumEndpoints; e++) {
+			struct usb_endpoint_descriptor *ep;
+
+			ep = &alts->endpoint[e].desc;
+			if (!usb_endpoint_xfer_int(ep))
+				continue;
+			if (usb_endpoint_dir_in(ep)) {
+				*ep_in = usb_endpoint_num(ep);
+				*interval = ep->bInterval;
+			} else {
+				*ep_out = usb_endpoint_num(ep);
+			}
+		}
+		if (*ep_in && *ep_out)
+			return iface;
+	}
+	return NULL;
+}
+
+int snd_topping_init(struct usb_mixer_interface *mixer)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	struct usb_interface *iface;
+	struct topping_mixer *tm;
+	int ep_in = 0, ep_out = 0, interval = 5;
+	int i, err;
+
+	iface = topping_find_iface(chip, &ep_in, &ep_out, &interval);
+	if (!iface) {
+		usb_audio_err(chip, "Topping: no vendor HID interface\n");
+		return 0;	/* not fatal: the card still plays */
+	}
+	if (usb_interface_claimed(iface)) {
+		usb_audio_err(chip,
+			      "Topping: the HID interface is already claimed\n");
+		return 0;
+	}
+
+	tm = kzalloc_obj(*tm);
+	if (!tm)
+		return -ENOMEM;
+
+	tm->mixer = mixer;
+	tm->iface = iface;
+	tm->ctls = topping_m62_ctls;
+	tm->num_ctls = ARRAY_SIZE(topping_m62_ctls);
+	tm->pipe_in = usb_rcvintpipe(chip->dev, ep_in);
+	tm->pipe_out = usb_sndintpipe(chip->dev, ep_out);
+	tm->interval = interval;
+	spin_lock_init(&tm->lock);
+	INIT_DELAYED_WORK(&tm->keepalive, topping_keepalive);
+
+	tm->val = kcalloc(tm->num_ctls, sizeof(*tm->val), GFP_KERNEL);
+	tm->kctl = kcalloc(tm->num_ctls, sizeof(*tm->kctl), GFP_KERNEL);
+	if (!tm->val || !tm->kctl) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = snd_usb_claim_iface(chip, iface);
+	if (err < 0)
+		goto fail;
+
+	tm->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!tm->urb) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	tm->inbuf = usb_alloc_coherent(chip->dev, TOPPING_EP_BUF, GFP_KERNEL,
+				       &tm->inbuf_dma);
+	if (!tm->inbuf) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	usb_fill_int_urb(tm->urb, chip->dev, tm->pipe_in,
+			 tm->inbuf, TOPPING_EP_BUF,
+			 topping_urb_complete, tm, tm->interval);
+	tm->urb->transfer_dma = tm->inbuf_dma;
+	tm->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	mixer->private_data = tm;
+	mixer->private_free = topping_private_free;
+
+	for (i = 0; i < tm->num_ctls; i++) {
+		err = topping_add_ctl(tm, i);
+		if (err < 0)
+			return err;	/* private_free cleans up */
+	}
+
+	err = usb_submit_urb(tm->urb, GFP_KERNEL);
+	if (err < 0) {
+		usb_audio_err(chip, "Topping: cannot listen: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * Subscribe, then ask for the state.  The device answers in two
+	 * waves -- identification at once, the gains about 3.7 s later,
+	 * which is the same delay a phantom rail takes to settle -- so
+	 * nothing here waits for them: each value lands through the URB
+	 * and notifies its own control.
+	 */
+	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
+	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	schedule_delayed_work(&tm->keepalive,
+			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
+	return 0;
+
+fail:
+	if (tm->inbuf)
+		usb_free_coherent(chip->dev, TOPPING_EP_BUF, tm->inbuf,
+				  tm->inbuf_dma);
+	usb_free_urb(tm->urb);
+	kfree(tm->val);
+	kfree(tm->kctl);
+	kfree(tm);
+	return err;
+}
diff --git a/sound/usb/mixer_topping.h b/sound/usb/mixer_topping.h
new file mode 100644
index 000000000000..15e16b509eb9
--- /dev/null
+++ b/sound/usb/mixer_topping.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __USB_MIXER_TOPPING_H
+#define __USB_MIXER_TOPPING_H
+
+int snd_topping_init(struct usb_mixer_interface *mixer);
+
+#endif /* __USB_MIXER_TOPPING_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index c49709d7ad25..4f9770a5db69 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -80,6 +80,9 @@ struct snd_usb_audio {
 
 #define USB_AUDIO_IFACE_UNUSED	((void *)-1L)
 
+int snd_usb_claim_iface(struct snd_usb_audio *chip,
+			struct usb_interface *iface);
+
 #define usb_audio_err(chip, fmt, args...) \
 	dev_err(&(chip)->dev->dev, fmt, ##args)
 #define usb_audio_err_ratelimited(chip, fmt, args...) \
-- 
2.55.0

