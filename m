Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941EF35E1B3;
	Thu, 18 Jun 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768388; cv=none; b=rvN/BlqBIWJ8+4MufE77QAB7q059HbQX0i6Qtvy3UEBppvQQX9/VvkwF3QYgPeEiBJyIc8Cl5xghS0FKqvlVCEQNNOxk8/F/XG8HW2FE/WSTjLr+S9Kh2r1qAPF+9MabRpSqNULQ05C6uy61OXdNx5QK7E+GBv2GYE7CLw7kZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768388; c=relaxed/simple;
	bh=uPH5NJeA1u8C4R2OF7zuijEJjEnwbnuhmwmUW+QA+JA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VhnjPxKmPSobsXBpkPPjvqI3kANNYJ/GMHbbJAg9/EwSFHo0DaTE6qC8iXvytCRnkQeqeyzzYGynH6ovIQKQKGB+V7imh3FdaPRLQB2je8McRwESHI+0WJ+FO6imBquAoBym6fPyYKP9/bWBTxSr/MJFNTLcULcNe+iCZekErSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAWz5a9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAWz5a9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E25C1F000E9;
	Thu, 18 Jun 2026 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781768387;
	bh=Yj+lIiOg6DB1bfrgX9lr6tllzrvgFzDO1mVEU+NCOS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAWz5a9y11IByycJY+UKomWKQrqhVPSfl8qjFq6BSLqk3QKV+xLbuhWySEkXrL99F
	 tTm/kgcTiU0Cq/Jnr0nypkD31KmOd83CnZAuCBIm5ovmjwLqk4U7hIAlQqZ0TIinv/
	 w7U9/0gv1YAoOH0EUQZ9rC452XmfAz7ptviIoCJT+Hjwgn8waUAXFUowZXjN0dX0X1
	 /+eFjqsbynsjyUqTJa7ohD8m0+RFDttnng2KA2QCTWEjYcypFkXo34eJNp3I4rjwhH
	 Ha2yzE5Md8p4hO+yMvcCq8zHtkXPZM/FjQ9/Rp0XaeCMCalTnSrkKHVpxqTb08UURo
	 CmAT7ETxv1GRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: linux-input@vger.kernel.org, imx@lists.linux.dev, dmitry.torokhov@gmail.com, Frank.Li@kernel.org
In-Reply-To: <20260618-b4-pwrkey-v4-3-4bfda105bdf3@oss.nxp.com>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
 <20260618-b4-pwrkey-v4-3-4bfda105bdf3@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 07:39:46 +0000
Message-Id: <20260618073947.0E25C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup for device wakeup and wake IRQ on driver unbind ca=
uses memory leaks and re-bind warnings.
--

commit aed6a36738ed05979b6e5650a6efcf08cfb05a1d
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - use local device pointer to simple code

This patch introduces a local device pointer in imx_snvs_pwrkey_probe()
to simplify the code. It replaces repeated references to the platform device
pointer with the new local variable.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c

[ ... ]

> @@ -191,27 +192,27 @@ static int imx_snvs_pwrkey_probe(struct platform_de=
vice *pdev)

[ ... ]

> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> -	error =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +	device_init_wakeup(dev, pdata->wakeup);
> +	error =3D dev_pm_set_wake_irq(dev, pdata->irq);

[Severity: High]
This is a pre-existing issue, but since there is no remove callback in this
driver, does this leak the wake IRQ allocation when the driver is unbound?

When the driver is unbound via sysfs, the wake_irq structure allocated by
dev_pm_set_wake_irq() seems to remain attached to dev->power.wakeirq.

If the driver is subsequently rebound, will dev_pm_set_wake_irq() fail with
-EEXIST and trigger a kernel warning about the wake irq already being
initialized?

Furthermore, because device_del() does not automatically free
dev->power.wakeirq, could this memory permanently leak when the platform
device is destroyed?

Would it be better to use devm_pm_set_wake_irq() here to ensure proper
cleanup?

>  	if (error)
> -		dev_err(&pdev->dev, "irq wake enable failed.\n");
> +		dev_err(dev, "irq wake enable failed.\n");
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-b4-pwrkey-=
v4-0-4bfda105bdf3@oss.nxp.com?part=3D3
