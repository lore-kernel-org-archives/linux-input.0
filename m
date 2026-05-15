Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEE3BD646
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829053; cv=none; b=WLP+QZYbf21IcmpATX/58rX8qUd4T4+4RftaasNgKWBu7QvG4Q4TLX2puukjJgA+NZuaoOcdSS4tGgD37FHAWcV+aKcTT1wYGdXFmldysrgVMI33gjvxEY6LETaAsKVqkY1rf2vQTPXXjnPixWFMDvNjKsqFISjRKfPRRR3pwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829053; c=relaxed/simple;
	bh=KU7ZeSQrrXs5WE/m57ECtxi1Wtz4OEDJi6yXRm2mwqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=loP0QgYt4RmsnVO0m4P2bhJwi6apb/sKMdGNdENSMrErPqTzBRoN0j4nKztikf7I/WiCo2iuKGWHSsVIm4/y5q/5+jyDRsZowfz6tMXvTH/3L5cbqr19XJ6m2fwfamCaJHqFFTeb4KXW8JzZKDFb618ucTloYClZ+rjX6pwt7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hthG0n+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hthG0n+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA0C2BCB0;
	Fri, 15 May 2026 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778829052;
	bh=KU7ZeSQrrXs5WE/m57ECtxi1Wtz4OEDJi6yXRm2mwqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hthG0n+vUMzL2hMJ/GtkHnLJ0UmK3jnrDWJGksNlEXXhRQ8OVRD93ojF2lR1XOeUJ
	 QCiKmhJ5LEHx+1HJyPYb1P+eVZJrsvAZ4bwztyksPFElURl6j2bjfbJCHIERb+CRG1
	 w3ehuGYNGQGMOEc0EP2DfeuJfizCnTNvM4NvZdMxVlPVmXpqYPIxIQipbQT0sLK++H
	 Egcy2u72YL6ga16O3jKilZpDhlQ2WpCtW4VmC83olMLXPp+GfMtgIJH68PlDKpVEZF
	 6ZOCP8QVv93Me5N412coH3mYYGIkstb0le0EOR3VjQjbSQ1qRx+3T7Rs568FMC5/fd
	 zgBLe5rKeJSqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: elan_i2c - prevent division by zero on
 invalid device parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ranjan Kumar" <kumarranja@chromium.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260515065235.1913403-1-kumarranja@chromium.org>
References: <20260515065235.1913403-1-kumarranja@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 07:10:51 +0000
Message-Id: <20260515071052.7DDA0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting `width_x` and `width_y` to 1 as a fallback introduces a se=
vere arithmetic underflow when calculating touch area sizes.
--

commit 592cc1df694c917c489ca1a6dcea8bd8b7a8d985
Author: Ranjan Kumar <kumarranja@chromium.org>

Input: elan_i2c - prevent division by zero on invalid device parameters

The Elan I2C touchpad driver queries the device for its physical dimensions
and trace counts to calculate the device resolution and width. If the device
provides invalid zero values, this commit adds checks to fall back to safe
default values of 1 to bypass the division and prevent a kernel panic.

> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/el=
an_i2c_core.c
> index fee1796da3d08..32b2849ab36a7 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -425,8 +425,17 @@ static int elan_query_device_parameters(struct elan_=
tp_data *data)
>  		if (error)
>  			return error;
>  	}
> -	data->width_x =3D data->max_x / x_traces;
> -	data->width_y =3D data->max_y / y_traces;
> +
> +	if (unlikely(x_traces =3D=3D 0 || y_traces =3D=3D 0)) {
> +		dev_warn(&client->dev,
> +			 "invalid trace numbers: x=3D%u, y=3D%u\n",
> +			 x_traces, y_traces);
> +		data->width_x =3D 1;
> +		data->width_y =3D 1;

Does setting these fallback values to 1 introduce an arithmetic underflow
regression when calculating touch area sizes?

In elan_report_absolute() and elan_report_contact(), the touch area sizes a=
re
calculated using an expression like:

    area_x =3D mk_x * (data->width_x - ETP_FWIDTH_REDUCE);

Since ETP_FWIDTH_REDUCE is 90 and data->width_x is an unsigned int, setting
the width to 1 causes the subtraction to underflow, resulting in a massive
unsigned integer.

When passed to input_report_abs(), this value is cast back to a negative
number, violating the 0 minimum boundary configured for ABS_MT_TOUCH_MAJOR.

Could this confuse userspace input handlers and trigger unwanted behaviors?

To prevent this underflow while maintaining the firmware update fallback pa=
th,
should the fallback value be at least ETP_FWIDTH_REDUCE (90) instead of 1?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515065235.1913=
403-1-kumarranja@chromium.org?part=3D1
