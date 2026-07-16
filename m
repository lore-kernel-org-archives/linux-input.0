Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CA3C09FF
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193449; cv=none; b=MoRYPMFuU07CaS9n6l+pjLkPTx/iUJMLjEKS2feBGBNjO6ouRnYpnC4Alu+sLaWMxSLDjasMrQBBeVZWHPPQ5+G5cM8V+waRW8yT7qyWZ8cobMcKvvZ/GBPRDkfDdG0cwGVsr/QZYaG+dryhPTpIFxmQqGhWOcGmUKglnUnek8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193449; c=relaxed/simple;
	bh=POfPh6JZN5RiarUJ41sEZD755Zmx/yxuBudhnZr//zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i0cHA2yVhzSPWfi6QhKn/mO8fnL85BZ+4E3wZe5cQlrTHQ8qJRoKiXFGRZmy8IbHWgqkKwSIi2g2VOQWWMxxZdh+1iqzx0tmqT6xIGThUoH3xZ+CuA+KoLFiFa5qjQNAjM2K09c1bFLpIng6QqUnUZH/e/Xsoa0WUP3yhrdLhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLvwwHgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLvwwHgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F931F000E9;
	Thu, 16 Jul 2026 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784193447;
	bh=JwAfhMdtZ77b3FmTAteLc8jdjaphEs0FEXI2KvwtLJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLvwwHgYa1aUSfGSEuXLH4fnRyplhJWbIZLELCwaY5axEeudmfxwH7RlZnTvkvTux
	 LQtbt5CP2tEv++2Rxq2Uu7w9IhQfi/hvwQwgKKFRJ535qhk/Lsp5Uc9DN8nfAPz/0S
	 ykZr/ZNz5iVEpo5srlT2Rqnh6OSFs+7N9JgOOx6tIueEp76K23hQgT/VRGFY3UTOY9
	 RC+IJe04UGoTBtuWlxGlVquxUFMoKo0q3lmWxcn/FmnU6tXrqgdcaGNnGELuwhjZWT
	 oMCdLuhnx+LAdPV7TAqUc3W8s9xfpQUn34tsHWt7EMaZCz5Cgd6Csgc+vn+zwMXGnb
	 A5ybTMlr9bjvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260716090726.2711293-1-lee@kernel.org>
References: <20260716090726.2711293-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:17:26 +0000
Message-Id: <20260716091726.A2F931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Direct bit manipulation is used to set the SW_MUTE_DEVICE capabilit=
y instead of the preferred input_set_capability() helper.
--

--- Patch [1]: [PATCH v6 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capabili=
ty prior to registration ---
commit 5e17768d036dad9565ea2c66ff5662065517024d
Author: Lee Jones <lee@kernel.org>

HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration

This commit moves the SW_MUTE_DEVICE capability advertisement for touch
devices to wacom_setup_touch_input_capabilities() to comply with input
subsystem guidelines. It also replaces lookup-dependent product
references with hdev->product.

[ ... ]

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..6fd1a5bcc28a4 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3961,9 +3963,12 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
>  	else
>  		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> =20
> -	if (features->type =3D=3D HID_GENERIC)
> +	if (features->type =3D=3D HID_GENERIC) {
> +		input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> +		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);

[Severity: Low]
This isn't a bug, but since this is setting a single capability, would it be
better to use the input_set_capability() helper here instead of direct bit
manipulation?

>  		/* setup has already been done */
>  		return 0;
> +	}
> =20
>  	input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>  	__set_bit(BTN_TOUCH, input_dev->keybit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716090726.2711=
293-1-lee@kernel.org?part=3D1
