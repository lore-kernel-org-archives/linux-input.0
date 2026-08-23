Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2601233929
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787525211; cv=none; b=jeorETE0fSLD1SA1baCy2sVtqIIkbwpIH1kmQUAHHjwsQlawqIThSSY4gsZuc4sV0qkmsMllIW3kQzvA98iizQAn2f8lsSCy9jZg1Rv247M5LaQJ8TVXmynmUPOGF2n/D5u13yqzZv5VfCovY5mirG5Nu74S/5pjnqVBcYXu3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787525211; c=relaxed/simple;
	bh=eMTLlWTs5A03qjNNtu9VuZ7o2wzsZt57YwN1nboAIPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CrFYfsfe1NOPkWF79DLKpXnbAHNppoRVwQqrRR0z786wyf5X+oGaGxhfn+GVDYV8y4cWQtLNpKsi2+tU45lHfEj75IB2uWCYrigGzAPUfYvyzQ0R8HLHbQ3CyAHxvAEl8kRgBev36mMiD6Hrsh4GjCxTwkfu9vnn7Pvs4B79biM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtO7+pNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtO7+pNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45331F000E9;
	Sun, 23 Aug 2026 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787525210;
	bh=M9ZS0LJAJtNnkTQqn8cZKAlLPdMlTcnGAJaSec13mTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WtO7+pNzMXgI6Id4Ln3zq6j1nZFR8/ZJt4DYFnaCBs7NKLCuK7Qtblla760kDANQs
	 9YF0LxFKpksa6giT9hKXx1lIYIjFC0XYq0SzB8RmB++MNX5nJgcVNXl/QsgfNBydog
	 Ppl7cn0UJ1GTVFw78cBp8tQsY+c76GggCnbqymC49PKJFrODMc8bFmkZC7+uH/dip8
	 PeRhNitlhlSaYU4QSAeRN/PUuGCBki3wXMufI1toGlp01TN1rd1UnrYgTr6jpXt4Dn
	 7NiRopwe1zUCI1zLeJlqqQvScUEhol+Q171r+nR0108uxncvSebHpmNFNcapGck44N
	 iHAbMfJ3/fwZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] ALSA: usb-audio: let the M62's outputs say what
 they listen to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260823222946.171345-3-mikhail.v.gavrilov@gmail.com>
References: <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
 <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
 <20260823222946.171345-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:46:49 +0000
Message-Id: <20260823224649.E45331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent ALSA control access during USB disconnect causes a Use-=
After-Free or NULL pointer dereference in the get/put handlers.
--

--- Patch [2]: [PATCH v4 2/2] ALSA: usb-audio: let the M62's outputs say wh=
at they listen to ---
commit 4881f3c183895a107d4e643799ad16e76377b10a
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: let the M62's outputs say what they listen to

This commit adds enumerated controls for the Topping M62 mixer outputs to
select their playback source. It handles the specific hardware behaviour
where the current selection cannot be queried from the device.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> index 2f2365b9b4762..e71ea70ec4b00 100644
> --- a/sound/usb/mixer_topping.c
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> @@ -332,6 +372,66 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
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

[Severity: High]
This is a pre-existing issue, but does this dereference of tm risk a
use-after-free or NULL pointer dereference if the USB device is disconnected
concurrently?

If an ALSA control ioctl is executing while the USB device is disconnected,
the disconnect sequence calls usb_audio_disconnect_components() which calls
snd_usb_mixer_disconnect(). This triggers topping_private_free() which
frees the tm struct and sets mixer->private_data to NULL.

If the control callback executes without first calling
snd_usb_lock_shutdown() to check for device disconnection, it can extract
and dereference tm (e.g., locking tm->write_lock here) either after it has
been freed or while it is NULL.

> +	ucontrol->value.enumerated.item[0] =3D tm->sel[elem->control];
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
> +
> +	guard(mutex)(&tm->write_lock);

[Severity: High]
This is a pre-existing issue, but could this also trigger a use-after-free
or NULL pointer dereference for the same reasons as in topping_sel_get()?

As this issue is also present in the pre-existing topping_ctl_put() and
topping_ctl_get(), perhaps snd_usb_lock_shutdown() needs to be used to
safeguard these control callbacks against concurrent USB teardown.

> +
> +	/*
> +	 * "Unknown" is what this control reports until a hand has chosen,
> +	 * and alsactl stores and restores it like any other value.  It is
> +	 * not a choice, so writing it changes nothing -- quietly, rather
> +	 * than failing a restore of the driver's own report.
> +	 */
> +	if (!item || tm->sel[elem->control] =3D=3D item)
> +		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823222946.1713=
45-1-mikhail.v.gavrilov@gmail.com?part=3D2
