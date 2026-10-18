Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B246EC6A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357049; cv=none; b=dmm8gcM5HugaApvto0uwjXniSaUebmxbT9VFl80XO/cLLpvSEJ0GIETBzSm1t3Itkklo5+gdyA+3PTAepvxsiHflhVHbxrgz+GS04nkNN5TUlpDxx+uj1pAPCtlg13dWCvpq5KUX8Gosb9QXMEbfW2ecAwjd9sHUKfI4RffVUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357049; c=relaxed/simple;
	bh=gxFPbFHCgKwAuFU/50eXi9Vkyh5by1zilp0WcTELwXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEuGj51YRjDGrcSF5yrCcdJ0Sn2p1LrGkcg2S/BQexmEr0GGK5CmG7lA4ZzOeEeSGXAbWYwUKYH0auQ5gcft2HcZXvEZtxxTGDeJiSxn0Thjvnx2hUK/aevcY4FgkhyYGb078ylNQpNDyHcyXMeW2FCvWNSMwQjY1J/3Vc/Rp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoMdCflP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoMdCflP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso802427f8f.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792357044; x=1792961844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWfCkqoOkbXQHGdsKUA40PAlVQpFvXL+M/DfMmZGB+Y=;
        b=XoMdCflPRiiKHPjfuCbkIPhKIuHPiiQhEClorxhYpEtsrYQ7DKA9EY97uoyN1rLl9B
         S78Qa5BQL1CzPvpCIU6wQtSDp1nkDseQDQkk5Sb23hmYBw1mcVa1B44t0uiOqnaPU/Qw
         RATZJouLSNNP6JHqIZwIgQhsdEBcESDSHOYsmvpEdP5aFNP3VYKz6LgGTwg3UUFENAKi
         zypNgqh3uRtIns/IL21u+OaVX0fzm8L3DdJU12pK1e1MIOQ8hCO4KZGQj/K1eZ6HUKn4
         ej5qWc3DW/1FUDBKix3Pb3OwlhK3uKfn+lcFJnxW/s5w6wrgmAgwCJaDfxOt3roOnzVu
         H6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357044; x=1792961844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWfCkqoOkbXQHGdsKUA40PAlVQpFvXL+M/DfMmZGB+Y=;
        b=pt2yOiw8hxz2tlxEDM6U5qxQtX1+duZulf+DyNeg+cTWABu7hqFTjlGEhPTgb0d/UB
         6kS9D1r7BcrEOMMV7LBLfpfTcUiYUKRAFTeNBKsnyPObPNNc0Z/fjeuwILQr2NuhMqsw
         brfWDTrbWRmYQ7EWXwXHZGNuBcYQkNP8+blcQRMbfOJGkWDQoIl15UjXrqPSTSFSc6l/
         fqqy2mZD6Z0h+2nln2RK7CZ/L8s8FmhItSwt1uCoaAE+tO3iR59xyr15va7kco7pTKZd
         DMO7hflUSF1R0PvwlLpIhigdJ1zOMtk3gaXhvleSPnlWSu8N+62jjAq7NAzg444+XEio
         Iklg==
X-Forwarded-Encrypted: i=1; AKwUvBz38ZcGqQIEc1Iyqp+7FyoPxU+Ic4B73U869imyLNClHd8aM9RmLbMYQ73xjoqo5tN333FOjjbVvhdeCw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIwQ0SO9x/C8F01VEAkc8ck1v7mkcgntGU90TviDOrkr81htwOn
	KqZp+qF1hiHoK9OK+Io1NYTIVXYjvaCocxBKRIlXVb3hSRFUqNZTpA2G
X-Gm-Gg: AYBFou2Ijqsfit+a8M6EU5oXsZ/K4OPV6TTG5zbF+UFo7sXDyg55XjvloQLBa58gkIS
	7pzwrrTAHtUxYFzO4msyzMozZJjrGQMTpMmCVqLjLbHFmUc31XTIllXjb7/90ho0FpaCZd/acBc
	Sqjjh6+WX6HGkq9OXb3xXwIIWwOkolS4egosEGnNSK8fFa5ONX9otlPUK77efyCwVUPJs7o1ILn
	A5/k4tfFSzQi42jdsbMagkzpcdly0fhPYltTOIE+tgVfZMBdMYUWz6QFqreRcv8094WZU4pmdUh
	3MZP/4SSHqE8EdH6ZuTr8BEdUMWMGYX+dgBZ/zkmtsNr8MDW5/kozV8cCRD4kBuAlk8nGUfAkcZ
	YqUtkWXhcLcQqXO8Ar7XOHii3yLnVSJZ2ql8xQJYPDDtNLmEMbZUjl0ydt5ZbwUbY5QLd5Ukw7I
	NIrms198dO/d3CRFL0h/+eU8Tu9L2rpWjU9wWf8LY/X9lr6v+ovOzKopPPjvf0Qf75pEyNZ/HDC
	fB86J9o1kMxRbFrdU5ImKnIJlSVjIemuF7NKUaqfrXUbj0urwnTnDPpJffV2OoYuCvv/A==
X-Received: by 2002:adf:f20e:0:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48e07fb288emr7562573f8f.50.1792357044011;
        Sun, 18 Oct 2026 13:57:24 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm18496263f8f.30.2026.10.18.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:57:23 -0700 (PDT)
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
Subject: [PATCH v10 2/8] ALSA: usb-audio: add the Topping M62's vendor controls
Date: Mon, 19 Oct 2026 01:57:04 +0500
Message-ID: <20261018205711.168291-3-mikhail.v.gavrilov@gmail.com>
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

The M62's analogue input gains, output volumes and output source
selectors are reached over a vendor protocol on the card's HID
interface, which hid-topping, added in the previous patch, speaks.
This adds the controls themselves, on the sound card that plays the
audio, and the component master that joins them to that driver.

