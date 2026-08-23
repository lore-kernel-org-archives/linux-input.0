Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D43655CE
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495932; cv=none; b=fITJ9zdmBG76d0XK13MI2RbKSJVUuCqe/UNjgQjSO/mWNyqfPP026Wyfx0ra3rmyJRaOvlR79vbhSvDwrp16pWzk4z2bi7fEfosXZcVdzbCOmLg1uAAOKXsJ1826rfSwyQAtfqm9yWNLDX+nlD1em1f29mtBJ+g0cb5lHZ4Owf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495932; c=relaxed/simple;
	bh=/EcH8iyFmW3xoVkvmaLhe4s+I1JnV+LJYFo79545ye4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eTIAAL274naGt866Xy6LTFUSMgmw9I7fASlQWpVOpXpvzTkJPt4We9Vr+ad32UbYV6Pau1cgh0n/n0mV1dh1q1HOrUeDxC8tUSy0j5JseOV8W6d4Mzgk95o0EnX9NwSAX/r0227ZWQKr3gdSSXDLu26Ujjseh69YsN8X/MNmgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDgNTCRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDgNTCRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7EB1F000E9;
	Sun, 23 Aug 2026 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787495931;
	bh=xyA2R2yTlRP2k7VDPgAra5hDzA5fdwztgshdWHslfvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDgNTCRJfB7SDqe6EZG1/0syZ5W8iZsQ/0RfFXhGJEChSgZesZdprHCPn6SutmoyN
	 fgmQtI/m2gh0VzvIolRetvG6ZzQGBYxJJV6d5Lluj3BDLwuTgwxipo/N450FZXQLEo
	 tqInnn71VddgccTFMvWCMIL0uKgmuMbrWfiC8yfLTNsabiHTiY6uUcX8Jhe8D4sTgT
	 TidTzB4OZgUo3ct2g84laoKtcYAu+FChrcQEsaaR8ylrIog+a3kR2kX48HrHoP+Zfm
	 jnRUKjtAtKnifzY7Jfxiyr07loOLhL6KrFg3xVrcERrmDhBIDtPD/PCYjlM+dF3fTK
	 YRzU0izpthupA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] ALSA: usb-audio: expose the Topping M62's
 analogue gains as mixer controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260823142216.79704-2-mikhail.v.gavrilov@gmail.com>
References: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
 <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
 <20260823142216.79704-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 14:38:50 +0000
Message-Id: <20260823143850.BF7EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing PM resumption callbacks permanently disable hardware event=
 notifications after system suspend.
- [Medium] HID interface is never released on error paths or during driver =
unbind, breaking subsequent binds.
- [Medium] Missing serialization in ALSA control put callbacks causes TOCTO=
U and data races.
--

--- Patch [1]: [PATCH v2 1/2] ALSA: usb-audio: expose the Topping M62's ana=
logue gains as mixer controls ---
commit 18f648280996252310709cd8402415d38f18a8be
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: expose the Topping M62's analogue gains as mixer controls

This commit introduces a mixer quirk driver for the Topping M62 audio
interface. It exposes analog gains and output volumes via a vendor protocol
over a HID-class interface by directly communicating with the device endpoi=
nts
and parsing unsolicited state reports.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..3405f28dec66c
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static int topping_ctl_put(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct usb_mixer_interface *mixer =3D elem->head.mixer;
> +	struct topping_mixer *tm =3D mixer->private_data;
> +	const struct topping_ctl_desc *d =3D &tm->ctls[elem->control];
> +	int value, err;
> +
> +	value =3D ucontrol->value.integer.value[0];
> +	if (value < d->min || value > d->max)
> +		return -EINVAL;
> +
> +	scoped_guard(spinlock_irqsave, &tm->lock)
> +		if (tm->val[elem->control] =3D=3D value)
> +			return 0;
> +
> +	err =3D topping_send(tm, d->target, d->prop, value);

[Severity: Medium]
Does dropping the lock across hardware transmission introduce a race condit=
ion?

The spinlock is used to check the value but is released before calling
topping_send(). If two threads simultaneously write different values to the
same control, the order of hardware execution might differ from the order of
the software state updates at the end of the function, causing get operatio=
ns
to report incorrect values.

[ ... ]
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
> +
> +	d =3D &topping_m62_enums[elem->control];
> +	err =3D topping_send(tm, d->target, d->prop,
> +			   topping_source_value[item]);
> +	if (err < 0)
> +		return err;
> +
> +	tm->sel[elem->control] =3D item;

[Severity: Medium]
Is it possible for concurrent writes to corrupt the cached state here?

This function lacks locking when reading and updating tm->sel[elem->control=
],
which could allow concurrent threads to write different values, leading to a
race where the software state drifts from the hardware state.

> +	return 1;
> +}
[ ... ]
> +static void topping_private_free(struct usb_mixer_interface *mixer)
> +{
> +	struct topping_mixer *tm =3D mixer->private_data;
> +
> +	if (!tm)
> +		return;
> +	cancel_delayed_work_sync(&tm->keepalive);
> +	if (tm->urb) {
> +		usb_kill_urb(tm->urb);
> +		usb_free_coherent(mixer->chip->dev, TOPPING_EP_BUF,
> +				  tm->inbuf, tm->inbuf_dma);
> +		usb_free_urb(tm->urb);
> +	}
> +	kfree(tm->val);
> +	kfree(tm->kctl);
> +	kfree(tm);
> +	mixer->private_data =3D NULL;

[Severity: Medium]
Does this code leak the claimed USB interface?

snd_usb_claim_iface() was called during initialization, but
usb_driver_release_interface() is not called here. If the driver is unbound
and rebound via sysfs, the subsequent probe will fail at the
usb_interface_claimed() check and skip creating the controls.

> +}
[ ... ]
> +int snd_topping_init(struct usb_mixer_interface *mixer)
> +{
> +	struct snd_usb_audio *chip =3D mixer->chip;
> +	struct usb_interface *iface;
> +	struct topping_mixer *tm;
> +	int ep_in =3D 0, ep_out =3D 0, interval =3D 5;
> +	int i, err;
[ ... ]
> +	err =3D snd_usb_claim_iface(chip, iface);
> +	if (err < 0)
> +		goto fail;
[ ... ]
> +	mixer->private_data =3D tm;
> +	mixer->private_free =3D topping_private_free;

[Severity: High]
Does this setup permanently lose hardware notifications after system suspen=
d?

The URB completion handler (topping_urb_complete) stops on suspend errors, =
but
there is no mixer->private_resume assigned here to restart the URB on resum=
e.
Without it, the driver won't receive unsolicited hardware state changes aft=
er a
suspend/resume cycle.

[ ... ]
> +fail:
> +	if (tm->inbuf)
> +		usb_free_coherent(chip->dev, TOPPING_EP_BUF, tm->inbuf,
> +				  tm->inbuf_dma);
> +	usb_free_urb(tm->urb);
> +	kfree(tm->val);
> +	kfree(tm->kctl);
> +	kfree(tm);
> +	return err;

[Severity: Medium]
If a memory allocation fails after claiming the interface, does this error =
path
leave the interface permanently claimed?

It appears we jump to fail without calling usb_driver_release_interface() to
undo the snd_usb_claim_iface() call made earlier.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823142216.7970=
4-1-mikhail.v.gavrilov@gmail.com?part=3D1
