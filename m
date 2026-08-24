Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05A3955F0
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610681; cv=none; b=HOjOjmHuQzj+Rwr/cIXesx/wMLoa/2TJJx3H1aqNwVJCsnPPeYdUwO9Pj0C2F2uu8KhBOzxYi0qyrBzPqIbTKk3eShYOMXwW2CMQi4xU+XYMCMtOZM3R8Ady7n4Tu1o26sfwCyJMsrxP123FMGgLbucOF6kw2Oquq1zt6mqCO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610681; c=relaxed/simple;
	bh=tCZdD8KXm0twLInzbpXjz6pv7CKq1Lv0XNh9VsUTe5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCVB+WOJ8RH8G7z3SAupAIdBzvomlZDgbSYHOjoR2qQxinsxfH1lOcyO0P+cMUTUgZPC5B/xe+RlJp6VQj/n/HO+2v0N+9LkxRP/dp9BI4B9LJqNv1TAmPIq5nT98LnGMc1I+HXar8lE/GtdFGNPE3wYCxtSzxcLSAJuUqVt3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnP13yOt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnP13yOt"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso3957978e87.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787610677; x=1788215477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ca0Zs/xTHuEz+v8rwst1BlpMVa0G0BUWbtgcjLGPvdc=;
        b=pnP13yOtdugb7L07TSBrKiDF1KK9QLfQ/2lwPWTSIvObE4vgANykmveNp92QvXl7B0
         da2fGH88J3YpLFlFMFKEtCePr6uBzNeyJ1XU9tufHmd5o2MubIn4ncHYQZy3fziGki4D
         eI1pylnRKSeQkku02RSzh8zt2XmnFPpbUHz8x6NBw8WQ2kY0pTm3wvAbxB8fnpQXL8H2
         bi1J6tT6Io+NE2eYYBVx+74jGWxLxOjqGg8ceP623AnVAZ7saenZocaPTt6LsN+IBVX/
         vRxk0Zz1lUZmH97ZQL4+W1qM26EM6sZ4cg8xWF+wcdaxg5X1dnVOwjiS9Y91OuUsDg2n
         gELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610677; x=1788215477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ca0Zs/xTHuEz+v8rwst1BlpMVa0G0BUWbtgcjLGPvdc=;
        b=DsKIvI/IlUnwYS5M+JnnlIQsj4eQnka6FPpbiO6xsRMuIy/xo8sFMxc1igJqGCus35
         XIB1UR0MC1fx7IUlVFQeTVHZcyI+R3YifWiYas5/FWahwE/8jnasobidltmMMmWeSGTI
         chBQetfvawIimJ5OugI9zcdwdp7Vh/Uop0Dud/xZn3MoLTdg/nXDY4JI277YVYuJTfOE
         3TZ3Wn1QHM+qHKVCiV5g/BMyN+JqlK9Jcp41nadHozugXMa0TdFggbTJAZLFxnCOjxpx
         HW0jB9Z5GBDGCDFT7xsSCkP/2VJOqzdKlApSlnglyEEc2lg0r+1HPV8rlUQr/26wyEis
         0bWA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/UYEXVnPXmCKLC1p7LK++5bUe7gYMyom+e8bvG7WvM0DEEUm/sIQxEL88Y+o7Y4q19eOuAPpIZHZzWw==@vger.kernel.org
X-Gm-Message-State: AFuF++mSvIrEoBbjV7hk2WZuR7BcqnA7JvB44bxc+6b3hLPZyDW7YyhH
	UawH4r/YlVO5xT+fdAqU0yIRSXAfsS9Fav73ZLLqaWBu3C2bfJhQUb5HBbO53K8NnGmlhwu3
X-Gm-Gg: AR+sD12FKewoGJb3rZymLX39rdb2XZRCI1AfO47cuL63tfu8uvPYqriWr48HfRFH7f/
	KRnZRr9k5zbbDZIs7enM2j0YI+eQ2zxvT/OzeI1Cn/oeQs0O1dP3r0xTna4tu1N93rsed5kQ1bw
	alx2NWST0VRdQ7AwlrqbLWsmE4bAp/QfzLdNotCcaF1Spg10XXu2byOPTAP+vtquzrIhjR8+KKP
	yo/IsFSgFgQPDHKzy/2w8rbvikVfBmw5Byqdsol7vQ2LcO/q/OI/wmg2QWJsvC80YuUYSZfQEn4
	LobM5iFF/4TCDSl+JwQXvsdnUL8nsSZ1STw2YRlKQJlHL9/7TyY/ereJAE/PLIlOUrxZhvst0oX
	08tz/a21SvbFAjVrh2J4jlEhpTQ+GBSM9K4tlXgpLjGp+ZnIF6RUmYK/4G8ZnE0EIIBqmCRQ88B
	YOmK2EqlXP+nqSC0zQAi3/V6A5waaRvORUwQvxRmR7+xW8ckJPHtSReTTo8nrj6AjNZBEwxIdSo
	+V1FaC4aO0/lLYfm+4kZXFTr3gRMg+I3SUpmYuDy3DZJ9TXHKA158t5AHUSUci3JQNjn+8=
