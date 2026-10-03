Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB79457E55
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052963; cv=none; b=fgciyjY4GNRPlmKiVVMTexlZfsMwUmVwWwvEGc2dz5uBO5KW49GsvyK0Dp03y+cG98Bd3aalSReg1LDPENFNiFpG5KbCrKg5RY9tuTbTeMY8k71yPyL906uBqoopnCJ6JVEQ8v88fhjtEeg3nIqGjnLRdTBOtr6UefBf+PUuiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052963; c=relaxed/simple;
	bh=t8ry6+PyPiLyTfYw0sns5Egq8nVFCpgT2kopRFdzrKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCrEHzoGiAZColX/ncXYpeKB6wIn+TAFPx4YrpDEpRa6qayNNIDn/wYeCd2nreemDJzBVcuL23pqbf7K/atmepvyrsL+EBJh9/22iX2qVNt2i2D3T45ldYk8xGyvS0pIfgGfXOdTkuXNIEBlQNRMufS8Ikg528XjZMn6+iSXNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD8MgOXF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD8MgOXF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so4891325e9.0
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052948; x=1791657748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNmkTjjoAfa2N4w2c1hhRM5QOyXo2Miq8JHRcxKPf6M=;
        b=YD8MgOXF6V9+HNlKdzmAmp1i6PJLwgZYKZ/C4chOF9bAkjKmEzOPpsoWUYYt0Xeu0t
         kU6GPhE5ABIyPf5V3nNGb7ieX64uC9PpBKFsvIas2rgh49St4nNxvczA+yEYfr7lCoxV
         owxdzTs5p6AIutZ5SFBAwrvGC2UP2DyhzI8OmtywSZftiJkVGVmyHjTcC8cNn/nVCaAB
         FOrAYZYe7Mp/zJ429vqE0/WyyILHISGQru/OSiW8jzOeyjCT9oIj1WlJL+G3Q2MUHYzB
         Gq47ow6HRiRz2ACIdCG40JFGZ/CQEHOin5QFaHp8IndJskHuHUuKne8RQodjFuAGCMu7
         j4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052948; x=1791657748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xNmkTjjoAfa2N4w2c1hhRM5QOyXo2Miq8JHRcxKPf6M=;
        b=NmoS5PX6DraaBKfPRtM7GMU6N+KTcoHT/FAfLpxbJFoupWb0C4+ZGPwa/aO4qCriW3
         rzO4pbU5Q8Y9qk7HUVdZCVFr4zKr3ZGSJhuXO0vYESvShN0wEvIbUnF2Ine9rFZFVO1V
         mM15sBcyMzPi/FULmqPUPJ9rgWnTuP+pWjRvDhKtACmA9y1ZJydp+buPQTPERVLw+KzF
         GeAvrshBXyWg2EsHcP+qIkrWXQ4zo8DdElRiT6+BjbPdsFad7rXZGnobzgWGbz9NzCj5
         i+pEokJgAM021HRzlmak2d+9MDiMSk4pL6aF2fqBneqi9eJNtjvfSxtQO4fEWVAgjg6C
         svYg==
X-Forwarded-Encrypted: i=1; AKwUvBzsqkqwzfr5UIjejAV7mxbmpNGVwkQfY/4Nxz4BUuhVDPO6KsNJlnX6kQc5OF1NCaGdTG/m6Om9nPJXlg==@vger.kernel.org
X-Gm-Message-State: AFuF++mBLkKiHWaEjAcHx5A0JwnMPbWJZ5TDX7vwt38n9QVNmeV/dB9x
	6otlhTOuO3nTNh8CfC1Gz5Y0JkEv8HaIW1g9YxolfoPvq4ocWeW53fP1+KO/g2rkWVRO+j2z
