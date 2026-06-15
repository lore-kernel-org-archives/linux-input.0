Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87135145B3F;
	Mon, 15 Jun 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509083; cv=none; b=LK0iYejZcwgqYmSa1KCUrf9Gu8a76XvBoFP2ytd90AH04u7F/pS9tiDuhoKLrE9/+Gm0QmhXgeKfMS5l17cnwO0vh6xOF0JLkdOp4pWxDeuUCrLtq+t66UQIaUZV2urodLsD023n5ZhmsUoqCkWP2sSLyYGNKw9RZObnnaEu+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509083; c=relaxed/simple;
	bh=QMP5vqIDXJDnoGpiBkvCRUpVkzx4WOIgIktz0sfrZP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFZuT0uHOPc/kquiLiSglxrp3ZtM3d08iY5BQyYtWD9CfsysRz3LrpRwTzief2DI1lQS8qkvi82QktLGdAeYWVxa6IWPVQPJyK9pR6sjuNcBjAoE1Jh6jW3JC8IWyH/X4PQrTj2D14KK1PCuZByQUWNifAzPqw4u9Hvn0PoNsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4MKJuCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4MKJuCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BAA1F000E9;
	Mon, 15 Jun 2026 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509082;
	bh=NZV91TLd9EUUqLhnbAM8CEbm4USXInFWEkNJCurjJ04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b4MKJuCbxTc82OFy5kvSb9iBcXVZ8N2h9W2XdofPAwRlybgUVVpSThFkfieRy7/a9
	 SAIykxRBAudizgJ3zzz3PvmQVV8wwbyUXRgRbA/5xKmZ2bgxK6ZjEnQaeABQqJeAfI
	 d+oybaZpji1nqFm7siGHat1SHmiYmwysT39eXJtE0SrxX/x5GxN57nsmi5izY/Hj11
	 Uhw7zhKwbwaDJzHxgrdauroY6CD1PjRMbjL4+AH48eWHeIrSIA1KV64XZ6jNWB9tnz
	 Jdzl8hLrlaJ51wQlsw7jnYGpaxz1ZdPPX7a3w3lb1joHEoYdbkoTtXxzEL6heuNtpM
	 aT6vTlJ/fbabw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] mfd: mt6397: Add support for MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260615071836.362883-6-l.scorcia@gmail.com>
References: <20260615071836.362883-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:38:01 +0000
Message-Id: <20260615073801.D2BAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of PM notifier on device unbind or probe failure
- [High] Use-After-Free of irq_domain in probe error path due to active IRQ=
 thread
- [High] Concurrent hardware state writes in PM notifier
- [High] Lost interrupts due to late Write-1-to-Clear (W1C) in the threaded=
 IRQ handler
--

commit cd7aa2c7d4f30c2e0b9a697283dae8066d30b344
Author: Fabien Parent <parent.f@gmail.com>

mfd: mt6397: Add support for MT6392 PMIC

This commit aligns the MT6397 PMIC driver to other MFD drivers by passing
an identifier through mt6397_of_match and adds support for the MT6392
PMIC variant along with its regulator, RTC, keys, and pinctrl devices.

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index ccd97d66d7f1c..f683e878543e1 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
[ ... ]
> @@ -327,30 +388,15 @@ static int mt6397_probe(struct platform_device *pde=
v)
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
with the PM notifier during probe failure or device unbind.

In mt6397_irq_init(), the pm_nb notifier is registered globally:

mt6397_irq_init() {
    ...
    register_pm_notifier(&chip->pm_nb);
    return 0;
}

However, there doesn't seem to be a corresponding unregister action if
devm_mfd_add_devices() fails in mt6397_probe(), or when the driver is
unbound (since mt6397_driver lacks a .remove callback). Because the chip
struct is devm-allocated, could this leave a dangling pointer in the
global pm_chain_head, resulting in a use-after-free during the next
suspend/resume cycle?

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of a
use-after-free involving the irq_domain in the probe error path?

In mt6397_probe(), if devm_mfd_add_devices() fails, the domain is
manually removed:

mt6397_probe() {
    ...
    if (ret) {
        irq_domain_remove(pmic->irq_domain);
        dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
    }
}

Since the threaded IRQ handler was requested earlier using
devm_request_threaded_irq(), it remains active until the probe function
returns and devres unwinds. If a pending hardware interrupt fires during
this window, would mt6397_irq_thread() execute and call irq_find_mapping()
on the already freed pmic->irq_domain?

>  static const struct of_device_id mt6397_of_match[] =3D {
[ ... ]
> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> index 5d2e5459f7444..80ea5b92d232f 100644
> --- a/drivers/mfd/mt6397-irq.c
> +++ b/drivers/mfd/mt6397-irq.c
[ ... ]
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
This isn't a bug introduced by this patch, but does the PM notifier
need to acquire the irqlock to prevent hardware state corruption?

In mt6397_irq_pm_notifier(), during PM_SUSPEND_PREPARE:

mt6397_irq_pm_notifier() {
    ...
    case PM_SUSPEND_PREPARE:
        regmap_write(chip->regmap,
                     chip->int_con[0], chip->wake_mask[0]);
}

This directly accesses chip->wake_mask and writes to the regmap without
acquiring chip->irqlock. Since PM notifiers run while userspace tasks
are still active, could a concurrent request_irq() or free_irq()
interleave, causing the PM notifier to read torn state or overwrite
hardware registers with stale values?

[Severity: High]
This is a pre-existing issue, but can this interrupt handling sequence
cause lost edge interrupts?

In mt6397_irq_handle_reg(), the driver reads the status, handles the
nested irqs, and then clears the status at the end:

mt6397_irq_handle_reg() {
    ...
    for (i =3D 0; i < 16; i++) {
        if (status & BIT(i)) {
            irq =3D irq_find_mapping(mt6397->irq_domain, irqbase + i);
            if (irq)
                handle_nested_irq(irq);
        }
    }
   =20
    regmap_write(mt6397->regmap, reg, status);
}

Because these are Write-1-to-Clear registers, does writing the status
back after handling the interrupts unintentionally clear any new edge
interrupts that might have arrived while handle_nested_irq() was executing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615071836.3628=
83-1-l.scorcia@gmail.com?part=3D5
