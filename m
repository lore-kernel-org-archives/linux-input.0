Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3C49BB7D
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327793; cv=none; b=dvmLezJJ+CvIYPoeNhmUGPCN7RUuBfMPo9OrNCOnQ/8HJWWK6OhjzHZqIcQ8dNUpkaF2gDyeWLl6HyxukoS7NWW5ng9wBSN/PNgl99Vz+09rwNMDoJ9dxbhjEFmyBxzfsV3Ioa0ME4vvUb7zSQQF+YG5ZVJqvGxcXCni4X00L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327793; c=relaxed/simple;
	bh=9L1MUWesKnzW/j4nbifU5MtwwWjDVVgJAfvHXW+dGEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbF9/jMKNPhVU4H0Q6WnmIyT4OAab8e4vv+OXsM8mpygkRRE6VzGT18vuRO1o/iArLg08g4LfhLyvXI6szuFxM94gYaJLwyeX0i1m6N9PYBzt0/o4g2+HKxZ2PYKh2Wq2OS1qshwakxW78LE2lckpieX81mxiV3QfhA+lDpjVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKR+f/V2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKR+f/V2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so567738f8f.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327789; x=1792932589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMy4jUecZbAP9r0NgW4diLy64NCzpGcs+Y/SryrXpU8=;
        b=JKR+f/V2dCMqLW3F0xcfykEtjdGSQM98/UvTdrm0hCdlr8zShtaIwKNVIkHS9NNEFn
         5uqbjNZCnpC8iiutaX52toxnomFOqjbytXZFsOJI3QT0Xu5unc51IHZevDdqPagk4lv6
         rxIEAnUmYIUqS7tfooUzVWlEMIHWGzrkdYq1fqdbk6bpi8dwAs7Y853Yte07zylUmW+0
         U8WcC7N7kWpIGk8wV4nlX0ZxHG6bZ8En4Ng9IJipe54cLnGZhvc4NVQ6xhKxZ0pPdrxn
         xTGFLDnneHbvBuks2qr3xnErGOvPE8jCn5vgarCvXy/QUVPNozau57o4Af7Qe1koNHJ0
         LXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327789; x=1792932589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMy4jUecZbAP9r0NgW4diLy64NCzpGcs+Y/SryrXpU8=;
        b=Xt4OdJF4gH+0jNR4bdGePakDEqfpyK20MvdHN1ixy5SodGI8ulqHgH4kRV6lcxnc+p
         eOObhGR9/4LoLuTLn+LGQMJRWDKUbVPGTaJfBf0RrMXYaH5Y5rzVhk3ivgeA8KAZ0sXG
         2QEADvnWFbrhvZiyT0ZmZI+r54VqoSf2b6dRhaQ4gb9ZDT0trWPG8bj2oUY8ebUpEEUs
         x0ju8i0YZtKOcaU2OHnAz+exBjbhsIeiRttoXhcCsviua7VOMiuQT6vS1+CSqQJcLL9Q
         BWGRka+trhQP8yNrq060ore1s7sxJN3doNXPzK4I7T7m7rBXOmYkeQa8TIB74k2JG6Sb
         xUTw==
X-Forwarded-Encrypted: i=1; AKwUvByOMV6pR0/h9wSfd1GF/3Ef4Y+0yc3tEYymfHW/dueCXoDI+/wntqJu9+EVIAkNsvtAcAHKXPC9yO7ihQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJhn1raiMlZLQg5xWF3gulnn+kOdFVryz0soJGXjcQtPQuIcWmU
	6ZLf8QEDDDq9N3HuLtIn01rZCeWaC0Tp66frLAL+DHwliAvK73MNSKcm
X-Gm-Gg: AYBFou2KUF+mWs3RbMldwdKJ+5rgCnzaFQIIh9w2phnqwIaRHzDP0SNBw0wTuZl18bH
	uk8srGWOFonV872nKUaP5Ij8BKjeX/mWn0XpUz6oiJkWO4F/zhTmAuTilxGg0rlgdVunjCXYufx
	A0H0RKqTItOdwcaJw/rTqHxXegczBYxuLvVtCS9O6xDm9x73LRKAnzk/AGD3EhMWrJFdz1MP6he
	NkgUx+QdJlp4r6uNf4kQlulAQ6LXBpFlevl+uHNXFZ8UD6bkYvS7sGZvQoLoLyqO/GDM7kpsiPc
	SrUxtTckcq7EyqCQvIdDFWn+PL0/5/ix6tbUhO1YYGI1YDoarl6K0tWLyV8RLvJfpkASloiWm+S
	m1rzE5EY+72G4xDOTYtn00VLheyb+oiPyxp0QEjwCxkBImHrb/q5lNNSyx1Tgr44/MfN4OcKitG
	3J1iq0H98XsG4Klf5h2k3G126AWS1+RISDK44XhjUKdPDbx9UCr/2PrXyg+sDDYsEVDthGOyuFo
	cXAyyCbLXkiXE1bJe8s6QVVDzwaoj21o5G8CvVmcNM3VPN29WPInuSMwHQu8OGn4GkiovWMbkRb
	D512
