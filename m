Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742330F94D
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613956; cv=none; b=ljKs11rTmUOdq4pKL3risXWg6VzUmoFYU2bRkY8cIgPxCJ7x79sq9h0Q08kQ0LaMkbdcWNBgt+qgcl3Dd8ECnskNhj11bklF1t1e9spZ8HCOX6cfuCziF/JYPmT+Dg+o6/Cq9Qqr0wI90fPDBBS+pFuCOYiCWZcDkBeRpdeEtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613956; c=relaxed/simple;
	bh=oPp8URG1NL/BCjhgVKLBANXaPycazsCWsIK2v/RBXYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tD46FamAnucfVQYNv6YnZnA1jlO5z6Nt7dEv1wLzYdyUESD6FSoqnbN5ynPDBMdk4bIT0hFDa71U5Cl5yatKh+GSb9gL2Ai9krBGyZheogTbFh3bM5PEA53VWCP920UEQOPq1Y2svBV+Nm+UsjKl55yfKqTY5I4lmiQkHnyNFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa4myt+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa4myt+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB81F000E9;
	Tue, 21 Jul 2026 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784613955;
	bh=DjIXY5I447V3SEHnTX4SWJen9VYxTL76DSzv6ulhxFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qa4myt+zEP0QAXvqbJCMsLerpI/OsFZGo95uQzUB7v884KSnLy+gYX6E3UVxEmfw/
	 bsVgHfHgC9XTK2Ek5jeQPJ7WaQczt4PB5e5qW8aJtvx1B3OHlblZ/YozwRCDk1G4Nc
	 tRftw28vaHRHa4ZpfBaMc7LSGUb+LzfsPzjhi/i/pvTr7GL+2K8iurHCYCCrC+Lt4G
	 susN6qdYlXct0LNew1y8RuLpJddRO3mVVUasUyZ/Wfv3yPSRnKR/RJmRV98fPgBSHe
	 KOZ9BBA6rn8htoxZ/O89qXBBIr06++nUbp257tDcTxRpK7Aybhjvuea3mY30QJuepX
	 sperjNj0HCOaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: psxpad-spi - set driver data before use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260721055551.1714965-1-lilinmao@kylinos.cn>
References: <20260721055551.1714965-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:05:54 +0000
Message-Id: <20260721060555.4BAB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Rumble motors are not physically stopped during system suspend, ca=
using continuous vibration.
--

--- Patch [1]: [PATCH] Input: psxpad-spi - set driver data before use ---
commit 23ee40f181c679e252ac9e0908c0dcf15457e7b6
Author: Linmao Li <lilinmao@kylinos.cn>

Input: psxpad-spi - set driver data before use

This commit fixes a NULL pointer dereference in the suspend path by ensuring
the driver data is stored in the SPI device during probe. It prevents
psxpad_spi_suspend() from crashing when accessing the controller state.

> diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick=
/psxpad-spi.c
> index f902a56d011f4..b1ab2486bb0d7 100644
> --- a/drivers/input/joystick/psxpad-spi.c
> +++ b/drivers/input/joystick/psxpad-spi.c
> @@ -301,6 +301,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
>  	/* input poll device settings */
>  	pad->idev =3D idev;
>  	pad->spi =3D spi;
> +	spi_set_drvdata(spi, pad);
> =20
>  	/* input device settings */
>  	input_set_drvdata(idev, pad);

[Severity: High]
This is a pre-existing issue, but will the rumble motors actually stop duri=
ng
suspend?

While this patch fixes the crash when retrieving the driver data, looking at
psxpad_spi_suspend(), it calls psxpad_set_motor_level(pad, 0, 0):

static int psxpad_spi_suspend(struct device *dev)
{
        struct spi_device *spi =3D to_spi_device(dev);
        struct psxpad *pad =3D spi_get_drvdata(spi);

        psxpad_set_motor_level(pad, 0, 0);

        return 0;
}

This only updates the internal software state (pad->motor1level and
pad->motor2level). Since the driver relies entirely on its polling thread
to transmit this state via SPI to the hardware, and that poller is frozen
during suspend, is there a risk that the hardware never receives the stop
command?=20

Does the suspend routine need to dispatch a synchronous SPI command before
returning so the motors do not continue to vibrate indefinitely while the
system sleeps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721055551.1714=
965-1-lilinmao@kylinos.cn?part=3D1
