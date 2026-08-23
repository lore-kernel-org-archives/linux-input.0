Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135A3B2FDB
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787524201; cv=none; b=qTMkYnUUOpHr+N3Eg5yxpYAs71AMfPNPMEdOU48NalhnFMRJMAvuj6RYerZRGR5LiUlxK37U99wcl5uf43eLK8xabdvooeVQT+1LuAsEU/j24tcJoQYfKO9x+1sQnt4CgZkmqdszzdfCjmqBoleNQ0ROpyVkv6hInhmGBth0SK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787524201; c=relaxed/simple;
	bh=sumoM0+ivo2kOK7jMQH5DwQDJ8MSahEHghXRJq48fvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgosULb0o2/8SkVFvn/70omNBllQvGAj9n+2qxCEGi3YlLd9cSeci2d3AvGR3eU6eFZSbd+667qsDoIBfYDj8veNFFM/qWA9Ac8KQH1/PllxDPT0Qh0mazcMm5mxX/ytOpkRO1AByxM0fe6eZspPr7pr7k6QY6Q6Yn5F5jw6IrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pq+waaZq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq+waaZq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so4174966e87.0
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787524198; x=1788128998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx9lkJhxiwlf7YhfgwOSPj0Jmhvx8W0GRSOYarSnFPw=;
        b=pq+waaZqfPuzJYIDgGtkrIEaDdkljdTTjKt7xnKzhaLG5TgIYo+Utdo5nynoNLA2Fg
         PgO5HR5SfW6TBn3mKdCzFDX0mLWiVnSEEyXfKrPpCtNTFFUG4SFHlq7j71QEgIfDMZ+5
         SEgWMnNGJMtwiMlCGipBAJz2azutdWmANN0GLncnFChTA7eu2CI5vWWgrEzDy2Qlt2sX
         uy71czG+xOf8aNCRtkDniWgMLJl3vGmjBQuZjUa/CLtGLqsF6oq+RVWfXRDNo4sX3B8z
         zB15HN7MxyxQgPvaKAErm1obFcHmNrJGbbffMZOht/RE6B2r1slAjV75g/SxWT/e7gAR
         OeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787524198; x=1788128998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cx9lkJhxiwlf7YhfgwOSPj0Jmhvx8W0GRSOYarSnFPw=;
        b=PmUmHxvFQzhIvoMh2NzuEVgGqYQz3F1mKp47o/hWdxYrA79XqoCIWmU6LWtcob3UFj
         +c+KeMLNvNGJHEdzDWLcSCYl0zPUV+gOOsO509FKiolTD6YmtSp1AvqqFK+VSMMddZTD
         DRygxIiGl/Ll6J6NmvtggSN14S6eARryqhxPzxLC25NZIEqWC3C7sjB0afzvDIvJKNMc
         GAU3W2u8sfsxMHbkMGqshBjNEZFHawyl+5oTcj/meryfVPFG072QSH4ljyhrWe1Ma73i
         sWmF8nTmHnvhnJstGgkQmAVBIF4BpKi1eRrZUNvBxTGsL3J5Kwi1JQxe/gQP36b74v25
         9W0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rph0MDtJlu3xmTSk9QUtM/RAJm+xzd9gjhbWsSoy+MeD6loOr2DVjI7Czfn5j2Kb8w5e7gmcLLSYDjaag==@vger.kernel.org
X-Gm-Message-State: AFuF++nietKbpuEEQIYTUDnABGa+KTb4kxb2Qib0npaPu5gR8JpyDq5z
	l1dRCnkzxkWmPMWM9PO/xEfToNaAyOR5S8iAhxsgiPnKSricWwWO7BlE
X-Gm-Gg: AR+sD10cepqtds+4vwx3m0HyYtBt1xFb46vpw/VRe21W4OW44dfu5FsnCA40+UT4wZt
	t9nrqRtMPVq+p8ZxFAnmD4UEQR/ohKTnWXdrhkQFhjPdJoyaUSYlUfHUZbfll1I4jyZYE7UgWRb
	78RYzvJ+b/8I+PpN6PDlHg+ueUwJRGNZ2JVCjIlBpdLVLG1D/47bE3TO7n1hfiw6n/BsXIMUsUq
	Z/Pj1LdRkom/Hd3vraGsXhW/GTqIx1/s+OTAA9A4oVmFsZg331JHoLTf+lKoMQq4p0gOAi4xyQ3
	tI3cpscI8kkzKwda8RRadOhuEixaFjhu+bn//wLsA4XnipaBEaZLsG0/7zJMl521UDQADRNI81j
	Tlt9CcPblGzLuYoA/sC3l8rONt45HOQA43zP5D/k5r1EK4UMbWz87BlmtSgqcme3KeWyiLJtBap
	g8j90WXl+N6Ecg0ww8ISsg5+nAYT/FPh6Bz4Z6KJVet1NGSd7pnZjrKdja4Iv5drBHur7giiI/G
	KDqD387n6XSV75rjtJcKjLguDeB+G8SHRBWuPslwO71z2XKlFQOVuelu/XMmQPkaYlVe6Q=
X-Received: by 2002:a05:6512:2306:b0:5aa:671d:9960 with SMTP id 2adb3069b0e04-5b4841f3a8fmr5319162e87.6.1787524197468;
        Sun, 23 Aug 2026 15:29:57 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2bccsm1227499e87.28.2026.08.23.15.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 15:29:56 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4 2/2] ALSA: usb-audio: let the M62's outputs say what they listen to
Date: Mon, 24 Aug 2026 03:29:46 +0500
Message-ID: <20260823222946.171345-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
References: <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
 <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
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

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 sound/usb/mixer_topping.c | 157 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
index 2f2365b9b476..e71ea70ec4b0 100644
--- a/sound/usb/mixer_topping.c
+++ b/sound/usb/mixer_topping.c
@@ -126,6 +126,45 @@ static const struct topping_ctl_desc topping_m62_ctls[] = {
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
@@ -142,6 +181,7 @@ struct topping_mixer {
 	spinlock_t lock;	/* guards val[] against the URB */
 	int *val;
 	struct snd_kcontrol **kctl;
+	int sel[TOPPING_NUM_ENUMS];	/* what a hand chose, or 0 */
 };
 
 static void topping_build(u8 *f, u8 target, u8 prop, s32 value)
@@ -332,6 +372,66 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
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
@@ -374,6 +474,57 @@ static int topping_add_ctl(struct topping_mixer *tm, int idx)
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
@@ -407,6 +558,7 @@ static int topping_resume(struct usb_mixer_interface *mixer)
 	 */
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
 	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
+	topping_restore_sel(tm);
 	schedule_delayed_work(&tm->keepalive,
 			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
 	return 0;
@@ -543,6 +695,11 @@ int snd_topping_init(struct usb_mixer_interface *mixer)
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

