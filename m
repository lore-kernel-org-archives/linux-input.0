Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC449B5B1
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327800; cv=none; b=GLGtigyx7mGSploTpA1W2TPK3025Y1tKLUBm4X8sZjEu469JJHfFnCSWzHyK1dXqUj5vNyNpjWqKF8Z8bpvd50y469Oh0FOhO51LrH3Nk+urh/n9x+NJgef/Ow1eBwGIB6KLkdhz59rHdbQELw0OqUeaohf4IvhcDWEKp2kRAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327800; c=relaxed/simple;
	bh=in8qrMhhCn8+iRl1pHPQhgbmr3OKXurF25m+dmvmaas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXkP2OxNfGR2pGl/vWDeYt+MBotb41WIXh4L/K37vgQU/FFJjefMOaQ029BoIxfwFRTIfcAYEDInes0eKK67GrsVQdjZd3AQK22e7CorT0732ichSPg4muGDXRT5sI8X3AkPB8YOf2Pzqikl5sOMcQ18gCozrTZTwFoz5CashXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+h3zafj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+h3zafj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso5557365e9.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327793; x=1792932593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwYhA8yuwTltEmhlw7+AMc/GWC8sIlkGYHOhcUohYjQ=;
        b=Y+h3zafjeGoQsR9v6uOmGHSKtPe4Kz0A466+tcLVW/A0i+SwSHJqunJet3YLo1b93t
         FFD731C1nSezeruyGHrYeNjYH9Pb2zntiTxpBtEq62nQYGaB8W6I3nl6x1ab2L/dA8Ck
         Y+74Mggxz0/lzhSWsO8lIyYtr1+tD7JAVwUdNoTDC1fzLCA/Y3cXBab0SJNRSXqt1e8u
         KN6GUyKQUJ9BMRwKvL9GbYK3Vrrc0ksEdwV4oFNDzQtofOzdnU8O+UD3feHRwoABGyAo
         HekeYHbxyfEB9WiPXkF+i64AkmLXTnocJLnQrAkXFfluw74Jn7XSe+htioXbU+Bi3R2P
         Hodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327793; x=1792932593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwYhA8yuwTltEmhlw7+AMc/GWC8sIlkGYHOhcUohYjQ=;
        b=1LYttULyUaVut5L7drIXz5yyvT7tkjlEow1pOKVHRxLsO71aUNJMZoVn620gqdOd1x
         MVoGrgMFsjFjKKiI3f4BpCCOSRyzmrefHgkQkGpnr7uTVBagDqjw2usUIn4VfAKh4b6w
         RArNgffF8mSFMA6ofMwix7D7hqhKuLWNowWHrHQMn+6XskPuJyVMJ/Bd8BuJdtstc8oi
         jf3+7LAMvXD0Es0UT+DjGyu+z1inww8z0/A2ao6j4ec2KVS2AisfnFeCZYGZziLeSp8Z
         2rS6Hphp7asMlr5D0am9fzCWaP8H7NmFhnEiDImPTVRGoXCF14sf31W3vfyMbc4pPNrh
         rdQw==
X-Forwarded-Encrypted: i=1; AKwUvBwgEHMZoXNbaitePql6I5RLKjmVGjySMxafL3ouXHxb/Z4NrW5MDn9wYyXOQcbrOoun7Z+y8VARL5sVow==@vger.kernel.org
X-Gm-Message-State: AFq9FYJF3Z8xQZ1AZAjPJnhdd4nEOV0IKIBaG0F8b+dsfoNcHt58QVf0
	3qI0WHG8uR5MAW/trkv3LLHvtIkeVE+n4vS7T+RSk9VNoB2NAfYNRCV1
