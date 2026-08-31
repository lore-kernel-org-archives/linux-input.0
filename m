Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAA3CC7EA
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164901; cv=none; b=dU1hesFl2ZItoGipXa03W/6xFyJEbji42M1E2YIVvHNLeKIDRJQQHvB+cc851dg24SBrKsqMd7K7a+S7PxXRcym26SboCrnfigfWZ2K4JNh+H9BSSETmRPn5ql9rYokTlXp5VZEWIUv+8x6Y2sNLte2hY+nX/Lqpm8ueV4uy0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164901; c=relaxed/simple;
	bh=rk/RtQGUqa4je87E0MF9GWbu0/T3ERV1oTSRlN0aUu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jGi9zGenkoLgpgPaioVld15AzI94EO5PPbECjGeblNGGH1H79tZZkmAgFQWfmBH3qvEFtKGT/2tJZ2DsmFMHBm10f3TPbUpPvW6jWxzmUcd3lMI9SdlZoOn2wNjtKbtsuy7tJNR8EjtLmV2fxdVTh10GS1Io7KLA6cnlaqFVCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ/LHiaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ/LHiaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063D81F00A3D;
	Mon, 31 Aug 2026 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164900;
	bh=jcG3orvgsawqnp04zywibxntSjzGuC7VlJBwY0J8HzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJ/LHiaVHX0R7vMtBHBArhbATQf+akx2D17D6o75llW60CT8dZZNCu9x+B4LEOo4R
	 50qlHcK2TBqfCVxjXNewkn3qjnQYjPn16haGUnKJCWS3of2fZCNsaYFdIEKA/YT9Iq
	 MBgIFxSseGv1zQp7eTfY3pj/wPwYArGilnOEjxEDwWrRfG34d/JXo9NIeXyfUn9NNI
	 FwUsa51K0Y/OlYEp0dRxxH/E/2s2FhjiJeDwmCFlnWOBU2BsKwH3ZLpJaJccuUWgrr
	 jPy49KWYEbM57bUFo5nUzYUeGxKVbHSmiFUT570YCLJsrm6KO8DOvJO5XqhYBEqJid
	 7D/tGUI7PMZDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] Input: drv260x: Fix suspend and resume sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260831081227.1794986-1-mauriziocasciano7@gmail.com>
References: <20260831011526.24AB11F000E9@smtp.kernel.org>
 <20260831081227.1794986-1-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:28:19 +0000
Message-Id: <20260831082820.063D81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The `work_disabled` flag becomes permanently wedged to `true` if t=
he device is closed after a system resume failure, breaking force-feedback =
functionality on subsequent opens.
- [Low] Direct return of error code from regmap_bulk_write in a function wi=
th multiple failure points.

Pre-existing issues:
- [High] Device configuration is permanently lost if system power is cut du=
ring suspend while the input device is closed, leading to hardware misconfi=
guration upon the next open.
- [High] Uncancelled work item leads to Use-After-Free during device unbind=
 due to asynchronous ff-memless timer.
--

commit 0cbbdf5958f6ed62525dabc219437a115afe42b3
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Fix suspend and resume sequencing

Force-feedback playback is queued asynchronously, but system suspend can
cut power while the worker is pending. Disable and drain the work item
before entering standby, and keep force-feedback quiesced until resume has
restored communication.

Link: https://lore.kernel.org/linux-input/20260831011526.24AB11F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/20260830143050.03E081F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/
Link: https://www.ti.com/lit/ds/symlink/drv2604.pdf

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
[ ... ]
> @@ -258,11 +282,29 @@ static int drv260x_haptics_play(struct input_dev *i=
nput, void *data,
>  	return 0;
>  }
> =20
> +static int drv260x_open(struct input_dev *input)
> +{
> +	struct drv260x_data *haptics =3D input_get_drvdata(input);
> +
> +	if (haptics->work_disabled)
> +		return -EIO;
> +
> +	gpiod_set_value(haptics->enable_gpio, 1);
> +	/* Data sheet says to wait 250us before trying to communicate */
> +	fsleep(250);
> +
> +	return 0;
> +}

[Severity: High]
This is a pre-existing issue, but will device configuration be permanently
lost if system power is cut during suspend while the input device is closed?

During system suspend, VDD power can be cut. Because drv260x_resume() checks
input_device_enabled(), it skips drv260x_init() if the device was closed.
When userspace later opens the device, drv260x_open() asserts the enable
GPIO but does not reinitialize the hardware registers, leaving the device
in an erratic default state.

>  static void drv260x_close(struct input_dev *input)
>  {
>  	struct drv260x_data *haptics =3D input_get_drvdata(input);
>  	int error;
> =20
> +	/* PM has not restored register access yet. */
> +	if (haptics->work_disabled)
> +		return;

[Severity: High]
Could this early return leave the device permanently wedged if it is closed
after a system resume failure?

If drv260x_resume() fails, it leaves work_disabled =3D true. If userspace
then closes the device, this early return skips clearing the wedge state. On
the next suspend/resume cycle, drv260x_resume() skips recovery entirely
because input_device_enabled() evaluates to false (since users is 0). The
work_disabled flag would remain stuck to true, returning -EIO on all future
opens.

> =20
>  	cancel_work_sync(&haptics->work);

[Severity: High]
This is a pre-existing issue, but does relying on close() for cancellation
risk a use-after-free during device unbind?

When the device is unbound, input_unregister_device() calls drv260x_close()
and then stops the background ff-memless timer. If the asynchronous timer
fires in that window, it can reschedule the work item after
cancel_work_sync() has already returned. Because the work item lacks a
registered devm cleanup action, it remains pending and could execute after
the memory has been freed.

[ ... ]
> @@ -398,6 +440,11 @@ static int drv260x_init(struct drv260x_data *haptics)
>  		return 0;
>  	}
> =20
> +	if (haptics->calibration_valid)
> +		return regmap_bulk_write(haptics->regmap, DRV260X_CAL_COMP,
> +					 haptics->calibration_data,
> +					 ARRAY_SIZE(haptics->calibration_data));
> +

[Severity: Low]
Does returning the error code from regmap_bulk_write() directly violate the
explicit failure paths coding style?

The input subsystem maintainer guidelines prefer the expanded error checking
form instead of returning the action directly in functions with multiple
failure points.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081227.1794=
986-1-mauriziocasciano7@gmail.com?part=3D1
