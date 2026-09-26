Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBC3BE179
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429636; cv=none; b=LN+PI6Qc99jHXNJvz6E+rUpXGu2whuKIXltKHITwBP3IPT5T7XiAI3CAgMJN+vmlNTQmmMw5KCp7u9PncP3P9wJmic/2GXqIXr3pR/H5axwGRUnrhiNTuty5sW5paJ300q9VlQ4JMeSbPLMQuuIWhEhDXOOdeZ+Wl4eX181/Rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429636; c=relaxed/simple;
	bh=MrlVxnFXxZHjKk0I45EHOzWwEZcii7SXEGWwNHTJnnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EylHASPMMqOVITg9zXD9jglo4n4lakPZ+QS01S5yoMcQ4fGAfxBiaOH40IyzzxQmxlMSRgOg09ORzf+9Q04cwGembQVJMHGaf8NN0hiDRK+WVQjk+hlsjeOPJmjvYa+CQws0h1thgsvU4m4puNddLt483NPpkGGmK3Hl/8Fh6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV4Uqhwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV4Uqhwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717B91F000FF;
	Sat, 26 Sep 2026 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790429635;
	bh=f7zKPBnbUp6eUB/KEXui9d/UrTXlZyGna2N3UHmO1JU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VV4Uqhwg3goroXJnxSkntCl+TmsX91WAbIX36NP0HdAsMQqSpMWFeuVD/0l6lwyPe
	 8DLlGyS1dPIeD6gS9Mxq2uLszlKaqoDG+RZtfUiXP6g3V4tQu0yRVK4Iu5Z+C2b+DD
	 zNWeHwQIPTRjrjQkJ7FxFkVtciH4m/6gZeqIiqwAXuDjc6beCnLcDvFGVZPLodElLD
	 bCxP+W08dYW3S/Cidgwhtv6Pi6hpsm5NHfyysFHWJsJAUU0gfBIghmPouRcPlFkFLE
	 1s0RnnXPkZwccH/kjWQU4pTgZ2TBR8Dgo4Z4JVg4Nv/GMT8s9ucYnGPveH6APD+lEA
	 h5G7/HSuWMfSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] fbdev: sh_mobile_lcdc: check for
 fb_deferred_io_init() error
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-6-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
 <20260926-fix-fbdefio-error-handling-v1-6-a94810b6e263@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 13:33:54 +0000
Message-Id: <20260926133355.717B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] fbdev: sh_mobile_lcdc: clock leak on fb_deferred_io_init() failure
--

commit 5d69f4a8e3d4f95bd3f24c9c5188ad04101636e7
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error

This commit updates sh_mobile_lcdc_start() to check the return value of
fb_deferred_io_init(). If it fails, info->fbdefio is cleared to prevent
sh_mobile_lcdc_stop() from cleaning up uninitialized deferred I/O state,
and the function returns the error.

> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev=
/sh_mobile_lcdcfb.c
> index e8324b01700f6..1409a5cc736b0 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1042,7 +1042,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_l=
cdc_priv *priv)
>  			ch->defio.deferred_io =3D sh_mobile_lcdc_deferred_io;
>  			ch->defio.delay =3D msecs_to_jiffies(tmp);
>  			ch->info->fbdefio =3D &ch->defio;
> -			fb_deferred_io_init(ch->info);
> +			ret =3D fb_deferred_io_init(ch->info);
> +			if (ret) {
> +				ch->info->fbdefio =3D NULL;
> +				return ret;
> +			}

[Severity: High]
Does this early return bypass unwinding the clocks and stopping the hardwar=
e?

Earlier in sh_mobile_lcdc_start(), the clocks are enabled and the hardware =
is
started. When called via the FBIOPUT_VSCREENINFO ioctl through
sh_mobile_lcdc_set_par(), a failure here exits without disabling the clocks=
 or
stopping the hardware:

drivers/video/fbdev/sh_mobile_lcdcfb.c:sh_mobile_lcdc_set_par() {
    ...
	ret =3D sh_mobile_lcdc_start(ch->lcdc);
	if (ret < 0)
		dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
    ...
}

Additionally, in a multi-channel setup during probe, the failure on one
channel bypasses sh_mobile_lcdc_channel_fb_register(). This causes the error
handler sh_mobile_lcdc_stop() to explicitly call clk_on() for the successful
channel, creating an unmatched increment:

drivers/video/fbdev/sh_mobile_lcdcfb.c:sh_mobile_lcdc_stop() {
    ...
		if (ch->info && ch->info->fbdefio) {
			...
			sh_mobile_lcdc_clk_on(priv);
		}
    ...
}

Could this lead to a permanent leak of the hardware clock reference count
(priv->hw_usecnt) and leave the LCDC hardware running in an error state?

>  		}
> =20
>  		sh_mobile_lcdc_display_on(ch);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-fix-fbdefi=
o-error-handling-v1-0-a94810b6e263@kernel.org?part=3D6