X-Received: by 2002:a05:6512:2356:b0:5b4:5352:e2db with SMTP id 2adb3069b0e04-5b49cdbf946mr416343e87.20.1787610676537;
        Mon, 24 Aug 2026 15:31:16 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cdfdc49sm2073351e87.41.2026.08.24.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:31:15 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v6 2/2] ALSA: usb-audio: let the M62's outputs say what they listen to
Date: Tue, 25 Aug 2026 03:31:07 +0500
Message-ID: <20260824223107.406504-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824223107.406504-1-mikhail.v.gavrilov@gmail.com>
References: <20260824201331.304705-1-mikhail.v.gavrilov@gmail.com>
 <20260824223107.406504-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each output on this card has a source selector: it can take one of the
three internal mixes, or any input, or any playback bus straight from
USB. Which it is decides everything downstream -- point the headphones
at a playback bus and the card's mixer leaves the path entirely, along
with every question about what is summed into it.

That matters more here than it would elsewhere. There is no control
panel for the M62 on Linux, so a user who never runs the vendor's
application on another machine has no way to see or change this, and
inherits whatever the card was last told. One enumerated control per
output gives them the whole choice, and it does so without exposing the
sixty-cell mixer matrix, which without a graphical representation would
confuse far more than it helps.

The item list has "Unknown" first, and it is deliberate rather than
tidy: THE DEVICE NEVER REPORTS A SELECTOR. Not to this driver, and not
to the vendor's own application, which on connect pushes its entire
workspace to the card rather than asking it anything. So the current
setting cannot be learned at probe, and saying so is the only honest
thing a control can do until a hand has chosen. Selecting "Unknown" is
refused, since it is a report and not a choice.

The numbering the card uses has a hole where 4 and 5 would be, so the
item index and the value written are kept as separate tables rather
than one being computed from the other.

Writing "Unknown" changes nothing and says so quietly. It is what the
control reports until a hand has chosen, and alsactl stores and
restores it like any other value, so refusing it would fail a restore
of the driver's own report -- once at every boot, and again whenever a
saved state is put back over a chosen one.

The choice is written again on resume. The gains need no such help --
the device announces them and the cache re-syncs by itself -- but a
selector is never reported, so if the card came up on its own defaults
while the host slept, the driver's idea of it would be silently wrong
and writing the remembered value back would look like no change at all.

This write wakes the device before taking the lock for the same reason
the gain controls do: the wake can run the resume callback on this
thread, and that callback writes the selectors back under the same
lock.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 sound/usb/mixer_topping.c | 162 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
index f8ddeafb0222..df0dbe212c40 100644
--- a/sound/usb/mixer_topping.c
+++ b/sound/usb/mixer_topping.c
@@ -127,6 +127,45 @@ static const struct topping_ctl_desc topping_m62_ctls[] = {
 	  topping_tlv_out_0 },
 };
 