X-Gm-Gg: AYBFou0Q2h9aBhqybCpILvpw8q5rna+KCxwDvhpPH3+6ALNCmpW2Mds0UrCJz7ppzxC
	77heT/h3TndUdS/ekK4QnJXtQYuTGx8Ct9DVeEng0Z/l+bLd63zAbaoYYRNJafXq1UYa/pRg6R8
	/PqyPsbVK//+Gcoxb4f4QAi4wWvgLCyWMkoM4tFOTEV+Z0waX1oH8ySkr9BJn6K4FrvZmZ/PI46
	cWrBuBpH/XVnVzZxd4F4OOTT379j54Txbvlc3RNijzz32AFSMBsPFMWn5JGkVILH6mNeo78EJY6
	esM1foDtME6BULEQLZ1t4WG6yGi92jzSqRmVwoD6+eB7jK5VJOXFoq+FTKBP2mz3hqwjzWgzv6T
	7l8i/z3I+zIkkEpeDpaABMHnFk7Tuj1Gh1vRPKLC7s+g9ZuSK5kVV1bG0doK3bi+5A7pxq0Uk8J
	9ltqCT97LPhe0rC9S8Df+9VNfMm77nqace8AgltPxAa21o28CDYggNaTA3GmGVNIsFv6tifSSOL
	KrgmQF9s+VitDmIxPIlklNVpuBxBsAuGlPBeUasnE8ZHI4xSGYUEEJOEYseji/b2to4Rdk=
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a1d75ab363mr109281025e9.4.1792327792739;
        Sun, 18 Oct 2026 05:49:52 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:52 -0700 (PDT)
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
Subject: [PATCH v9 6/8] ALSA: usb-audio: add the Topping M62's port power settings
Date: Sun, 18 Oct 2026 17:48:36 +0500
Message-ID: <20261018124838.129349-7-mikhail.v.gavrilov@gmail.com>
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

An M62 whose USB-C port the vendor's application has set to Off or
Discharge does not charge from the computer it is connected to, and
runs its battery down; nothing on Linux shows that setting or changes
it, nor the power of the OTG port. Both are kept in the card, and the
application offers them under Device.

Offer both as enumerated controls with the application's items: "USB-C
Port Power" (Charge, Discharge, Off) and "OTG Port Power" (Discharge,
Off), at 0x11/0x1c and 0x11/0x1b, in every mode.

Like every other value here, both are written at the first bind: the
USB-C port to Charge, so that a card left on Off or Discharge by another
host takes power from this one again, and the OTG port to Off, which
leaves a phone on it to its own battery rather than the card's.
alsactl's restore then puts back what the user chose. The card reports
both settings in its announce, and a report updates the control, as for
the volumes; but it sends each of the two once in an announce and leaves
one or both out of some announces, 13 of 120 in one run here, so the
announce cannot stand in for the write. The vendor application reads
them from the announce and never pushes them; a host that is to charge
the card cannot leave that to an announce that may not come.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 sound/usb/mixer_topping.c | 143 ++++++++++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 35 deletions(-)

diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
index 725db57..854ff0a 100644
--- a/sound/usb/mixer_topping.c
+++ b/sound/usb/mixer_topping.c
@@ -2,16 +2,17 @@
 /*
  * Topping M62 and E2x2 OTG -- the cards' vendor controls.
  *
- * The M62's analogue input gains, output volumes, source selectors and
- * loopback gains, and the E2x2 OTG's digital input gains, faders,
- * source selectors and output switches, are not described by the USB
- * Audio Class.  They are reached over a vendor protocol on the card's
- * HID interface, which hid-topping speaks.  This file owns the
- * controls; that driver is the transport.  The two meet through the
- * component framework, with this side as the master, in the same shape
- * as HD-audio and the graphics drivers in sound/hda/core/component.c:
- * the master owns a struct topping_component, and the HID driver fills
- * in its one operation when it binds and clears it when it unbinds.
+ * The M62's analogue input gains, output volumes, source selectors,
+ * loopback gains and port power settings, and the E2x2 OTG's digital
+ * input gains, faders, source selectors and output switches, are not
+ * described by the USB Audio Class.  They are reached over a vendor
+ * protocol on the card's HID interface, which hid-topping speaks.
+ * This file owns the controls; that driver is the transport.
+ * The two meet through the component framework, with this side
+ * as the master, in the same shape as HD-audio and the graphics
+ * drivers in sound/hda/core/component.c: the master owns a struct
+ * topping_component, and the HID driver fills in its one operation
+ * when it binds and clears it when it unbinds.
  *
  * THE CONTROLS LIVE AS LONG AS THE CARD.  They are created at the first
  * bind of the HID driver and not removed when it unbinds: a value
@@ -27,19 +28,22 @@
  * THE CARD'S STATE CANNOT BE READ.  The card reports what a hand does to
  * its hardware, every turn of a front-panel knob, and when a session
  * opens it announces the gains of the inputs that have something
- * plugged in; nothing answers a request for a value.  A host that does
- * not set the card inherits whatever the last host, or a hand on the
- * panel, left in a battery-powered card.  So the first bind writes
+ * plugged in and the M62's port power settings, though an announce can
+ * leave those out; nothing answers a request for a value.  A host that
+ * does not set the card inherits whatever the last host, or a hand on
+ * the panel, left in a battery-powered card.  So the first bind writes
  * everything, and from then on the cache is the truth, which the card's
  * own reports keep up to date: each output listens to the host's main
  * stream, Playback 1/2, with the mixer out of the path, or at 0 dB
  * through it where there is no way around it, as on an M62 in Mobile
  * Mode; every input gain starts at 0 dB, where it changes nothing; the
- * analogue headphone stage starts at its quiet end; and the digital
- * stream to a phone starts at unity.  That follows the usual Linux
- * division -- the kernel puts the hardware into a defined state, and the
- * level a user hears is set from userspace, by alsactl's restore or init
- * and by the sound server, both of which run after the card appears.
+ * analogue headphone stage starts at its quiet end; the digital stream
+ * to a phone starts at unity; and the M62's USB-C port charges the card,
+ * while its OTG port leaves a phone to its own battery.  That follows
+ * the usual Linux division -- the kernel puts the hardware into a
+ * defined state, and the level a user hears is set from userspace, by
+ * alsactl's restore or init and by the sound server, both of which run
+ * after the card appears.
  */
 
 #include <linux/bits.h>
@@ -250,14 +254,43 @@ struct topping_enum_desc {
 	u8 modes;		/* the modes that have it, or 0 for all */
 };
 
+/* the power settings of the two ports, as the vendor application has them */
+static const char * const topping_m62_usbc_power[] = {
+	"Charge", "Discharge", "Off",
+};
+
+static const u8 topping_m62_usbc_power_value[] = { 1, 2, 3 };
+
+static const struct topping_sources topping_m62_usbc = {
+	topping_m62_usbc_power, topping_m62_usbc_power_value,
+	ARRAY_SIZE(topping_m62_usbc_power),
+};
+
+static const char * const topping_m62_otg_power[] = { "Discharge", "Off" };
+
+static const u8 topping_m62_otg_power_value[] = { 1, 0 };
+
+static const struct topping_sources topping_m62_otg = {
+	topping_m62_otg_power, topping_m62_otg_power_value,
+	ARRAY_SIZE(topping_m62_otg_power),
+};
+
 /*
- * A selector answers on ONE target of a pair, unlike a volume or a
- * mute, which must be written to both: the second target of an
+ * A source selector answers on ONE target of a pair, unlike a volume
+ * or a mute, which must be written to both: the second target of an
  * output's pair, the first of a loopback return's.  It is never
  * reported, so it is always written at the first bind.  The outputs
  * start on the host's main stream, the loopback returns where the
  * vendor application puts them.
  *
+ * The power settings of the USB-C port the card is connected by and of
+ * its OTG port are in the card's announce, but not in every one, and
+ * another host can leave them anywhere: set to Off or Discharge, the
+ * USB-C port does not charge the card from this computer, and the card
+ * runs its battery down.  So they are written like everything else, the
+ * USB-C port to Charge and the OTG port to Off, which leaves a phone on
+ * that port to its own battery rather than the card's.
+ *
  * The names end in "Source", not "Route": alsa-lib's simple mixer joins
  * a "... Playback Route" or "... Capture Route" enumeration to the
  * volume of the same name and then reads and writes only the
@@ -277,6 +310,8 @@ static const struct topping_enum_desc topping_m62_enums[] = {
 	  TOPPING_M62_BT, &topping_m62_src, TOPPING_PRO },
 	{ "Loopback 7/8 Capture Source", 0x57, 0x02,
 	  TOPPING_M62_OTG_IN, &topping_m62_src, TOPPING_PRO },
+	{ "USB-C Port Power", 0x11, 0x1c, 0, &topping_m62_usbc },	/* Charge */
+	{ "OTG Port Power", 0x11, 0x1b, 1, &topping_m62_otg },		/* Off */
 };
 
 /*
@@ -610,7 +645,9 @@ static void topping_sync(struct topping_mixer *tm)
 	for (i = 0; i < m->num_enums; i++) {
 		if (!topping_here(tm, m->enums[i].modes))
 			continue;
-		topping_write_sel(tm, i, tm->sel[i]);
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			value = tm->sel[i];
+		topping_write_sel(tm, i, value);
 	}
 	for (i = 0; i < m->num_fixed; i++)
 		topping_write(tm, m->fixed[i].target, m->fixed[i].prop,
@@ -640,6 +677,41 @@ static void topping_resume_work(struct work_struct *work)
  * control's own private_free clears kctl[] under this lock.  It is safe
  * from here: it takes read_lock_irqsave and allocates with GFP_ATOMIC.
  */
