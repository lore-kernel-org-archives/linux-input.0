Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2491233929
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787525176; cv=none; b=cfkMz5IDmfLTs4Xmx6agTi4PQOSe7ofnZb1N5JZMdRJ2t5+9AUPJStEgorzwDcutXXs/WaQk/chZAekKsO95nV3bmE0Ifi/qpzgCUP5r2PRu3J6WKElQ1Ua0juI/KMRd9OagVnRW7tMzas5UixgZZ1k0LZYr8EDXQN9ihz7/Vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787525176; c=relaxed/simple;
	bh=A9AlrVzRz/8estM7PwpL2DleKb7S+l7EUzo5el4FCfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mH3v+ZR3M8MZVMC2D3mqdrdg2fhbUrQ1i1NmmGlNlYW7oAm2SGtDkNlpynvjInmwlG3SyPTkfgOGedOORgZiBf8zYDAQjgagfD+6wfRXjG5nv8Zt78sBr9COyW3LfY+nvzkQ3OPbIS53P8fYN/fYZ9LvL8uMm5wo7iHGEQS75X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZD5yAFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZD5yAFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDF71F000E9;
	Sun, 23 Aug 2026 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787525174;
	bh=4buMYYBK3cyt+SZ1kzy5Y8sPaxOqwNBHdrdkM5L2TSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZD5yAFE/ElkqeOVZoZQCE8h79IXYKSyu14w54Z+hxOrWWFJnlV0nXTTKt9I2rcYG
	 G4Ns67xBrx2duFr1zyg+KVTss59ya49k2CbIz6zrSPKKfv72Iv/fZlcNHwBm1UJHsx
	 12pbUviGjIAAFbi3WnFtcKKpsVVSG0JztII4PUks6lSZAroXMTXmPUgPHgNCEMosNa
	 pd5dxasgyGQB3jNm1z4f1zAZaMrMOp1Xu4l6U16RZ5Fz792yIhVRCZ0GZYqUnptTiG
	 7xztC1c4gI2r8WJCwb7Q6WcsstJbBB3gndV10inAK5lT29IzTt3i9ZdWrieksY7n45
	 igqT0A1yGotZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] ALSA: usb-audio: expose the Topping M62's
 analogue gains as mixer controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260823222946.171345-2-mikhail.v.gavrilov@gmail.com>
References: <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
 <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
 <20260823222946.171345-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:46:13 +0000
Message-Id: <20260823224614.3BDF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory reclaim deadlock potential due to GFP_KERNEL usage in sys=
tem suspend/resume path.
- [Low] Bogus URB resubmit error logged during driver unbind due to unhandl=
ed -EPERM.
--

--- Patch [1]: [PATCH v4 1/2] ALSA: usb-audio: expose the Topping M62's ana=
logue gains as mixer controls ---
commit 08a702649defd38485537f408f6392de558fea68
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: expose the Topping M62's analogue gains as mixer controls

This commit adds mixer controls for the Topping M62 audio interface by read=
ing
and writing to its vendor HID channel. It introduces a new file to handle t=
he
specific protocol, managing the device's state via USB interrupt URBs. It c=
laims
the HID interface and handles suspend/resume by resubmitting the URBs and
renewing the subscription.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..2f2365b9b4762
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static int topping_send(struct topping_mixer *tm, u8 target, u8 prop,
> +			s32 value)
> +{
> +	u8 *buf __free(kfree) =3D kzalloc(TOPPING_EP_BUF, GFP_KERNEL);

[Severity: Medium]
Could this trigger a memory reclaim deadlock?

During system resume, the PM core calls the USB driver's resume callback, w=
hich
executes topping_resume(). topping_resume() then invokes topping_send(), wh=
ich
allocates memory with GFP_KERNEL here.

Since this happens in the suspend/resume path, allocating with GFP_KERNEL c=
ould
trigger memory reclaim that waits on block devices that are still suspended.
Should this use GFP_NOIO instead?

[ ... ]
> +static void topping_urb_complete(struct urb *urb)
> +{
[ ... ]
> +resubmit:
> +	err =3D usb_submit_urb(urb, GFP_ATOMIC);
> +	if (err < 0 && err !=3D -ENODEV && err !=3D -ESHUTDOWN)
> +		usb_audio_err(tm->mixer->chip,
> +			      "Topping: cannot resubmit: %d\n", err);
> +}

[Severity: Low]
Does this error path log a bogus error during driver unbind?

If usb_kill_urb() is called concurrently during device unplug, it sets
urb->reject. When this completion handler subsequently attempts to resubmit=
 the
URB, it will fail with -EPERM.

Should this explicit check for -ENODEV and -ESHUTDOWN also include -EPERM to
avoid logging a spurious error message when the device is removed?

[ ... ]
> +static int topping_resume(struct usb_mixer_interface *mixer)
> +{
> +	struct topping_mixer *tm =3D mixer->private_data;
> +	int err;
> +
> +	if (!tm)
> +		return 0;
> +
> +	if (tm->urb) {
> +		err =3D usb_submit_urb(tm->urb, GFP_KERNEL);

[Severity: Medium]
Similar to the allocation in topping_send(), could submitting this URB with
GFP_KERNEL in the resume path also trigger a memory reclaim deadlock?

Should this use GFP_NOIO instead, since it is called synchronously during
system resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823222946.1713=
45-1-mikhail.v.gavrilov@gmail.com?part=3D1