X-Received: by 2002:a05:600c:3b1c:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a1d76046dbmr100544975e9.13.1792327788475;
        Sun, 18 Oct 2026 05:49:48 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:47 -0700 (PDT)
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
Subject: [PATCH v9 4/8] ALSA: usb-audio: add the Topping E2x2 OTG's vendor controls
Date: Sun, 18 Oct 2026 17:48:34 +0500
Message-ID: <20261018124838.129349-5-mikhail.v.gavrilov@gmail.com>
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

The E2x2 OTG keeps its input gains, its faders, its output and loopback
source selectors and its output switches behind the vendor protocol
hid-topping speaks, and reports none of them back. A Linux host cannot
set them at all, and inherits whatever the last host left in the card,
which saves its own state across power cycles: with the three output
switches left off by the vendor application, the card plays nothing
and nothing on Linux can turn it back on.

The control tables become per model, chosen by USB ID. A model is all
this file knows of a card: its rows, the properties written at every
bind without a control, and whether bcdDevice tells its mode, as the
M62's does. The per-card state is sized from the model, so a card with
more controls is only a longer table. A row may now be an on/off
switch, and a selector names its own list of sources. The E2x2 OTG
takes its gains and faders as Q25, through a table of what each step
writes, as the M62's loopback gains do.

Every control is written at the first bind, as for the M62: the gains at
+0 dB, the faders at 0 dB, the outputs on Playback 1/2, each loopback on
Playback 3/4, 5/6 and 7/8, the output switches on and the headphone
amplifier's extra gain off. Four properties of unknown meaning get the
values the vendor application always writes.

48V, INST and the monitor mix knob are left to the front panel. MON
is not, although it has buttons there and the card reports them:
after every power-on the card mixes as though monitoring were on, so
the monitor mix knob sits in the playback path -- at its leftmost
position nothing is heard -- until MON on both inputs has been
switched off. The vendor application writes both at every connect,
and so does this driver at every bind, starting from off. A MON off
written to IN 2 while IN 1 monitors also silences the monitor mix
until a MON on is written, so after either MON is written the other
is written again if it is on.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 sound/usb/mixer_quirks.c  |   1 +
 sound/usb/mixer_topping.c | 407 +++++++++++++++++++++++++++++++-------
 2 files changed, 332 insertions(+), 76 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 78d1966..fe68975 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4545,6 +4545,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_evo_controls_create(mixer);
 		break;
 
+	case USB_ID(0x152a, 0x8756): /* Topping E2x2 OTG */
 	case USB_ID(0x152a, 0x875c): /* Topping M62 */
 		err = snd_topping_init(mixer);
 		break;
diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
index cd848a3..725db57 100644
--- a/sound/usb/mixer_topping.c
+++ b/sound/usb/mixer_topping.c
@@ -1,16 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Topping M62 -- the card's vendor controls.
+ * Topping M62 and E2x2 OTG -- the cards' vendor controls.
  *
  * The M62's analogue input gains, output volumes, source selectors and
- * loopback gains are not described by the USB Audio Class.  They are
- * reached over a vendor protocol on the card's HID interface, which
- * hid-topping speaks.  This file owns the controls; that driver is
- * the transport.  The two meet through the component framework, with
- * this side as the master, in the same shape as HD-audio and the
- * graphics drivers in sound/hda/core/component.c: the master owns a
- * struct topping_component, and the HID driver fills in its one
- * operation when it binds and clears it when it unbinds.
+ * loopback gains, and the E2x2 OTG's digital input gains, faders,
+ * source selectors and output switches, are not described by the USB
+ * Audio Class.  They are reached over a vendor protocol on the card's
+ * HID interface, which hid-topping speaks.  This file owns the
+ * controls; that driver is the transport.  The two meet through the
+ * component framework, with this side as the master, in the same shape
+ * as HD-audio and the graphics drivers in sound/hda/core/component.c:
+ * the master owns a struct topping_component, and the HID driver fills
+ * in its one operation when it binds and clears it when it unbinds.
  *
  * THE CONTROLS LIVE AS LONG AS THE CARD.  They are created at the first
  * bind of the HID driver and not removed when it unbinds: a value