Seventeen controls in Pro Audio Mode: five input gains (IN 1, IN 2,
AUX, BT, OTG IN), two output volumes (HP, OTG OUT), the two output
source selectors, and a source selector and a gain for each of the four
loopback returns. The outputs come in pairs and the device announces
only the second of each, so both are written and the second is the one
listened for. A selector answers on one target of a pair -- the second
of an output's, the first of a loopback return's -- and a loopback
return's gain is written to both, as Q25 in whole decibels from -89
to +12 dB, the values the vendor application writes for each step. The
mixer matrix, the mutes, the input power and the EQ remain reachable
only through the HID driver's hidraw node.

The M62 has three operating modes, chosen on its own panel, and keeps
one USB ID in all three; the high byte of bcdDevice tells them apart:
01xx Mobile, 02xx Live Streaming, 03xx Pro Audio. Live Streaming goes
with Pro Audio: the application's connect push in each writes the
inputs, the loopback returns and the outputs at the same targets and on
the same scales, and Live Streaming only adds two mixes and an effects
bus that no control here reaches. In Mobile Mode the card is a two-in,
two-out device for a phone. It mixes all of its inputs into one stereo
recording, which is the whole of its capture: a microphone on IN 1, a
phone on Bluetooth and a source on AUX are all in it at once. The
host's playback is not in the recording; the headphones carry it with
every input. The card has no output selectors and no loopback returns
in that mode, and the vendor application shows none and writes none.

Part of the address map means something else in Mobile Mode. The
application writes whole decibels there to property 03 of 0x51..0x54,
where Pro Audio Mode takes Q25, and 0x51/0x52 is the level of the
recording itself: on a card in Mobile Mode, writing to it the 0 dB in
Q25 that Loopback 1/2 Capture Volume starts at raised the recording
by 9 dB, from -87.7 to -78.5 dBFS of input noise. The selectors have
nothing to select. So a row that belongs to Mobile Mode alone, or to
the other two alone, says which, and the mode is taken from bcdDevice
when the card appears; a change of mode re-enumerates the card. The
loopback returns and the six selectors are Pro Audio Mode's. The input
gains and the headphone and OTG volumes are in both: the application's
Mobile Mode screen shows them on the scales these controls use, IN 1
and IN 2 at +26 dB written as 26, AUX at 0.0 dB as 81, BT and OTG IN
at -6.0 dB as 87, the headphone output at -50 dB as 21 and the OTG
output at 0 dB as 99. Mobile Mode gets the two levels it has on the
targets of two of the loopback returns, as the application writes them:

  - PCM Playback Volume, the Playback 1/2 knob: the level of the host's
    playback in the headphones, -90 to +12 dB on 0x53/0x54;
  - Recording Capture Volume, the Recording fader: the level of the
    recording, -90 to 0 dB on 0x51/0x52.

The controls live as long as the card. They are created at the first
bind of the HID driver and stay when it unbinds, unchanged and without
an event: a value written meanwhile is kept, and the next bind writes
back every value. They are not even marked inactive, because alsa-lib's
simple mixer handles an INFO event by removing the element and adding it
again, and a sound server would see the same churn as a removal. So
reloading either driver changes nothing a holder of the card can see --
the controls keep their numids, a stored alsactl state keeps matching
them, a mixer application keeps its elements -- and no control is left
showing a value the card does not hold.

The card's state cannot be read. The card reports what a hand does to
its hardware, every turn of a front-panel knob, and when a session opens
it announces the gains of the inputs that have something plugged in --
of no other input, and never BT's or OTG IN's. A source selector has no
front-panel control and is never reported, nor are Mobile Mode's two
levels, and an output volume is not reported until its knob turns.
Topping were asked for a command that reads the selection and declined
to provide one or to commit to adding one. A host that cannot read these
values has to set them, or it inherits whatever the last host, or a hand
on the panel, left in a battery-powered card, so the first bind writes
all of them and from then on the cache is the truth, which the card's
own reports keep up to date. The gains are no exception: left unwritten,
a gain the card has not reported shows 0, alsactl stores that 0, and its
restore at the next connect writes it back, which mutes AUX, BT and
OTG IN.

The values are the ones the rest of snd-usb-audio would choose rather
than the vendor's. For a volume whose GET_CUR fails, init_cur_mix_raw()
sets the minimum, and the level a user hears is left to userspace --
alsactl and the sound server, which run after the card appears. So the
analogue headphone stage starts at its quiet end; every input gain
starts at 0 dB and the digital stream to a phone at unity, where they
change nothing; and each output listens to the host's main stream,
Playback 1/2, with the mixer out of the path. The loopback returns have
no such default to borrow, so they start where the vendor application
puts them -- on Playback 1/2, Playback 3/4, BT and OTG IN -- at unity
gain. In Mobile Mode, which has no selector to take the mixer out of the
path, the Playback 1/2 knob and the Recording fader start at 0 dB, where
they change nothing: the knob passes the playback's level on to the
headphones as Pro Audio Mode's outputs do, and the fader is at its top.
After a resume the same values are written again from the cache, in case
the card came up on its own defaults, or was changed on its panel, while
the host slept.

The master's context is reached through devres on the audio control
interface rather than through drvdata, which on a usb_interface belongs
to snd-usb-audio itself; devres_find(), keyed on the release function,
gives it back inside the callbacks, which are handed nothing but a
struct device *. It hangs off the control interface rather than off the
USB device because component_match_add() allocates the match list with
devm: on the interface that is released at unbind, while on the
usb_device it would live until the device itself was released and a
rebind would stack a second list on top. The context itself is
reference-counted, held by the mixer until it disconnects and by each
control until the card frees it.

Neither component_compare_dev() nor component_compare_dev_name() fits:
the audio side has no pointer to the HID device, and the HID device's
name carries an instance counter that is not predictable. The match is
therefore one of descent -- the HID device sits two levels below the
USB device -- and which interface it is stays the HID driver's
business, since it registers a component for the vendor interface and
for no other. That keeps sound/usb free of HID symbols and of any
opinion about this card's interface numbering.

