Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08D1DFFD;
	Fri, 12 Jun 2026 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297076; cv=none; b=H7pqa6e/7pC4v3zP7Owxe94Mbi0sAiSslKy2DixCGnU/iYrrEhqKbdlAIywevF4xDV7jz5HUqyWVWCjJnNblmXEFj++RImadwRBlDO6AfVe+17Awi7b+ZnOjDugNCYQOgFohjJOpsug+jjN0lOh6+1rgzo/bpEbKzGzFXDgEa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297076; c=relaxed/simple;
	bh=goAxhR7qqdBE6S0+LOf4GqM+w16qCkFiYfwfPMsf6ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OfNzTnje9ArCfI2HR6VrdPE13BhaYCVsE3bCSVsOvWvh42IPprP6zG+yxESiVoyUat6C4c2rhO7/KjgBDLoSXw2j8zx6sW9rm0er50EyhSkc07pyKXwEGJsfuH/5RDd2onYI8k1q8hARIfGl3LU7vZtoUxUC1R662btnwSMFYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzDnuddY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzDnuddY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E891F000E9;
	Fri, 12 Jun 2026 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781297075;
	bh=ESlgcV+sSAXhJ8EWfwDbiW8pWPCgj7FlQDagWfEaYlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzDnuddYU/c6vTo7gtQtd79qMe8uR3/vMhY0/bnClpUChs8Qq8ZnrlOMlUnKModP9
	 gKhXjTgPzteOujFGsAwEIdiMQ/BSTc4HMQ8Yd54rmk7Kbuyw0kz+x6SP9M3XcOoGpQ
	 44YBl+als0rKHPCiqCUvbu1ZsNQQCL1nC94ewiIWwAmJUxDQBQTwO6S7eAei3urnyr
	 QjdAWkOo6KnlUq/fR3K1RL9fezSRd6F2y4bgIYKTutV622n1hioS5FB+H2RDePr+yA
	 dtTg5UDIzuVxaGOQb6iqqdqmUpl8KAPEhYDIbtAN3O4avgs3gt4zE4U9IbpNcBI8IW
	 jO/HsG02wm/xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] mfd: mt6397: Add support for MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260612200717.361018-5-l.scorcia@gmail.com>
References: <20260612200717.361018-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 20:44:34 +0000
Message-Id: <20260612204434.D1E891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PM notifier `chip->pm_nb` and the unmanaged `irq_domain` are l=
eaked on probe failure and driver unbind, leading to a Use-After-Free durin=
g system suspend/resume.
--

commit 7e58614b47c19c51b0d112cc3708ab6bf5ecdc5a
Author: Fabien Parent <parent.f@gmail.com>

mfd: mt6397: Add support for MT6392 PMIC

Align the MT6397 PMIC driver to other MFD drivers by passing only an
identifier through mt6397_of_match[*].data and add support for the MT6392
PMIC and its RTC, keys and pinctrl devices.

> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> index 5d2e5459f7444..80ea5b92d232f 100644
> --- a/drivers/mfd/mt6397-irq.c
> +++ b/drivers/mfd/mt6397-irq.c
> @@ -203,6 +205,12 @@ int mt6397_irq_init(struct mt6397_chip *chip)
>  		chip->int_status[0] =3D MT6397_INT_STATUS0;
>  		chip->int_status[1] =3D MT6397_INT_STATUS1;
>  		break;
> +	case MT6392_CHIP_ID:
> +		chip->int_con[0] =3D MT6392_INT_CON0;
> +		chip->int_con[1] =3D MT6392_INT_CON1;
> +		chip->int_status[0] =3D MT6392_INT_STATUS0;
> +		chip->int_status[1] =3D MT6392_INT_STATUS1;
> +		break;
> =20
>  	default:
>  		dev_err(chip->dev, "unsupported chip: 0x%x\n", chip->chip_id);

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory safety
problem involving the initialization in mt6397_irq_init() and the probe
error path in mt6397_probe().

Later in mt6397_irq_init(), we call:

    register_pm_notifier(&chip->pm_nb);

However, there doesn't seem to be a corresponding unregister_pm_notifier()
anywhere in the driver, nor a .remove callback in mt6397_driver.

If devm_mfd_add_devices() fails in mt6397_probe(), the devres mechanism
will free the mt6397_chip structure (pmic). Since the pm_nb remains
linked in the global pm_chain_head list, wouldn't a subsequent
suspend/resume event dereference the freed memory and cause a
use-after-free panic?

Additionally, could this also leak the irq_domain (created with
irq_domain_create_linear) if the driver is unbound via sysfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612200717.3610=
18-1-l.scorcia@gmail.com?part=3D4
