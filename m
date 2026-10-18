Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C149D5AD
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327803; cv=none; b=RRkM3MiHgHipW52wvp8pPBbrhqD/XiSE++UngmMnwsysONqr1WSpZ8hmYvjiSI3sGoTA5bdhIXLc6aj01ffu4cESSFtE3q7/S9fsltI0xhrEZAfRM/QyOQoQcajO+5oYWCt04x4MrSAiDsvYISawVnmtOeydoe9D9yAuJ07lnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327803; c=relaxed/simple;
	bh=egCkSl1ziENZtLgdaKC+K1+MML1bessZk/jEY6CYHho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGxF9tl9Cr0niXY7tbGc6Rk4ABUkz63Vsys+ibxH6GEKOfaTMBtlp1ISTkucI+yh0uqgnbXQ5VZQ8XsPbWCggZzJ1e/59zDohwHjm7fMQzwYy/LhYDSrAS/Myk9JeaXiU5K9YscIiFKse2jlURBnIfG9Kg7647V6ry6qC6Tp9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTEkWm4X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTEkWm4X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1e3b87ac5so2719895e9.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327795; x=1792932595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlhaq0uy1Evc/akvQOutaQ2B/WUPQcS2vQ+budKfpsw=;
        b=oTEkWm4Xdis3ALlVegoVTEDTAifaxwJ2n6rrMXtTJNtWF+LFPd9TkgCqTWBfgFfc5d
         VTRmvkk/gE3JGRU6BejUyMG8ZNUgqfA2frNsjBL8xzbTMBpeXejYQHOSMOaE22W33ROk
         vGfG2n+XNg61h02uiuSQU0/Je9gr7NmSMNsJyludgmTBfclM/DjE5KAHKepes8mL0stL
         vk8YDF2q2gCNS9r5ZgtFwYBELl8WMn/hyYigcPG3Gn4350EqzcJJZcdD3HsKBo7fFsym
         4NUOZICZB6jXncY8H6XPGAuE6I0uhQ069FQTsUBU2+7eWy1J8l7/A6U1HjQwxT6htrz/
         hTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327795; x=1792932595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlhaq0uy1Evc/akvQOutaQ2B/WUPQcS2vQ+budKfpsw=;
        b=CjAK+ra20KoKUjCnfbtDOkCo21DlwnJedjjvQnDtSeefyjUU/StVlPkOOR/QILGoK/
         RmINFO22wWWkHA/4yo8naIILhBy9EcIL347Z0MFHEmv1oUnMV+Q9Rbg+CQgs5Gobpn90
         4+6Pc7jkg1TiPGWww6OTCbv9K/pUw7KX2HWOlnDluXQ/llYBgsC5MC3PGDsxCP4vnFYu
         xqNQ8YEF+rwYIJipq2cIBH0BnVu9zDKc+bC1lRkZMDMcGHIb0jbCA6+6Ujc4hpVdftQ7
         4HACao0lT8K6KZ68xjQ35ayI5uih3Ny1792R45OvTKx5OZujYrUX7HVZmrKq4uLb76g5
         ncEg==
X-Forwarded-Encrypted: i=1; AKwUvBy3bMt/FAMMPLgsh9SvIVTwMa2f70GSXNpkKWobKTKNzsMQTHfVCBXHT7KybBIrDII9hqXJRVWafGXlfQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJwKSXvdYHQ5yWXDVL6M+fu+fQmMyKJQ4iUKTOYRTVl4c7+iTjn
	etLLNFZpt49nDgUHwFvjSqnVhCw/Bfhnq49z6BOPxJK6qwUhyiYXmGNj
X-Gm-Gg: AYBFou3j9vn5tQgMcrbUVA8aTU6Usd4lhjirlFCsN/67z5O+DsTA8Mu0bJbPupM89w6
	JxIEscEB/fNXN69OanYBSWxNFSToCjzZEMGt2GaqTumlwq3+u1XJdi7HY4/4yvQsiiKHoDrycFT
	bk1cLOoWcgN6qhyIoC0aoUswHfFDLvbsIpbTUotH0vgh5OjtgsoOPRu/1mt1nw+STufoOavMzH1
	rYHkZX+z4Y2wKDA4Llkr6ohvAGGm2S3jOfwWrv6xe+xGrfe7LTAn34er7KgJnzhIk/uy4gzC/x5
	yusKtRAxGBmjEGKUKfTWiRtZ+Ndep4LD4RJLcYUvO7KDvYzYfhOXjOutEQ3da8+CjJfH4wuyeGW
	UmcEgczsIM50uUCZekgxCUAqh6rpmGvFrbOasMvShizJJjUvmF6Cv5waH7CE5NaC26d53SK8h2x
	6kWNn1cgJjXDa06EYrL6P7qXJn/+7Z76okffIsyTaiOxG2noSlPareLDrbmHWMlAKD+0qATy8j9
	QEuKn//DkUfnnYlPfljdXZBEdjC9Y4KnyOhr2u4sP404WiUMQ4yh4xk9GUBWY+V5RgPlmF7ydo+
	y02O