component_master_add_with_match() returns 0 with the aggregate merely
pending when the HID driver is absent, so the card comes up either way
and grows the vendor controls if and when the other half appears.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 MAINTAINERS               |  10 +
 sound/usb/Makefile        |   1 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 991 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 5 files changed, 1014 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a5c7dbd..75fdd2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27630,6 +27630,16 @@ S:	Maintained
 W:	https://tomoyo.sourceforge.net/
 F:	security/tomoyo/
 
+TOPPING AUDIO INTERFACE VENDOR CONTROLS
+M:	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
+L:	linux-sound@vger.kernel.org
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-topping.c
+F:	include/sound/topping.h
+F:	sound/usb/mixer_topping.c
+F:	sound/usb/mixer_topping.h
+
 TOPSTAR LAPTOP EXTRAS DRIVER
 M:	Herton Ronaldo Krzesinski <herton@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 2e842dc..5b511b5 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -15,6 +15,7 @@ snd-usb-audio-y := 	card.o \
 			mixer_quirks.o \
 			mixer_scarlett.o \
 			mixer_scarlett2.o \
+			mixer_topping.o \
 			mixer_us16x08.o \
 			mixer_s1810c.o \
 			pcm.o \
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 01210cc..78d1966 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -36,6 +36,7 @@
 #include "mixer_quirks.h"
 #include "mixer_scarlett.h"
 #include "mixer_scarlett2.h"
+#include "mixer_topping.h"
 #include "mixer_us16x08.h"
 #include "mixer_s1810c.h"
 #include "mixer_evo.h"
