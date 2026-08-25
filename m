Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D03FD946
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656376; cv=none; b=VADTouK2EvYWNtut7FUrFF/QVPYsmlIDLG64TZYnIT9jd04aXID4LMSDylejcSAwJrjbMv3NJ7Mmb/P7qTlOlPHVqIZIEQNEl7PJXEujmpTlkHawxbmD7XC9p+p3rz+tEVzwZ3F4+7vHT5xVzOMTDaLi+TAcukuubltzgmIF+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656376; c=relaxed/simple;
	bh=vMtWDNwbwcpelyaCoK5Kmwd4wqMxpsqiZD7dK5PEs7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL+aF77/I1hXKb6tbvAiqPoz8KGSULFWSsC4fmQfSq44Pu7ULDkuOeAAlA3pvzTEvy+kcImxRh68yNmdv1SxKP4yq8v5BNG8DHfYKHfqvVfHnVH7s+3mqBYHIR9BJWdlGvrw070rfDW99Hz9cfd52nWQRgUuwE3TeEcGzs4DWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/JbF3sG; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/JbF3sG"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b457a0b4e5so4171047e87.1
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787656372; x=1788261172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lymENNeZhP352EEGP9sBVket9fGxGtuJScsbcL5Oefo=;
        b=U/JbF3sGiE98wRd9XSfDTNCO22ziIQ8ccviO053ukdTu/ZyZ2U9Ie4PwC7dOjnaIhp
         FC5SG5BTuhVKbRxbZ39WxCibShVX9J0f7M3F0UoLjj98Q9K3S8uM9px2Jm1O7smYNmFI
         VoxFD+NKrGwq48Vir4vupeG7UZXttUh3ahC907cLj1CyB6hLle1wC+tWMGTkHcj2if47
         AijOuQKpmN4rUntbC+R6jcYY01Hc9Hk3wRFU1No5rhs3HGGLr/laK5PtWQZvE9KXNPsB
         iTkeUrEBDq1oKFeDY220hNau5kEFK+yZNEfRWOJeyJrPhfFqcdImnmB1YAI/F4L0Nmj1
         1B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787656372; x=1788261172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lymENNeZhP352EEGP9sBVket9fGxGtuJScsbcL5Oefo=;
        b=szAKy5VDas3DJ1V1OG1JRRmpWeWWFTdJsDGXtMxLiWL5pxuNWUQdTiputbAwxSWQOt
         HkDkxB/+C1QoL8EnSWwuj2XttDcWfB/u9M9kve6LjUIugifx1L06vr0mx2ALgjkQeITG
         HMhug+Vm+uxwDXb9C4uPi+rcA7BYec08C+j9Czh0NYhobhMM8HUhVsna12/rTcq8cgLb
         iSZT7Ka8ROJKOfsRt9f83GaaEuA70X+SiJ1Q5sz8BO6+zR9LJY0SPXS7MpGbvAQtKD7H
         z46f/1iQChTKsAunHDfWpSAwxicKIPMwig0MkS57kCKx1Aqki+VeJQhyot5ykR18e/tt
         t6cw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5cfag8mi7A1LqtQuqSCMIXlHEAZjiNMhX0TRx5gXtN9jUK0+bwT+uo7zzLumaMGf3mwODqBUx6dypJg==@vger.kernel.org
X-Gm-Message-State: AFuF++kjALOD1QBCdurAUkJ4niwlw+6FSAqZkmJWovp3q5E2DcurMa+t
	5ZLeIUwwYbgmIiubLSXBT/73pkziCQ5ZDCV7AMBkDw5Wbt7jI20MEduL
X-Gm-Gg: AR+sD136/Gi+nQU0PAkxkNsCCcwlaBeYBr+svwpFUvrJunCi/E10EVGS7/vsPU7QxKv
	wa401i8G2F8SSlo3wqEy6SOC088cQR2m8W2HLHZRkX+njKbvy4C/jEY23Tl8egB7TiGQMbrqybb
	+23mmMlI3A0dbvP0VaOKABhHhev87AfqZTvbvNYtxsTfYMlGEaECtxmW74/55QxxihP4zo9JTyg
	aLKELA+2LFAe7/PwyQdzl+DuFR9wxeCd/vsth+2xG7XjVra+TDkys/Cni7TJB8BUiHvNHIn3ZTY
	v6QpPU3uWrnlPPpzPX7WnreBpTQIQow/w8837xyhKILL1UU+0lNmc+gIx7MUQumLU4JvaD3J8iK
	aXp2LwBZfg5A5yeLZZs9NLtJZjhbv7azhuWaj+6S+GaYI8SMadVSfPcnk5L1l0NzPmac7u4Ic55
	iwnxvmEcid9iLmevayeej6MukQJWAvhGi/9VPjfMGouFp/TzoChJ6iup/J+vJvZ+d1nySOuT4qm
	Pralf9g4GE4JQbn2DJ6kzLv9uxppXmtHJ4di/PUUdbtAdJTkt48SQoEtctAYcjyv9+it9I=
X-Received: by 2002:a05:6512:118a:b0:5b2:9f7a:29aa with SMTP id 2adb3069b0e04-5b4841a9e27mr10019236e87.0.1787656371650;
        Tue, 25 Aug 2026 04:12:51 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce3a89fsm2337244e87.83.2026.08.25.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:12:51 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v8 2/2] ALSA: usb-audio: let the M62's outputs say what they listen to
Date: Tue, 25 Aug 2026 16:12:39 +0500
Message-ID: <20260825111239.24834-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825111239.24834-1-mikhail.v.gavrilov@gmail.com>
References: <20260825085659.52675-1-mikhail.v.gavrilov@gmail.com>
 <20260825111239.24834-1-mikhail.v.gavrilov@gmail.com>
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
index 933a8bbe57b9..7d6ba7257807 100644
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
@@ -387,6 +427,71 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
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
@@ -429,6 +534,57 @@ static int topping_add_ctl(struct topping_mixer *tm, int idx)
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
@@ -473,6 +629,7 @@ static int topping_resume(struct usb_mixer_interface *mixer)
 	 */
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	topping_restore_sel(tm);
 	schedule_delayed_work(&tm->keepalive,
 			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 	memalloc_noio_restore(noio);
@@ -618,6 +775,11 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
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

