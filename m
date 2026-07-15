Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34B175A93;
	Wed, 15 Jul 2026 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108351; cv=none; b=Kmu455vf4Zplx5koOmpxVBsoZudFeabeES7FRCQFIuD5Wwk6q6YBtUeIMBmPjQp9qyta8Ka5qFMif0bVi8l/72vJ266TbYUSSg5QjlwJnfS7mZ+o8t0rjrjG3GcZwvGnfZ9aYgf//mrTFjinQKpZ7X7LJunvcFg6Kkhcpst/SYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108351; c=relaxed/simple;
	bh=Mcb5Pl6kJ0SF8IhFOTAYYaweuNO0Y9rWKS8Dtt5o/og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XTWXH7B1d0Yj0Ry4sbSeCQlDM0DGh3AaZmqMgXFLhX9iuEesGMPkp6Vlnbu+OkECeMeafL8f/x6Cp/8tv3lo6ZbB+YqCg0/EpceufcyzTJ7p4zGVofeI9I65udkMLCzPNrSw26Xzt6Vrgndxa6ZvOp7UTSlYEKB2Xw5wi5TScPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5/TOwQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5/TOwQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57EE1F00A3E;
	Wed, 15 Jul 2026 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108337;
	bh=40zRxgrq/wrfErW5RIm4gsaFU11d3DJnsfKG7EuduU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d5/TOwQZYOD/OObeuuJ5j2l6c1DCquRR4lnduuHCarqba2bv7Upfvl6UsDg0fb/on
	 8rgNt/xAzdWuVBuk42BaL5KWqtsdU73ssX4Ys5fxaW1G50ADzUSv4zrACwWVzGwRWR
	 3d+IpZ+E9s9wl75nepNua4r0FF6CgKzKxSM31HO14Ru1OS2ft+7ei11o/XkhSx7gcm
	 ESWFKpFpkk61fXGqAylPplQCSX6Bo+b6rQgM5WynPxkvCqJzdBSwOkzI/ZC3hlCXkp
	 9lfyTUX/lUK5lEITwoIeNKoyFzyQpPAEQuG2DTtWueZZqvBDOodswiJUSpAhNVFwev
	 +BKOd64JNUkwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: imx@lists.linux.dev, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260715-b4-pwrkey-v5-3-07e7353c319e@oss.nxp.com>
References: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
 <20260715-b4-pwrkey-v5-3-07e7353c319e@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:38:56 +0000
Message-Id: <20260715093856.A57EE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resource Leak / Use-After-Free due to unmanaged dev_pm_set_wake_ir=
q()
--

--- Patch [3]: [PATCH v5 3/4] Input: snvs_pwrkey - use local device pointer=
 to simple code ---
commit a69cd5d0da1072f6e3d82c6e22dfe1b937e29159
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - use local device pointer to simple code

This commit introduces a local device pointer in imx_snvs_pwrkey_probe() to
simplify the code. It replaces repeated references to &pdev->dev with a
single local variable.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index d58bbbe9fd58f..cbe44a38d2b3d 100644
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
This is a pre-existing issue, but does this code leak the wakeirq structure
when the driver is unbound?

Because the driver provides no remove callback or devm action to call
dev_pm_clear_wake_irq(), the allocated wake_irq structure appears to be left
attached to dev->power.wakeirq on unbind. If the driver is re-probed, could
this cause dev_pm_set_wake_irq() to fail with -EEXIST?

Also, since the underlying IRQ is managed by devm_request_irq() and freed on
unbind, if the system enters suspend after unbinding, could the PM core
attempt to call enable_irq_wake() using the stale, freed IRQ number and
cause an oops or use-after-free?

>  	if (error)
> -		dev_err(&pdev->dev, "irq wake enable failed.\n");
> +		dev_err(dev, "irq wake enable failed.\n");
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-b4-pwrkey-=
v5-0-07e7353c319e@oss.nxp.com?part=3D3
