Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6D4CCDFB;
	Wed,  2 Sep 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380702; cv=none; b=gIljD2yiWKTa4Mzc4GRaDBPlMw+HTHWd5183EHvlMouXxduIeZlSsQ6N9llfvVzKAwUoXh308yLYOjVXesNf+1gVSMnNlujKrbLKp4eWI8dBA9SnyaVhi+hTAKvoFvapRa5AMWqa4nnFXNSc5kaITV0X/BQotphjzrCmEvbbmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380702; c=relaxed/simple;
	bh=fSiltKOcb3v69E6wjt8E5Ko78Hw/y50obDkazcedyc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mC35lJbC78nXPPBHhNIf7ymiwuYrG18BytPM28nSh1n8vIS9ggiYR5K5h57GhR6Pd/0pDPZpyHKyxkHVXneq8dQnnTrDTX3JqoxU78WgK7jeQ5yOaHKqYwYJ/3AO35WK0ns8cUI/e/5Fo4hCInNWC+PFWGa1E9OYW063+1p8bqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5J+kQO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5J+kQO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11551F000E9;
	Wed,  2 Sep 2026 20:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788380700;
	bh=2pPfC1eZm+OvLJcrh/RYH2wsmeUSw3MxD4E5z0eOcZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5J+kQO1w70m4sBaGabZxeLo8N966mEWYN1hVUFu9COnssyWo2cf5LVKBpYFMuhU/
	 ol2AkuGMBPvf5kJH+NRDZuGTmlf/yscMA4ESyJo5K/aJIb1I3dSxxxwkXeQl/hebME
	 4EsERx2kMndnK3ohKYj0nwUver8gQwLZ30AXJABlmkdksXTQtky1GZjmTqNxGikDaf
	 PfMOrBFnSgpJZiykRnm7rBg0uM/cQPVuSdfXVzb4Gnrs0wAZJK0rBLcZugRLV89I+H
	 kuXMdKcGyx/c6qU4jvtnTLgDxKpZ+n+p2Gdx04SvRjsYIcATQUd5nUP7rDkPLj+9pW
	 CJMJ/3Mew0Wgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/9] mfd: mt6397: Add support for MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260902193351.185771-6-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:24:59 +0000
Message-Id: <20260902202459.D11551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Driver-specific header files were added to the global include/linux=
/mfd/ directory, violating MFD subsystem guidelines.

Pre-existing issues:
- [High] Incomplete resource cleanup in probe error path and missing driver=
 `.remove` callback lead to Use-After-Free and resource leaks.
--

commit cf917ffc4ed0ebfc40bb77132283778e31d7ae09
Author: Fabien Parent <parent.f@gmail.com>

mfd: mt6397: Add support for MT6392 PMIC

Align the MT6397 PMIC driver to other MFD drivers by passing only an
identifier through mt6397_of_match[*].data and add support for the MT6392
PMIC and its regulator, RTC, keys and pinctrl devices.

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 3e08179002fad..f284d3885ae18 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
[ ... ]
> @@ -282,6 +317,7 @@ static int mt6397_probe(struct platform_device *pdev)
>  	unsigned int id =3D 0;
>  	struct mt6397_chip *pmic;
>  	const struct chip_data *pmic_core;
> +	int chip_variant;
> =20
>  	pmic =3D devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
>  	if (!pmic)

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the lack of a .remove
callback and incomplete probe error handling leak resources and cause a
use-after-free?

If devm_mfd_add_devices() fails during mt6397_probe(), or if the driver is
unbound via sysfs, devres automatically frees the mt6397_chip structure.
However, mt6397_irq_init() registers a PM notifier:

drivers/mfd/mt6397-irq.c:mt6397_irq_init() {
    ...
    register_pm_notifier(&chip->pm_nb);
    return 0;
}

This is never unregistered because there is no explicit cleanup on the probe
error path, and no .remove callback is defined in mt6397_driver:

drivers/mfd/mt6397-core.c:
static struct platform_driver mt6397_driver =3D {
    .probe =3D mt6397_probe,
    .driver =3D {
        .name =3D "mt6397",
        .of_match_table =3D mt6397_of_match,
    },
};

When the system subsequently suspends, the PM core invokes the dangling
notifier_call, causing a UAF.

Additionally, the error path destroys the irq domain while the managed IRQ
thread is still active:

drivers/mfd/mt6397-core.c:mt6397_probe() {
    ...
    if (ret) {
        irq_domain_remove(pmic->irq_domain);
        dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
    }
    ...
}

Does this create a UAF window if an interrupt fires before devres cleans up
the devm-managed IRQ handler mt6397_irq_thread?

> diff --git a/include/linux/mfd/mt6392/core.h b/include/linux/mfd/mt6392/c=
ore.h
> new file mode 100644
> index 0000000000000..8777b3abf9292
> --- /dev/null
> +++ b/include/linux/mfd/mt6392/core.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

[Severity: Low]
Does placing this driver-specific header file in the global include/linux/m=
fd/
directory violate MFD subsystem layering guidelines?

The MFD subsystem guidelines state: "Do not include driver-specific header
files in the global include/linux/mfd/ directory if they are only used by t=
he
parent and its immediate children. Keep them local to drivers/mfd/."

> diff --git a/include/linux/mfd/mt6392/registers.h b/include/linux/mfd/mt6=
392/registers.h
> new file mode 100644
> index 0000000000000..68fe9af448f5d
> --- /dev/null
> +++ b/include/linux/mfd/mt6392/registers.h
> @@ -0,0 +1,488 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

[Severity: Low]
Is it intentional to place these driver-specific registers in the global
include directory rather than keeping them local to drivers/mfd/?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D5