@@ -107,8 +108,10 @@ struct topping_ctl_desc {
 	u8 prop;
 	int min, max;
 	int first;		/* written at the first bind */
-	const unsigned int *tlv;
+	const unsigned int *tlv;	/* NULL for a switch */
 	const s32 *map;		/* what each step writes, or NULL: the step */
+	bool sw;		/* an on/off switch, not a level */
+	u8 resend;		/* written again after this one if on, or 0 */
 	u8 modes;		/* the modes that have it, or 0 for all */
 };
 
@@ -201,8 +204,6 @@ static const struct topping_ctl_desc topping_m62_ctls[] = {
 	  0, topping_tlv_lb, .modes = TOPPING_MOBILE },
 };
 
-#define TOPPING_NUM_CTLS	ARRAY_SIZE(topping_m62_ctls)
-
 /*
  * WHAT AN OUTPUT CAN LISTEN TO.  The same numbering serves the outputs
  * and the loopback returns, and it has a hole where 4 and 5 would be,
@@ -228,11 +229,24 @@ static_assert(ARRAY_SIZE(topping_m62_sources) ==
 #define TOPPING_M62_PLAYBACK_1_2	9
 #define TOPPING_M62_PLAYBACK_3_4	10
 
+/* the items of a selector, and what the card wants for each */
+struct topping_sources {
+	const char * const *items;
+	const u8 *values;
+	unsigned int num;
+};
+
+static const struct topping_sources topping_m62_src = {
+	topping_m62_sources, topping_m62_source_value,
+	ARRAY_SIZE(topping_m62_sources),
+};
+
 struct topping_enum_desc {
 	const char *name;
 	u8 target;
 	u8 prop;
 	unsigned int first;	/* the item written at the first bind */
+	const struct topping_sources *src;
 	u8 modes;		/* the modes that have it, or 0 for all */
 };
 
