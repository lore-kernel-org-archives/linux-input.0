Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200A23BF91;
	Sun, 11 Oct 2026 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697701; cv=none; b=SnmFaWpVsm5YXYDHhfo1m2lz43fAM4Ctc97whIbCJmVyFliJPY7d0XtwXk5nJ4mGuxSYG2TwBeKnsztuXaRfcBgiqUhD0YqeTfpxVCkNY6FJjRD4K6KxIrpw0abvp3mCA8r6npSCiPP3dGlcKhyT3UcRtmW8CuYvn8A7s8DHHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697701; c=relaxed/simple;
	bh=KH9Bzl3qF2Q8zeeqrU2BjZrJgVz6HQLRXJ6c9AhevJw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XgGWNy4a16wdPRR6Zz6ECYwH/Ef3SBbrB8usB5cCutjf9ww3EcjyJtIEmXOP2r3GZDH7jeCUnKKG6Jr24j+YudcmaWtr/LMp4Zkg2qYwpJur6XJcLiJxcVKj/0qNQ69gTob2X1e/aWP49EfQ9JplG8yf4uV1gWD5S5gdIGZsDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2nDPDrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2nDPDrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16281F0089B;
	Sun, 11 Oct 2026 05:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791697700;
	bh=n6JKMwEDFL8edhoX1+ICdpNa8nIzRfSPaL7L3N6U4FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2nDPDrdlI1RinuXLnht3MwjbRAABnpfl5Jpo6ebmXSaoLkrmXGIBUMRq1lOafMo6
	 sX2RUR/aSy/6+JtD7PIg0XZ4wEh0raZWPi9TsKRg3i1VVov06J3aywssPmFR+0ybtd
	 z8FsYuHiiq0X3CdKV2ncAOqpY72LzmaP0imfbvSDplUQjbSR9IN102amAWR/YzT8Gl
	 TlnR0cEIo8E0CQpZ6OWczHMjc1GkLHw8WgAK7IA9tWFqO0wrMhlmQyVElW3I6VWgtz
	 e4fhCMKKz2YPtJB2aApckDn6qRE9VbEiSp4IYlpoVUHZ+VhvGGj8Hr5LRfYal5PYPf
	 tj68tj39pyK7A==
Message-ID: <sashiko-outbox-167045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Input: add Nsiway NS2009 resistive touchscreen
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miotsuki Mizuno" <founder@crepuse.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261011054223.93396-4-founder@crepuse.com>
References: <20261009144729.85832-1-founder@crepuse.com>
 <20261011054223.93396-1-founder@crepuse.com>
 <20261011054223.93396-4-founder@crepuse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 05:48:19 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] i2c: i2c_device_id array is missing named initializers
--

commit 0ef31ef1051f1f4d0d958b8c5e57e36de085c191
Author: Miotsuki Mizuno <founder@crepuse.com>
Subject: Input: add Nsiway NS2009 resistive touchscreen driver

This commit introduces a new polling driver for the Nsiway NS2009 I2C
touchscreen controller. It supports reading 12-bit X/Y ADC values and repor=
ts
touch events using the raw Z1 contact threshold.

Link: https://lore.kernel.org/all/20170315155140.54518-4-icenowy@aosc.xyz/

> diff --git a/drivers/input/touchscreen/ns2009.c b/drivers/input/touchscre=
en/ns2009.c
> new file mode 100644
> index 0000000000000..d5c1f9f96bb6b
> --- /dev/null
> +++ b/drivers/input/touchscreen/ns2009.c

[ ... ]

> +static int ns2009_probe(struct i2c_client *client)
> +{

[ ... ]

> +	error =3D input_register_device(input);
> +	if (error)
> +		return dev_err_probe(dev, error,
> +				     "failed to register input device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ns2009_id[] =3D {
> +	{ "ns2009" },

[Severity: Low]
This isn't a runtime bug, but I2C subsystem guidelines require initialized
arrays of type struct i2c_device_id to use named initializers. Should this
element be initialized as { .name =3D "ns2009" } instead of positionally?

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ns2009_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011054223.9339=
6-1-founder@crepuse.com?part=3D3
