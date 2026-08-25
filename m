Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2473EA973
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648235; cv=none; b=sbLUp3Kt4IhgRVTwe2qnWfbcDyimYoHQbg8pKlovlrgLbnX6tUAZv0ybUGzmanzO29siDUaZyMPB01/3ANRdqiTOSEZwR8PDzopZefKxpJ7UeVWBAAJ/3k93JjyqXt9mAQyBmDlbUHWti58E3Duxq731SSVahqmsL9tWqSf2ELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648235; c=relaxed/simple;
	bh=kJ7klInST5o3tLLc7OKG3pFtnIYvJegWXJKOTxxeefQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp58H1Q/yomf/LfB4oZaS7LMxZUU64MnX/N6yNwkPYbIv5hb2oLJtCfKS744MAP0IKQaDQXcY+Ahgq2qwmEFE9xGQrLg4Nzy0EWufNervBjdX6gWx5VRbJxomPXpYxsWt4npD751EFscIoFenR5yg87MteX5CELU7hJmO9FKrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVYjK/e5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVYjK/e5"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c953950dfso33493691fa.1
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648228; x=1788253028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9mKUb7KLToO0RRB/kg3fqtUc76zZQHXNqB47te/ev+k=;
        b=gVYjK/e5b8TPW6vZlt0Dy4MD5AcF5spd+6RMZNSXNcTiB1AlAD+MAwI7ArilwWvTzr
         rVojn8LRIO1/EXUYzi6U+XLq2ky4pYhXDWWGzHbRJOLxzsrbXoOAcxLcpac4WVydOtBW
         xPr6tqpWKLkTVdzFnQylCaQnymIYwVIYrzwPbjzcHx1oYCy6D4TD1rcRyYae1dxsg6rz
         he3qeF4ItRgf4VzqJWmv54B9RmKkGeqsYparuCcngsUMHV4uYJGWf3FY9mTjDI9oI0tg
         aT7LBKg3p6hZ77oQg2JQm60QQCCtDKm3agj4T938zQNm6PsylK5s+L6Qp6mVhbm6EwKt
         ROYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648228; x=1788253028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9mKUb7KLToO0RRB/kg3fqtUc76zZQHXNqB47te/ev+k=;
        b=QFe0Pc18xGIgqQL0+g93t3oO8UFNQ9f0B9/9VeasySIO9DhZSY97SQd9X/ltwhDdDd
         oizA7cpjwS1vxhSC05W4TbzgVqFGzr9QQh9oUtkAG//QNSsGH9TD77BGeRO3EyosFTwf
         EC1UAzg6PnMEUJmwfXDpzHtUnYcF/8Y+BNtlI2xhLIGjMifkSDsbY6OWnJ61k4SW5VqA
         jACxFWxlHP2JKu8rJGmUAZbQg9LdwEU25tkMsS8PyIOskUvAfwhUnA9GdfGJ98IVD187
         4eVDJSHTc/+IS4u4FD+sQmbwcKYRKedTZ7DsibHlYMqtlffzSTckc1pNLU4UEdlOJP8O
         ad1Q==
X-Forwarded-Encrypted: i=1; AHgh+RofjkcS5pfW8+bDY1w8wze+YKRHpREspAteyibLIXnEQJCdwp1E1Ae6YlvZ8gaLOHgZAuH4X/JO/jz2rQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ly42/6veJ4k0impezd+oX2U42B89rlTcWnnDtg4t4S+lShWGhv
	q4fCjYRG3NZ6ASB3Cw3T8lUiM4BHFadTtdIbGDMp3PVAXz8FTr9rPX9V
X-Gm-Gg: AR+sD13139qqhyrVIxKT9daKBqju7U90Sjbqt5ip7PwgqdFmPU9ygmqVVfTsDD64Kj/
	x9GXK5Y9y+Zuyu/mDhxYKZffCM2AlKVwbSN6KvafJDN9OYiNzkaWaM+F/HpOd3DHJ2AcIdC0aKv
	hp8wImpwaU/HqgbpCBUdpdRg4JHbm90tV/QBcxtFpUcoWNUSXUq1rllXrdvIyjxEml9gih80huS
	+fIi5Yv1P2jL8INcJQXII/OILBajahedUZlKGyQ7avtJR35DrrneVtiPOUcZb/a+msestMlTeKE
	uIc89kqWszdn0B9ZQhaG1D5ZhK0CC19bxbglWjzLxTGye1hUIIqp7svL85SIP8J5BpwmVntj2w+
	kgndB/M5aApqneTqxMT7AaNpK9F9eWc9n4HCdEu21vKTX3tteQGpjRmqRDgL1xAwRGEdklVe009
	ohTYD1n/4XqkXIGqU7vfYulSc9mwiFEFjJTUxxJ8ftAUGWvPW9FxWoBWe/3nLdG9bnKQdmjSehX
	+vfwI8Wlmhb3iAz/zY5ucBrDIX4jsTENFlGAi38N0GJsC0ZY8PVx5IWjX7AjDZj0g==
X-Received: by 2002:a2e:b889:0:b0:3a1:5cd1:9f90 with SMTP id 38308e7fff4ca-3a1aeb5d50dmr75860151fa.3.1787648227927;
        Tue, 25 Aug 2026 01:57:07 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a1c2e56737sm20545111fa.6.2026.08.25.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:57:07 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v7 2/2] ALSA: usb-audio: let the M62's outputs say what they listen to
Date: Tue, 25 Aug 2026 13:56:59 +0500
Message-ID: <20260825085659.52675-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825085659.52675-1-mikhail.v.gavrilov@gmail.com>
References: <20260824223107.406504-1-mikhail.v.gavrilov@gmail.com>
 <20260825085659.52675-1-mikhail.v.gavrilov@gmail.com>
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
index 06cea753046a..79ba1c5fdcdf 100644
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
@@ -369,6 +409,71 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
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
@@ -411,6 +516,57 @@ static int topping_add_ctl(struct topping_mixer *tm, int idx)
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
@@ -455,6 +611,7 @@ static int topping_resume(struct usb_mixer_interface *mixer)
 	 */
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	topping_restore_sel(tm);
 	schedule_delayed_work(&tm->keepalive,
 			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 	memalloc_noio_restore(noio);
@@ -600,6 +757,11 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
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

