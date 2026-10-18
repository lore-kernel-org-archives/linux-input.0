Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9E4D990A
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357063; cv=none; b=q8JgZYmJO0p3+MjedOJXIC1PsNrgHvSYN7cncEk6GAW+qEFxeiT/+h7iJuwviK3La7ISeAFNZKd8tUT799lDtvs/KyEDy9q8Q83NxBmbbqKXdkvit2e5shk5Rl1AWBXmGq2Ksej3hp9i3zhihrRC86r3drofIaCl2pVdLYmfWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357063; c=relaxed/simple;
	bh=GWAu37cFuv1xLgMuD4ayPerncnncwTCUkhb8UR/jiu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsYm5XlldeFgAVuDt+X/5jdvB7Cl5LjcORn9SQFd6lilZqKkGdVEealKaZNxjwoXZv6eLmA//KDqmA+M7yrLwPvlc1cnWWQEgrPdiRPJVgyskUozKGc88OD2r0jD7LJUj0e8O5pJzU8SGK3nGaht5WHtfcr7FT0DLklh9/vVpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCcgKz6j; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCcgKz6j"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1035418f8f.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792357060; x=1792961860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BFGmTwaDCUDmZpp/IelpQAtIfirEzussdQk26erg+E=;
        b=mCcgKz6jz2YjNE1xKlm4Pw07+lLjgJfEZ5YvX19Vm1dhn0eYL7OFHeHMCewzH3ZztU
         Dnd37HDyYwTUhOfpnGqWJqGKRlgSYgTgm68kIC+MfZ7Ty8CPoEuWsSwPvnU/yY0ElLqb
         Lb+QVBIOpEgNyULQADBrLJVU1BabwFrlsbNPLqfJQW+oCz40okij6iAxcpGx7wC3GcjA
         uLtwqDAQx8a3htYEjJ52M5iBCA3xmSIZ/b/mQD6rtESWcOsLfdHjmJDspF5bq8q9Aqam
         WY43H9NqzZyMEChkcUjogrnKTIZnotZoVrcNIgR7vIXDl2cBd586M+iRZMai7KYGE9+L
         ViBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357060; x=1792961860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4BFGmTwaDCUDmZpp/IelpQAtIfirEzussdQk26erg+E=;
        b=lkQQYmoaArDcbFldt8c9L53z+12Zf9mbJFme6/7gBtdfvp3etVwndgpeZun9Bds1st
         HJTSSefuaJiC9LQ+AChW3Vh9TEkhFAzgULekQ7e0T2k8kMRpk2cPaP0gal0WfJou9H/J
         mm6U5ATKtfyaLvCXSA3fQzZEhCnUA8whJqHHkQHuhc97/LC374JiTGRm0yb0HnmvRRxx
         NQ2R1qxnscqfxSoBuasmFx/pnzaHBLE+2PkRpkLWuyl/pzn9v97l+Iat9BmB3K5lG5To
         WcvVbZKcvpgNQJLkWHKE9M8dYSGP83YzTfPdC9MbAND0GCFisUoYu98nzb/1rP2gQXnZ
         Sp7g==
X-Forwarded-Encrypted: i=1; AKwUvBzUyCbKMKSC2Mf0/BefSSjJiFy6LgR+23rn2dx+IxqKrimCK8+ju8O6G1t2t77ejtKAtBaMFZPIBFyv2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYI8D9FWI7ZlR5n7upUsM4ueeq4TRYlyLKxDXjjnKLEzL2omSiRv
	Wx0QksJ1paAbJu0kKGKTJf097Yr9E/ArZRdQmZ8ji0v+lqOWyZm3EWmH