X-Received: by 2002:a05:600c:8b6f:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4a1d75f23e2mr87744845e9.9.1792327794494;
        Sun, 18 Oct 2026 05:49:54 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:53 -0700 (PDT)
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
Subject: [PATCH v9 7/8] ALSA: usb-audio: add the Topping M62's mutes
Date: Sun, 18 Oct 2026 17:48:37 +0500
Message-ID: <20261018124838.129349-8-mikhail.v.gavrilov@gmail.com>
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

M Control Center shows a MUTE beside each level these controls offer,
and the card keeps it: a MUTE left on by another host silences that
input or output here, with nothing on Linux to show it or to clear it.

Offer each as a switch named after its level, so that alsa-lib's simple
mixer joins the two and a sound server mutes through the card: the
inputs' MUTEs at property 05 of their targets, the outputs' at property
04 of both targets of their pair, and in Mobile Mode those of the
Playback 1/2 knob and the Recording fader at property 04 of theirs. The
card takes 1 for muted, so each switch is the inverse, on when the
sound passes. Each was pressed in the application and captured, in
both modes. The application writes them all off at each connect, and
so does the first bind here. The card reports the outputs' in its
announce, as 0x64/04 and 0x62/04, and that report has the last word.

The card also releases a MUTE by itself. In Pro Audio and Live Streaming
Mode, HP's volume written from the host while HP was muted released the
MUTE in 29 writes of 54, by HP's sound through a cable to AUX, and the
card reported each release at 0x64/04; a MUTE written right after the
volume did not hold in 7 probes of 9. No other level written from the
host released its MUTE. A sound server writes such a volume as a matter
of course: PipeWire, switching back to a device it has saved as muted,
writes the MUTE and then the volume 4 ms later, and the card released
HP's MUTE after 11 such switches of 20, for about two seconds before
PipeWire wrote the MUTE again. So a level set while its switch is off is
only kept, and the switch writes it on its way on, just before the
MUTE 0, as M Control Center writes a level turned under a MUTE before
releasing it. A bind and a resume, which write a level and then its
MUTE, leave a muted level to its switch the same way.

In Live Streaming Mode a level turned one step on the panel released its
port's MUTE in 257 turns of 260. The card reported every release of HP,
AUX and OTG OUT and most of IN 1's and IN 2's, and the switches follow
those reports rather than guess: a release left unreported stays shown
as muted, as M Control Center shows it. A level kept under a MUTE the
card has released, or one the card has reported, is dropped rather than
written over the card's own.

The MUTE on each of Pro Audio Mode's loopback returns has no property of
its own: the application writes the return's gain to off and, when
released, back to its level, and a return carrying a tone stayed as it
was with 1 written to 04 or 05 of its targets. Off is already the
bottom step of that volume control, so the returns get no switch.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 sound/usb/mixer_topping.c | 106 +++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
index 854ff0a..5fd14b3 100644
--- a/sound/usb/mixer_topping.c
+++ b/sound/usb/mixer_topping.c
@@ -46,6 +46,7 @@
  * after the card appears.
  */
 
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/cleanup.h>
@@ -115,6 +116,7 @@ struct topping_ctl_desc {
 	const unsigned int *tlv;	/* NULL for a switch */
 	const s32 *map;		/* what each step writes, or NULL: the step */
 	bool sw;		/* an on/off switch, not a level */
+	bool mute;		/* a MUTE, 1 when on: the switch is its inverse */
 	u8 resend;		/* written again after this one if on, or 0 */
 	u8 modes;		/* the modes that have it, or 0 for all */
 };
@@ -163,21 +165,51 @@ static_assert(ARRAY_SIZE(topping_m62_lb_gain) == 103);
 
 static const DECLARE_TLV_DB_SCALE(topping_tlv_lb, -9000, 100, 1);
 
