Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D41E9B1A;
	Mon, 10 Aug 2026 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786335840; cv=none; b=UrjP0znG9jmMnEPFfv1SDUY0d4C26J+6OIpBgaIz3uVrZko3aP3iTbUrrxeR5RPLAHqsjp3Fxr4R2xU4NA87zbjAsmm/7fczzq8iH/NyQZvoL0eclVtd9FeGx33NAbMS/vxFpWaxQjY3iNnvk/32PShd4FxTF0UfJMiiiyO1obk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786335840; c=relaxed/simple;
	bh=ZcVqvT+Y6eFRnYyRCFWzLo91a4PH7hvw4v2r0+IFFzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG/5FFcPpu6p29a8RCQ+VRvkTUY9xuGTs1aeuW8yV9g5eOXc6/Foryp7rt29hbB1qrDq/J+p3W+V6z8QRLwXIiXizuqxMCbecB3S3oCTvEYqtb4mWm35oZOx+SsvtUKv8UT5fJQWMEqLuEbhpCWaqVke6+XbW4h3NWCAlU04sE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrftN1Pw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrftN1Pw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B95921F000E9;
	Mon, 10 Aug 2026 04:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786335838;
	bh=uFGiMJzadKk4WX1sGbrXcX9F5jSOD0EWYJ8Z2mfpKII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CrftN1Pw5PPEzt8ofFRGrvoIUPrn3m58F4gAMhw6PyZ6K8lS9mih2UHvQ7UgfJM+u
	 id1TdxQitIoh2/bcsUaPHyuxkeWr9VYr588ad7U/ATEwj3XLS8uREaoytUHrK9m1sf
	 lTkmydeKQnI32vp737oTsvYBdkYtjiPyD13ilRa4Vp90zFvZNWXXugj2QwDs0n0K/N
	 I4Mi1e5dhslGK0mG7e1+4QUtOtcGsWLao3JeWExAsjjV+/pXgiZckXMhu+YXy6vxB9
	 g150QZEK0Kc8W2DYqS55/aWXZQV2Y3DbazYvpj2lSTyl0vvSZLBl0cL+WI0HHGYiPe
	 two04nd7qCD8A==
Date: Mon, 10 Aug 2026 06:23:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
Message-ID: <anlSAqWxS7boyJBT@monoceros>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-11-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mu7hbbg5juva7cmc"
Content-Disposition: inline
In-Reply-To: <20260726101739.33170-11-farbere@amazon.com>


--mu7hbbg5juva7cmc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
MIME-Version: 1.0

Hello,

On Sun, Jul 26, 2026 at 10:17:36AM +0000, Eliav Farber wrote:
>  int devm_uniwill_wmi_register_notifier(struct device *dev, struct notifier_block *nb)
>  {
> -	int ret;
> -
> -	ret = blocking_notifier_chain_register(&uniwill_wmi_chain_head, nb);
> -	if (ret < 0)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, devm_uniwill_wmi_unregister_notifier, nb);
> +	return devm_blocking_notifier_chain_register(dev,
> +						     &uniwill_wmi_chain_head,
> +						     nb);
>  }

I'd remove this function and replace calls to it directly by
devm_blocking_notifier_chain_register().

Best regards
Uwe

--mu7hbbg5juva7cmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5UlgACgkQj4D7WH0S
/k6sGwf/UZUQmeE+yaDBE/vWSAF4KRfM4BCOpYcTy2/gv7+b5S9qFmFjWZ0HCOoh
3V4X2yJPH6DGRzTHUVXh8dm+ZJMuNjVS01nEMJ1zlyJfJna5Cp0FJDsIhDJRCqc9
y5GYM6P2xKFZLwL5D7FisGULZQmpmrhUXPsKsC/GpSKCplAWSTyGHtfSBPBQQuCh
F+5zgE5mG28X8ZNw5bycaSMPtilvT4jot0aIPE3USc7k1tofx/1UcWVBWRaGFYEF
nctDHlhw63B2c8e/RcObUVengsA4HeVjy+Xwaf7Pwk/nP0pOQEo6S+zy/rd+/62b
57kF59SGPY7M6iDeGXMEyaXmkbc21A==
=62yG
-----END PGP SIGNATURE-----

--mu7hbbg5juva7cmc--
