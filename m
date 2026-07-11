Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E251625
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783732744; cv=none; b=kjZkROoTNYXV/YEkd6jQGwyVIXDKyXNMqi+RfS5uJhfkoJVZVRGVgkdKmNp/YpHesXjJ/1nnhR7AkC1Kiy7ae8Xh9zXNrEvRcYD1khS2XFanR/iYSE7CK1GfEAhMKsjmeJVUW7j8DiinXRWmFt18ROpVCk2B/q9nYXhDmVh3Q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783732744; c=relaxed/simple;
	bh=02IW/XQQafVGBBvNyYjoCk4KZGEZ4C076mJszsRdP74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gWGx23K2NPrPIb45NsNNwgA3TYGvCQhP+ZZ4RId7Q3+cxzdek8LmaDmAOknB68BMvHcIsG7mVKb1Fs5tkwHbuzxx+Yl/qZkLcH/3KyFAMleqoiXmoe7NZnsNh5D9XKKC1ET+lG40OuetTg2f/iXG51XUQDLzr4jHn4MnfiJV968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV49P/bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV49P/bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0605C1F000E9;
	Sat, 11 Jul 2026 01:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783732743;
	bh=JCwzx8Iy3lq2nVDVjiP51nJ/eBzHZ4kgvy5ii2ugYtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UV49P/bdLQucSlzZvcKqjvVyG7dnV3NK+vd1OE6L7y37vxTO8nFHlqwEjIdaAzQKh
	 LYMMF7r4bODXJMmNUPySGSObzzmrOBj5h2a7KEhYXqpN0qfT7mvLj+tkgTXtKx3E6m
	 09dFB7vPE3mc+tTg9lG40TN3oTs3GML7ego8j0/Md24HpuIn4faP9P9nVR0RMOSXF7
	 RIzK8B0S8Ooal8D0gNEW9FCl254klNpaQ5phpsOloCyDgAcv15ZhX5yimaLC/o+bi8
	 7DMfC0Ac0YLYy5UHYpB7CDkGVw+TudG0Wsy60UjcbNC/sZ4nT7qyMwT3F+uqbI1IBJ
	 0msiDtadxYTlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: qt1050 - name calibration status bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miles Krause" <mileskrause5200@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710-qt1050-calibration-status-bit-v1-1-e4f7d1d797b6@gmail.com>
References: <20260710-qt1050-calibration-status-bit-v1-1-e4f7d1d797b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 01:19:02 +0000
Message-Id: <20260711011903.0605C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The polling loop for calibration completion exits immediately beca=
use the break condition is inverted, potentially causing probe failure or a=
borted calibration.
--

--- Patch [1]: [PATCH] Input: qt1050 - name calibration status bit ---
commit 8a227bbb51956d6b0303c06859d65e498d26eb5f
Author: Miles Krause <mileskrause5200@gmail.com>

Input: qt1050 - name calibration status bit

This commit introduces a named constant for the calibration status bit 7
in the QT1050_DET_STATUS register. It replaces an open-coded shift and
comparison with this new constant in the calibration polling loop to
improve readability.

> diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1=
050.c
> index f9f480c910325..2371ac027aabd 100644
> --- a/drivers/input/keyboard/qt1050.c
> +++ b/drivers/input/keyboard/qt1050.c
[ ... ]
> @@ -498,7 +499,8 @@ static int qt1050_probe(struct i2c_client *client)
>  		return err;
>  	}
>  	err =3D regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
> -				 status >> 7 =3D=3D 1, 10000, 200000);
> +				 status & QT1050_DET_STATUS_CALIBRATE,
> +				 10000, 200000);

[Severity: High]
This is a pre-existing issue, but does this polling condition in qt1050_pro=
be()
wait for the calibration to complete or for it to start?

The regmap_read_poll_timeout() macro exits when the condition evaluates
to true. Since QT1050_DET_STATUS_CALIBRATE (bit 7) indicates calibration is
in progress, this condition is true while running and false when complete.

If calibration completes before the first read, won't this poll for the full
200ms timeout and return -ETIMEDOUT, causing the probe to fail? Alternative=
ly,
if calibration is still running, won't this exit immediately and allow the
subsequent soft-reset to abort the calibration process?

Should this condition be inverted to check that the calibrate bit is cleare=
d?

>  	if (err) {
>  		dev_err(dev, "Calibration failed: %d\n", err);
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-qt1050-cal=
ibration-status-bit-v1-1-e4f7d1d797b6@gmail.com?part=3D1
