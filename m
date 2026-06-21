Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D01A6836;
	Sun, 21 Jun 2026 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030546; cv=none; b=fCuDyGK9+pgb4THi89ib8wOB+EfihUX0hWKheDDL6LShmY62M2+kZPVaa1Pd/flXDuPvSdu2T0UK91vIhkYSgoQmfQ7ktG/OS5yOVgUe0NksFN62seVHg3kB4FhLqqYQubkLIYDBhLHz9a8dssvMmuLXkTXT9pztu294d0o4eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030546; c=relaxed/simple;
	bh=v8kxL6hcRbJW9BDaY/kEhi7Vq7ZGw8MEE35CkWnWjm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgwqse/b2N3FUodmtUnIf+P3j1U65zBEIzvpIEuHYHGWTW0UZyUgDMA55wnPy7sUSYSnEaVfqSKiTfRShPuzx98jPDNbGmnAvY93nI023qJeW5UKmibZfqaxdmCAVrL1ivIe15A/TICiWx+uAUJSC26NNSNyFreenGnYIlcmDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLLQoiGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLLQoiGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0302B1F000E9;
	Sun, 21 Jun 2026 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782030545;
	bh=rKY1RtU6HFUM0R7fObA2dERuWT/tfwuyau9ZdOZULD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cLLQoiGCDLiVxYv/Sver+iA7+pzMEYjWp9EfOtdukOuSv5DM6HFybrpWpQO5osK/i
	 D18UF3xgAh3ciWVls5NDH2eSzN3suH5p8kAQEi36l5TmKaAfO29zmcss+podi8KNAC
	 wByBjeUYLewKA9IIYBrlDH6WEhZd1hDCxKbz0PQsftP89UYQvF4YN+PEIeu0ktzPJV
	 X0xtDhJhjiHfl+F06D9cgIArkSnOXfenWzmSZ00CK7XX1uF+IjDTra/LCOwBGYcWMm
	 EBscl0adMw+zQ5GhPAwkXkNjkr0Z7Ja/B7l/X29FxGFH6lgrj8XxTtho9EX6MPYcBY
	 +5AFg0BKARf5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/9] mfd: mt6397: Use MFD_CELL_* to describe
 sub-devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260621081634.467858-5-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
 <20260621081634.467858-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 08:29:04 +0000
Message-Id: <20260621082905.0302B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing unregister_pm_notifier() on probe error path and driver un=
bind.
--

commit ad0ff6ef61b51852f825a12aebf3d2e548ceb3dd
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

mfd: mt6397: Use MFD_CELL_* to describe sub-devices

This commit updates the sub-device descriptions in mt6397-core.c to use the
MFD_CELL_* macros. There are no functional changes intended.

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 1bdacda9a933f..ccd97d66d7f1c 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing this driver I noticed
a potential problem in the probe error path and teardown lifecycle.

In mt6397_irq_init() (drivers/mfd/mt6397-irq.c), a PM notifier is
registered:

mt6397_irq_init() {
    ...
	register_pm_notifier(&chip->pm_nb);
	return 0;
}

However, if devm_mfd_add_devices() fails later in mt6397_probe(), the
function returns an error without unregistering this notifier:

drivers/mfd/mt6397-core.c:mt6397_probe() {
    ...
	ret =3D devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
				   pmic_core->cells, pmic_core->cell_size,
				   NULL, 0, pmic->irq_domain);
	if (ret) {
		irq_domain_remove(pmic->irq_domain);
		dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
	}

	return ret;
}

Since the pmic structure is managed by devres and will be freed on probe
failure, does this leave a dangling pointer in the global PM notifier list
that could cause a use-after-free on the next suspend/resume transition?

Additionally, would this same situation occur on driver unbind via sysfs,
since there appears to be no .remove callback to unregister the notifier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621081634.4678=
58-1-l.scorcia@gmail.com?part=3D4
