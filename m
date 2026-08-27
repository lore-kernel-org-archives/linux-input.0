Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FE1E1A3D
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855339; cv=none; b=r51BaqNcarofrFI3ZjRNqlfnGRtMH5u/9ta9VUPW3h91+zj2BvL3w70qOo9JrJnFQ6HzIe/2UcaaKzbrUlnPMLVVBk3XNRY2PFHPeRhBoGwQmuswQ5sQ4V/jo/8JXs2gx199WN2gR8uR2+O9hrBXtZbpFBBdRd/Ypko/V9n1fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855339; c=relaxed/simple;
	bh=NG2/dofKp8CNwnNEPLJtTAkOT1ZDTSuJqkYTb0UCu2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQAw4twBeyKLewBgTA7oXXZDG6h2x7ZAvN4pEzSYYNyoQOWCOspuG9Hsuekjo8oNsPN5NBRCbDlJm4yTV9sxFmXOjHW/NwB7TZ0+jfrUgVpOZMnxNQPHiO1RK+82hPc0q3UjjxTWou/VmgJAO+g4JYWdrPjDcbLUPPYJSR4q9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFlFQd88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFlFQd88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8E91F000E9;
	Thu, 27 Aug 2026 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787855336;
	bh=4dlzOfcxPu2X2egm6j6fBvKHjSCQou4Vzd1ixRRHMtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFlFQd88pEKgeGqx3EWqIfIkQp0OLr8plV2IocU7RL+vX8Dps/rAiQeiGl9180E2S
	 eNvbOgaZ6S7mCdSoLxGV3HD2uW0ClLe2ciV/ShlInmSgfDPZlp061MjTenyYnTFK6G
	 zb1h3vLrshaJV6QF4BfeblyoRU0ux8sQtHgRyKEeDpX7c4OGdo77Hz+rC57gOns6vP
	 8nV4b2wagMrWWDlzZz7EKag/OMSyjHmu0UxOKkrA6W9xYOmnnLqgSCb7rM5SQH7O0g
	 KSqrZsIc9zA7B2pmDxzFMWkstITUNfc1ahcZTQy3Fl2u+c6wf+aIrqzGGUCKhUYlgY
	 g+kAp1v+v12kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: drv260x: Fix suspend and resume sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260827181545.2426800-1-mauriziocasciano7@gmail.com>
References: <20260827181545.2426800-1-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:28:55 +0000
Message-Id: <20260827182855.DE8E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The device mode is permanently overwritten during playback, breaki=
ng resume initialization for ERM actuators.

Pre-existing issues:
- [High] Volatile configuration is wiped on device close but is never resto=
red on subsequent playbacks.
--

commit f2bc5aa859d35cc4439e1699724bc7b8924e6f2a
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Fix suspend and resume sequencing

This commit fixes system suspend and resume for the drv260x haptics driver.
It quiesces the worker and rejects new playback requests during suspend,
and restores the volatile configuration by reinitializing the device on res=
ume.

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 6c5c4c53753b1..36e867734fc1b 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
[ ... ]
> @@ -243,6 +252,9 @@ static int drv260x_haptics_play(struct input_dev *inp=
ut, void *data,
>  {
>  	struct drv260x_data *haptics =3D input_get_drvdata(input);
> =20
> +	if (haptics->suspended)
> +		return 0;
> +
>  	haptics->mode =3D DRV260X_LRA_NO_CAL_MODE;

[Severity: High]
Does this code permanently overwrite the device mode during playback,
breaking the newly added resume initialization for ERM actuators?

When a user triggers a haptic playback, drv260x_haptics_play() permanently
overwrites haptics->mode to DRV260X_LRA_NO_CAL_MODE.

When the system suspends and resumes, the newly added drv260x_init() call in
drv260x_resume() reads the overwritten haptics->mode and executes the wrong
initialization sequence (the default switch case).

This will cause ERM actuators and calibrated LRA modes to fail to
reinitialize properly upon system resume, leading to haptic malfunction and
incorrect drive signals for ERM hardware.

> =20
>  	/* Scale u16 magnitude into u8 register value */
[ ... ]
> @@ -612,16 +634,18 @@ static int drv260x_resume(struct device *dev)
[ ... ]
>  		if (error) {
>  			dev_err(dev, "Failed to enable regulator\n");
>  			return error;
>  		}
> =20
> -		error =3D regmap_update_bits(haptics->regmap,
> -					   DRV260X_MODE,
> -					   DRV260X_STANDBY_MASK, 0);
> +		gpiod_set_value(haptics->enable_gpio, 1);
> +		usleep_range(250, 500);
> +
> +		error =3D drv260x_init(haptics);

[Severity: High]
This is a pre-existing issue, but is the volatile configuration wiped on
device close and never restored on subsequent playbacks?

When the last user closes the device, drv260x_close() pulls the enable_gpio
low, which powers down the chip and clears its configuration:

drivers/input/misc/drv260x.c:drv260x_close() {
    ...
    gpiod_set_value(haptics->enable_gpio, 0);
    ...
}

A subsequent program can open the device and play an effect, but since there
is no open() callback to call drv260x_init(), drv260x_worker() executes
playback on an uninitialized chip:

drivers/input/misc/drv260x.c:drv260x_worker() {
    ...
    gpiod_set_value(haptics->enable_gpio, 1);
    /* Data sheet says to wait 250us before trying to communicate */
    udelay(250);

    error =3D regmap_write(haptics->regmap,
                         DRV260X_MODE, DRV260X_RT_PLAYBACK);
    ...
}

Because there is no open callback in drv260x_probe() that symmetrically cal=
ls
drv260x_init(), the haptic actuator loses its calibration, rated voltage, a=
nd
overdrive voltage configuration after the device is closed. Subsequent
playbacks run on power-on reset defaults.

Any unprivileged user with access to the input device node can trigger this
behavior by opening and closing the device, potentially causing hardware
damage if the default voltages exceed the actuator's limits.

>  		if (error) {
> -			dev_err(dev, "Failed to unset standby mode\n");
> +			dev_err(dev, "Failed to restore configuration: %d\n", error);
> +			gpiod_set_value(haptics->enable_gpio, 0);
>  			regulator_disable(haptics->regulator);
>  			return error;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827181545.2426=
800-1-mauriziocasciano7@gmail.com?part=3D1
