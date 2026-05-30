Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F92BD5B9
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101920; cv=none; b=jmnb9PgIwYr312QvHo73in92EQKRkJZ7gFOnPBdqjD0T1/Lv08VK+dQsYkYKrxKKd+8lq7txu6Wrrtzhwy6ITdaskDpyub12lhFuJkrXAKc4t4gQShD+Xucr3j9MzngZa6YI3vy8nJ/bGaTrDlYfQaSv/6Oxr6ynW0FLjoQwmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101920; c=relaxed/simple;
	bh=IWee1Ue7mcZ35XmpeqbbalO+LtGys99z0cNhnvbOi+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxOksaVPhvThRGV2BUBsm9eSHawGerFezw2StBlXC4GzHjKPToz+4rJcVSX1kLa73KlCz9wxYewhNnj6pP0SneySwueQQH0lRZlEpknKi3JTHIJNgsu7jK9RA2zgrQwrw0z1UdeBDManRJdkFhVQZrlv1yiKwoARGcIdE119Cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf7idyqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf7idyqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BAB1F00898;
	Sat, 30 May 2026 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101919;
	bh=7CoLaJBHGMfJ29kE8a6DpxAxO3rQDyKqq5nP10QVUM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wf7idyqNMOzrk3i/V3EZAzcX5DA3QU2mzyagjQVDAEcBYeVQ2C8Km664VJslGop9f
	 fOx794vyXWiHA8TvckqEF860cYryZeq9R1Bi6O9FKh2YYZneapdsRhfjQGiO0oyXqh
	 OF7aSpXOBx1IXMomHHacLV8ShAPfrmHaV8DFDa9hLw4yCcdN0n3h/Kq/6EHYQJqff3
	 AjnzVkURHLA+vZuK41gqUj340N8YIxR6G4nDxZmGbRwvS1k7xvbb8nnGAdBFe4+KVj
	 ayNlKWbanQqg2qOBRx0x4/nnL4fzccoe1vy3IS6zRJVQN0IgW8uKMxGU3GlOcyHNmg
	 +kdRPwj+uM/aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] [v2] [net-next] net: dsa: b53: hide legacy
 gpiolib usage on non-mips
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520183815.2510387-2-arnd@kernel.org>
References: <20260520183815.2510387-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:19 +0000
Message-Id: <20260530004519.A9BAB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Probe errors from devm_gpio_request_one() are silently ignored, fa=
iling to propagate critical errors such as -EPROBE_DEFER.
--

commit 46ca85c6cb9da93cad093c8eb342afc0ea94be33
Author: Arnd Bergmann <arnd@arndb.de>

net: dsa: b53: hide legacy gpiolib usage on non-mips

This commit moves legacy gpiolib usage inside an #ifdef block and transitio=
ns
the common parts of the driver to use modern GPIO descriptors. This allows
building the driver even when gpio_set_value is left out of the kernel.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 2c4131ed7e30b..d838511ae6744 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
[ ... ]
> @@ -3173,12 +3172,6 @@ static int b53_switch_init(struct b53_device *dev)
>  		return -ENOMEM;
> =20
>  	dev->reset_gpio =3D b53_switch_get_reset_gpio(dev);
> -	if (dev->reset_gpio >=3D 0) {
> -		ret =3D devm_gpio_request_one(dev->dev, dev->reset_gpio,
> -					    GPIOF_OUT_INIT_HIGH, "robo_reset");
> -		if (ret)
> -			return ret;
> -	}
> =20
>  	return 0;
>  }

[Severity: High]
Does this silently ignore probe errors like -EPROBE_DEFER?

Previously, if devm_gpio_request_one failed, the error was returned to the
caller. Now, b53_switch_get_reset_gpio handles the request and returns an
ERR_PTR on failure, but that error pointer is simply stored in dev->reset_g=
pio
while b53_switch_init unconditionally returns 0.

Later in the code, b53_switch_reset_gpio relies on IS_ERR(dev->reset_gpio)
to gracefully return, which would silently skip the reset sequence entirely
if the GPIO controller simply isn't ready yet (-EPROBE_DEFER) or if there
was a memory allocation failure (-ENOMEM).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520183815.2510=
387-1-arnd@kernel.org?part=3D1
