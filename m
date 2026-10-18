Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1249DBB2
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327804; cv=none; b=FjF+8MxIIw9oIhdcS3kXvfu2mR7TcVQQ3X1SyOoMi6hUO9yqAz7tOooMdjV6OctaCJffi1BgXj0VL19LerggN1V/q6cxGL16QiLj7lC/eP5d/Bw1jKhOHkXODbspxIVgmcj/6RF0RnN5OvurZtgILaY9IQNDk9XKtkgnmHKZzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327804; c=relaxed/simple;
	bh=GWAu37cFuv1xLgMuD4ayPerncnncwTCUkhb8UR/jiu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLrGJiaHAfKJPfLcvioMNFrz0XOygbrDkNLjG30TCkdIsnr/wFEDNg3zR25oBuXVuEuVPbpRDlz/AHQK8KLDpkCbXUNCrKxxobwpWclsrQLlNXDo1DIMZCa9jshFTLSKcI3/iqpxlTxc1VhEe8A4rc7IgpvpFgvHCGhXsANJ5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIdcSxUu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIdcSxUu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10663365e9.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327797; x=1792932597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BFGmTwaDCUDmZpp/IelpQAtIfirEzussdQk26erg+E=;
        b=cIdcSxUuFb1aJRJQQoViSFz9LqCB5kiEXjkPWrJ/jBlJ1DPC56C7QV8JjksjF3EroE
         JpPFdZOo2JKYp2CGe7COBo/6EXk2EdGlwpCKBS0V+KvyfTRaDW7gBxPG/R/hu53GYVJ6
         cyquJ9SVioWbSVYT4c3KhzB/knk5ylQ+W3XpEs6YTO7rHlmfgSjgdbBSurwGTATYMf90
         XTLfeivW02nhz8VIJJdO7gWxmul3ZkZhc/hMI6anmCBR6xwjlq7pf/8gCl9nXC8f0X7q
         EdhFQOGtWhkcdt5k+DvPvRl/KVfVQiUh1YjH35YKmqUBfG8RZeKizFyari/KajgvOkHH
         +b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327797; x=1792932597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4BFGmTwaDCUDmZpp/IelpQAtIfirEzussdQk26erg+E=;
        b=HNnP8P12u0w5amhGWgv58o8OAHySsl4Dt7Jf+uGmzzmuLDpI4jEMbJXV02nAghXxrn
         jbB6tx0PS0+YnHPKOPF7fuQQkOBI+hUCBMmdu2OFb64v1k56QGiJKWnp/JWdyhcfomQQ
         dTqp6e1OhSPouvI19GGhASjTkW1csYt9xeCqs/LXq+cvUVtIm1yPRjChx8nBAs6L2m/C
         VWqovV/qcAwz+pZkhFQlPwvv0YwJZZU5iby1Ujpx53ZJDOLQNkgeoodaGGP2z5AEGo4v
         mWyYP/oIJw7sGZ/YVwnVw73drm6+OH9FnEB3O343ry2xARI4wzkTJ+iF/+snBHyjawxW
         jamg==
X-Forwarded-Encrypted: i=1; AKwUvByJoFiB83qanJayskZTSROuU4zy47aC349V1rE6r5d8WxmD5qgQtW0zHDPkBwDdg8Okr3N4wct0aOZBlQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLCfpCZfj1HuR8dkUfy/aHpjYY85UWwp25+3Xx0EDqiInAjw1Xk
	ccSlxdqwaChXkl4BuKnFR9Qt9s3JaOOfgVfYnO5mb3zpJL+pUfq37erL
X-Gm-Gg: AYBFou3ewPwmPcg54GIHwk9Efo4ybNowH6R1KVi4QF0I5v7NR8JBLKOOndvbkUP8zUa
	928Y5PbD120aOIOZY8HFiqVtLM/t57ynguK8Jh4i0GFA/fgUeqwlxkzX6IqwotYm+9iO6oo0oh5
	6V4JQEHJN1kLaJzzDC3jxxp/4iR9B+P37PqOEoKf5DydYtxNVB1EJp2ZQZDOg3mZAWcCQSlBbeG
	kK737Hn8l6TMt1clILyrbBcftJSBcNKyMDLXp2C75eXCvZ0u48QJRBbjQZFatzM5KH04mAzyRRW
	LjNgIU0Lq4wmSc5kBV24t+rblT+GPRhzXS61FoOvVGODGNU96cSgQeLv/UVZktCZ5bW0IdL+IB1
	2j3FnYIjLJERGB2cfV0f/MET7mIiLjntb5DF48D5RKbQxQaw2tDFL1PrTBKaDQ8/HdB3wal8MHG
	+Q5pqVvsKMxMFH2yBmgIKJc5h7BA9aW3gZRnxb/b1qlmctsfL292Zs7l8gN2yA/OBa70rjHL4sr
	LV7kn48frOVa+Kg/8uNwqX2eAFlIiCsjrxaVi7J/p1wHoRtgGzWwHnohJ/o49dtJjmSOw==
X-Received: by 2002:a05:600c:8b43:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a1d75ad072mr99880305e9.1.1792327796908;
        Sun, 18 Oct 2026 05:49:56 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:55 -0700 (PDT)
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
Subject: [PATCH v9 8/8] ALSA: usb-audio: add the Topping E2x2 OTG's input mutes
Date: Sun, 18 Oct 2026 17:48:38 +0500
Message-ID: <20261018124838.129349-9-mikhail.v.gavrilov@gmail.com>
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

