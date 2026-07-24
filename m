Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1732A3DA
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913814; cv=none; b=mOdRXFFt14B07/TSGlhLRTPGI74ZkbobQVzYAk6V1VQJP6kpPp+XaXa+Ybws/aRLOxfq+v+LgPUfgZP3e8/ixOtCoMkAZvlQMqGYkeN67x527avCH8+1s/41q55nekKh5XGedBGOMN1g22pI/5dEBEgN0SXk2Mvq8lt2uvPFXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913814; c=relaxed/simple;
	bh=q11IyNmZY0mKD97/+rG019OoURw5wILcmtTcrsQb0oA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nt3HYCMzrll0VbOFA/cs4XS3bZAoc17cH4klLzGR8XYSoSpLlC1nzGHkSnhk/cZUCtATAGgNwNBEjbuhTJulRo7GNYgvxnwAVKCrqG6yMHJUU4zQwbtpT+g1eXGJuUbHwTqP3vKB/kJSFdiLYH4r/1gr57dYUNdhOmMie2KyJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdKuvMHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdKuvMHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8191F000E9;
	Fri, 24 Jul 2026 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784913813;
	bh=q7TnBBTUag79Zei/JVtkC4nMZZlGVwrTMqWHJ24rpOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdKuvMHyQq6R6LJrYOWz/2FT/8BUpTmL+QnEZAtFbtZ6ufTQKZrYRWaBwPsJtJB0J
	 OZpP7h8opNbWIJP3Yvb4RgnTUqmMYVPR6YU3b348SKq8UQUaXGLTt3/+P0rzhVGXA7
	 E9jTp4oLo++bn4hU5hfm6NBdZyScmTRux6QKsc76bH6bNFx0J+kHrhtN/kI2X8R5if
	 4678EWCaKldV4u9p5CUI+XFrU0FeikEiJ6yZtC8WVyziTGVQMsyKZB9NLi2X2NypPl
	 sHDbL2RefOaxj5wRKt/ZQrdQYnpG0g+9JtWt/umRTLJmgj1l13OY49O6l9rmmG9dHy
	 mZB/cAJZ0kF8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-2-0c932b77104a@gmail.com>
References: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
 <20260724-24-july-hid-gyro-dev-log-clenaup-v1-2-0c932b77104a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:23:32 +0000
Message-Id: <20260724172333.0D8191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch drops the `return` statement when handling failures from=
 `gyro_3d_parse_report()`, causing the probe function to continue instead o=
f aborting.
--

--- Patch [2]: [PATCH 2/2] iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe=
() ---
commit 9e2d893e70018e9931c8153d83e07fffde994281
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe()

This commit replaces dev_err() calls with dev_err_probe() during the driver
probe to simplify error code handling and nicely manage deferred probes.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index bcf53e2677015..48540c9a097c5 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
[ ... ]
> @@ -297,10 +296,8 @@ static int hid_gyro_3d_probe(struct platform_device =
*pdev)
>  	ret =3D gyro_3d_parse_report(pdev, hsdev,
>  				   (struct iio_chan_spec *)indio_dev->channels,
>  				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to setup attributes\n");

[Severity: High]
Does this accidentally drop the return statement?

If gyro_3d_parse_report() fails, hid_gyro_3d_probe() will now continue
executing instead of aborting. This could lead to an incompletely initializ=
ed
IIO device being registered.

Should this also be returning dev_err_probe(dev, ret, ...), similar to the
previous error handling block in this function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-24-july-hi=
d-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com?part=3D2
