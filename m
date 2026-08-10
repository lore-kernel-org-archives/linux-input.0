Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDA331EC0;
	Mon, 10 Aug 2026 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336649; cv=none; b=Zcu3B///6VOLHE95iZoHQbJQ2rRIAb/gfmX52kBzYGn7LmRpoyIc5kEgWt6OSYcSyCdOHAmJCkq1rn0dwsXEb78HwJTlfLDj2jxtoy6T9A3cWbFP+6gFd3DO1Amdhd8Sz2uiPC22ma3+KJu8Yd408xVW2V+v5/Fu50fvcOJgrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336649; c=relaxed/simple;
	bh=Jm0rR64KGyDGoikpEiNSCtekIgxns/JBiMF6db9onn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUdXoICbY/6+xyt8g4543DgzPAZZR9/ERMCZiyPMP3kQzaE7WVNWRxx9zsRG0sl5tHzT0YAF7q6w/8a8nC4MHOm5GlBepXspuOhEwI0mbhki5eQiBrGtgRw+nM9LZS1CsTtnSJ1L+H0qhlaB073dm1HDMnJk3+QuvOXpqcl7Upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cugtVEEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cugtVEEe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 305651F000E9;
	Mon, 10 Aug 2026 04:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786336648;
	bh=acLx0N9qa91vOfdS3Nkiz8dBADpDoaJ10v37OearMzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cugtVEEejtGCgd+xwQ+FZwVHSfwOrOATVa7WAURDE/VqYh2nOEEKFW3LlFfMJsiBQ
	 5Kvft+m/nezLWtnGRRzjANIQXFyrbyecRPWNpPggkdGBUklo1iksKcjHJ3zJ/fXgL/
	 snEydRshr4XALmsr8hTFmGgmV63W3LVyWkQ1UM0OfiA0oYshywcSejoyv5svCFvXOm
	 DwL4XXueOWVV9PT8JBaNQnyLVijL7gTFiMN+eBbogjP1CUe0eEiLd+Jh9AOiRR6oAG
	 JX5gsts3JbduXItxfT9ZmRYQxxrFdfz7gykIRxlzk+bAyjPLH3O9/6exesoDD8MYDM
	 M3+NjvhM97axw==
Date: Mon, 10 Aug 2026 06:37:25 +0200
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
Subject: Re: [PATCH v4 01/13] notifier: add device-managed registration APIs
Message-ID: <anlUQXtxrghA8kNT@monoceros>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="laigukhl2znmnns4"
Content-Disposition: inline
In-Reply-To: <20260726101739.33170-2-farbere@amazon.com>


--laigukhl2znmnns4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 01/13] notifier: add device-managed registration APIs
MIME-Version: 1.0

Hello,

On Sun, Jul 26, 2026 at 10:17:27AM +0000, Eliav Farber wrote:
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 2f9fe7c30287..c1a66fa0c331 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/device/devres.h>
>  #include <linux/kdebug.h>
>  #include <linux/kprobes.h>
>  #include <linux/export.h>
> @@ -197,6 +198,56 @@ int atomic_notifier_chain_unregister(struct atomic_n=
otifier_head *nh,
>  }
>  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> =20
> +struct atomic_notifier_chain_devres {
> +	struct atomic_notifier_head *nh;
> +	struct notifier_block *nb;
> +};
> +
> +static void devm_atomic_notifier_chain_unregister(struct device *dev, vo=
id *res)
> +{
> +	struct atomic_notifier_chain_devres *dr =3D res;
> +
> +	atomic_notifier_chain_unregister(dr->nh, dr->nb);
> +}
> +
> +/**
> + *	devm_atomic_notifier_chain_register - Device-managed atomic notifier =
registration
> + *	@dev: Device to tie the notifier lifetime to
> + *	@nh: Pointer to head of the atomic notifier chain
> + *	@n: New entry in notifier chain
> + *
> + *	Adds a notifier to an atomic notifier chain and registers a cleanup
> + *	action to automatically unregister it when @dev is unbound.
> + *
> + *	Return:
> + *	0 on success, negative errno on error.
> + */
> +int devm_atomic_notifier_chain_register(struct device *dev,
> +					struct atomic_notifier_head *nh,
> +					struct notifier_block *n)
> +{
> +	struct atomic_notifier_chain_devres *dr;
> +	int ret;
> +
> +	dr =3D devres_alloc(devm_atomic_notifier_chain_unregister,
> +			  sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret =3D atomic_notifier_chain_register(nh, n);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	dr->nh =3D nh;
> +	dr->nb =3D n;
> +	devres_add(dev, dr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_atomic_notifier_chain_register);

IMHO devm_atomic_notifier_chain_register() should look as follows:

	ret =3D atomic_notifier_chain_register(nh, n);
	if (ret)
		return ret;

	return devm_add_action_or_reset(dev, devm_atomic_notifier_chain_unregister=
, dr)

which is much easier and includes less details from the inner workings
of devm. Same for the blocking variant.

Best regards
Uwe

--laigukhl2znmnns4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5VYEACgkQj4D7WH0S
/k4A9Af+Ojn2E+l4xDQpsSDbVEqgiXv61C4OfU2RE50xgQP4qAZidi+pc4zGxtUg
0z13yR8gFAmrMM9N6O1VhriVFGIUA9vMYDtAyeU2TLjBIjMLKUFrr2vChSm/skP1
t/4Z+hc+YzosxSB0JIgsL5Bb3AwUCzwX/8tP18KNafUyRr8aQ9oOXfu/M+YNzh7a
3mc1JDU1vaCOJFX/SPtRdy9YLa7m9KEvawXtOChlmpMAxSCbHrjSAPJMkiBFc4k2
zqsTCnh/psoYVGSnNg/gfrXxINJkt3GkiKT84w3/SX02KB37Sx+CwIYavuUv/zEj
P5J9NCBIC3tSQpekexPhQywVL+yAsQ==
=Jvr3
-----END PGP SIGNATURE-----

--laigukhl2znmnns4--