+/*
+ * WHAT AN OUTPUT CAN LISTEN TO. The same numbering serves the outputs
+ * and the loopback returns, and it has a hole where 4 and 5 would be,
+ * so the index of a control item is not the value the card wants and
+ * the two are kept side by side.
+ *
+ * "Unknown" is first and is not a choice: the device NEVER reports a
+ * selector, not to us and not to the vendor's own application, which
+ * pushes its whole workspace on connect rather than asking. So a
+ * driver cannot learn where an output is pointing, and the only honest
+ * thing it can show until a hand has chosen is that it does not know.
+ */
+static const char * const topping_sources[] = {
+	"Unknown", "Mix A", "Mix B", "Mix C", "IN 1", "IN 2", "IN 1+2",
+	"AUX", "BT", "OTG IN", "Playback 1/2", "Playback 3/4",
+	"Playback 5/6", "Playback 7/8", "Playback 9/10",
+};
+
+static const u8 topping_source_value[] = {
+	0, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
+};
+
+struct topping_enum_desc {
+	const char *name;
+	u8 target;
+	u8 prop;
+};
+
+/*
+ * The selector answers on ONE target of an output's pair, unlike the
+ * volume and the mute which must be written to both.
+ */
+static const struct topping_enum_desc topping_m62_enums[] = {
+	{ "Headphone Playback Source", 0x64, 0x02 },
+	{ "OTG Playback Source", 0x62, 0x02 },
+};
+
+#define TOPPING_NUM_ENUMS	ARRAY_SIZE(topping_m62_enums)
+
 struct topping_mixer {
 	struct usb_mixer_interface *mixer;
 	struct usb_interface *iface;
@@ -143,6 +182,7 @@ struct topping_mixer {
 	spinlock_t lock;	/* guards val[] against the URB */
 	int *val;
 	struct snd_kcontrol **kctl;
+	int sel[TOPPING_NUM_ENUMS];	/* what a hand chose, or 0 */
 };
 
 static void topping_build(u8 *f, u8 target, u8 prop, s32 value)
@@ -365,6 +405,71 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
 	return 1;
 }
 
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
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct topping_mixer *tm = elem->head.mixer->private_data;
+
+	guard(mutex)(&tm->write_lock);
+	ucontrol->value.enumerated.item[0] = tm->sel[elem->control];
+	return 0;
+}
+
+static int topping_sel_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct topping_mixer *tm = elem->head.mixer->private_data;
+	const struct topping_enum_desc *d;
+	unsigned int item;
+	int err;
+
+	item = ucontrol->value.enumerated.item[0];
+	if (item >= ARRAY_SIZE(topping_sources))
+		return -EINVAL;
+
+	/* the wake before the lock, for the reason given in _ctl_put */
+	CLASS(snd_usb_lock, pm)(elem->head.mixer->chip);
+	if (pm.err < 0)
+		return -EIO;
+
+	guard(mutex)(&tm->write_lock);
+
+	/*
+	 * "Unknown" is what this control reports until a hand has chosen,
+	 * and alsactl stores and restores it like any other value.  It is
+	 * not a choice, so writing it changes nothing -- quietly, rather
+	 * than failing a restore of the driver's own report.
+	 */
+	if (!item || tm->sel[elem->control] == item)
+		return 0;
+
+	d = &topping_m62_enums[elem->control];
+	err = topping_send(tm, d->target, d->prop,
+			   topping_source_value[item]);
+	if (err < 0)
+		return err;
+
+	tm->sel[elem->control] = item;
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
 static const struct snd_kcontrol_new topping_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -407,6 +512,57 @@ static int topping_add_ctl(struct topping_mixer *tm, int idx)
 	return 0;
 }
 
+static int topping_add_sel(struct topping_mixer *tm, int idx)
+{
+	struct usb_mixer_elem_info *elem;
+	struct snd_kcontrol *kctl;
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
+	kctl = snd_ctl_new1(&topping_sel, elem);
+	if (!kctl) {
+		kfree(elem);
+		return -ENOMEM;
+	}
+	kctl->private_free = snd_usb_mixer_elem_free;
+	strscpy(kctl->id.name, topping_m62_enums[idx].name,
+		sizeof(kctl->id.name));
+
+	return snd_usb_mixer_add_control(&elem->head, kctl);
+}
+
+/*
+ * The gains come back by themselves, since the device announces them,
+ * but a selector is never reported: if the card came up on its own
+ * defaults while the host slept, this driver's idea of it would be
+ * silently wrong, and writing the remembered value would then look
+ * like no change at all.  So the choice a hand made is written again
+ * -- which is what the mixer core does for every control that is not
+ * marked as the driver's own to handle.
+ */
+static void topping_restore_sel(struct topping_mixer *tm)
+{
+	const struct topping_enum_desc *d;
+	int i;
+
+	guard(mutex)(&tm->write_lock);
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
+		if (!tm->sel[i])
+			continue;	/* nothing was ever chosen */
+		d = &topping_m62_enums[i];
+		topping_send(tm, d->target, d->prop,
+			     topping_source_value[tm->sel[i]]);
+	}
+}
+
 static void topping_suspend(struct usb_mixer_interface *mixer)
 {
 	struct topping_mixer *tm = mixer->private_data;
@@ -451,6 +607,7 @@ static int topping_resume(struct usb_mixer_interface *mixer)
 	 */
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	topping_restore_sel(tm);
 	schedule_delayed_work(&tm->keepalive,
 			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 	memalloc_noio_restore(noio);
@@ -596,6 +753,11 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
 		if (err < 0)
 			return err;	/* private_free cleans up */
 	}
+	for (i = 0; i < TOPPING_NUM_ENUMS; i++) {
+		err = topping_add_sel(tm, i);
+		if (err < 0)
+			return err;
+	}
 
 	err = usb_submit_urb(tm->urb, GFP_KERNEL);
 	if (err < 0) {
-- 
2.55.0

