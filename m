Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CA4A2A4C;
	Fri, 18 Sep 2026 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717198; cv=none; b=q04J25JoSeuEmjmUhJHJltU1+iU7sMjbf2TY0nZ53tZLgtcvi9J9WuMZhli2JhNldqCH400EQUySbI8pOV6usRJjRoOMMkfzSDuj982lPhT1+mxmhmwIaBmukDSs00lJFzlRXT9s2L/6mXkOfmwu4sFCdCReZKQDkhvmlOs8j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717198; c=relaxed/simple;
	bh=jd/4XUkR1ulqciOmIUzr2+yM/M3lbap8ZlA5AmRAUwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPrSG1xir0vTGpQ4w8jwamRlltwfqZORV5Lt5MwjIA4a+B/tU21aNv677RFE0AlgkGucMryYeoNFIK7lMb0BneGETb49w2l9DdOLibH6Q63LAPpVZMseP+eF/hRxq1iKETnbJyIi3eK0k9kgVaFMsqkLDRDEd0VqwaDdUXAFXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxdFFAhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxdFFAhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252CD1F00893;
	Fri, 18 Sep 2026 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789717191;
	bh=HRtdFQfigpgCNVcpObna9Um71uV/3yHs2xzVab1me3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxdFFAhwjVeKSiv1RcMW5S3HO5h2HCCqp17UP5GdV0gPygBrArbczLeX+eWMvabBU
	 B3jYDr7Dy0tDfvv7PIJX3lCbp9MIilsUHkcPf+MkffL4hlXievvT7vs5dROTQaEgJH
	 Gw3+1Bx/PeORB5+iMF6kLiS4yX0a7ew36iXbZjLSJ+FFr5hUGn4qFSHmHqAZX77uGA
	 ctXCVePK4DLGqYCqG3N+bBXb4OPGepAdwEqX4scGAUfNVhHLBU/2s3qfEX+moRlAw3
	 fLjq+xFKnKuqE0wcY2wsu/h5AlfcLyJGMG2KAppw+9f2+GH1FwcooE73V2OoeGE8mT
	 oE6P3O6YrQ7fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] Input: Add driver for ESWIN EPH8621 touchscreen
 IC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260918-eswin-eph8621-v3-2-514eb1f622c0@fairphone.com>
References: <20260918-eswin-eph8621-v3-0-514eb1f622c0@fairphone.com>
 <20260918-eswin-eph8621-v3-2-514eb1f622c0@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 07:39:50 +0000
Message-Id: <20260918073951.252CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] power: regulator imbalance on resume failure
--

commit 84d6ec94a7b38cd8d1245f0f98657e92de7d8440
Author: Luca Weiss <luca.weiss@fairphone.com>

    Input: Add driver for ESWIN EPH8621 touchscreen IC
   =20
    Add a driver for the ESWIN EPH8621 touchscreens, connected via SPI.

> diff --git a/drivers/input/touchscreen/eswin_eph8621.c b/drivers/input/to=
uchscreen/eswin_eph8621.c
> new file mode 100644
> index 0000000000000..766b113b3288d
> --- /dev/null
> +++ b/drivers/input/touchscreen/eswin_eph8621.c
[ ... ]
> +static void eswin_power_off(struct eswin_touch *ts)
> +{
> +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +}
> +
> +static void eswin_power_off_act(void *data)
> +{
> +	struct eswin_touch *ts =3D data;
> +
> +	eswin_power_off(ts);
> +}
[ ... ]
> +static int eswin_resume(struct device *dev)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	struct eswin_touch *ts =3D spi_get_drvdata(spi);
> +	int error;
> +
> +	error =3D eswin_power_on(ts);
> +	if (error)
> +		return error;
                ^^^^^^^^^^^^

[Severity: Medium]
If eswin_power_on() fails during system resume, the regulators remain
disabled.

Since the devres cleanup action (eswin_power_off_act) runs unconditionally
when the driver unbinds, devres will eventually call eswin_power_off().

Could this attempt to disable the already-disabled regulators and trigger
a regulator disable count underflow warning?

> +
> +	enable_irq(spi->irq);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-eswin-eph8=
621-v3-0-514eb1f622c0@fairphone.com?part=3D2
