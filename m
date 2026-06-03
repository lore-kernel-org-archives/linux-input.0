Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA540913F
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474322; cv=none; b=LGJO8uXK9DC3IDJb0KIzjdxQrIA+UQy6qvk3mXCghCt74167NlGuf3JBi7l0mzanVYBD5hiuvdoo2KJYb8UBMsEKkp3y9pN5jLz4eUQOcY650cE9tNVncSOTGYIbxMflJ6EPRIghMObEOhVabvbQGylC2qGg+EyK7sQK0H+M7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474322; c=relaxed/simple;
	bh=Qg4qMf5j1WYe4PoW6rd6nf1YYnM7I2/1aHhet1HufVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z60uggc8ZU7VcVb8leP45LhxNSUQzMZWBX/+MSRHPnjKz7ZIJ/Ed9ouz+EYpgexQ7n3YbtcsIAHOqk8UNOxEV9saR5DQW/2yBDkusAHTA3hpPgc6Z5exElBgpUs7K7iOMmxeJKV9e73DqUmhmj+ftklJG53AzsMu555+nQHops8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am8TNxJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am8TNxJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B31F00898;
	Wed,  3 Jun 2026 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474317;
	bh=qylzIkAJHXHojSZ5oHfJIUqoj6EPVEOkFaMtwYUq7dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Am8TNxJ6JanZzSGMg2daltb33qPP0VydI3dkPwTo5gAA4I//Kx2NS0+W/o9gRGEUw
	 vhoWgi/fJnfk6asWtcYB+DWcJ5y2dAV7aWhWvMELrqrRy1HV6ZETot2TptBf+YqPT/
	 izCQy3NH8rO2nB3hLp+pRoqiUTen+rYQFdHAuK0+5kafUuvu8ga80q2z6deWU/u1fa
	 KPlZF9Mc/UaHA8ZnjWgWY1FuNZLz8p3dA/RszuTVAN49mEOEMFLPjCD/2cWpZT6KVe
	 ipZRafV14vOkQX0pPems6oi6e2Nnh+AkQNdCDzy88fzCDe3jbEtoS1cJg2IRTcUTEY
	 96Ez7Somnptsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] Input: axp20x-pek - add support for AXP313A
 variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Feng" <steven@joint-cloud.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_58979D4AAAB2237B7CFCA5445D81B687E207@qq.com>
References: <tencent_58979D4AAAB2237B7CFCA5445D81B687E207@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 08:11:56 +0000
Message-Id: <20260603081156.E38B31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Suspend and resume callbacks unconditionally disable/enable IRQs e=
ven when the input device is not registered, potentially disabling the syst=
em timer (IRQ 0).
- [Low] Manual assignment of the input device's parent is redundant when us=
ing devm_input_allocate_device().
--

commit 54f63f8b19bf8de6d0676d801f797fd4b2f755ae
Author: Steven Feng <steven@joint-cloud.com>

Input: axp20x-pek - add support for AXP313A variant

Add power button support for the AXP313A PMIC. Creates a dedicated
axp313a_info configuration with NULL time tables to support the
device since it lacks the PEK_KEY register.

> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index c1a4e5ea1e001..964b39817af9f 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c

[ ... ]

> @@ -414,6 +421,10 @@ static const struct platform_device_id axp_pek_id_ma=
tch[] =3D {
>  		.name =3D "axp221-pek",
>  		.driver_data =3D (kernel_ulong_t)&axp221_info,
>  	},
> +	{
> +		.name =3D "axp313a-pek",
> +		.driver_data =3D (kernel_ulong_t)&axp313a_info,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, axp_pek_id_match);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the driver
I noticed an issue in the suspend and resume callbacks:

drivers/input/misc/axp20x-pek.c:axp20x_pek_suspend() {
        ...
        disable_irq(axp20x_pek->irq_dbf);
        disable_irq(axp20x_pek->irq_dbr);
        ...
}

If axp20x_pek_should_register_input() returns false, the input device
is not registered and the IRQ numbers remain initialized to 0.

During suspend and resume, these callbacks unconditionally disable and
enable the IRQs. Since device_may_wakeup() evaluates to false in this
state, the callbacks execute disable_irq(0) and enable_irq(0).

On systems where IRQ 0 is the system timer, manipulating its state
during power transitions can lead to system hangs or kernel panics.

Should these callbacks verify that the input device is actually registered
before interacting with the IRQs?

[Severity: Low]
This is also a pre-existing issue, but I noticed a redundant assignment
in axp20x_pek_probe_input_device():

drivers/input/misc/axp20x-pek.c:axp20x_pek_probe_input_device() {
        ...
        idev->dev.parent =3D &pdev->dev;
        ...
}

Since devm_input_allocate_device() automatically sets the input device's
parent, is it necessary to manually assign it here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603074727.6133=
19-1-steven@joint-cloud.com?part=3D2