@@ -252,21 +266,210 @@ struct topping_enum_desc {
  */
 static const struct topping_enum_desc topping_m62_enums[] = {
 	{ "Headphone Playback Source", 0x64, 0x02,
-	  TOPPING_M62_PLAYBACK_1_2, TOPPING_PRO },
+	  TOPPING_M62_PLAYBACK_1_2, &topping_m62_src, TOPPING_PRO },
 	{ "OTG Playback Source", 0x62, 0x02,
-	  TOPPING_M62_PLAYBACK_1_2, TOPPING_PRO },
+	  TOPPING_M62_PLAYBACK_1_2, &topping_m62_src, TOPPING_PRO },
 	{ "Loopback 1/2 Capture Source", 0x51, 0x02,
-	  TOPPING_M62_PLAYBACK_1_2, TOPPING_PRO },
+	  TOPPING_M62_PLAYBACK_1_2, &topping_m62_src, TOPPING_PRO },
 	{ "Loopback 3/4 Capture Source", 0x53, 0x02,
-	  TOPPING_M62_PLAYBACK_3_4, TOPPING_PRO },
+	  TOPPING_M62_PLAYBACK_3_4, &topping_m62_src, TOPPING_PRO },
 	{ "Loopback 5/6 Capture Source", 0x55, 0x02,
-	  TOPPING_M62_BT, TOPPING_PRO },
+	  TOPPING_M62_BT, &topping_m62_src, TOPPING_PRO },
 	{ "Loopback 7/8 Capture Source", 0x57, 0x02,
-	  TOPPING_M62_OTG_IN, TOPPING_PRO },
+	  TOPPING_M62_OTG_IN, &topping_m62_src, TOPPING_PRO },
+};
+
+/*
+ * THE E2X2 OTG REPORTS LITTLE OF WHAT IS SHOWN HERE.  Its gains, faders,
+ * selectors and output switches are only ever written, by its vendor
+ * application as by this driver, so every one of them is written at
+ * the first bind and the cache is the truth from then on.  None of them
+ * has a control on the front panel, so another host can leave any of
+ * them anywhere -- every output switched off, say -- and this side has
+ * to be able to put it back.  What the panel owns is left alone: the
+ * 48V and INST buttons, and the monitor mix knob, which the card
+ * reports and does not take from the host anyway.  MON is the
+ * exception, for the reason given at its rows.
+ *
+ * The card keeps its own state, saving a change about five seconds
+ * after it is made, so nothing is written that does not have to be: a
+ * put that leaves the cache as it was writes nothing, and only a bind
+ * or a resume writes everything.
+ *
+ * Input gain is digital, +0 to +20 dB in whole decibels, and these are
+ * the values the vendor application writes for each step.  The Mobile
+ * input's gain is the one on its left channel, 0x22; it moves both.
+ */
+static const s32 topping_e2x2_gain[] = {
+	33554432, 37648680, 42242512, 47396908, 53180188, 59669144,
+	66949880, 75119016, 84284904, 94569240, 106108440, 119055624,
+	133582616, 149882144, 168170512, 188690432, 211714144, 237547200,
+	266532320, 299054176, 335544320,
+};
+
+static_assert(ARRAY_SIZE(topping_e2x2_gain) == 21);
+
+/* A fader in whole decibels: step 0 is off, step n is n - 81 dB. */
+static const s32 topping_e2x2_fader[] = {
+	0, 3355, 3765, 4224, 4740, 5318,
+	5967, 6695, 7512, 8428, 9457, 10611,
+	11906, 13358, 14988, 16817, 18869, 21171,
+	23755, 26653, 29905, 33554, 37649, 42243,
+	47397, 53180, 59669, 66950, 75119, 84285,
+	94569, 106108, 119056, 133583, 149882, 168171,
+	188690, 211714, 237547, 266532, 299054, 335544,
+	376487, 422425, 473969, 531802, 596692, 669499,
+	751190, 842849, 945692, 1061084, 1190556, 1335826,
+	1498821, 1681705, 1886904, 2117142, 2375472, 2665323,
+	2990542, 3355443, 3764869, 4224253, 4739689, 5318019,
+	5966916, 6694989, 7511902, 8428492, 9456924, 10610843,
+	11905562, 13358260, 14988214, 16817053, 18869044, 21171415,
+	23754719, 26653233, 29905419, 33554432,
+};
+
+static_assert(ARRAY_SIZE(topping_e2x2_fader) == 82);
+
+static const DECLARE_TLV_DB_SCALE(topping_tlv_fader, -8100, 100, 1);
+
+static const struct topping_ctl_desc topping_e2x2_ctls[] = {
+	{ "Mic1 Digital Capture Volume", 0x21, 0, 0x05, 0, 20,
+	  0, topping_tlv_gain, topping_e2x2_gain },
+	{ "Mic2 Digital Capture Volume", 0x23, 0, 0x05, 0, 20,
+	  0, topping_tlv_gain, topping_e2x2_gain },
+	{ "OTG Capture Volume", 0x22, 0, 0x05, 0, 20,
+	  0, topping_tlv_gain, topping_e2x2_gain },
+	/*
+	 * Output 1+2's fader as "Master": the sound server's stock
+	 * profile takes a control by that name for the volume of the
+	 * output, so the desktop's own slider moves this fader, and there
+	 * is no second level left somewhere out of sight.
+	 */
+	{ "Master Playback Volume", 0x31, 0x32, 0x03, 0, 81,
+	  81, topping_tlv_fader, topping_e2x2_fader },
+	{ "OTG Playback Volume", 0x33, 0x34, 0x03, 0, 81,
+	  81, topping_tlv_fader, topping_e2x2_fader },
+	{ "SPDIF Playback Volume", 0x5a, 0x5b, 0x03, 0, 81,
+	  81, topping_tlv_fader, topping_e2x2_fader },
+	{ "Loopback 1+2 Capture Volume", 0x51, 0x52, 0x03, 0, 81,
+	  81, topping_tlv_fader, topping_e2x2_fader },
+	{ "Loopback 3+4 Capture Volume", 0x53, 0x54, 0x03, 0, 81,
+	  81, topping_tlv_fader, topping_e2x2_fader },
+	{ "Loopback 5+6 Capture Volume", 0x55, 0x56, 0x03, 0, 81,
+	  81, topping_tlv_fader, topping_e2x2_fader },
+	/*
+	 * Not "Headphone Playback Switch": the sound server's stock
+	 * profile would take a control by that name for the mute of the
+	 * whole output, and muting would then silence the headphones
+	 * alone while TRS and AUX play on.
+	 */
+	{ "Output 1+2 Headphone Playback Switch", 0x37, 0, 0x01, 0, 1, 1,
+	  .sw = true },
+	{ "Output 1+2 TRS Playback Switch", 0x37, 0, 0x03, 0, 1, 1,
+	  .sw = true },
+	{ "Output 1+2 AUX Playback Switch", 0x37, 0, 0x05, 0, 1, 1,
+	  .sw = true },
+	{ "Output 1+2 Headphone Gain Playback Switch", 0x35, 0, 0x02, 0, 1, 0,
+	  .sw = true },
+	/*
+	 * MON has buttons on the front panel, and the card reports them,
+	 * but it is written here all the same.  After every power-on the
+	 * card mixes as though monitoring were on, whatever the buttons
+	 * show: the monitor mix knob stays in the playback path, passing
+	 * all of it at its rightmost position and none at its leftmost,
+	 * until MON on IN 1 and on IN 2 have both been switched off, from
+	 * the panel or by a write.  The vendor application writes both at
+	 * every connect, and this driver does the same at every bind.
+	 *
+	 * Written from the host, MON off on IN 2 also silences the monitor
+	 * mix while IN 1 still monitors, until the knob is turned or a MON
+	 * on is written.  So after either is written, the other is written
+	 * again if it is on: a MON on is the cure, and a second MON off
+	 * would be the very write that does the harm.
+	 */
+	{ "Mic1 Monitor Playback Switch", 0x21, 0, 0x01, 0, 1, 0,
+	  .sw = true, .resend = 0x23 },
+	{ "Mic2 Monitor Playback Switch", 0x23, 0, 0x01, 0, 1, 0,
+	  .sw = true, .resend = 0x21 },
+};
+
+/* The vendor application's numbering, in the order of its menu. */
+static const char * const topping_e2x2_sources[] = {
+	"Mix A", "Mix B", "Mix C", "Mix D", "IN 1", "IN 2", "IN 1+2",
+	"Mobile IN", "Playback 1/2", "Playback 3/4", "Playback 5/6",
+	"Playback 7/8",
+};
+
+static const u8 topping_e2x2_source_value[] = {
+	11, 12, 13, 14, 1, 3, 5, 2, 7, 8, 9, 10,
+};
+
+static_assert(ARRAY_SIZE(topping_e2x2_sources) ==
+	      ARRAY_SIZE(topping_e2x2_source_value));
+
+static const struct topping_sources topping_e2x2_src = {
+	topping_e2x2_sources, topping_e2x2_source_value,
+	ARRAY_SIZE(topping_e2x2_sources),
+};
+
+/*
+ * The outputs listen to the host's main stream, and each loopback to
+ * one of the others, as the vendor application sets them: nothing is
+ * recorded from a loopback until someone chooses what.
+ */
+static const struct topping_enum_desc topping_e2x2_enums[] = {
+	{ "Output 1+2 Playback Source", 0x35, 0x01, 8, &topping_e2x2_src },
+	{ "OTG Playback Source", 0x36, 0x01, 8, &topping_e2x2_src },
+	{ "SPDIF Playback Source", 0x5c, 0x01, 8, &topping_e2x2_src },
+	{ "Loopback 1+2 Capture Source", 0x57, 0x01, 9, &topping_e2x2_src },
+	{ "Loopback 3+4 Capture Source", 0x58, 0x01, 10, &topping_e2x2_src },
+	{ "Loopback 5+6 Capture Source", 0x59, 0x01, 11, &topping_e2x2_src },
 };
 