+/*
+ * Each level has the MUTE the vendor application shows beside it, as a
+ * switch of the same name: property 05 for an input and 04 for an
+ * output, where 1 is muted.  The application writes all of them with
+ * the sound on at every connect, and so does the first bind here; the
+ * card reports the outputs' in its announce, and that report has the
+ * last word.  The card also releases a MUTE by itself: HP's in about
+ * half the writes of HP's volume made under it, and any port's when its
+ * level is turned on the panel.  So a level set while its switch is off
+ * is only kept, and written on the switch's way on, as the application
+ * writes a level turned under a MUTE before releasing it.  The card
+ * reports most of its own releases, and the switch follows the report;
+ * a release left unreported is not guessed at.  A loopback return's
+ * MUTE has no property: the application writes the gain to off and
+ * back, and off is the bottom step of the return's volume here.
+ */
 static const struct topping_ctl_desc topping_m62_ctls[] = {
 	{ "Mic1 Analog Capture Volume", 0x21, 0, 0x04, 0, 88,
 	  0, topping_tlv_gain },			/* 0 dB */
+	{ "Mic1 Analog Capture Switch", 0x21, 0, 0x05, 0, 1, 1,
+	  .sw = true, .mute = true },
 	{ "Mic2 Analog Capture Volume", 0x22, 0, 0x04, 0, 88,
 	  0, topping_tlv_gain },			/* 0 dB */
+	{ "Mic2 Analog Capture Switch", 0x22, 0, 0x05, 0, 1, 1,
+	  .sw = true, .mute = true },
 	{ "Aux Capture Volume", 0x23, 0, 0x04, 0, 99,
 	  81, topping_tlv_out_9 },		/* 0 dB */
+	{ "Aux Capture Switch", 0x23, 0, 0x05, 0, 1, 1,
+	  .sw = true, .mute = true },
 	{ "Bluetooth Capture Volume", 0x25, 0, 0x04, 0, 99,
 	  99, topping_tlv_out_0 },		/* 0 dB */
+	{ "Bluetooth Capture Switch", 0x25, 0, 0x05, 0, 1, 1,
+	  .sw = true, .mute = true },
 	{ "OTG Capture Volume", 0x27, 0, 0x04, 0, 99,
 	  99, topping_tlv_out_0 },		/* 0 dB */
+	{ "OTG Capture Switch", 0x27, 0, 0x05, 0, 1, 1,
+	  .sw = true, .mute = true },
 	{ "Headphone Playback Volume", 0x64, 0x63, 0x03, 0, 99,
 	  0, topping_tlv_out_9 },		/* the quiet end */
+	{ "Headphone Playback Switch", 0x64, 0x63, 0x04, 0, 1, 1,
+	  .sw = true, .mute = true },
 	{ "OTG Playback Volume", 0x62, 0x61, 0x03, 0, 99,
 	  99, topping_tlv_out_0 },		/* 0 dB, unity */
+	{ "OTG Playback Switch", 0x62, 0x61, 0x04, 0, 1, 1,
+	  .sw = true, .mute = true },
 	/*
 	 * A loopback return's gain is written to both targets of its pair
 	 * and never reported.  It starts at 0 dB, unity, as the vendor
@@ -197,15 +229,20 @@ static const struct topping_ctl_desc topping_m62_ctls[] = {
 	 * headphones, which carry it with every input while the recording
 	 * does not, and its Recording fader, the level of the recording.
 	 * Both are whole decibels, -90 to +12 and -90 to 0, where Pro Audio
-	 * Mode takes Q25 on the same targets.  Neither is reported, so the
-	 * first bind writes 0 dB: the knob then passes the playback's level
-	 * on unchanged, as Pro Audio Mode's outputs do with the mixer out of
-	 * the path, and the fader is at its top.
+	 * Mode takes Q25 on the same targets.  Neither is reported, nor is
+	 * either MUTE, so the first bind writes 0 dB and the sound on: the
+	 * knob then passes the playback's level on unchanged, as Pro Audio
+	 * Mode's outputs do with the mixer out of the path, and the fader is
+	 * at its top.
 	 */
 	{ "PCM Playback Volume", 0x53, 0x54, 0x03, -90, 12,
 	  0, topping_tlv_lb, .modes = TOPPING_MOBILE },
+	{ "PCM Playback Switch", 0x53, 0x54, 0x04, 0, 1, 1,
+	  .sw = true, .mute = true, .modes = TOPPING_MOBILE },
 	{ "Recording Capture Volume", 0x51, 0x52, 0x03, -90, 0,
 	  0, topping_tlv_lb, .modes = TOPPING_MOBILE },
+	{ "Recording Capture Switch", 0x51, 0x52, 0x04, 0, 1, 1,
+	  .sw = true, .mute = true, .modes = TOPPING_MOBILE },
 };
 
 /*
@@ -535,6 +572,7 @@ struct topping_mixer {
 
 	spinlock_t val_lock;		/* the cache and kctl[] against reports */
 	int *val;			/* one per row of the model's ctls */
+	unsigned long *kept;		/* levels set under their MUTE, unwritten */
 	unsigned int *sel;		/* one per row of its enums */
 
 	/* the volume controls and switches first, then the selectors */
