Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B831F99E
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515436; cv=none; b=ei+JLgBwcNDX4AMq38YN8IYDqdDyoyzrbveH78hZJJrKW5DTqclysfA1uAJDjuLgcAagx6Ln7HWUaqwKtZS4ejqgr/62XWX+n5FYYMxEI4b6PuKk6esqp4yJpDjswEJT8nvqtx/p1nuV/hxjP9CIKw+Y6jgEDaqoABTyLnEO4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515436; c=relaxed/simple;
	bh=jSf5Gx6L904gqKFrsxWTWEwX6xYv2ylgNuKv8TuVXPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ueKZ0b3Sa2+8LA6tRjnPD7/r0WeT7ioheJUgR2iHPWXUyDQad9titztv+c3HioU5He4DHZkWri/Av5fiPiS+ODL6jmwkaBUPlkjlXikR8O4RgW+Am4KyHymLGz7j3iVArmCQOM6a1T89tym60+sqVE4J5Czyb/cgC6KHsRa4Hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLBjl+87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLBjl+87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9C1F000E9;
	Sun, 23 Aug 2026 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787515434;
	bh=TtKjndcOmv35MXpaYLkyjjSDMc94fVfb6E6pqMabqzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLBjl+877mT3uqQjNJ84YMyD/Oqpat8T0hCQhC8zth8AM69PAtuAxvdPCwycf0RcR
	 VgMwdY2H0ldIfgUiqXbNdkExUMFHSWfQ8QqkXmsWJP0HXBxeMyOWO6G8TkuiQPn/nK
	 NNuNyB77/yQz0ZalLp+tK31ypTlA0TZZNu5mbCnDpHOoSHLSdZOBFH+OwLFKvhL2LC
	 gDsu9kCaf6hSuiUxZWQ4v+MlRD4fZvgeNsCwUi0gkWef8AnDtq5idd7PdUkEhAdqmk
	 +g0MghlHPJZCJvTlb5d14MCcYGgIUWB3CgtAOaNyQLcIwR8YEbblweLm5R3yoZceW9
	 ViZ1Ewwtmv6Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] ALSA: usb-audio: let the M62's outputs say what
 they listen to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260823194822.29430-3-mikhail.v.gavrilov@gmail.com>
References: <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
 <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
 <20260823194822.29430-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 20:03:53 +0000
Message-Id: <20260823200354.71A9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware selector state desynchronization on device resume prevent=
ing state restoration.
--

--- Patch [2]: [PATCH v3 2/2] ALSA: usb-audio: let the M62's outputs say wh=
at they listen to ---
commit be8957abcd6e5ddab4c6d827af25bced12462261
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: let the M62's outputs say what they listen to

This adds source selector controls for the M62 sound card to handle
its output routing. It uses an "Unknown" default item since the card
never reports the active selector.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> index 2f2365b9b4762..8bf5fe483ccf1 100644
> --- a/sound/usb/mixer_topping.c
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> @@ -374,6 +374,60 @@ static int topping_sel_put(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct topping_mixer *tm =3D elem->head.mixer->private_data;
> +	const struct topping_enum_desc *d;
> +	unsigned int item;
> +	int err;
> +
> +	item =3D ucontrol->value.enumerated.item[0];
> +	if (item >=3D ARRAY_SIZE(topping_sources))
> +		return -EINVAL;
> +
> +	guard(mutex)(&tm->write_lock);
> +
> +	/*
> +	 * "Unknown" is what this control reports until a hand has chosen,
> +	 * and alsactl stores and restores it like any other value.  It is
> +	 * not a choice, so writing it changes nothing -- quietly, rather
> +	 * than failing a restore of the driver's own report.
> +	 */
> +	if (!item || tm->sel[elem->control] =3D=3D item)
> +		return 0;

[Severity: High]
If the system suspends and loses USB power, the hardware resets its selector
to the default.

Because topping_add_sel() sets elem->val_type =3D USB_MIXER_BESPOKEN, the A=
LSA
core's restore_mixer_value() skips restoring this control on resume.

Since topping_resume() doesn't manually push tm->sel back to the hardware,
tm->sel retains the pre-suspend value while the hardware has reset.

If the user then tries to re-apply their previous setting, won't this check
evaluate to true and silently block the write, permanently desynchronizing
the hardware and driver state until a different setting is applied first?

[ ... ]
> +static int topping_add_sel(struct topping_mixer *tm, int idx)
> +{
> +	struct usb_mixer_elem_info *elem;
> +	struct snd_kcontrol *kctl;
> +
> +	elem =3D kzalloc_obj(*elem);
> +	if (!elem)
> +		return -ENOMEM;
> +
> +	elem->head.mixer =3D tm->mixer;
> +	elem->head.id =3D 0;
> +	elem->control =3D idx;
> +	elem->channels =3D 1;
> +	elem->val_type =3D USB_MIXER_BESPOKEN;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823194822.2943=
0-1-mikhail.v.gavrilov@gmail.com?part=3D2