X-Gm-Gg: AYBFou31ny8lOm5BwW+Dfme6m0RQ07caRIRdsPxKjB2P6fCuXAky/KebCkGhPQicYnS
	41uB/5r7OOMJBYta2RUV/6jPBqRnKK9cnBXzxWCsbhB6kgrzVgj00Bf44p1F9zIJg9URr9rlKI0
	oEu6Q0VJ0kwOSkggQLX6wMNW81Tcs3zsSKlC1S2XqTbUyItW4+3nRU9FsWcS2iV0jiN5wjv1Ze3
	XYDy0bKai3qpLhNFzAJx/c42Kfmsx5gwfoofuj3fdxTQd4m2GAWgmSACTTMauhG4PFVYT/i1w5K
	iqQ7Xo97ru22zKV/X0jVgu+elckPv9OHz9knj2Q5PXapne3wTsViQeLS7asSRW3As2YMwW0W+xL
	T4SrXAMWup7lZkNDUY34tB4qNn1Uz5kjq8VDRv/Cxo0q6rK4znWumNli9qNk28B5TgZT7NuGbPk
	MLdToJTiHDd2SKze0lnxJtNNwV9hC4ONAmlNvqMMGgnaco/7v8SMY1SocGpdYkcw/vAaoa/k0Pv
	LKOV2swZmB0f6qblEw410b07nqCnRIQA4ihwrVm5rnSMjoiUZWVeOKuhHajo/OoSeaT2w==
X-Received: by 2002:a05:6000:2313:b0:48e:884:affb with SMTP id ffacd0b85a97d-48e0884b2ffmr11671095f8f.24.1792357059833;
        Sun, 18 Oct 2026 13:57:39 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm18496263f8f.30.2026.10.18.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:57:39 -0700 (PDT)
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
Subject: [PATCH v10 8/8] ALSA: usb-audio: add the Topping E2x2 OTG's input mutes
Date: Mon, 19 Oct 2026 01:57:10 +0500
Message-ID: <20261018205711.168291-9-mikhail.v.gavrilov@gmail.com>
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

TOPPING Professional Control Center shows a MUTE beside each input of
the E2x2 OTG, and on Linux an input could not be muted on the card: the
gain controls start at +0 dB, as the application's knobs do, and its
MUTE is a value below them.

The card keeps no MUTE of its own. The application writes the input's
gain, property 05, to 0, writes 0 again at every step of the knob while
the MUTE is lit, and on release writes back the gain it kept; nothing
else is written either way, and the Mobile input's MUTE writes 0x22
alone, as its gain does, which silences both of its channels. The card
acts on the 0 at once: an input's meter, which follows the gain,
read -96.0 within 82 ms of the MUTE and came back within 62 ms of the
release. The gain itself never reaches 0, so 0 is the MUTE and anything
above it the gain.

Offer each input's MUTE as a switch named after its gain, so that
alsa-lib's simple mixer joins the two and a sound server mutes through
the card, as on the M62. The switch and the gain write that one
property: 0 while the switch is off, the gain otherwise, and a gain set
while the switch is off is only kept, as the application keeps it. The
first bind writes the switches on, so a MUTE another host left on the
card is released there, as writing the gains already released it.

An off step at the bottom of each gain would have been simpler, but the
step above it is +0 dB: the input would go from silence to its full
level in one step, and a sound server that follows the scale in
decibels would find nothing between the two.

The faders get no switch. Their MUTE, on Mobile OUT, S/PDIF OUT and
each loopback, writes the same 0 to both targets of the pair, which is
already a fader's bottom step, and the steps above it start at -80 dB.
Output 1+2 has no MUTE in the application at all, only its three output
buttons, which are switches here already.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 sound/usb/mixer_topping.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
index 5fd14b3..6e1f60d 100644
--- a/sound/usb/mixer_topping.c
+++ b/sound/usb/mixer_topping.c
@@ -117,6 +117,7 @@ struct topping_ctl_desc {
 	const s32 *map;		/* what each step writes, or NULL: the step */
 	bool sw;		/* an on/off switch, not a level */
 	bool mute;		/* a MUTE, 1 when on: the switch is its inverse */
+	bool zero_mute;	/* the MUTE of the level above, as its 0 */
 	u8 resend;		/* written again after this one if on, or 0 */
 	u8 modes;		/* the modes that have it, or 0 for all */
 };