@@ -4544,6 +4545,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_evo_controls_create(mixer);
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
index 0000000..cd848a3
--- /dev/null
+++ b/sound/usb/mixer_topping.c
@@ -0,0 +1,991 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Topping M62 -- the card's vendor controls.
+ *
+ * The M62's analogue input gains, output volumes, source selectors and
+ * loopback gains are not described by the USB Audio Class.  They are
+ * reached over a vendor protocol on the card's HID interface, which
+ * hid-topping speaks.  This file owns the controls; that driver is
+ * the transport.  The two meet through the component framework, with
+ * this side as the master, in the same shape as HD-audio and the
+ * graphics drivers in sound/hda/core/component.c: the master owns a
+ * struct topping_component, and the HID driver fills in its one
+ * operation when it binds and clears it when it unbinds.
+ *
+ * THE CONTROLS LIVE AS LONG AS THE CARD.  They are created at the first
+ * bind of the HID driver and not removed when it unbinds: a value
+ * written meanwhile is kept, and the next bind writes everything back.
+ * Nothing about them changes in between, not even their active flag --
+ * alsa-lib's simple mixer handles an INFO event by removing the element
+ * and adding it again, which is exactly the churn a sound server must
+ * not see.  So reloading either driver changes nothing that anyone
+ * holding the card can see: the controls keep their numids, a stored
+ * alsactl state keeps matching them, and a mixer application keeps its
+ * elements.
+ *
+ * THE CARD'S STATE CANNOT BE READ.  The card reports what a hand does to
+ * its hardware, every turn of a front-panel knob, and when a session
+ * opens it announces the gains of the inputs that have something
+ * plugged in; nothing answers a request for a value.  A host that does
+ * not set the card inherits whatever the last host, or a hand on the
+ * panel, left in a battery-powered card.  So the first bind writes
+ * everything, and from then on the cache is the truth, which the card's
+ * own reports keep up to date: each output listens to the host's main
+ * stream, Playback 1/2, with the mixer out of the path, or at 0 dB
+ * through it where there is no way around it, as on an M62 in Mobile
+ * Mode; every input gain starts at 0 dB, where it changes nothing; the
+ * analogue headphone stage starts at its quiet end; and the digital
+ * stream to a phone starts at unity.  That follows the usual Linux
+ * division -- the kernel puts the hardware into a defined state, and the
+ * level a user hears is set from userspace, by alsactl's restore or init
+ * and by the sound server, both of which run after the card appears.
+ */
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/cleanup.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/tlv.h>
+#include <sound/topping.h>
+
+#include "usbaudio.h"
+#include "mixer.h"
+#include "helper.h"
+#include "mixer_topping.h"
+
+/* ------------------------------------------------------------------ */
+/* what the controls are						*/
+/* ------------------------------------------------------------------ */
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
+ * that has to be written in step with the first, the range, what the
+ * first bind writes, and the scale.  Adding a knob is adding a row.
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
+	int first;		/* written at the first bind */
+	const unsigned int *tlv;
+	const s32 *map;		/* what each step writes, or NULL: the step */
+	u8 modes;		/* the modes that have it, or 0 for all */
+};
+
+/*
+ * THE M62 HAS THREE OPERATING MODES, chosen on its panel, and tells
+ * which in the high byte of bcdDevice: 01xx Mobile, 02xx Live Streaming,
+ * 03xx Pro Audio.  Live Streaming and Pro Audio keep everything these
+ * controls reach at the same targets; Live Streaming only adds two mixes
+ * and an effects bus, which none of them reaches.  Mobile Mode is another
+ * mixer behind the same targets: the card mixes all of its inputs into
+ * one stereo recording, which is the whole of its capture, and has no
+ * output selectors and no loopback returns.  A row that belongs to
+ * Mobile Mode alone, or to the other two alone, says which.
+ */
+#define TOPPING_MOBILE		BIT(0)
+#define TOPPING_PRO		BIT(1)
+
+/*
+ * A loopback return's gain, in whole decibels: step 0 is off and step
+ * n is n - 90 dB, up to +12 dB.  These are the values the vendor
+ * application writes for each step, Q25 with 0 dB at 1 << 25.
+ */
+static const s32 topping_m62_lb_gain[] = {
+	0, 1190, 1335, 1498, 1681, 1886,
+	2117, 2375, 2665, 2990, 3355, 3764,
+	4224, 4739, 5318, 5966, 6694, 7511,
+	8428, 9456, 10610, 11905, 13358, 14988,
+	16817, 18869, 21171, 23754, 26653, 29905,
+	33554, 37648, 42242, 47396, 53180, 59669,
+	66949, 75119, 84284, 94569, 106108, 119055,
+	133582, 149882, 168170, 188690, 211714, 237547,
+	266532, 299054, 335544, 376486, 422425, 473968,
+	531801, 596691, 669498, 751190, 842849, 945692,
+	1061084, 1190556, 1335825, 1498821, 1681705, 1886904,
+	2117141, 2375471, 2665323, 2990541, 3355443, 3764869,
+	4224252, 4739689, 5318019, 5966915, 6694989, 7511901,
+	8428492, 9456923, 10610843, 11905561, 13358259, 14988214,
+	16817052, 18869043, 21171415, 23754718, 26653232, 29905418,
+	33554432, 37648691, 42242527, 47396894, 53180190, 59669155,
+	66949893, 75119016, 84284922, 94569238, 106108430, 119055617,
+	133582599,
+};
+
+static_assert(ARRAY_SIZE(topping_m62_lb_gain) == 103);
+
+static const DECLARE_TLV_DB_SCALE(topping_tlv_lb, -9000, 100, 1);
+
+static const struct topping_ctl_desc topping_m62_ctls[] = {
+	{ "Mic1 Analog Capture Volume", 0x21, 0, 0x04, 0, 88,
+	  0, topping_tlv_gain },			/* 0 dB */
+	{ "Mic2 Analog Capture Volume", 0x22, 0, 0x04, 0, 88,
+	  0, topping_tlv_gain },			/* 0 dB */
+	{ "Aux Capture Volume", 0x23, 0, 0x04, 0, 99,
+	  81, topping_tlv_out_9 },		/* 0 dB */
+	{ "Bluetooth Capture Volume", 0x25, 0, 0x04, 0, 99,
+	  99, topping_tlv_out_0 },		/* 0 dB */
+	{ "OTG Capture Volume", 0x27, 0, 0x04, 0, 99,
+	  99, topping_tlv_out_0 },		/* 0 dB */
+	{ "Headphone Playback Volume", 0x64, 0x63, 0x03, 0, 99,
+	  0, topping_tlv_out_9 },		/* the quiet end */
+	{ "OTG Playback Volume", 0x62, 0x61, 0x03, 0, 99,
+	  99, topping_tlv_out_0 },		/* 0 dB, unity */
+	/*
+	 * A loopback return's gain is written to both targets of its pair
+	 * and never reported.  It starts at 0 dB, unity, as the vendor
+	 * application sets it.
+	 */
+	{ "Loopback 1/2 Capture Volume", 0x51, 0x52, 0x03, 0, 102,
+	  90, topping_tlv_lb, topping_m62_lb_gain, .modes = TOPPING_PRO },
+	{ "Loopback 3/4 Capture Volume", 0x53, 0x54, 0x03, 0, 102,
+	  90, topping_tlv_lb, topping_m62_lb_gain, .modes = TOPPING_PRO },
+	{ "Loopback 5/6 Capture Volume", 0x55, 0x56, 0x03, 0, 102,
+	  90, topping_tlv_lb, topping_m62_lb_gain, .modes = TOPPING_PRO },
+	{ "Loopback 7/8 Capture Volume", 0x57, 0x58, 0x03, 0, 102,
+	  90, topping_tlv_lb, topping_m62_lb_gain, .modes = TOPPING_PRO },
+	/*
+	 * In Mobile Mode two of those pairs carry the vendor application's
+	 * Playback 1/2 knob, the level of the host's playback in the
+	 * headphones, which carry it with every input while the recording
+	 * does not, and its Recording fader, the level of the recording.
+	 * Both are whole decibels, -90 to +12 and -90 to 0, where Pro Audio
+	 * Mode takes Q25 on the same targets.  Neither is reported, so the
+	 * first bind writes 0 dB: the knob then passes the playback's level
+	 * on unchanged, as Pro Audio Mode's outputs do with the mixer out of
+	 * the path, and the fader is at its top.
+	 */
+	{ "PCM Playback Volume", 0x53, 0x54, 0x03, -90, 12,
+	  0, topping_tlv_lb, .modes = TOPPING_MOBILE },
+	{ "Recording Capture Volume", 0x51, 0x52, 0x03, -90, 0,
+	  0, topping_tlv_lb, .modes = TOPPING_MOBILE },
+};
+
+#define TOPPING_NUM_CTLS	ARRAY_SIZE(topping_m62_ctls)
+
+/*
+ * WHAT AN OUTPUT CAN LISTEN TO.  The same numbering serves the outputs
+ * and the loopback returns, and it has a hole where 4 and 5 would be,
+ * so the index of a control item is not the value the card wants and
+ * the two are kept side by side.
+ */
+static const char * const topping_m62_sources[] = {
+	"Mix A", "Mix B", "Mix C", "IN 1", "IN 2", "IN 1+2", "AUX", "BT",
+	"OTG IN", "Playback 1/2", "Playback 3/4", "Playback 5/6",
+	"Playback 7/8", "Playback 9/10",
+};
+
+static const u8 topping_m62_source_value[] = {
+	1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
+};
+
+static_assert(ARRAY_SIZE(topping_m62_sources) ==
+	      ARRAY_SIZE(topping_m62_source_value));
+
+/* items, not card values */
+#define TOPPING_M62_BT			7
+#define TOPPING_M62_OTG_IN		8
+#define TOPPING_M62_PLAYBACK_1_2	9
+#define TOPPING_M62_PLAYBACK_3_4	10
+
+struct topping_enum_desc {
+	const char *name;
+	u8 target;
+	u8 prop;
+	unsigned int first;	/* the item written at the first bind */
+	u8 modes;		/* the modes that have it, or 0 for all */
+};
+
+/*
+ * A selector answers on ONE target of a pair, unlike a volume or a
+ * mute, which must be written to both: the second target of an
+ * output's pair, the first of a loopback return's.  It is never
+ * reported, so it is always written at the first bind.  The outputs
+ * start on the host's main stream, the loopback returns where the
+ * vendor application puts them.
+ *
+ * The names end in "Source", not "Route": alsa-lib's simple mixer joins
+ * a "... Playback Route" or "... Capture Route" enumeration to the
+ * volume of the same name and then reads and writes only the
+ * enumeration, which would take the volume away from every mixer
+ * built on it.
+ */
+static const struct topping_enum_desc topping_m62_enums[] = {
+	{ "Headphone Playback Source", 0x64, 0x02,
+	  TOPPING_M62_PLAYBACK_1_2, TOPPING_PRO },
+	{ "OTG Playback Source", 0x62, 0x02,
+	  TOPPING_M62_PLAYBACK_1_2, TOPPING_PRO },
+	{ "Loopback 1/2 Capture Source", 0x51, 0x02,
+	  TOPPING_M62_PLAYBACK_1_2, TOPPING_PRO },
+	{ "Loopback 3/4 Capture Source", 0x53, 0x02,
+	  TOPPING_M62_PLAYBACK_3_4, TOPPING_PRO },
+	{ "Loopback 5/6 Capture Source", 0x55, 0x02,
+	  TOPPING_M62_BT, TOPPING_PRO },
+	{ "Loopback 7/8 Capture Source", 0x57, 0x02,
+	  TOPPING_M62_OTG_IN, TOPPING_PRO },
+};
+
+#define TOPPING_NUM_ENUMS	ARRAY_SIZE(topping_m62_enums)
+#define TOPPING_NUM_KCTLS	(TOPPING_NUM_CTLS + TOPPING_NUM_ENUMS)
+
+/*
+ * One per card, and as long-lived as the card's controls: each control
+ * holds a reference, and so does the mixer until it disconnects.  The
+ * controls are freed with the card, which can be well after the
+ * disconnect, and nothing here may go before them.
+ */
+struct topping_mixer {
+	struct kref ref;
+	struct device *dev;		/* the audio control interface */
+	struct snd_card *card;
+	struct usb_mixer_interface *mixer;
+
+	u8 mode;			/* TOPPING_MOBILE or TOPPING_PRO */
+	struct topping_component comp;
+	struct work_struct resume_work;
+
+	/*
+	 * One writer at a time, end to end, and @bound with it: a write
+	 * reaches the card through comp.ops only under this lock and only
+	 * while @bound is set, and the HID driver clears comp.ops only
+	 * after @bound has been cleared under it.
+	 */
+	struct mutex lock;
+	bool bound;
+	bool created;			/* the controls exist */
+
+	spinlock_t val_lock;		/* the cache and kctl[] against reports */
+	int val[TOPPING_NUM_CTLS];
+	unsigned int sel[TOPPING_NUM_ENUMS];
+
+	/* the volume controls first, then the selectors */
+	struct snd_kcontrol *kctl[TOPPING_NUM_KCTLS];
+};
+
+static void topping_mixer_release(struct kref *ref)
+{
+	struct topping_mixer *tm = container_of(ref, struct topping_mixer,
+						ref);
+
+	mutex_destroy(&tm->lock);
+	kfree(tm);
+}
+
+/* ------------------------------------------------------------------ */
+/* writing to the card							*/
+/* ------------------------------------------------------------------ */
+
+static int topping_write(struct topping_mixer *tm, u8 target, u8 prop,
+			 s32 value)
+{
+	lockdep_assert_held(&tm->lock);
+
+	return tm->comp.ops->write(tm->comp.dev, target, prop, value);
+}
+
+/* whether a row for @modes exists on this card */
+static bool topping_here(const struct topping_mixer *tm, u8 modes)
+{
+	return !modes || (modes & tm->mode);
+}
+
+static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
+{
+	const struct topping_ctl_desc *d = &topping_m62_ctls[idx];
+	s32 wire = d->map ? d->map[value] : value;
+	int err;
+
+	err = topping_write(tm, d->target, d->prop, wire);
+	if (!err && d->target_pair) {
+		/*
+		 * The device announces only one of a pair, so the other
+		 * would drift away unheard.
+		 */
+		err = topping_write(tm, d->target_pair, d->prop, wire);
+	}
+	return err;
+}
+
+static int topping_write_sel(struct topping_mixer *tm, int idx,
+			     unsigned int item)
+{
+	const struct topping_enum_desc *d = &topping_m62_enums[idx];
+
+	return topping_write(tm, d->target, d->prop,
+			     topping_m62_source_value[item]);
+}
+
+/*
+ * Brings the card into line with the cache: at the first bind, from the
+ * values the cache was born with; at a later bind, with what was set
+ * while this side was alone, which is still only in the cache; and after
+ * a resume, in case the card came up on its own defaults or was changed
+ * on its panel while the host slept.
+ *
+ * Errors are not passed on.  The HID driver logs the ones that mean
+ * something, and a card that cannot be written now is written again by
+ * the next bind or resume.
+ */
+static void topping_sync(struct topping_mixer *tm)
+{
+	int i, value;
+
+	lockdep_assert_held(&tm->lock);
+
+	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
+		if (!topping_here(tm, topping_m62_ctls[i].modes))
+			continue;
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			value = tm->val[i];
+		topping_write_ctl(tm, i, value);
+	}
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
+		if (!topping_here(tm, topping_m62_enums[i].modes))
+			continue;
+		topping_write_sel(tm, i, tm->sel[i]);
+	}
+}
+
+static void topping_resume_work(struct work_struct *work)
+{
+	struct topping_mixer *tm = container_of(work, struct topping_mixer,
+						resume_work);
+
+	guard(mutex)(&tm->lock);
+	if (tm->bound)
+		topping_sync(tm);
+}
+
+/* ------------------------------------------------------------------ */
+/* what the HID driver tells this side					*/
+/* ------------------------------------------------------------------ */
+
+/* -1 when this frame is not one of ours */
+static int topping_index_of(const struct topping_mixer *tm, u8 target,
+			    u8 prop)
+{
+	int i;
+
+	for (i = 0; i < TOPPING_NUM_CTLS; i++)
+		if (topping_m62_ctls[i].target == target &&
+		    topping_m62_ctls[i].prop == prop &&
+		    topping_here(tm, topping_m62_ctls[i].modes))
+			return i;
+	return -1;
+}
+
+/*
+ * Every frame the card sends, meters included, in the HID driver's
+ * interrupt context -- hence the spinlock.
+ *
+ * The notify happens under the same lock that guards the cache, not
+ * after it.  snd_ctl_notify() dereferences the id it is given, and the
+ * control's own private_free clears kctl[] under this lock.  It is safe
+ * from here: it takes read_lock_irqsave and allocates with GFP_ATOMIC.
+ */
+static void topping_report(struct topping_component *comp, u8 target,
+			   u8 prop, s32 value)
+{
+	struct topping_mixer *tm = container_of(comp, struct topping_mixer,
+						comp);
+	int idx;
+
+	idx = topping_index_of(tm, target, prop);
+	if (idx < 0)
+		return;			/* a meter, or something unnamed */
+	if (value < topping_m62_ctls[idx].min ||
+	    value > topping_m62_ctls[idx].max)
+		return;
+
+	guard(spinlock_irqsave)(&tm->val_lock);
+
+	if (tm->val[idx] == value)
+		return;
+	tm->val[idx] = value;
+
+	if (tm->kctl[idx])
+		snd_ctl_notify(tm->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &tm->kctl[idx]->id);
+}
+
+/* Atomic context, so the writing is left to a worker. */
+static void topping_resumed(struct topping_component *comp)
+{
+	struct topping_mixer *tm = container_of(comp, struct topping_mixer,
+						comp);
+
+	schedule_work(&tm->resume_work);
+}
+
+/*
+ * The HID driver is going and takes its operation with it.  Clearing
+ * @bound under the lock waits out a write already inside it, and turns
+ * every later one into a cache update that the next bind writes out.
+ */
+static void topping_unbound(struct topping_component *comp)
+{
+	struct topping_mixer *tm = container_of(comp, struct topping_mixer,
+						comp);
+
+	guard(mutex)(&tm->lock);
+	tm->bound = false;
+}
+
+static const struct topping_audio_ops topping_mixer_ops = {
+	.report		= topping_report,
+	.resumed	= topping_resumed,
+	.unbound	= topping_unbound,
+};
+
+/* ------------------------------------------------------------------ */
+/* the volume controls							*/
+/* ------------------------------------------------------------------ */
+
+static int topping_ctl_info(struct snd_kcontrol *kctl,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	const struct topping_ctl_desc *d;
+
+	d = &topping_m62_ctls[kctl->private_value];
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = d->min;
+	uinfo->value.integer.max = d->max;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int topping_ctl_get(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
+
+	guard(spinlock_irqsave)(&tm->val_lock);
+	ucontrol->value.integer.value[0] = tm->val[kctl->private_value];
+	return 0;
+}
+
+static int topping_ctl_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
+	int idx = kctl->private_value;
+	int value, prev, err;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < topping_m62_ctls[idx].min ||
+	    value > topping_m62_ctls[idx].max)
+		return -EINVAL;
+
+	/*
+	 * Held from the comparison to the end of the write, so that two
+	 * writers cannot reach the device in one order and the cache in
+	 * the other.  The wake inside the write is safe under it: the
+	 * resume it may run on this thread only schedules work.
+	 */
+	guard(mutex)(&tm->lock);
+
+	/*
+	 * The cache takes the new value BEFORE the write, not after.  A
+	 * hand on the front panel during the write produces a report the
+	 * cache stores; updating afterwards would throw that away and
+	 * leave a value the device had already moved away from.  Written
+	 * first, the device's own report is simply the last word, which
+	 * is the right bias.
+	 */
+	scoped_guard(spinlock_irqsave, &tm->val_lock) {
+		if (tm->val[idx] == value)
+			return 0;
+		prev = tm->val[idx];
+		tm->val[idx] = value;
+	}
+
+	/* kept, and written when the HID driver binds again */
+	if (!tm->bound)
+		return 1;
+
+	err = topping_write_ctl(tm, idx, value);
+	if (err < 0) {
+		/* put back what was there, unless the device has spoken */
+		scoped_guard(spinlock_irqsave, &tm->val_lock) {
+			if (tm->val[idx] == value)
+				tm->val[idx] = prev;
+		}
+		return err;
+	}
+
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
+/* ------------------------------------------------------------------ */
+/* the source selectors							*/
+/* ------------------------------------------------------------------ */
+
+static int topping_sel_info(struct snd_kcontrol *kctl,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(topping_m62_sources),
+				 topping_m62_sources);
+}
+
+static int topping_sel_get(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
+	int idx = kctl->private_value - TOPPING_NUM_CTLS;
+
+	guard(spinlock_irqsave)(&tm->val_lock);
+	ucontrol->value.enumerated.item[0] = tm->sel[idx];
+	return 0;
+}
+
+static int topping_sel_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
+	int idx = kctl->private_value - TOPPING_NUM_CTLS;
+	unsigned int item, prev;
+	int err;
+
+	item = ucontrol->value.enumerated.item[0];
+	if (item >= ARRAY_SIZE(topping_m62_sources))
+		return -EINVAL;
+
+	guard(mutex)(&tm->lock);
+
+	/*
+	 * No report ever moves a selector, so the cache can be compared
+	 * and changed outside the spinlock; the spinlock is still taken
+	 * for the reader's sake.
+	 */
+	prev = tm->sel[idx];
+	if (prev == item)
+		return 0;
+	scoped_guard(spinlock_irqsave, &tm->val_lock)
+		tm->sel[idx] = item;
+
+	if (!tm->bound)
+		return 1;
+
+	err = topping_write_sel(tm, idx, item);
+	if (err < 0) {
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			tm->sel[idx] = prev;
+		return err;
+	}
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new topping_sel = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = topping_sel_info,
+	.get = topping_sel_get,
+	.put = topping_sel_put,
+};
+
+/* ------------------------------------------------------------------ */
+/* creating the controls						*/
+/* ------------------------------------------------------------------ */
+
+/* @kctl->private_value is the slot: volumes first, then selectors */
+static void topping_kctl_free(struct snd_kcontrol *kctl)
+{
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
+
+	scoped_guard(spinlock_irqsave, &tm->val_lock)
+		tm->kctl[kctl->private_value] = NULL;
+
+	kref_put(&tm->ref, topping_mixer_release);
+}
+
+static int topping_add_kctl(struct topping_mixer *tm,
+			    const struct snd_kcontrol_new *tmpl,
+			    const char *name, int slot,
+			    const unsigned int *tlv)
+{
+	struct snd_kcontrol *k;
+	int err;
+
+	k = snd_ctl_new1(tmpl, tm);
+	if (!k)
+		return -ENOMEM;
+
+	k->private_value = slot;
+	k->tlv.p = tlv;
+	strscpy(k->id.name, name, sizeof(k->id.name));
+	kref_get(&tm->ref);
+	k->private_free = topping_kctl_free;
+
+	err = snd_ctl_add(tm->card, k);
+	if (err < 0)
+		return err;	/* freed, and the reference with it */
+
+	scoped_guard(spinlock_irqsave, &tm->val_lock)
+		tm->kctl[slot] = k;
+	return 0;
+}
+
+static int topping_create_kctls(struct topping_mixer *tm)
+{
+	int i, err;
+
+	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
+		if (!topping_here(tm, topping_m62_ctls[i].modes))
+			continue;
+		err = topping_add_kctl(tm, &topping_ctl,
+				       topping_m62_ctls[i].name, i,
+				       topping_m62_ctls[i].tlv);
+		if (err < 0)
+			goto err_remove;
+	}
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
+		if (!topping_here(tm, topping_m62_enums[i].modes))
+			continue;
+		err = topping_add_kctl(tm, &topping_sel,
+				       topping_m62_enums[i].name,
+				       TOPPING_NUM_CTLS + i, NULL);
+		if (err < 0)
+			goto err_remove;
+	}
+	return 0;
+
+err_remove:
+	for (i = 0; i < TOPPING_NUM_KCTLS; i++)
+		if (tm->kctl[i])
+			snd_ctl_remove(tm->card, tm->kctl[i]);
+	return err;
+}
+
+/* ------------------------------------------------------------------ */
+/* component master							*/
+/* ------------------------------------------------------------------ */
+
+/*
+ * Where the callbacks find this card's context.  It lives in devres on
+ * the audio control interface rather than in drvdata, because drvdata
+ * on a usb_interface belongs to snd-usb-audio itself.  devres_find(),
+ * keyed on the release function, gives it back inside the callbacks,
+ * which are handed nothing but a struct device *.
+ */
+struct topping_master_res {
+	struct topping_mixer *tm;
+};
+
+static void topping_master_release(struct device *dev, void *res)
+{
+	/*
+	 * Storage only.  Taking the master down is a separate devres
+	 * action registered after the match array, so that it runs
+	 * before it -- see topping_master_teardown() below.
+	 */
+}
+
+static struct topping_mixer *topping_get_master(struct device *dev)
+{
+	struct topping_master_res *res;
+
+	res = devres_find(dev, topping_master_release, NULL, NULL);
+	return res ? res->tm : NULL;
+}
+
+/*
+ * Which of the registered components is ours.
+ *
+ * This is only ever called against devices that have registered with
+ * component_add(), so it does not have to defend itself against the whole
+ * device tree.  What it does have to do is tell this card's vendor
+ * function apart from a second M62 on another port.
+ *
+ * The HID device sits two levels below the USB device:
+ *
+ *	hid_device  ->  usb_interface  ->  usb_device
+ *
+ * WHICH interface it is, is the HID driver's business: it registers a
+ * component for the vendor interface and for nothing else.  So the test
+ * here is one of descent alone and needs no HID symbols in sound/usb --
+ * which also keeps this file free of any opinion about the M62's
+ * interface numbering.
+ */
+static int topping_match_component(struct device *dev, void *data)
+{
+	return dev->parent && dev->parent->parent == data;
+}
+
+static int topping_master_bind(struct device *dev)
+{
+	struct topping_mixer *tm = topping_get_master(dev);
+	bool first;
+	int err;
+
+	/*
+	 * Not a bug, and deliberately not a WARN.  devres_release_all()
+	 * moves every node off the device before it calls a single
+	 * release, so between a failed probe beginning to unwind and the
+	 * teardown action running, the context is already gone while the
+	 * aggregate is still registered.  A component that arrives in
+	 * that window has simply come at the wrong moment; EPROBE_DEFER
+	 * says so, and the framework does not log it.
+	 */
+	if (!tm)
+		return -EPROBE_DEFER;
+
+	err = component_bind_all(dev, &tm->comp);
+	if (err)
+		return err;
+
+	/*
+	 * Created with our lock not held: snd_ctl_add() takes
+	 * controls_rwsem for writing, and a put holding it for reading
+	 * can be waiting for our lock.
+	 */
+	first = !tm->created;
+	if (first) {
+		err = topping_create_kctls(tm);
+		if (err < 0) {
+			component_unbind_all(dev, NULL);
+			return err;
+		}
+		tm->created = true;
+	}
+
+	guard(mutex)(&tm->lock);
+	tm->bound = true;
+	topping_sync(tm);
+	return 0;
+}
+
+/*
+ * No topping_get_master() here, deliberately.  This can run while the
+ * interface's devres is unwinding, and devres_release_all() moves every
+ * node off the device before it calls a single release, so the lookup
+ * would come back empty and the unbind would be skipped altogether.
+ *
+ * Nor is anything needed from it: the HID driver kept the structure it
+ * was handed at bind, and tells this side through it that it is going.
+ */
+static void topping_master_unbind(struct device *dev)
+{
+	component_unbind_all(dev, NULL);
+}
+
+static const struct component_master_ops topping_master_ops = {
+	.bind	= topping_master_bind,
+	.unbind	= topping_master_unbind,
+};
+
+/*
+ * Registered as a devres action AFTER component_match_add(), because
+ * devres unwinds in reverse: this then runs before the match array is
+ * freed, and component_unbind_all() walks that array.
+ *
+ * Two roads reach it.  Normally topping_private_free() calls it through
+ * devm_release_action().  The other is a probe that got as far as
+ * creating this mixer and then failed: usb_audio_probe() leaves the
+ * card and its mixer list alone in that case, as long as an earlier
+ * interface had succeeded, so the mixer would outlive the interface
+ * whose devres this is.  Unhooking it here is what keeps a later
+ * disconnect from reaching this context.
+ *
+ * The mixer's reference is dropped last.  The controls hold theirs
+ * until the card frees them.
+ */
+static void topping_master_teardown(void *data)
+{
+	struct topping_mixer *tm = data;
+
+	component_master_del(tm->dev, &topping_master_ops);
+	cancel_work_sync(&tm->resume_work);
+
+	if (tm->mixer) {
+		tm->mixer->private_data = NULL;
+		tm->mixer->private_free = NULL;
+	}
+
+	kref_put(&tm->ref, topping_mixer_release);
+}
+
+static void topping_private_free(struct usb_mixer_interface *mixer)
+{
+	struct topping_mixer *tm = mixer->private_data;
+	struct device *dev;
+
+	if (!tm)
+		return;
+
+	/*
+	 * Reached from snd_usb_mixer_disconnect(), on an unplug and on an
+	 * unbind of the audio interface alike.  The action clears
+	 * mixer->private_data on its way through and may drop the last
+	 * reference, so the device is taken first.
+	 */
+	dev = tm->dev;
+	devm_release_action(dev, topping_master_teardown, tm);
+	devres_destroy(dev, topping_master_release, NULL, NULL);
+}
+
+static struct topping_mixer *topping_mixer_new(struct usb_mixer_interface *mixer,
+					       struct device *dev, u8 mode)
+{
+	struct topping_mixer *tm;
+	int i;
+
+	tm = kzalloc_obj(*tm);
+	if (!tm)
+		return NULL;
+
+	kref_init(&tm->ref);		/* the mixer's */
+	tm->mode = mode;
+	tm->dev = dev;
+	tm->card = mixer->chip->card;
+	tm->mixer = mixer;
+	tm->comp.audio_ops = &topping_mixer_ops;
+	INIT_WORK(&tm->resume_work, topping_resume_work);
+	mutex_init(&tm->lock);
+	spin_lock_init(&tm->val_lock);
+
+	/* what the cache is born with is what the first bind writes */
+	for (i = 0; i < TOPPING_NUM_CTLS; i++)
+		tm->val[i] = topping_m62_ctls[i].first;
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++)
+		tm->sel[i] = topping_m62_enums[i].first;
+
+	return tm;
+}
+
+int snd_topping_init(struct usb_mixer_interface *mixer)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	struct component_match *match = NULL;
+	struct topping_master_res *res;
+	struct usb_interface *intf;
+	struct topping_mixer *tm;
+	struct device *dev;
+	u8 mode = TOPPING_PRO;
+	int err;
+
+	if (le16_to_cpu(chip->dev->descriptor.bcdDevice) >> 8 == 0x01)
+		mode = TOPPING_MOBILE;
+
+	/*
+	 * The master hangs off the audio control interface rather than off
+	 * the USB device: component_match_add() allocates the match list
+	 * with devm, and on an interface that is released when the interface
+	 * is unbound.  On the usb_device it would live until the device
+	 * itself was released, and a rebind would stack a second list on top
+	 * of the first.
+	 */
+	intf = usb_ifnum_to_if(chip->dev,
+			       get_iface_desc(mixer->hostif)->bInterfaceNumber);
+	if (!intf)
+		return -ENODEV;
+	dev = &intf->dev;
+
+	tm = topping_mixer_new(mixer, dev, mode);
+	if (!tm)
+		return -ENOMEM;
+
+	res = devres_alloc(topping_master_release, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		kref_put(&tm->ref, topping_mixer_release);
+		return -ENOMEM;
+	}
+	res->tm = tm;
+	devres_add(dev, res);
+
+	mixer->private_data = tm;
+	mixer->private_free = topping_private_free;
+
+	component_match_add(dev, &match, topping_match_component,
+			    &chip->dev->dev);
+
+	/*
+	 * component_match_add() reports a failed allocation by storing
+	 * an error pointer rather than by returning, and
+	 * component_master_add_with_match() dereferences what it is
+	 * given without looking.
+	 */
+	if (IS_ERR(match)) {
+		err = PTR_ERR(match);
+		goto err_free;
+	}
+
+	/*
+	 * This returns 0 with the aggregate merely pending when
+	 * hid-topping has not registered its component yet:
+	 * try_to_bring_up_aggregate_device() reports an incomplete set as
+	 * "not ready", not as an error.  So the card comes up either way
+	 * and grows the vendor controls if and when the other half appears.
+	 */
+	err = component_master_add_with_match(dev, &topping_master_ops, match);
+	if (err < 0)
+		goto err_free;
+
+	/* Last, so that devres releases it first -- see the teardown. */
+	err = devm_add_action(dev, topping_master_teardown, tm);
+	if (err < 0) {
+		component_master_del(dev, &topping_master_ops);
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	mixer->private_data = NULL;
+	mixer->private_free = NULL;
+	devres_destroy(dev, topping_master_release, NULL, NULL);
+	cancel_work_sync(&tm->resume_work);
+	kref_put(&tm->ref, topping_mixer_release);
+	usb_audio_err(chip, "Topping: no component master: %d\n", err);
+	return err;
+}
diff --git a/sound/usb/mixer_topping.h b/sound/usb/mixer_topping.h
new file mode 100644
index 0000000..15e16b5
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
-- 
2.43.0

