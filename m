Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0639734D
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612291; cv=none; b=nnsbUv1FW8L9A7qbNjcwdT+FUWNZDWDd/zwuFz0jJxhNvZrhg7BEbw4woea6IX4ZcV+ymt/WmntJ+NDBMkCy4uiLeLdhJi3ONkDutQZEaTheuGxDd/Ayt+cISGF6r3s3BO8Ds6w902Ilej5y4rk6yK5aLYLhQB2ATPqt7ZOHbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612291; c=relaxed/simple;
	bh=bs3pYlCIWGpZk1p2QQd3F82B17/E9sPgL9uKESB/jgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImkfzYqPk/4C//L7kybFO+/JmUzuhkuPwZcu3OX3hSqZlUwyg74PkmZjnmySIPIEiK5dDJ0Uv3H9/l2wcnVsXQNJRW+iw/BOisw0J7o/6LR9Td/zxNI5NfCpzrEjsV+oP8wCxPazq77Y5V2HDeF3B5X4ALjw7WnrQ2agoI2FNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxIffBYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxIffBYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666331F000E9;
	Mon, 24 Aug 2026 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787612289;
	bh=8GAPrfJZWpvHXQ2bcL0IxtG71uwsn8Fb9fgLOM+XuhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxIffBYJ5rvEoSyvndaDxBLd0whT4Q/wkRVMBLyr2raZ2NjVDqMlqAGSx5sC4wHUs
	 8hejIq+SYRynv8/loLh0KJDMJwVVdDFUOkbcBpBAoTEUTTg/Yas9UuXttb18UgXj1f
	 oOZUZeEKO6AQ960DGLTm5m4/v5raTmVutGUVdc2JzaFkQW7FSYqBn2Yk+ca14GPvmV
	 S6VL6n8wWAtJ/HTU/zTFwts7NhWXCvNveZu+zZfZWQA4y9W0M/YkUVkMfzumu7UF+E
	 iSga/vU4ajbmHcwhizSfwSMuX/Tuo/bsaVKTHyW2I5iF49Xk5JtLETqqrTb1cZ3XOh
	 WnIoJm25UrRVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] ALSA: usb-audio: let the M62's outputs say what
 they listen to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824223107.406504-3-mikhail.v.gavrilov@gmail.com>
References: <20260824201331.304705-1-mikhail.v.gavrilov@gmail.com>
 <20260824223107.406504-1-mikhail.v.gavrilov@gmail.com>
 <20260824223107.406504-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:58:09 +0000
Message-Id: <20260824225809.666331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Missing snd_usb_lock protection in topping_sel_get() causes a =
Use-After-Free racing with device disconnect.

Pre-existing issues:
- [High] PM deadlock between `cancel_delayed_work_sync()` during suspend an=
d `pm_runtime_get_sync()` in the keepalive worker.
--

--- Patch [2]: [PATCH v6 2/2] ALSA: usb-audio: let the M62's outputs say wh=
at they listen to ---
commit d2da2c1cdae232f4506c200d692b9c0076c8746f
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

    ALSA: usb-audio: let the M62's outputs say what they listen to

This commit adds enumeration controls for the source selectors on the Toppi=
ng
M62 audio card. It handles reading and writing the source selections, inclu=
ding
restoring them upon resume, as the device doesn't report them itself.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> --- a/sound/usb/mixer_topping.c
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> @@ -365,6 +405,71 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
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
> +	guard(mutex)(&tm->write_lock);

[Severity: Critical]
Can this code trigger a use-after-free if the USB device is disconnected
concurrently?

If a user invokes the SNDRV_CTL_IOCTL_ELEM_READ ioctl while the device is
physically disconnected, this function accesses tm without holding the ALSA
USB PM lock via CLASS(snd_usb_lock, pm).=20

Without the PM lock incrementing the chip->usage_count reference, the USB
disconnect handler (usb_audio_disconnect) doesn't wait for this read operat=
ion
to finish. It proceeds to usb_audio_disconnect_components() and calls
snd_usb_mixer_disconnect(), which frees tm via topping_private_free().

This could lead to:

topping_sel_get()
  struct topping_mixer *tm =3D elem->head.mixer->private_data;
  // -> device disconnected here, tm is freed
  guard(mutex)(&tm->write_lock); // use-after-free

Does this function need to acquire the PM lock before accessing tm?

> +	ucontrol->value.enumerated.item[0] =3D tm->sel[elem->control];
> +	return 0;
> +}
> +
> +static int topping_sel_put(struct snd_kcontrol *kctl,
[ ... ]
> @@ -407,6 +512,57 @@ static int topping_add_ctl(struct topping_mixer *tm,=
 int idx)
>  	return 0;
>  }
> =20
[ ... ]
> +static void topping_restore_sel(struct topping_mixer *tm)
> +{
> +	const struct topping_enum_desc *d;
> +	int i;
> +
> +	guard(mutex)(&tm->write_lock);
> +	for (i =3D 0; i < TOPPING_NUM_ENUMS; i++) {
> +		if (!tm->sel[i])
> +			continue;	/* nothing was ever chosen */
> +		d =3D &topping_m62_enums[i];
> +		topping_send(tm, d->target, d->prop,
> +			     topping_source_value[tm->sel[i]]);
> +	}
> +}
> +
>  static void topping_suspend(struct usb_mixer_interface *mixer)
>  {
>  	struct topping_mixer *tm =3D mixer->private_data;
> =20
>  	if (!tm)
>  		return;
>  	cancel_delayed_work_sync(&tm->keepalive);

[Severity: High]
This is a pre-existing issue, but is it possible for a circular locking
dependency to cause a system or USB device hang during runtime suspend?

The topping_keepalive delayed work runs every 2 seconds. If the USB subsyst=
em
initiates a runtime suspend on the device exactly when the worker starts
executing, usb_audio_suspend() is invoked, setting the device's PM state to
RPM_SUSPENDING.=20

This suspend callback eventually calls topping_suspend(), which blocks on:

cancel_delayed_work_sync(&tm->keepalive);

However, the executing worker calls topping_send(), which attempts to acqui=
re
the ALSA USB PM lock:

topping_send()
  CLASS(snd_usb_lock, pm)(tm->mixer->chip);

This internally calls snd_usb_autoresume() -> usb_autopm_get_interface(),
wrapping pm_runtime_resume_and_get(). Because the device state is
RPM_SUSPENDING, the PM core waits on a waitqueue for the suspend operation =
to
complete.=20

This results in a classic deadlock: the suspend thread waits for the worker,
and the worker waits for the suspend thread.

>  	if (tm->urb)
>  		usb_kill_urb(tm->urb);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824223107.4065=
04-1-mikhail.v.gavrilov@gmail.com?part=3D2
