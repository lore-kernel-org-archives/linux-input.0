Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15CB35E93E;
	Fri, 12 Jun 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249563; cv=none; b=fzjevVGlDBa4PbCLg7CAjjm1BUBN3xgYDnkzHG0QVygaA17vciwo5EEUwwOvyzGqOb/qDa0xVZ+w0+PyR2F9EkPg0bYgqj+YsfEddGpzHJHy24/c7z3PfJdyHGLA0qFM+QutrGF2DK0MyKCQAE8bxHL5m7aCugMepyhKOa9NkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249563; c=relaxed/simple;
	bh=5M+NQNORC/o2YwTi72pQyX3fGjRUwGhyWa1GukXduwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=guGxBwOcapXQSPdS5zPL3maAXb/hlif6oBU7EiptvpxREGDmjbl0mwOaTrCzfSVtLK6jLT9WZpLnF0muThQ/oPz6eZntQPJmbXtgXhFz4rA6vtTpQ/MNwi33VyZbxtj9423lntxZF9ddAGvhWg4w0g7H9jxhdt63l5TkwhtGBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSdttWo3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSdttWo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7131F000E9;
	Fri, 12 Jun 2026 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781249562;
	bh=0A6QOwaR0asij5+wf8eHeA95mRob4XudCgAGyBzveo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSdttWo3yARdLmkB19aHgO6jSkpEEL79oA6Au6ALlxIqbHXiAI74ZcXJAXt+JlSpT
	 0U4crFMISPhULr+xx0vHsdjbWzaXHs8hqcZam1Hfy8w1NbINMTlcOiim8kkBraxcLH
	 GBgE7twXVyaVkPX15DC+5Qe/mm9Ah30J4kBd6FQ3ULJ6aJNLi2XX1gOsnmKQhAa4jp
	 mfrzdpljIvwRkgt09Q42RIofFpwRv5NYLTkLfO6hwpfd8B/qyPIXPxXLO8Jd/PsMgI
	 1697oyZWKWgYVV78s3IM+Sj8tVFVdbfKQMwmkawzgzP1y5NJ6+6qDmcsJjXkddBiQw
	 UU7gWOtavvEYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] Input: cap11xx - clean up duplicate log and add
 probe error logs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260612072237.1177304-2-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-2-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 07:32:41 +0000
Message-Id: <20260612073242.1E7131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Threaded interrupt handler returns IRQ_HANDLED on I2C failure, pot=
entially causing an interrupt storm.
--

commit f746dddeb8894305a4dab485d320b84f53191dc0
Author: Jun Yan <jerrysteve1101@gmail.com>

Input: cap11xx - clean up duplicate log and add probe error logs

This commit removes a duplicated device detection log entry to clean up
dmesg output. It also adds missing error logs using dev_err_probe()
when I2C communication fails during the driver's probe sequence.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index 2447c1ae21661..485d8ba977235 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c

[ ... ]

> @@ -531,11 +531,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_=
client)
>  	}
> =20
>  	error =3D regmap_read(priv->regmap, CAP11XX_REG_REVISION, &rev);
> -	if (error < 0)
> -		return error;
> -
> -	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
> -			 id->name, rev);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to read revision\n");
> =20
>  	priv->model =3D cap;

[Severity: High]
This isn't a bug introduced by this patch, but while looking at I2C failure
handling in this driver, I noticed an issue in cap11xx_thread_func().

If I2C communication fails during the interrupt handler, the code jumps to
the out label:

drivers/input/keyboard/cap11xx.c:cap11xx_thread_func() {
	...
	ret =3D regmap_update_bits(priv->regmap, CAP11XX_REG_MAIN_CONTROL, 1, 0);
	if (ret < 0)
		goto out;
	...
out:
	return IRQ_HANDLED;
}

Because it unconditionally returns IRQ_HANDLED without deasserting the
hardware interrupt, the level-triggered interrupt line remains active. This
causes the interrupt controller to unmask the IRQ and immediately trigger it
again, creating an infinite loop (interrupt storm) that can lock up the CPU.

Should the handler return IRQ_NONE upon I2C failure so the kernel's spurious
interrupt detector can eventually disable the broken IRQ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612072237.1177=
304-1-jerrysteve1101@gmail.com?part=3D1
