Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8C369D4F
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495926; cv=none; b=YXG1ssMG68AaBzbsfFHFZiGVewr+ll41gCKFoQrIVlS7C8Ksi5je8FEU7DABmJ3/0NybM3NAsqb3UHlxIYYsB9HviRe4+rUY5asZe7vjyy1dP3aLXJbIlMaIU5PVDUCX4ZpsLu6AOnLNh5g0PP/7RTAqpFQv7fQ5nzKt/2lEJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495926; c=relaxed/simple;
	bh=VOQgZWBzvbFVErVvxmwsb4mMU1Q5mRHnnktVIOEZ1cQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LYW0LJ48HjEikXxl4WPSMeGgSYeQq47O3x9Jl4C4zQd4yBEYsoEudbeBqbNiHgR7aGy7B0E30IbEyDTyjC4V2I5fQH9MlIBa3THplWpeI6zSLac2fP1KdAxdDab24RxCydZ10HkXtvRdKu6eI+JuAPa09BdjzXkw7QY2dPR61yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejOzdiQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejOzdiQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1617D1F000E9;
	Sun, 23 Aug 2026 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787495925;
	bh=Rk5C09IQWt9u7E9npct2BQsr829I2wG6epWWhEfLe+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ejOzdiQkbzsdcMDmrxjQljXwElbSMLbbxLOX7rQdrRS/gs9RrWNgszJuUKw3wmCTl
	 D2IXrcpBVeucW7Bji8Ep58BSsWSQEG4KS9PlV0sNDRAIzXV3C2fzCfEQfz/4QbLlYw
	 zG29mbVtyKM/vRFUOMAsDxlJzXasCfiRmseINAfEXuOpsOhTEj8mkFsOQV3yMS6XdL
	 El8HUHS0i9Z3R1ggzrhyXl4sksCe5pY0KmAJPz0OdT55D6hxwoUtnfjdbzvU5V6y2H
	 hV9zQhSh8i7U8KthYGv4zQ6QLOfJ+2d/5O9TMFdimHZIQntT3M7lzRM8BWDroM6uco
	 72tTzkGLt1Fsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: usb-audio: let the M62's outputs say what
 they listen to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260823142216.79704-3-mikhail.v.gavrilov@gmail.com>
References: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
 <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
 <20260823142216.79704-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 14:38:44 +0000
Message-Id: <20260823143845.1617D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The ALSA control callbacks lack synchronization with device unplug=
, leading to a Use-After-Free or NULL pointer dereference.
- [Medium] Restoring the default 'Unknown' state via alsactl will fail with=
 -EINVAL, potentially causing the alsa-restore service to fail on boot.
--

--- Patch [2]: [PATCH v2 2/2] ALSA: usb-audio: let the M62's outputs say wh=
at they listen to ---
commit 897c9f5bff5f6d9c9756bc3709ad74756868ab0e
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: let the M62's outputs say what they listen to

This patch adds an enumerated control to select the playback source for the
Topping M62's outputs. Because the device doesn't report its selector state
on probe, the initial state is reported as "Unknown".

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> index 3405f28dec66c..029f54865e220 100644
> --- a/sound/usb/mixer_topping.c
> +++ b/sound/usb/mixer_topping.c

[ ... ]

> @@ -312,6 +352,58 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
>  	return 1;
>  }
> =20
> +static int topping_sel_info(struct snd_kcontrol *kctl,
> +			    struct snd_ctl_elem_info *uinfo)
> +{
> +	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(topping_sources),
> +				 topping_sources);
> +}
> +
> +static int topping_sel_get(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct topping_mixer *tm =3D elem->head.mixer->private_data;
> +
> +	ucontrol->value.enumerated.item[0] =3D tm->sel[elem->control];

[Severity: High]
Does this code race with device unplug, leading to a UAF or NULL pointer
dereference?

If the USB device is disconnected, snd_usb_audio_disconnect() calls
snd_usb_mixer_disconnect(), which invokes topping_private_free().
topping_private_free() frees tm and sets mixer->private_data =3D NULL.

If a concurrently running ALSA control ioctl invokes topping_sel_get() or
topping_sel_put(), they do not call snd_usb_lock_shutdown() to
synchronize with the disconnect teardown, nor do they verify tm is not NULL.

Could this lead to a blind dereference of tm and cause a crash?

> +	return 0;
> +}
> +
> +static int topping_sel_put(struct snd_kcontrol *kctl,
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
> +	if (!item)
> +		return -EINVAL;	/* "Unknown" is a report, not a choice */
> +	if (tm->sel[elem->control] =3D=3D item)
> +		return 0;

[Severity: Medium]
Will restoring the default 'Unknown' state via alsactl fail with -EINVAL?

On probe, tm->sel defaults to 0 ('Unknown'). When alsactl store saves 0, and
alsactl restore subsequently calls this put callback with 0 on boot, the
check for !item returns -EINVAL before the code checks if the value is
unchanged (tm->sel[elem->control] =3D=3D item).

Could this cause the alsa-restore systemd service to fail on boot and produ=
ce
spurious error logs, instead of just returning 0 for an unchanged value?

> +
> +	d =3D &topping_m62_enums[elem->control];
> +	err =3D topping_send(tm, d->target, d->prop,
> +			   topping_source_value[item]);
> +	if (err < 0)
> +		return err;
> +
> +	tm->sel[elem->control] =3D item;
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823142216.7970=
4-1-mikhail.v.gavrilov@gmail.com?part=3D2