X-Gm-Gg: AYBFou1C9iuvQs3MhHM8KE6rU7JO2hVWyKtQB6F8KeN14TBI+LpJMnHYkw2Y8dJhH4V
	IwUBdY5OAK/H7Dyh0DRcwE+vawP+bjGzb/vdj9hFOP+kcrj8H3t9wUL3/hPWpny+jba6w+XvEtp
	ucCldaaiU+gy6DmR5KRA8dt7rf3RW2mBYOGO8fe7mNyfSp8FPzBYJUriqPI1WTKWArVqqq7nnm0
	vSovzBTf5FwmoHDm+KLy9LwMIlJgI5kLMrKjTbpBW4inE7vER1usK9LHL5WXL3rDP9X/m7Et0OP
	FsL4mD1HNKfjvb8ZRlM6TUV/NP2fOrVNAvVWutcM6TSMW4yeOPgnc+GHKe5RkTAz/IIUihKyulW
	K5R18FMtPGEu2ni6qOHN5JutmkyIEuP2tcjtjpvP5EeHurj00ex0dZJ+jYHuYXw9uW2Q71/sJ/h
	/QeeojOcNn5hFXCFMXL7oJQqM2vaDFtH3sZikAf3W6f+z0vtEvsR4RuSSdm2l26+ve/Js+tQYfv
	LdXOCWEtf/4lM3PZ524ymQCd2qt1N8l/QgvICoKSD/oFpYbmjSgcXf4EOK6AM5TRgT3nGk=
X-Received: by 2002:a05:600c:620c:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4a027583fb0mr108218495e9.20.1791052947932;
        Sat, 03 Oct 2026 11:42:27 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02770e8f2sm169437095e9.6.2026.10.03.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:42:27 -0700 (PDT)
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
Subject: [PATCH v8 2/2] ALSA: usb-audio: add the Topping M62's vendor controls
Date: Sat,  3 Oct 2026 23:42:17 +0500
Message-ID: <20261003184217.34671-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
References: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
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

Nine controls: five input gains (IN 1, IN 2, AUX, BT, OTG IN), two
output volumes (HP, OTG OUT) and the two output source selectors. The
outputs come in pairs and the device announces only the second of
each, so both are written and the second is the one listened for. The
mixer matrix, the mutes, the loopback routing, the input power and the
EQ remain reachable only through the HID driver's hidraw node.

The controls live as long as the card. They are created at the first
bind of the HID driver and stay when it unbinds, unchanged and without
an event: a value written meanwhile is kept, and the next bind writes
back every value that is known. They are not even marked inactive,
because alsa-lib's simple mixer handles an INFO event by removing the
element and adding it again, and a sound server would see the same
churn as a removal. So reloading either driver changes nothing a
holder of the card can see -- the controls keep their numids, a stored
alsactl state keeps matching them, a mixer application keeps its
elements -- and no control is left showing a value the card does not
hold.

What the card does not report, this side decides. The card reports
what a hand does to its hardware: every turn of a front-panel knob,
and once subscribed the gains of the inputs whose jacks are present. A
source selector has no front-panel control and is never reported, and
an output volume is not reported until its knob turns. Topping were
asked for a command that reads the selection and declined to provide
one or to commit to adding one. A host that cannot read these values
has to set them, or it inherits whatever the last host left in a
battery-powered card, so the first bind writes them and from then on
the cache is the truth.