@@ -404,12 +405,28 @@ static_assert(ARRAY_SIZE(topping_e2x2_fader) == 82);
 static const DECLARE_TLV_DB_SCALE(topping_tlv_fader, -8100, 100, 1);
 
 static const struct topping_ctl_desc topping_e2x2_ctls[] = {
+	/*
+	 * An input's MUTE has no property of its own.  The vendor
+	 * application writes the gain to 0, writes 0 again at every step of
+	 * the knob while the MUTE is lit, and on release writes back the
+	 * gain it kept; the gain itself never reaches 0.  So each gain has
+	 * its MUTE after it, as a switch of the same name, and the two write
+	 * that one property: 0 while the switch is off, the gain otherwise,
+	 * and a gain set while the switch is off is only kept.  A fader's
+	 * MUTE is the same 0, which is already the fader's bottom step.
+	 */
 	{ "Mic1 Digital Capture Volume", 0x21, 0, 0x05, 0, 20,
 	  0, topping_tlv_gain, topping_e2x2_gain },
+	{ "Mic1 Digital Capture Switch", 0x21, 0, 0x05, 0, 1, 1,
+	  .sw = true, .zero_mute = true },
 	{ "Mic2 Digital Capture Volume", 0x23, 0, 0x05, 0, 20,
 	  0, topping_tlv_gain, topping_e2x2_gain },
+	{ "Mic2 Digital Capture Switch", 0x23, 0, 0x05, 0, 1, 1,
+	  .sw = true, .zero_mute = true },
 	{ "OTG Capture Volume", 0x22, 0, 0x05, 0, 20,
 	  0, topping_tlv_gain, topping_e2x2_gain },
+	{ "OTG Capture Switch", 0x22, 0, 0x05, 0, 1, 1,
+	  .sw = true, .zero_mute = true },
 	/*
 	 * Output 1+2's fader as "Master": the sound server's stock
 	 * profile takes a control by that name for the volume of the
@@ -630,10 +647,17 @@ static bool topping_muted(const struct topping_model *m, int idx)
 	return idx + 1 < m->num_ctls && m->ctls[idx + 1].mute;
 }
 
+/* the same, for a MUTE written as the level's 0 */
+static bool topping_zero_muted(const struct topping_model *m, int idx)
+{
+	return idx + 1 < m->num_ctls && m->ctls[idx + 1].zero_mute;
+}
+
 static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
 {
 	const struct topping_model *m = tm->model;
 	const struct topping_ctl_desc *d = &m->ctls[idx];
+	const struct topping_ctl_desc *lvl;
 	s32 wire = d->mute ? !value : d->map ? d->map[value] : value;
 	bool kept;
 	int err, other, on;
@@ -663,6 +687,23 @@ static int topping_write_ctl(struct topping_mixer *tm, int idx, int value)
 		}
 	}
 
+	/*
+	 * A zero_mute switch and the level above it write one property: 0
+	 * while the switch is off, the level otherwise.  A level set while
+	 * its switch is off is only kept here as well.
+	 */
+	if (d->zero_mute) {
+		lvl = &m->ctls[idx - 1];
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			other = tm->val[idx - 1];
+		wire = !value ? 0 : lvl->map ? lvl->map[other] : other;
+	} else if (topping_zero_muted(m, idx)) {
+		scoped_guard(spinlock_irqsave, &tm->val_lock)
+			on = tm->val[idx + 1];
+		if (!on)
+			return 0;
+	}
+
 	err = topping_write(tm, d->target, d->prop, wire);
 	if (!err && d->target_pair) {
 		/*
@@ -715,6 +756,8 @@ static void topping_sync(struct topping_mixer *tm)
 	for (i = 0; i < m->num_ctls; i++) {
 		if (!topping_here(tm, m->ctls[i].modes))
 			continue;
+		if (topping_zero_muted(m, i))
+			continue;		/* its switch writes it */
 		scoped_guard(spinlock_irqsave, &tm->val_lock)
 			value = tm->val[i];
 		topping_write_ctl(tm, i, value);
-- 
2.43.0

