Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41646403E9B;
	Tue, 13 Oct 2026 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903500; cv=none; b=t3Zr4gMRnwH0hiGx5+n2p6dFtYPHY6mHbHjyUkiKbf69fIbKgLa8j689LV/SFclvl4YON05eKSI3+L6HTGV6NWaTcHEkQjto+FwuZnnr5fsMhO3aqovvWNr1OUInrGQlJ3wgyOipGwDamM+oAEsDxtkBxNepDlYSO+QCb2gOxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903500; c=relaxed/simple;
	bh=AesWvpSqDZiN3Gc5vT1oG/ZFt2uFeIR/WsPgFEY4YPE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kwpnQQvrdaigepfDwJl/FhppmJxClvV2TX9lmBA4IhXr4f0XdjYavtYWeTJ4BAyZW5ZTX1POfIL8xuS52rjdfsKhaGE+Nenpv8sPOCIDBVIzPI6z+JySvaH4FGs00crav+suSxScY62LQvlzlXMpB+G3YfTZ+2ryDLpelvG3ZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXMHW/9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXMHW/9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7806B1F000FF;
	Tue, 13 Oct 2026 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903497;
	bh=cWghkI4pZFc10+YbElzFuA7RMwPdieryb71st2duIm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXMHW/9bqHxTpcpDqCgvkPrl5JzHWKkdSuwVjrTX+USxyPed1/DqWQGwMBdhEKZpw
	 ncPgBoPirswt0x5+We7mPSe3glJh5dSc4UKJoSHcarvwaLFYB2yiM+30S/kBhu642Q
	 H3y0fr77hBTdaVQecCEvu7vKlzB7QsKBsljBQYnQZy4C+PW7Eh2U2nQNziHw/qKW4+
	 cq+vW40DGITucEVsfRnTkP7obH+oDIMcWDZya9CGA/JkwmjGT+C/QHnMRd7SooLJAn
	 GOMs7Acr73I5wrMRGcfd++2aTVsiVtw9cYJOMPRIpOw4kqTsdTL6usSJ8sWLuNUDbJ
	 5Sz35nCeo7RuA==
Message-ID: <sashiko-outbox-169953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Armandas Kvietkus" <armandas.kvietkus@proton.me>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261013-mainlining-v3-2-fca981f62b57@proton.me>
References: <20261013-mainlining-v3-0-fca981f62b57@proton.me>
 <20261013-mainlining-v3-2-fca981f62b57@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:58:17 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] irq: passing NULL devname to devm_request_threaded_irq()
--

commit dcca01e09d9b46c0ca4b04c76dcbcff656133fd5
Author: Armandas Kvietkus <armandas.kvietkus@proton.me>

Input: aw8697 - Add Awinic AW8697 haptics driver

Add a driver for the Awinic AW8697 LRA haptic driver IC. It supports
FF_RUMBLE and calibrates the LRA resonance at probe. Based on the aw86927
driver.

> diff --git a/drivers/input/misc/aw8697.c b/drivers/input/misc/aw8697.c
> new file mode 100644
> index 0000000000000..9f703f81df213
> --- /dev/null
> +++ b/drivers/input/misc/aw8697.c
[ ... ]
> +static int aw8697_probe(struct i2c_client *client)
> +{
[ ... ]
> +	err =3D regmap_read(haptics->regmap, AW8697_SYSINT_REG, &val);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to clear interrupts\n");
> +
> +	err =3D devm_request_threaded_irq(dev, client->irq, NULL, aw8697_irq,
> +					IRQF_ONESHOT, NULL, haptics);

[Severity: Low]
Does passing NULL as the devname argument here cause issues with procfs
interrupt reporting?=20

The interrupt core assigns this pointer directly to the action name field.
When exposed to userspace via /proc/interrupts, passing NULL causes it to
print (null) when formatted by the seq_file interface, which degrades
diagnostic information.=20

Could a valid string like the device name or client name be passed here
instead of NULL?

> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to request irq\n");
> +
> +	INIT_WORK(&haptics->play_work, aw8697_play_work);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-mainlining=
-v3-0-fca981f62b57@proton.me?part=3D2