+static void topping_report_sel(struct topping_mixer *tm, u8 target,
+			       u8 prop, s32 value)
+{
+	const struct topping_model *m = tm->model;
+	const struct topping_enum_desc *d;
+	struct snd_kcontrol *kctl;
+	unsigned int item;
+	int i;
+
+	for (i = 0; i < m->num_enums; i++) {
+		d = &m->enums[i];
+		if (d->target == target && d->prop == prop &&
+		    topping_here(tm, d->modes))
+			break;
+	}
+	if (i == m->num_enums)
+		return;			/* a meter, or something unnamed */
+
+	for (item = 0; item < d->src->num; item++)
+		if (d->src->values[item] == value)
+			break;
+	if (item == d->src->num)
+		return;
+
+	guard(spinlock_irqsave)(&tm->val_lock);
+
+	if (tm->sel[i] == item)
+		return;
+	tm->sel[i] = item;
+
+	kctl = tm->kctl[m->num_ctls + i];
+	if (kctl)
+		snd_ctl_notify(tm->card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
+}
+
 static void topping_report(struct topping_component *comp, u8 target,
 			   u8 prop, s32 value)
 {
@@ -648,8 +720,10 @@ static void topping_report(struct topping_component *comp, u8 target,
 	int idx;
 
 	idx = topping_index_of(tm, target, prop);
-	if (idx < 0)
-		return;			/* a meter, or something unnamed */
+	if (idx < 0) {
+		topping_report_sel(tm, target, prop, value);
+		return;
+	}
 	if (value < tm->model->ctls[idx].min ||
 	    value > tm->model->ctls[idx].max)
 		return;
@@ -795,7 +869,7 @@ static const struct snd_kcontrol_new topping_sw = {
 };
 
 /* ------------------------------------------------------------------ */
-/* the source selectors							*/
+/* the selectors: sources, and the M62's port power			*/
 /* ------------------------------------------------------------------ */
 
 static int topping_sel_info(struct snd_kcontrol *kctl,
@@ -833,24 +907,23 @@ static int topping_sel_put(struct snd_kcontrol *kctl,
 
 	guard(mutex)(&tm->lock);
 
-	/*
-	 * No report ever moves a selector, so the cache can be compared
-	 * and changed outside the spinlock; the spinlock is still taken
-	 * for the reader's sake.
-	 */
-	prev = tm->sel[idx];
-	if (prev == item)
-		return 0;
-	scoped_guard(spinlock_irqsave, &tm->val_lock)
+	/* as for a volume: the cache first, and a report has the last word */
+	scoped_guard(spinlock_irqsave, &tm->val_lock) {
+		if (tm->sel[idx] == item)
+			return 0;
+		prev = tm->sel[idx];
 		tm->sel[idx] = item;
+	}
 
 	if (!tm->bound)
 		return 1;
 
 	err = topping_write_sel(tm, idx, item);
 	if (err < 0) {
-		scoped_guard(spinlock_irqsave, &tm->val_lock)
-			tm->sel[idx] = prev;
+		scoped_guard(spinlock_irqsave, &tm->val_lock) {
+			if (tm->sel[idx] == item)
+				tm->sel[idx] = prev;
+		}
 		return err;
 	}
 
-- 
2.43.0

