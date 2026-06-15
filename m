Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08C25228D;
	Mon, 15 Jun 2026 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510258; cv=none; b=t3Wr4rH9kUSROdh/RTwLe8g0piC7LSKMTRGGdNEXtHKBWBJZKBvJWdYOPhg7wyKjy+jc5W3Kgq4DdQEBF3DTF76VVjXr6Xb9fr2DylolK5aA2ck8P5Dbdxvsw2cIZ8EmwKBxt7mQo8KFSNEgehiYBFzmb2vIKDOvMgtqzQ+Gwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510258; c=relaxed/simple;
	bh=5r89PAcicNPL6N909f/AQEHIq5FcxMceow5LM27U7Mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZEmn2p9Xytyya5ezjnV9evZDeoOvZwKdd1/UjCA6iTRxxDZTeK6gXVWNau/RzJH4JQxm3Imx+HvK0Qi6iPxHbMPIN3j5nRkRNS79NV753Kt2zMD5FM7ISjVLU1At9aZVzjExc60IK0/kts08aIi34aN1Hf/QXmlw5iv5ClHDhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHpzxlZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHpzxlZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A431F000E9;
	Mon, 15 Jun 2026 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781510257;
	bh=q09k+/DELzlKH3nnNQavMBAMMmmsCKpuIAJKJwKFyPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHpzxlZ2NzdYRF4n3+ijPJLVqQ1zPyEYoj74gVvq20CEhkeYWroGShceEhetyvjRa
	 v7bWVYL1KoIur+fOIp1S3YSod8y8u5PKxGq3Vo0J78OXjO4+NMnbhaL+PfkgB17rPh
	 HGoUg1w/s2oQG/r0Rw+30FKN57u7YWDVddThbpXd61K6G3MFPQZNLEZnK4ZRRWBA6+
	 qMhiZmvWtSwDcny8ePLfiwxHrdODtAMGMDN1dpC64DftvDDJArN+CDwTwJFcJa31hS
	 /OVXCn7KHqzF4PpdIScpzLj85gziGRekj8fFZTdPe9WBc6YfJQWDoXwi72xAZAOOeP
	 Ct4bgcupf1qoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: linux-input@vger.kernel.org, Frank.Li@kernel.org, dmitry.torokhov@gmail.com, imx@lists.linux.dev
In-Reply-To: <20260615-b4-pwrkey-v3-1-9510b1173f6e@oss.nxp.com>
References: <20260615-b4-pwrkey-v3-1-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:57:36 +0000
Message-Id: <20260615075737.03A431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing `.remove` callback causes a leak of `struct wake_irq` an=
d leaves dangling wakeup configuration upon driver unbind.
--

commit 07567ee0ff85afeb83d7fcfa00735130f4ec77e0
Author: Joy Zou <joy.zou@nxp.com>
Input: snvs_pwrkey - make use of dev_err_probe()

This commit updates the imx_snvs_pwrkey_probe function to use dev_err_probe
for its error paths. This helps simplify error logging and properly handles
probe deferral conditions.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
[ ... ]
> @@ -209,16 +203,12 @@ static int imx_snvs_pwrkey_probe(struct platform_de=
vice *pdev)
>  	error =3D devm_request_irq(&pdev->dev, pdata->irq,
>  			       imx_snvs_pwrkey_interrupt,
>  			       0, pdev->name, pdev);
> -	if (error) {
> -		dev_err(&pdev->dev, "interrupt not available.\n");
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
> =20
>  	error =3D input_register_device(input);
> -	if (error < 0) {
> -		dev_err(&pdev->dev, "failed to register input device\n");
> -		return error;
> -	}
> +	if (error < 0)
> +		return dev_err_probe(&pdev->dev, error, "failed to register input devi=
ce\n");
> =20
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
>  	error =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);

[Severity: Medium]
This is a pre-existing issue, but I noticed there might be a resource clean=
up
issue here in imx_snvs_pwrkey_probe().

Does this code leak the wakeup resources when the driver is unbound?

It appears that device_init_wakeup() and dev_pm_set_wake_irq() allocate
unmanaged resources and attach them to the device. Because there is no remo=
ve
callback or managed action to clean them up via dev_pm_clear_wake_irq() and
device_init_wakeup(dev, false), these resources might be leaked on unbind.

If the driver is later re-bound, could this also cause probe to fail since
dev_pm_attach_wake_irq() returns -EEXIST when the wakeirq is already
initialized?

Would it be appropriate to switch these to devm_device_init_wakeup() and
devm_pm_set_wake_irq() to handle the cleanup automatically?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-b4-pwrkey-=
v3-0-9510b1173f6e@oss.nxp.com?part=3D1
