Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8593B8D5C;
	Thu,  4 Jun 2026 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556676; cv=none; b=N6pWaarqImvkDAYijWFEvUjjMHOiS1P06EFO080SyFcMuKPVtDxXsxnaW2Jb0Gz6hzT1XOG1B0girLc8AjI14CiiLOlYA3kUR6wuHpkvUZTtLafiQDqAeV0M17r/Dy+64QhyQpLVGdguRu/5V3lq5L8Zk4rcS6JvTw5hfCVEQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556676; c=relaxed/simple;
	bh=3fgO5dnrp9LB1+MHoe9XOOTePiLJCgKLYq+bBkg1ucA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HCkh+zw/dBFNRFz6lhxmZcpuaeBOkDJZr8EUCDuuyzKHt97m83Y72XA5rOR5gQ+OvwZUG1wF7MxNu0CsXHedKqqiA/OTxqg+EyS9kWQQhTgayKn5rJZHK4ydRPsaAleWvA4k+62sy0GTmdgk2A8jmyaiBojOZ8SHqzN9CpCsq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndLvesyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndLvesyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DB71F00893;
	Thu,  4 Jun 2026 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780556675;
	bh=SGSAtrhnslDwLhjmSZf82EKvbKPDF1oWb87dIHZQ6zA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ndLvesyU1VGSPA0wdJM/+zAvNurEKe1eCo6Mx2/sP0GTujYyT6hG7v2odZ8xyaWHq
	 f95k/HO4gaGqfJKl8osTdrD+rhgDcl+JJ+h5s59DPhj6EaqkOhCUUWzaF78KOXwguC
	 gacofQ18FjhHmhtRU1zTOX+ObEuU/0nwaXLePRsZfB62b1j2N4sDIq9VLwLcQ7+rD8
	 0Kut2qdGJHybe/HoWOGrKWBt1fiViWoZY99FMc0kxOeohNpY2LSTrsHAKZQbOW/wkh
	 S75nhIDSxzHuAwoWvuIqv4JGCryAKV7/Axyj31XqkWDCDkDwtNoHAFvPoGV/Nk4Jc8
	 Yots4VaQJ9eAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joy Zou" <joy.zou@nxp.com>
Cc: linux-input@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260604-pwrkey-cleanup-v2-1-59fa0ddf0d7c@nxp.com>
References: <20260604-pwrkey-cleanup-v2-1-59fa0ddf0d7c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 07:04:34 +0000
Message-Id: <20260604070434.E8DB71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect pairing of pm_wakeup_event(dev, 0) and pm_relax(dev) fai=
ls to keep the system awake.
- [Medium] Missing cleanup for dev_pm_set_wake_irq() causes resource leak a=
nd -EEXIST on rebind.
--

commit c91200344c06e4226bdcadd16b77ac3688786f5d
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - make use of dev_err_probe()

This patch updates the imx_snvs_pwrkey_probe function to use dev_err_probe()
on its error paths. This provides more concise error logging and helps
identify issues more easily during probe.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index 954055aaf6e29..748196fcce75b 100644
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
This is a pre-existing issue, but since dev_pm_set_wake_irq() is called here
without a corresponding cleanup mechanism, does this cause a resource leak?

When the driver is unbound via sysfs, the allocated wake_irq structure is
leaked and the device remains marked with a wakeirq because there is no
.remove callback or devm action to call dev_pm_clear_wake_irq().

Will a subsequent rebind cause dev_pm_set_wake_irq() to fail with -EEXIST
because dev->power.wakeirq is still populated?

This is also a pre-existing issue, but I noticed something else regarding t=
he
wake event handling.

drivers/input/keyboard/snvs_pwrkey.c:imx_snvs_pwrkey_interrupt() {
    ...
	pm_wakeup_event(input->dev.parent, 0);
    ...
}

And later in the driver:

drivers/input/keyboard/snvs_pwrkey.c:imx_imx_snvs_check_for_events() {
    ...
		pm_relax(pdata->input->dev.parent);
    ...
}

[Severity: High]
Does this incorrect pairing of pm_wakeup_event(dev, 0) and pm_relax(dev) fa=
il
to keep the system awake?

Passing a 0 ms timeout to pm_wakeup_event() activates and immediately
deactivates the wakeup source. Because the wakeup source is already inactiv=
e,
the later call to pm_relax() acts as a no-op.

Does this mean the system is free to enter auto-sleep immediately after the
interrupt and before the timer executes, potentially delaying or dropping t=
he
power key event delivery? Would it be better to use pm_stay_awake() here
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-pwrkey-cle=
anup-v2-0-59fa0ddf0d7c@nxp.com?part=3D1
