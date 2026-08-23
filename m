Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA361DE8AE
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515622; cv=none; b=DCcyoODbQOOHmnzQhlCnrZhUUs62g4D6E9wiSTcPKhmnf4FqhmQpxY8qyKAdo3DKIuO4mh+KlTG9I048GZmJeXVgID+1DSYZXSE72FfL90NeIec2Xgore6IzZSsTQK5UaoqV1IuDr08/LF1kTbNZfqys4wlD2HMtHIMvw4Zu3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515622; c=relaxed/simple;
	bh=4ZRR3NfYtcRLwg5nRttiqAkCQsmyLRKPabaTXnyx9mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bAjCrzyopV9zL9bfUre11QIHOZ4rtk3HEEyBTmEmoknoYIE0cPAwlRKCbDBDh4g4MdYLy3TsQAXG7pBndM5gMXhtZUEgrEzbZ2XvM4RrLIfqN4ADI2KedKui8eRoiZGFIVmO8tXYkv7SZq2MUx0bo5GLoqEGxLoj4BMNNnunSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM585mND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM585mND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE3A1F000E9;
	Sun, 23 Aug 2026 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787515621;
	bh=81ky6KDgaaRdSguTDJXkpAON+hK+hfEzcVG5FSfaulE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OM585mND9O0PbyGFAvUuIIvlXHkoabzyzUW3od9PAi72bgyfoTTlWcidpZ8b1wges
	 bwRhSirzoSeAC6HxUpnDwJZGgXpJA8kcqMwGgeYlIPW8/WB4E+mtnT1ySkiG20IKd+
	 ckE5Amg9M5+nHX2tY9+CE1Sh8IOx219571FlK+yjlEfOlKj16ek7kvui2hGGvywXCf
	 p6whNJHgZQ2Z0d5hvbw/QgXrP2CDE9jpyQQckR2CxPPuLrMJHQZ1Arlg3kyfFK5dKG
	 7C5osmBocY5VaDftRo1BCbPL26aZf+ttubFIYzVK9XcqWqtbTwl+fEasgWOtdTdYqL
	 HcjeU9qm5Uh8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] ALSA: usb-audio: expose the Topping M62's
 analogue gains as mixer controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260823194822.29430-2-mikhail.v.gavrilov@gmail.com>
References: <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
 <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
 <20260823194822.29430-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 20:07:00 +0000
Message-Id: <20260823200701.1BE3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent ALSA control accesses during USB disconnect will use a =
freed `tm` pointer.
--

--- Patch [1]: [PATCH v3 1/2] ALSA: usb-audio: expose the Topping M62's ana=
logue gains as mixer controls ---
commit 1545a0b11450003ef36637ff184fd64c5e1bbfdd
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: expose the Topping M62's analogue gains as mixer controls

This commit adds a mixer driver for the Topping M62 to expose its analog
input gains and output volumes. The device uses a vendor protocol on a
HID-class interface, requiring the driver to claim the HID interface and
use interrupt endpoints for communication.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..2f2365b9b4762
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static int topping_ctl_get(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct topping_mixer *tm =3D elem->head.mixer->private_data;
> +
> +	guard(spinlock_irqsave)(&tm->lock);

[Severity: High]
Can this dereference a freed tm pointer if called concurrently with
a USB disconnect?

When the USB device is unplugged, topping_private_free() frees tm
and sets mixer->private_data to NULL. However, ALSA controls are not
removed until snd_card_free(). If a userspace application accesses
the control via ioctl (e.g., SNDRV_CTL_IOCTL_ELEM_READ) during
disconnect, tm might already be freed.

> +	ucontrol->value.integer.value[0] =3D tm->val[elem->control];
> +	return 0;
> +}
> +
> +static int topping_ctl_put(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct usb_mixer_interface *mixer =3D elem->head.mixer;
> +	struct topping_mixer *tm =3D mixer->private_data;
> +	const struct topping_ctl_desc *d =3D &tm->ctls[elem->control];

[Severity: High]
Similarly, can this race with topping_private_free() and use a freed tm?

Although topping_send() later takes the snd_usb_lock_shutdown lock to
protect against disconnects, that happens after tm has already been
dereferenced here.

> +	int value, err;
[ ... ]
> +static void topping_private_free(struct usb_mixer_interface *mixer)
> +{
> +	struct topping_mixer *tm =3D mixer->private_data;
[ ... ]
> +	if (tm->claimed)
> +		snd_usb_release_iface(tm->iface);
> +	kfree(tm->val);
> +	kfree(tm->kctl);
> +	kfree(tm);
> +	mixer->private_data =3D NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823194822.2943=
0-1-mikhail.v.gavrilov@gmail.com?part=3D1