The values are the ones the rest of snd-usb-audio would choose rather
than the vendor's. For a volume whose GET_CUR fails, init_cur_mix_raw()
sets the minimum, and the level a user hears is left to userspace --
alsactl and the sound server, which run after the card appears. So the
analogue headphone stage starts at its quiet end; the digital stream
to a phone starts at unity, where it changes nothing; and each output
listens to the host's main stream, Playback 1/2, with the mixer out of
the path. After a resume the same values are written again from the
cache, in case the card came up on its own defaults while the host
slept.

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
 sound/usb/mixer_topping.c | 902 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 5 files changed, 925 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7235a92ff..da9133376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27612,6 +27612,16 @@ S:	Maintained
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
index e62794a87..151b481df 100644
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
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index fc622eb95..8288eb222 100644
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
@@ -4539,6 +4540,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
index 000000000..38597292b
--- /dev/null
+++ b/sound/usb/mixer_topping.c
@@ -0,0 +1,902 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Topping M62 -- the card's vendor controls.
+ *
+ * The M62's analogue input gains, output volumes and output source
+ * selectors are not described by the USB Audio Class.  They are reached
+ * over a vendor protocol on the card's HID interface, which
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
+ * WHAT THE CARD DOES NOT REPORT, THIS SIDE DECIDES.  The card reports
+ * what a hand does to its hardware: every turn of a front-panel knob,
+ * and the gains of connected inputs once subscribed.  A source selector
+ * has no front-panel control, so it is never reported, and an output
+ * volume is not reported until its knob turns.  A host that cannot read
+ * them has to set them, or it inherits whatever the last host left in a
+ * battery-powered card.  So the first bind writes them, and from then on
+ * the cache is the truth: each output listens to the host's main stream,
+ * Playback 1/2, with the mixer out of the path; the analogue headphone
+ * stage starts at its quiet end; the digital stream to a phone starts at
+ * unity.  That follows the usual Linux division -- the kernel puts the
+ * hardware into a defined, quiet state, and the level a user hears is
+ * set from userspace, by alsactl's restore or init and by the sound
+ * server, both of which run after the card appears.
+ */
+
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
+/* the card reports it; nothing is written for it at the first bind */
+#define TOPPING_REPORTED	(-1)
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
+	int first;		/* written at the first bind, or REPORTED */
+	const unsigned int *tlv;
+};
+
+static const struct topping_ctl_desc topping_m62_ctls[] = {
+	{ "Mic-1 Analog Capture Volume", 0x21, 0, 0x04, 0, 88,
+	  TOPPING_REPORTED, topping_tlv_gain },
+	{ "Mic-2 Analog Capture Volume", 0x22, 0, 0x04, 0, 88,
+	  TOPPING_REPORTED, topping_tlv_gain },
+	{ "Aux Capture Volume", 0x23, 0, 0x04, 0, 99,
+	  TOPPING_REPORTED, topping_tlv_out_9 },
+	{ "Bluetooth Capture Volume", 0x25, 0, 0x04, 0, 99,
+	  TOPPING_REPORTED, topping_tlv_out_0 },
+	{ "OTG Capture Volume", 0x27, 0, 0x04, 0, 99,
+	  TOPPING_REPORTED, topping_tlv_out_0 },
+	{ "Headphone Playback Volume", 0x64, 0x63, 0x03, 0, 99,
+	  0, topping_tlv_out_9 },		/* the quiet end */
+	{ "OTG Playback Volume", 0x62, 0x61, 0x03, 0, 99,
+	  99, topping_tlv_out_0 },		/* 0 dB, unity */
+};
+
+#define TOPPING_NUM_CTLS	ARRAY_SIZE(topping_m62_ctls)
+
+static_assert(TOPPING_NUM_CTLS <= BITS_PER_LONG);
+
+/*
+ * WHAT AN OUTPUT CAN LISTEN TO.  The same numbering serves the outputs
+ * and the loopback returns, and it has a hole where 4 and 5 would be,
+ * so the index of a control item is not the value the card wants and
+ * the two are kept side by side.
+ */
+static const char * const topping_sources[] = {
+	"Mix A", "Mix B", "Mix C", "IN 1", "IN 2", "IN 1+2", "AUX", "BT",
+	"OTG IN", "Playback 1/2", "Playback 3/4", "Playback 5/6",
+	"Playback 7/8", "Playback 9/10",
+};
+
+static const u8 topping_source_value[] = {
+	1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
+};
+
+static_assert(ARRAY_SIZE(topping_sources) ==
+	      ARRAY_SIZE(topping_source_value));
+
+#define TOPPING_SRC_PLAYBACK_1_2	9	/* an item, not a card value */
+
+struct topping_enum_desc {
+	const char *name;
+	u8 target;
+	u8 prop;
+	unsigned int first;	/* the item written at the first bind */
+};
+
+/*
+ * The selector answers on ONE target of an output's pair, unlike the
+ * volume and the mute which must be written to both.  It is never
+ * reported, so it is always written at the first bind.
+ */
+static const struct topping_enum_desc topping_m62_enums[] = {
+	{ "Headphone Playback Source", 0x64, 0x02,
+	  TOPPING_SRC_PLAYBACK_1_2 },
+	{ "OTG Playback Source", 0x62, 0x02,
+	  TOPPING_SRC_PLAYBACK_1_2 },
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
+	unsigned long known;		/* which val[] the card or a put set */
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
+static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
+{
+	const struct topping_ctl_desc *d = &topping_m62_ctls[idx];
+	int err;
+
+	err = topping_write(tm, d->target, d->prop, value);
+	if (!err && d->target_pair) {
+		/*
+		 * The device announces only one of a pair, so the other
+		 * would drift away unheard.
+		 */
+		err = topping_write(tm, d->target_pair, d->prop, value);
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
+			     topping_source_value[item]);
+}
+
+/*
+ * Brings the card into line with the cache.  @all is the rebind, which
+ * writes every value that is known, the gains included: the card does
+ * not announce them again to a driver that comes back, and a write made
+ * while this side was alone is still only in the cache.  A gain nobody
+ * has reported or set is left alone rather than written as the zero the
+ * cache holds for it.  Otherwise only what the card never reports is
+ * written -- at the first bind, from the values the cache was born with,
+ * and after a resume, in case the card came up on its own defaults while
+ * the host slept.
+ *
+ * Errors are not passed on.  The HID driver logs the ones that mean
+ * something, and a card that cannot be written now is written again by
+ * the next bind or resume.
+ */
+static void topping_sync(struct topping_mixer *tm, bool all)
+{
+	bool known;
+	int i, value;
+
+	lockdep_assert_held(&tm->lock);
+
+	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
+		if (!all && topping_m62_ctls[i].first == TOPPING_REPORTED)
+			continue;
+		scoped_guard(spinlock_irqsave, &tm->val_lock) {
+			known = test_bit(i, &tm->known);
+			value = tm->val[i];
+		}
+		if (known)
+			topping_write_ctl(tm, i, value);
+	}
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++)
+		topping_write_sel(tm, i, tm->sel[i]);
+}
+
+static void topping_resume_work(struct work_struct *work)
+{
+	struct topping_mixer *tm = container_of(work, struct topping_mixer,
+						resume_work);
+
+	guard(mutex)(&tm->lock);
+	if (tm->bound)
+		topping_sync(tm, false);
+}
+
+/* ------------------------------------------------------------------ */
+/* what the HID driver tells this side					*/
+/* ------------------------------------------------------------------ */
+
+/* -1 when this frame is not one of ours */
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
+	idx = topping_index_of(target, prop);
+	if (idx < 0)
+		return;			/* a meter, or something unnamed */
+	if (value < topping_m62_ctls[idx].min ||
+	    value > topping_m62_ctls[idx].max)
+		return;
+
+	guard(spinlock_irqsave)(&tm->val_lock);
+
+	__set_bit(idx, &tm->known);
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
+	bool prev_known;
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
+	 *
+	 * A value nobody has reported or set is written even when it
+	 * equals the zero the cache holds: the card may be anywhere.
+	 */
+	scoped_guard(spinlock_irqsave, &tm->val_lock) {
+		prev_known = test_bit(idx, &tm->known);
+		if (prev_known && tm->val[idx] == value)
+			return 0;
+		prev = tm->val[idx];
+		tm->val[idx] = value;
+		__set_bit(idx, &tm->known);
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
+			if (tm->val[idx] == value) {
+				tm->val[idx] = prev;
+				if (!prev_known)
+					__clear_bit(idx, &tm->known);
+			}
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
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(topping_sources),
+				 topping_sources);
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
+	if (item >= ARRAY_SIZE(topping_sources))
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
+		err = topping_add_kctl(tm, &topping_ctl,
+				       topping_m62_ctls[i].name, i,
+				       topping_m62_ctls[i].tlv);
+		if (err < 0)
+			goto err_remove;
+	}
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
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
+	topping_sync(tm, !first);
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
+					       struct device *dev)
+{
+	struct topping_mixer *tm;
+	int i;
+
+	tm = kzalloc_obj(*tm);
+	if (!tm)
+		return NULL;
+
+	kref_init(&tm->ref);		/* the mixer's */
+	tm->dev = dev;
+	tm->card = mixer->chip->card;
+	tm->mixer = mixer;
+	tm->comp.audio_ops = &topping_mixer_ops;
+	INIT_WORK(&tm->resume_work, topping_resume_work);
+	mutex_init(&tm->lock);
+	spin_lock_init(&tm->val_lock);
+
+	/*
+	 * What the cache is born with is what the first bind writes, for
+	 * everything the card does not report.  A gain is not known until
+	 * the card reports it or a put sets it, and shows zero until then.
+	 */
+	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
+		if (topping_m62_ctls[i].first == TOPPING_REPORTED)
+			continue;
+		tm->val[i] = topping_m62_ctls[i].first;
+		__set_bit(i, &tm->known);
+	}
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
+	int err;
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
+	tm = topping_mixer_new(mixer, dev);
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
index 000000000..15e16b509
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