-#define TOPPING_NUM_ENUMS	ARRAY_SIZE(topping_m62_enums)
-#define TOPPING_NUM_KCTLS	(TOPPING_NUM_CTLS + TOPPING_NUM_ENUMS)
+/* written at every bind and after every resume, with no control */
+struct topping_fixed {
+	u8 target;
+	u8 prop;
+	s32 value;
+};
+
+/*
+ * What the vendor application writes, always the same, to properties
+ * whose meaning is not known; written here so that the card is in the
+ * state that application leaves it in whatever another host did.
+ */
+static const struct topping_fixed topping_e2x2_fixed[] = {
+	{ 0x36, 0x02, 0 },
+	{ 0x37, 0x02, 1 },
+	{ 0x37, 0x04, 1 },
+	{ 0x37, 0x06, 1 },
+};
+
+struct topping_model {
+	const struct topping_ctl_desc *ctls;
+	unsigned int num_ctls;
+	const struct topping_enum_desc *enums;
+	unsigned int num_enums;
+	const struct topping_fixed *fixed;
+	unsigned int num_fixed;
+	bool bcd_mode;		/* tells its mode in bcdDevice, as the M62 does */
+};
+
+static const struct topping_model topping_m62 = {
+	.ctls = topping_m62_ctls,
+	.num_ctls = ARRAY_SIZE(topping_m62_ctls),
+	.enums = topping_m62_enums,
+	.num_enums = ARRAY_SIZE(topping_m62_enums),
+	.bcd_mode = true,
+};
+
+static const struct topping_model topping_e2x2_otg = {
+	.ctls = topping_e2x2_ctls,
+	.num_ctls = ARRAY_SIZE(topping_e2x2_ctls),
+	.enums = topping_e2x2_enums,
+	.num_enums = ARRAY_SIZE(topping_e2x2_enums),
+	.fixed = topping_e2x2_fixed,
+	.num_fixed = ARRAY_SIZE(topping_e2x2_fixed),
+};
 
 /*
  * One per card, and as long-lived as the card's controls: each control
@@ -280,6 +483,7 @@ struct topping_mixer {
 	struct snd_card *card;
 	struct usb_mixer_interface *mixer;
 
+	const struct topping_model *model;
 	u8 mode;			/* TOPPING_MOBILE or TOPPING_PRO */
 	struct topping_component comp;
 	struct work_struct resume_work;
