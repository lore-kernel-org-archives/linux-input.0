Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BA3C342F
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187937; cv=none; b=Iia02noQOqvea6yyuhFffU8ItHv1DEmnFty4an3FPD90UVxz5EITIQdbFn6KEjUEwEUrbzuK2plnhLkHfNt8viOMWH6FShU8UIEIGq6J3bqDAuAyqlmurISJZNt+GxMQGc8mCQRTuKZJe5pkjudeJMwq1gs45CSMpHdMl8ID+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187937; c=relaxed/simple;
	bh=ywg55gy4jrdbwsFbMugggm+PWqTZlMnvST82q3fx6r0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHTtfLtgrjoe/zRuO4wABKuaTsTTFGNF0d91f60MBGEq0p8QddQAgFWGobbRfyn9ZrZAmq6iwSSfNEjxO/mtoM18Y+a6feWmJABvvZ8Xg+cJaMjB/8Jg6nOgdqizBJBUEwUg+MI1ZPsmbQQo9G0Wc+gPdEnK/PUwQmErp4fH0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwnamyfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwnamyfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB7B1F0089A;
	Wed, 23 Sep 2026 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187931;
	bh=WfO7KJ98DrzMABrfASDoLmwitI3EEDleCG6ztIjoc2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwnamyfUGl3gl2PHEdFiovGqnpm8SjOhiSf8DKl3dc8/zG4mxUi8h5gjDPKDq5/Mu
	 c07sYJ7R4jVY6P+znBsOwFzymCV5EGvsDizHGxk4OhnC8B/7WUXmpfQVlX+FYin66r
	 TGLaLcy9JAPxZqzVyU9cH61kzGxoyQMKAoLhdnZMG1NyzioQc7ikkyrF+08NVPy0bA
	 qgqVO1VHnPoarB6B/ryE2yJ1OM4DZWu1qLDdRSr6ON7Q6OfRdaM6/mzwMH45E4kIaT
	 kJ+bu/FYS2SiEliDoQB1j954CoA35FCDOcsIkht+FlD5d2H0CKIalLQolq37by1+d1
	 hCEq+OPNgmeXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: do not overwrite the device's
 hi-res wheel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roman Stingler" <roman.stingler@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260923181203.422097-1-roman.stingler@gmail.com>
References: <20260923181203.422097-1-roman.stingler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:25:30 +0000
Message-Id: <20260923182531.4FB7B1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: incorrect caching of hi-res wheel multiplier in low-res mode
--

commit 243fa986b83024ae16437c2e5c919019982c426b
Author: Roman Stingler <roman.stingler@gmail.com>

HID: logitech-hidpp: do not overwrite the device's hi-res wheel mode
   =20
This commit modifies hi_res_scroll_enable() to read the current wheel mode
from the device instead of always forcing high-resolution mode on connect.
This prevents the driver from overwriting a persistent mode configured by
userspace.
   =20
Link: https://lore.kernel.org/all/20260920094508.39682-1-roman.stingler@gma=
il.com/

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 493763a12518e..338477bfcaebe 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -3910,8 +3910,16 @@ static int hi_res_scroll_enable(struct hidpp_devic=
e *hidpp)
>  	u8 multiplier =3D 1;
> =20
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> -		if (ret =3D=3D 0)
> +		u8 mode;
> +
> +		/*
> +		 * The wheel mode is persistent state in the device, so read it
> +		 * rather than overwriting it, and scale to match. A device
> +		 * left in hi-res still gets the multiplier it needs; one the
> +		 * user configured for low resolution is left alone.
> +		 */
> +		ret =3D hidpp_hrw_get_wheel_mode(hidpp, &mode);
> +		if (ret =3D=3D 0 && (mode & BIT(1)))
>  			ret =3D hidpp_hrw_get_wheel_capability(hidpp, &multiplier);

[Severity: High]
Does skipping the capability query when in low-resolution mode introduce a
regression if the device is later switched to high-resolution mode?

If the device is probed in low-resolution mode, mode & BIT(1) is false and
hidpp_hrw_get_wheel_capability() is skipped. The local variable multiplier
remains 1.

Later in hi_res_scroll_enable(), this fallback value is cached permanently:

    hidpp->hires_wheel_multiplier =3D multiplier;
    hidpp->vertical_wheel_counter.wheel_multiplier =3D multiplier;

If a userspace configuration tool (such as Solaar) later switches the device
to high-resolution mode via HID++ commands, the driver will use this cached
multiplier of 1 instead of the hardware's true capability.

Since the kernel relies on hires_wheel_multiplier to scale physical
high-resolution wheel ticks, a multiplier of 1 causes each physical sub-det=
ent
tick to be incorrectly reported as a full 120-unit detent, making the scroll
wheel move wildly fast.

Should the true high-resolution multiplier capability be queried and stored
regardless of the current active mode?

>  	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL=
) {
>  		ret =3D hidpp_hrs_set_highres_scrolling_mode(hidpp, true,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181203.4220=
97-1-roman.stingler@gmail.com?part=3D1
