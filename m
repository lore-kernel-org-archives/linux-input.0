Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6332B115
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099583; cv=none; b=ZDgxiIfAFUX17qwbaaXf1/lGPrV8iHfxZNnJiyZQIVTWlBEaCQR7OhZ3wrnrPLaGjzhGQlfxhia5cYb1NyQ3IxSSJ+jXHEeSK9dewmxA0DaN32/QwmAVLtQprpkmReXqzlNrYzN4QVIUReffRt6pMbyNRvEXDESmNFFtadDH9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099583; c=relaxed/simple;
	bh=CQA6NbjUo3EXV4lUv4Xiyd2O883D4/uJqRHjzdrcdBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SSFGyjjE57UicbkV3j/WeiVw/+cSGQv0fx+lP665JH5+hOVoiQ5aVSHI4NyOjaImKOEwgZgzPLv5aeKmM9e3bB4MzyUjhjYnVv8Vj9yc2KjHBYw8eLdF4kuYbUH+epbzCLTDkEudzdGoFopzXH+NHkJkilpWDLP4xLL3iWgLuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVp0tZAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVp0tZAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B211F000FF;
	Tue, 22 Sep 2026 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099582;
	bh=rQZaGcqfyajXT6BzN4U45VzsdbYICj/3Q3pFij9w7lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVp0tZAPEkzZMfMmp3YYPEd4mlPWXV4IMT8MKhYfxmkYcaeyHJgNhcczTzOeoCGKZ
	 NuVLBppMiRJCvyn0r/GOf+jLW4y363t2rFRBysdfYtnV/U2+AWCy1PKX6HKnCtKYTb
	 zDXa0DBlPHKxx4Lbjuzyja196nYLGtKx62qonosoUV8CqQNCK4cm69xlX2FozYv303
	 1aLt/Z4/CVzkPQbMxJ5v65JFcbx4CJ/KSCe9cbLoRVJBxX0jETw1xukPp6DLlkCWtY
	 iZydS+k6U17OYNkmbzUFTVnrjAihurF3xc/MY3kfqU42SFQkMfwDQEUeHNJxsY4Jmo
	 vE4+WKCNhmEhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: logitech-hidpp: fix Bolt wheel mode handling
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RXJpayBIw6VrYW5zc29u?= <erikhakan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260922-feature-bolt-fix-v1-2-63b0fa8da0d3@gmail.com>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <20260922-feature-bolt-fix-v1-2-63b0fa8da0d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:53:01 +0000
Message-Id: <20260922175302.54B211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid-logitech-hidpp: high-resolution scrolling is no longer enabled=
 by default
- [Medium] hid-logitech-hidpp: failed capability read permanently breaks sc=
roll wheel
--

commit ca5a9ddace3102c7dc2ef5b518171ea6cf49e055
Author: Erik H=C3=A5kansson <erikhakan@gmail.com>

HID: logitech-hidpp: fix Bolt wheel mode handling

This patch modifies how high-resolution wheel settings are handled for Bolt
devices in the HID++ driver. It preserves the device's user-selected resolu=
tion
and inversion settings while enabling HID++ notifications for Bolt. It also
tracks diverted wheel events to apply the correct multiplier for high- and
low-resolution events.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 166980be57b7c..55e9ac5e5ab78 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -3912,16 +3939,43 @@ static int hi_res_scroll_enable(struct hidpp_devi=
ce *hidpp)
>  {
>  	int ret;
>  	u8 multiplier =3D 1;
> +	bool high_resolution =3D true;
> +	const bool is_bolt =3D hidpp_is_bolt_child(hidpp->hid_dev);
> +
> +	if (is_bolt)
> +		hidpp->hires_wheel_diverted =3D false;
> =20
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		bool use_hidpp =3D hidpp_is_bolt_child(hidpp->hid_dev);
> +		u8 mode;
> +
> +		/* Preserve the persistent mode, except for Bolt event routing. */
> +		ret =3D hidpp_hrw_get_wheel_mode(hidpp, &mode);
> +		if (ret =3D=3D 0) {
> +			bool invert =3D mode & HIRES_WHEEL_MODE_INVERT;
> +			bool use_hidpp =3D mode & HIRES_WHEEL_MODE_USE_HIDPP;
> +
> +			high_resolution =3D mode & HIRES_WHEEL_MODE_HIGH_RESOLUTION;
> +
> +			/* Preserve user-set resolution and inversion; enable HID++ for Bolt.=
 */
> +			if (is_bolt && high_resolution && !use_hidpp) {
> +				ret =3D hidpp_hrw_set_wheel_mode(hidpp, invert,
> +							       high_resolution, true);
> +				if (ret =3D=3D 0)
> +					use_hidpp =3D true;
> +			}

[Severity: High]
Does this code intentionally drop the default enablement of high-resolution
scrolling for non-Bolt devices and low-resolution Bolt devices?

The previous code unconditionally enabled high-resolution mode by calling
hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp). The new code appea=
rs
to remove this entirely for non-Bolt devices, and only enables it for Bolt
devices if they are already in high-res mode (is_bolt && high_resolution &&
!use_hidpp).

Could this permanently disable high-resolution scrolling out of the box for
these devices?

> =20
> -		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
> -		if (ret =3D=3D 0)
> -			ret =3D hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
> +			if (ret =3D=3D 0)
> +				ret =3D hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
> +			if (ret =3D=3D 0)
> +				hidpp->hires_wheel_diverted =3D use_hidpp;

[Severity: Medium]
What happens if hidpp_hrw_get_wheel_capability() fails due to an intermitte=
nt
RF timeout or IO error?

If the hardware is already in use_hidpp mode (or was successfully set to it=
),
but the capability read fails, hidpp->hires_wheel_diverted will not be
updated to match the hardware state.

Could this leave the driver desynchronized from the hardware, causing the r=
aw
event handler to permanently drop subsequent HID++ wheel events?

> +		}
>  	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL=
) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-feature-bo=
lt-fix-v1-0-63b0fa8da0d3@gmail.com?part=3D2