@@ -295,11 +499,11 @@ struct topping_mixer {
 	bool created;			/* the controls exist */
 
 	spinlock_t val_lock;		/* the cache and kctl[] against reports */
-	int val[TOPPING_NUM_CTLS];
-	unsigned int sel[TOPPING_NUM_ENUMS];
+	int *val;			/* one per row of the model's ctls */
+	unsigned int *sel;		/* one per row of its enums */
 
-	/* the volume controls first, then the selectors */
-	struct snd_kcontrol *kctl[TOPPING_NUM_KCTLS];
+	/* the volume controls and switches first, then the selectors */
+	struct snd_kcontrol **kctl;
 };
 
 static void topping_mixer_release(struct kref *ref)
@@ -307,6 +511,9 @@ static void topping_mixer_release(struct kref *ref)
 	struct topping_mixer *tm = container_of(ref, struct topping_mixer,
 						ref);
 
+	kfree(tm->kctl);
+	kfree(tm->sel);
+	kfree(tm->val);
 	mutex_destroy(&tm->lock);
 	kfree(tm);
 }
@@ -329,11 +536,25 @@ static bool topping_here(const struct topping_mixer *tm, u8 modes)
 	return !modes || (modes & tm->mode);
 }
 
+/* -1 when this frame is not one of ours */
+static int topping_index_of(const struct topping_mixer *tm, u8 target,
+			    u8 prop)
+{
+	const struct topping_model *m = tm->model;
+	int i;
+
+	for (i = 0; i < m->num_ctls; i++)
+		if (m->ctls[i].target == target && m->ctls[i].prop == prop &&
+		    topping_here(tm, m->ctls[i].modes))
+			return i;
+	return -1;
+}
+
 static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
 {
-	const struct topping_ctl_desc *d = &topping_m62_ctls[idx];
+	const struct topping_ctl_desc *d = &tm->model->ctls[idx];
 	s32 wire = d->map ? d->map[value] : value;
-	int err;
+	int err, other, on;
 
 	err = topping_write(tm, d->target, d->prop, wire);
 	if (!err && d->target_pair) {
@@ -343,16 +564,22 @@ static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
 		 */
 		err = topping_write(tm, d->target_pair, d->prop, wire);
 	}
+	if (!err && d->resend) {
+		other = topping_index_of(tm, d->resend, d->prop);
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			on = tm->val[other];
+		if (on)
+			err = topping_write(tm, d->resend, d->prop, on);
+	}
 	return err;
 }
 
 static int topping_write_sel(struct topping_mixer *tm, int idx,
 			     unsigned int item)
 {
-	const struct topping_enum_desc *d = &topping_m62_enums[idx];
+	const struct topping_enum_desc *d = &tm->model->enums[idx];
 
-	return topping_write(tm, d->target, d->prop,
-			     topping_m62_source_value[item]);
+	return topping_write(tm, d->target, d->prop, d->src->values[item]);
 }
 
 /*
@@ -368,22 +595,26 @@ static int topping_write_sel(struct topping_mixer *tm, int idx,
  */
 static void topping_sync(struct topping_mixer *tm)
 {
+	const struct topping_model *m = tm->model;
 	int i, value;
 
 	lockdep_assert_held(&tm->lock);
 
-	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
-		if (!topping_here(tm, topping_m62_ctls[i].modes))
+	for (i = 0; i < m->num_ctls; i++) {
+		if (!topping_here(tm, m->ctls[i].modes))
 			continue;
 		scoped_guard(spinlock_irqsave, &tm->val_lock)
 			value = tm->val[i];
 		topping_write_ctl(tm, i, value);
 	}
-	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
-		if (!topping_here(tm, topping_m62_enums[i].modes))
+	for (i = 0; i < m->num_enums; i++) {
+		if (!topping_here(tm, m->enums[i].modes))
 			continue;
 		topping_write_sel(tm, i, tm->sel[i]);
 	}
+	for (i = 0; i < m->num_fixed; i++)
+		topping_write(tm, m->fixed[i].target, m->fixed[i].prop,
+			      m->fixed[i].value);
 }
 
 static void topping_resume_work(struct work_struct *work)
