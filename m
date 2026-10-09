Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A145367B8F;
	Fri,  9 Oct 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557595; cv=none; b=OcGSVwtGTkzdMHmowciVWKjY8rXXyDDl+f42fqbTUZAi1UnxoL1qJWMJURVGmOXEqaWnVRb9cBec0w5v5a/etIIUFfpgqWRB1SAp7N8tjEsZ/H9ReklbRMvMGfkJq+CB6A9h7rnqdSmAlXHqMT8qM1d2P/XBaQh4NZw0zuUwAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557595; c=relaxed/simple;
	bh=DakRWxWFkNizGKcTPVZer5CghHXS1js43OIDtmqBEfc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PoMKCq00mLE+q887o0hZylQpstOE9YW0njSrPYoh4fvHddvFjDOkFZ5SroEB2MYvRd0Yq2ipFIlz0SFKxMV5fPtk0HyAOXD5PC517n2BDrVfX9a/M2YnACnVYOXM0xfOiTvKlBI5KkBAWkZIuNJ6gEef7rNXj+a36aBJTdthQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgKAHvda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgKAHvda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18F71F000FF;
	Fri,  9 Oct 2026 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557594;
	bh=3w7ua7fOk6ZBm9HBGvhU+2G2jOJ3R2EbZ1ld9mXT050=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgKAHvdaNomN8Mk/wQaTpUdAbwG5vKqqSeimnyB/s1OmQZM9dN9+AtGlFLqu/r3B/
	 XKzfyXYbjYv1X2gWCXJdVuSwaOT/ukhjoC/Vx3chTZ80Bk9Z9zaHIYpjMPkHg6OLTL
	 qsqCzgb/TTMTUO6zBMsSQX1jhBQVX3viCgSLgl8WpUIG9+YIqbcaUXZIhN9XRkiFyi
	 K+Oj6oHhwDTLB2FcIhOiR9ome5lButyscBXtB1yYHeQJkBF3jT0TqI6gxyaDiLgrOr
	 /rWrzSlU3CvZpiP2OsedTenRJ1AZa+m+8wnigXGicQw7Hc8sVJGevw0bzdg5cKulef
	 CbIMCGw9piQWA==
Message-ID: <sashiko-outbox-165743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Input: add Nsiway NS2009 resistive touchscreen
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miotsuki Mizuno" <founder@crepuse.com>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261009144729.85832-4-founder@crepuse.com>
References: <20261009144729.85832-1-founder@crepuse.com>
 <20261009144729.85832-4-founder@crepuse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:53:13 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] i2c: missing named initializer in i2c_device_id array
--

commit 22cbbc5b42325e09804bb86ec6c548c4fefefb81
Author: Miotsuki Mizuno <founder@crepuse.com>

Input: add Nsiway NS2009 resistive touchscreen driver

Add polling support for the Nsiway NS2009 I2C touchscreen controller using
the input polling API and managed input allocation. Read 12-bit X/Y ADC
values and report BTN_TOUCH from the raw Z1 contact threshold.

Link: https://lore.kernel.org/all/20170315155140.54518-4-icenowy@aosc.xyz/

> diff --git a/drivers/input/touchscreen/ns2009.c b/drivers/input/touchscre=
en/ns2009.c
> new file mode 100644
> index 0000000000000..d5c1f9f96bb6b
> --- /dev/null
> +++ b/drivers/input/touchscreen/ns2009.c

[ ... ]

> +static const struct i2c_device_id ns2009_id[] =3D {
> +	{ "ns2009" },

[Severity: Low]
Should this array element use a named initializer?

The I2C subsystem guidelines specify that initialized arrays of type
struct i2c_device_id must be declared const and use named initializers
(e.g., { .name =3D "ns2009" }).

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ns2009_id);
> +
> +static const struct of_device_id ns2009_of_match[] =3D {
> +	{ .compatible =3D "nsiway,ns2009" },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009144729.8583=
2-1-founder@crepuse.com?part=3D3
