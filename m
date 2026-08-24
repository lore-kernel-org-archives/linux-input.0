Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB0388397
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611283; cv=none; b=uLYV+LF5D3PA+E/2w5xrzOfsoWiCnxJrc+nAmEKnrLAgjWU313ZWeA/XVPN+tPfnCjiDlgreiQ4W2dzM7FhFPN0GARhhWpBa9PzmpddfzP0YJyipWXdmBY2KxzweQqqN5qcf3f1KT7lDRw2+MdDQbTqOKSJb9Cu2ilKYXtWIUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611283; c=relaxed/simple;
	bh=O/4oDYAnT8bocp+cDu4XsrCvmZ710PiJjLf+0+r0N7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQot7kv5oXW77IEq/YGKnhUuzunCviWwaDAaJ8lofyKuuIfSJgvdWNV6LM7CBu57B+pmUcI64hcnJbiT2Li4T53OGRUDd8ku1wxb6Ahm6FEfX9oWxBjVzXMT9WA+8U7N8PKOPXMd2KpO516DoTzlxPKqtRSemSlHUzzN/vbY/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtLHDwWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtLHDwWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5601F000E9;
	Mon, 24 Aug 2026 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787611281;
	bh=csr2S0J8KpvXjZj1qkqSL8NWMXaf7E8gJgGk/wFns5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FtLHDwWW9nR/9VkPnpz6KmaNCEPZlk6b1esdBMRrD2qMtNrdFuUsT3UjVO5cUySjC
	 oDZ5eF1CfR0hICSaQpqweBd+gaj8+MkNYeJPpPb8q6afMXnJp9E8z/U/zMqUuIEja2
	 oa2iSER5lmuJ6+jqjDSsZ5h3sd4hHf9gTldCAJwYaUx/GYvjwa5hr8ky41cMGm/18k
	 jrO0StzoLQqauvI3f+KsePTuH2NEVmnkGK6eMs2CUKibz4MiSWz+Pb4mokXQUjfIkm
	 Fmntbpd1FHKPkpW7X+sfefVgRqo2m8Kwwd0eHipx/WDT52PlgWq5sGWN6k5FKUpU6s
	 BHwzfYkv6tV9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: ayaneo: Add AYANEO 3 detachable controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0acyBYXMgTWFydGnMgW5leg==?= <hello@matias.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824223103.93947-1-hello@matias.me>
References: <20260824215041.79892-1-hello@matias.me>
 <20260824223103.93947-1-hello@matias.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:41:20 +0000
Message-Id: <20260824224121.2C5601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing initialization of the multicolor LED channel intensities=
 results in the LED remaining off by default.
- [Medium] The `hw_pattern` implementation completely ignores the brightnes=
s requested in the pattern string.
--

--- Patch [1]: [PATCH v2] HID: ayaneo: Add AYANEO 3 detachable controller d=
river ---
commit e8a8ced2df93a1a83b6b165f28028f3d597aafea
Author: Mati=CC=81as Marti=CC=81nez <hello@matias.me>

HID: ayaneo: Add AYANEO 3 detachable controller driver

This commit adds a driver for the vendor interface of the AYANEO 3
detachable controller. It provides module identification, software eject,
and RGB control of the joystick rings as a multicolor LED class device.

> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c
[ ... ]
> @@ -359,25 +359,25 @@ static int aya3_pattern_set(struct led_classdev *cd=
ev,
>  			    struct led_pattern *pattern, u32 len, int repeat)
>  {
>  	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
>  	struct aya3 *aya =3D container_of(mc, struct aya3, mcled);
>  	int ret;
> =20
>  	if (len !=3D 2 || pattern[0].brightness || !pattern[1].brightness)
>  		return -EINVAL;
> =20
>  	ret =3D mutex_lock_interruptible(&aya->lock);
>  	if (ret)
>  		return ret;
>  	aya->pulse =3D true;
>  	ret =3D aya3_send_config(aya, 0);

[Severity: Medium]
Will this hardware breathing pattern fail to activate if the LED is current=
ly
turned off?

In aya3_pattern_set(), the requested brightness in pattern[1].brightness is
validated but never used to update aya->rgb. If the LED was previously off,
aya->rgb remains {0, 0, 0}.

When aya3_send_config() is called, it checks aya->rgb to determine the mode:

    if (aya->rgb[0] || aya->rgb[1] || aya->rgb[2])
        mode =3D aya->pulse ? AYA3_RGB_PULSE : AYA3_RGB_SOLID;

If aya->rgb is all zeros, the mode will remain AYA3_RGB_OFF instead of
AYA3_RGB_PULSE, silently ignoring the pattern request. Also, if the LED was
already on, it will pulse with the previous brightness instead of the
requested brightness.

>  	mutex_unlock(&aya->lock);
>  	return ret;
>  }
[ ... ]
> @@ -389,17 +389,17 @@ static int aya3_register_led(struct aya3 *aya)
>  {
>  	struct led_classdev *cdev =3D &aya->mcled.led_cdev;
> =20
>  	aya->subleds[0].color_index =3D LED_COLOR_ID_RED;
>  	aya->subleds[1].color_index =3D LED_COLOR_ID_GREEN;
>  	aya->subleds[2].color_index =3D LED_COLOR_ID_BLUE;
>  	aya->mcled.subled_info =3D aya->subleds;
>  	aya->mcled.num_colors =3D 3;

[Severity: Medium]
Is it intentional that the subled channel intensities are left uninitialize=
d?

Because aya is allocated with devm_kzalloc(), the intensity fields in
aya->subleds are zero-initialized. When userspace sets the brightness,
aya3_led_set() calls led_mc_calc_color_components(), which multiplies the
requested brightness by each subled's intensity to calculate the final RGB
values.

Since the intensity is 0, the resulting color components will always be 0,
causing the LED to remain off by default when a brightness is requested.
Should the channel intensity fields be initialized here?

> =20
>  	cdev->name =3D devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
>  				    "%s:rgb:joystick_rings",
>  				    dev_name(&aya->hdev->dev));
>  	if (!cdev->name)
>  		return -ENOMEM;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824223103.9394=
7-1-hello@matias.me?part=3D1