@@ -400,20 +631,6 @@ static void topping_resume_work(struct work_struct *work)
 /* what the HID driver tells this side					*/
 /* ------------------------------------------------------------------ */
 
-/* -1 when this frame is not one of ours */
-static int topping_index_of(const struct topping_mixer *tm, u8 target,
-			    u8 prop)
-{
-	int i;
-
-	for (i = 0; i < TOPPING_NUM_CTLS; i++)
-		if (topping_m62_ctls[i].target == target &&
-		    topping_m62_ctls[i].prop == prop &&
-		    topping_here(tm, topping_m62_ctls[i].modes))
-			return i;
-	return -1;
-}
-
 /*
  * Every frame the card sends, meters included, in the HID driver's
  * interrupt context -- hence the spinlock.
@@ -433,8 +650,8 @@ static void topping_report(struct topping_component *comp, u8 target,
 	idx = topping_index_of(tm, target, prop);
 	if (idx < 0)
 		return;			/* a meter, or something unnamed */
-	if (value < topping_m62_ctls[idx].min ||
-	    value > topping_m62_ctls[idx].max)
+	if (value < tm->model->ctls[idx].min ||
+	    value > tm->model->ctls[idx].max)
 		return;
 
 	guard(spinlock_irqsave)(&tm->val_lock);