@@ -548,6 +586,7 @@ static void topping_mixer_release(struct kref *ref)
 
 	kfree(tm->kctl);
 	kfree(tm->sel);
+	bitmap_free(tm->kept);
 	kfree(tm->val);
 	mutex_destroy(&tm->lock);
 	kfree(tm);
@@ -585,12 +624,45 @@ static int topping_index_of(const struct topping_mixer *tm, u8 target,
 	return -1;
 }
 
+/* whether the row after @idx is the MUTE of the level in it */
+static bool topping_muted(const struct topping_model *m, int idx)
+{
+	return idx + 1 < m->num_ctls && m->ctls[idx + 1].mute;
+}
+
 static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
 {
-	const struct topping_ctl_desc *d = &tm->model->ctls[idx];
-	s32 wire = d->map ? d->map[value] : value;
+	const struct topping_model *m = tm->model;
+	const struct topping_ctl_desc *d = &m->ctls[idx];
+	s32 wire = d->mute ? !value : d->map ? d->map[value] : value;
+	bool kept;
 	int err, other, on;
 
+	/*
+	 * A level set while its switch is off is only kept: written under
+	 * the MUTE, it may be taken for a release.  The switch writes it on
+	 * its way on, before the MUTE 0, so that the sound comes back at it.
+	 */
+	if (topping_muted(m, idx)) {
+		scoped_guard(spinlock_irqsave, &tm->val_lock) {
+			on = tm->val[idx + 1];
+			if (!on)
+				__set_bit(idx, tm->kept);
+		}
+		if (!on)
+			return 0;
+	} else if (d->mute && value) {
+		scoped_guard(spinlock_irqsave, &tm->val_lock) {
+			kept = test_bit(idx - 1, tm->kept);
+			other = tm->val[idx - 1];
+		}
+		if (kept) {
+			err = topping_write_ctl(tm, idx - 1, other);
+			if (err)
+				return err;
+		}
+	}
+
 	err = topping_write(tm, d->target, d->prop, wire);
 	if (!err && d->target_pair) {
 		/*
@@ -599,6 +671,10 @@ static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
 		 */
 		err = topping_write(tm, d->target_pair, d->prop, wire);
 	}
+	if (!err && topping_muted(m, idx)) {
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			__clear_bit(idx, tm->kept);
+	}
 	if (!err && d->resend) {
 		other = topping_index_of(tm, d->resend, d->prop);
 		scoped_guard(spinlock_irqsave, &tm->val_lock)
@@ -622,7 +698,8 @@ static int topping_write_sel(struct topping_mixer *tm, int idx,
  * values the cache was born with; at a later bind, with what was set
  * while this side was alone, which is still only in the cache; and after
  * a resume, in case the card came up on its own defaults or was changed
- * on its panel while the host slept.
+ * on its panel while the host slept.  A level whose switch is off is
+ * kept for the switch, as a put keeps it.
  *
  * Errors are not passed on.  The HID driver logs the ones that mean
  * something, and a card that cannot be written now is written again by
@@ -724,12 +801,24 @@ static void topping_report(struct topping_component *comp, u8 target,
 		topping_report_sel(tm, target, prop, value);
 		return;
 	}
+	if (tm->model->ctls[idx].mute)
+		value = !value;
 	if (value < tm->model->ctls[idx].min ||
 	    value > tm->model->ctls[idx].max)
 		return;
 
 	guard(spinlock_irqsave)(&tm->val_lock);
 
+	/*
+	 * The card's word, on a level or on the release of its MUTE, drops
+	 * a level kept under that MUTE, rather than have it written over
+	 * the card's later.
+	 */
+	if (topping_muted(tm->model, idx))
+		__clear_bit(idx, tm->kept);
+	else if (tm->model->ctls[idx].mute && value)
+		__clear_bit(idx - 1, tm->kept);
+
 	if (tm->val[idx] == value)
 		return;
 	tm->val[idx] = value;
@@ -1202,9 +1291,10 @@ static struct topping_mixer *topping_mixer_new(struct usb_mixer_interface *mixer
 	spin_lock_init(&tm->val_lock);
 
 	tm->val = kzalloc_objs(*tm->val, m->num_ctls);
+	tm->kept = bitmap_zalloc(m->num_ctls, GFP_KERNEL);
 	tm->sel = kzalloc_objs(*tm->sel, m->num_enums);
 	tm->kctl = kzalloc_objs(*tm->kctl, m->num_ctls + m->num_enums);
-	if (!tm->val || !tm->sel || !tm->kctl) {
+	if (!tm->val || !tm->kept || !tm->sel || !tm->kctl) {
 		kref_put(&tm->ref, topping_mixer_release);
 		return NULL;
 	}
-- 
2.43.0

