Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD53D47D7
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395010; cv=none; b=T9XOw4SQtbxSa4NcNAgcONuq1wLg9YwPuZaKi1SEfA7Cwk94tfcxq5+umvL0xZ9ZI2raX5ZIVCxlWtKJBVfkYr6ZsQBpOzAaaN/FkgN4XcFFsP5pXoKs+uoYA+rPEdr0lcfqYJ3yssCG2iQUL0ND9jPiFeHp4x+ErAB7nEG6nhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395010; c=relaxed/simple;
	bh=+J2N7LtBPnFeGuGwtfbqqbe5PeyFtkMOgnp7TFpZJ2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EpH6yHXkngoGNhzOhRxIpvcQ2n5XWuVRCrfpGKuaHnE25eYpDn52SvMS7qU4ByGgaWhjKYynPeOR+Q7wCWsWxzb+KQdbbwXavEk+JGmRwReJqjClBseY6RkL9cC84QCUu7SSVaTMldJTdzgdSeh/obmVvKgsq1k5UX+J8kouu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB87A0BI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB87A0BI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEE1F00893;
	Tue,  2 Jun 2026 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395008;
	bh=CJD5LVmtWc3gmjxnaYAOkYfsNFdphAItSevzRO4Y/O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lB87A0BI2hxsRCqWTcc3XtQ2teA0upQh+IVyat/ZMG7rlo0UOK+eblDPtovzsvHAE
	 ci7OL38zMszkeMyfDq48idxfONr7cVit+hhOMfTbOfTwZ0a3yYe20fuqlH/Hfv7fvo
	 V78oMj/AQplv8DFgTkubIGghigl62Kr2nj/fx15UWjvKBpJMjAxQ5CD/B6W4fBziId
	 SW77/V3p984MTKs8eU5dIkSWBC0NCEJ3U5nZYzaQIvDOak4IeNmGkfOfEShfvJIOhb
	 1juX85NbvIj/d07kBHJfZUsC9LD1+kjDzhaMgPipFDt31jpZ5NTOFM5L4TJ3yyo1sJ
	 CDdwbp+1FvhqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - add support for AXP313A variant
Reply-To: sashiko-reviews@lists.linux.dev
To: steven <steven@joint-cloud.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_5F1FF80489E702360F352F889570656BF608@qq.com>
References: <tencent_5F1FF80489E702360F352F889570656BF608@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 10:10:08 +0000
Message-Id: <20260602101008.93DEE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Sysfs attributes 'startup' and 'shutdown' are unconditionally br=
oken for the newly added AXP313A device due to out-of-bounds regmap access.

Pre-existing issues:
- [High] Unconditional manipulation of uninitialized IRQ 0 during system su=
spend and resume when input device registration is bypassed.
--

commit 689d64caa4b9f21a0926e40a611d5111bfe37d22
Author: Steven Feng <steven@joint-cloud.com>

Input: axp20x-pek - add support for AXP313A variant

This commit adds power button support for the AXP313A PMIC. It reuses the
existing axp20x_info structure, noting that the AXP313A shares the same
register layout and timing parameters as the AXP20X.

> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index 24f9e9d893de3..d4e2fc9a937ff 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_ma=
tch[] =3D {
>  		.name =3D "axp221-pek",
>  		.driver_data =3D (kernel_ulong_t)&axp221_info,
>  	},
> +	{
> +		.name =3D "axp313a-pek",
> +		.driver_data =3D (kernel_ulong_t)&axp20x_info,

[Severity: Medium]
Will reusing axp20x_info for the AXP313A break the sysfs attributes?

The axp20x_info struct exposes the startup and shutdown sysfs attributes.
When these are accessed, the driver reads or updates AXP20X_PEK_KEY (0x36):

drivers/input/misc/axp20x-pek.c:axp20x_show_attr() {
...
	ret =3D regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
...
}

However, the AXP313A regmap configuration restricts max_register to 0x21
(AXP313A_IRQ_STATE). Won't the regmap core reject accesses to 0x36 with
-EINVAL, making these sysfs attributes non-functional for this device?

> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, axp_pek_id_match);

[Severity: High]
This is a pre-existing issue, but could the suspend and resume handlers cra=
sh
the system if input device registration is skipped?

In axp20x_pek_suspend() and axp20x_pek_resume(), the driver unconditionally
calls disable_irq() and enable_irq():

drivers/input/misc/axp20x-pek.c:axp20x_pek_suspend() {
...
	if (device_may_wakeup(dev)) {
...
	} else {
		disable_irq(axp20x_pek->irq_dbf);
		disable_irq(axp20x_pek->irq_dbr);
	}
...
}

If axp20x_pek_should_register_input() returns false (for instance, on x86
systems where ACPI handles the power button), the IRQs are never initialized
and remain 0.

Does calling disable_irq(0) disable the system timer interrupt on x86,
potentially causing a system hang or panic during the suspend cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_5F1FF80489E=
702360F352F889570656BF608@qq.com?part=3D1