@@ -484,10 +701,12 @@ static const struct topping_audio_ops topping_mixer_ops = {
 static int topping_ctl_info(struct snd_kcontrol *kctl,
 			    struct snd_ctl_elem_info *uinfo)
 {
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
 	const struct topping_ctl_desc *d;
 
-	d = &topping_m62_ctls[kctl->private_value];
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	d = &tm->model->ctls[kctl->private_value];
+	uinfo->type = d->sw ? SNDRV_CTL_ELEM_TYPE_BOOLEAN :
+			      SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = d->min;
 	uinfo->value.integer.max = d->max;
@@ -513,8 +732,8 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
 	int value, prev, err;
 
 	value = ucontrol->value.integer.value[0];
-	if (value < topping_m62_ctls[idx].min ||
-	    value > topping_m62_ctls[idx].max)
+	if (value < tm->model->ctls[idx].min ||
+	    value > tm->model->ctls[idx].max)
 		return -EINVAL;
 
 	/*
@@ -566,6 +785,15 @@ static const struct snd_kcontrol_new topping_ctl = {
 	.put = topping_ctl_put,
 };
 
+/* the same, with no scale to read */
+static const struct snd_kcontrol_new topping_sw = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = topping_ctl_info,
+	.get = topping_ctl_get,
+	.put = topping_ctl_put,
+};
+
 /* ------------------------------------------------------------------ */
 /* the source selectors							*/
 /* ------------------------------------------------------------------ */
@@ -573,15 +801,18 @@ static const struct snd_kcontrol_new topping_ctl = {
 static int topping_sel_info(struct snd_kcontrol *kctl,
 			    struct snd_ctl_elem_info *uinfo)
 {
-	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(topping_m62_sources),
-				 topping_m62_sources);
+	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
+	const struct topping_enum_desc *d;
+
+	d = &tm->model->enums[kctl->private_value - tm->model->num_ctls];
+	return snd_ctl_enum_info(uinfo, 1, d->src->num, d->src->items);
 }
 
 static int topping_sel_get(struct snd_kcontrol *kctl,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
-	int idx = kctl->private_value - TOPPING_NUM_CTLS;
+	int idx = kctl->private_value - tm->model->num_ctls;
 
 	guard(spinlock_irqsave)(&tm->val_lock);
 	ucontrol->value.enumerated.item[0] = tm->sel[idx];
@@ -592,12 +823,12 @@ static int topping_sel_put(struct snd_kcontrol *kctl,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct topping_mixer *tm = snd_kcontrol_chip(kctl);
-	int idx = kctl->private_value - TOPPING_NUM_CTLS;
+	int idx = kctl->private_value - tm->model->num_ctls;
 	unsigned int item, prev;
 	int err;
 
 	item = ucontrol->value.enumerated.item[0];
-	if (item >= ARRAY_SIZE(topping_m62_sources))
+	if (item >= tm->model->enums[idx].src->num)
 		return -EINVAL;
 
 	guard(mutex)(&tm->lock);
@@ -678,30 +909,30 @@ static int topping_add_kctl(struct topping_mixer *tm,
 
 static int topping_create_kctls(struct topping_mixer *tm)
 {
+	const struct topping_model *m = tm->model;
 	int i, err;
 
-	for (i = 0; i < TOPPING_NUM_CTLS; i++) {
-		if (!topping_here(tm, topping_m62_ctls[i].modes))
+	for (i = 0; i < m->num_ctls; i++) {
+		if (!topping_here(tm, m->ctls[i].modes))
 			continue;
-		err = topping_add_kctl(tm, &topping_ctl,
-				       topping_m62_ctls[i].name, i,
-				       topping_m62_ctls[i].tlv);
+		err = topping_add_kctl(tm, m->ctls[i].sw ? &topping_sw :
+							   &topping_ctl,
+				       m->ctls[i].name, i, m->ctls[i].tlv);
 		if (err < 0)
 			goto err_remove;
 	}
-	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
-		if (!topping_here(tm, topping_m62_enums[i].modes))
+	for (i = 0; i < m->num_enums; i++) {
+		if (!topping_here(tm, m->enums[i].modes))
 			continue;
-		err = topping_add_kctl(tm, &topping_sel,
-				       topping_m62_enums[i].name,
-				       TOPPING_NUM_CTLS + i, NULL);
+		err = topping_add_kctl(tm, &topping_sel, m->enums[i].name,
+				       m->num_ctls + i, NULL);
 		if (err < 0)
 			goto err_remove;
 	}
 	return 0;
 
 err_remove:
-	for (i = 0; i < TOPPING_NUM_KCTLS; i++)
+	for (i = 0; i < m->num_ctls + m->num_enums; i++)
 		if (tm->kctl[i])
 			snd_ctl_remove(tm->card, tm->kctl[i]);
 	return err;
@@ -875,7 +1106,9 @@ static void topping_private_free(struct usb_mixer_interface *mixer)
 }
 
 static struct topping_mixer *topping_mixer_new(struct usb_mixer_interface *mixer,
-					       struct device *dev, u8 mode)
+					       struct device *dev,
+					       const struct topping_model *m,
+					       u8 mode)
 {
 	struct topping_mixer *tm;
 	int i;
@@ -885,6 +1118,7 @@ static struct topping_mixer *topping_mixer_new(struct usb_mixer_interface *mixer
 		return NULL;
 
 	kref_init(&tm->ref);		/* the mixer's */
+	tm->model = m;
 	tm->mode = mode;
 	tm->dev = dev;
 	tm->card = mixer->chip->card;
@@ -894,11 +1128,19 @@ static struct topping_mixer *topping_mixer_new(struct usb_mixer_interface *mixer
 	mutex_init(&tm->lock);
 	spin_lock_init(&tm->val_lock);
 
+	tm->val = kzalloc_objs(*tm->val, m->num_ctls);
+	tm->sel = kzalloc_objs(*tm->sel, m->num_enums);
+	tm->kctl = kzalloc_objs(*tm->kctl, m->num_ctls + m->num_enums);
+	if (!tm->val || !tm->sel || !tm->kctl) {
+		kref_put(&tm->ref, topping_mixer_release);
+		return NULL;
+	}
+
 	/* what the cache is born with is what the first bind writes */
-	for (i = 0; i < TOPPING_NUM_CTLS; i++)
-		tm->val[i] = topping_m62_ctls[i].first;
-	for (i = 0; i < TOPPING_NUM_ENUMS; i++)
-		tm->sel[i] = topping_m62_enums[i].first;
+	for (i = 0; i < m->num_ctls; i++)
+		tm->val[i] = m->ctls[i].first;
+	for (i = 0; i < m->num_enums; i++)
+		tm->sel[i] = m->enums[i].first;
 
 	return tm;
 }
@@ -907,6 +1149,7 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
 {
 	struct snd_usb_audio *chip = mixer->chip;
 	struct component_match *match = NULL;
+	const struct topping_model *model;
 	struct topping_master_res *res;
 	struct usb_interface *intf;
 	struct topping_mixer *tm;
@@ -914,7 +1157,19 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
 	u8 mode = TOPPING_PRO;
 	int err;
 
-	if (le16_to_cpu(chip->dev->descriptor.bcdDevice) >> 8 == 0x01)
+	switch (chip->usb_id) {
+	case USB_ID(0x152a, 0x875c):
+		model = &topping_m62;
+		break;
+	case USB_ID(0x152a, 0x8756):
+		model = &topping_e2x2_otg;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	if (model->bcd_mode &&
+	    le16_to_cpu(chip->dev->descriptor.bcdDevice) >> 8 == 0x01)
 		mode = TOPPING_MOBILE;
 
 	/*
@@ -931,7 +1186,7 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
 		return -ENODEV;
 	dev = &intf->dev;
 
-	tm = topping_mixer_new(mixer, dev, mode);
+	tm = topping_mixer_new(mixer, dev, model, mode);
 	if (!tm)
 		return -ENOMEM;
 
-- 
2.43.0

