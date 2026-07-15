Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CC306B31;
	Wed, 15 Jul 2026 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108768; cv=none; b=G5OezhOdDuE8pKIrai2v9TEq/E8FHG5vgOvMYjDwmMefrg5LOs9DjPZI+nWrgVUzoytVWoyP4kCqLlwzCzDK6B3zHpADOEjHUa9YMKH5cGA+wWpRnu6ZRvyfBj1l3t2UBWA+YZ7djBbTbgsNX3Z+0Oe2oO/fw6VZ3ReAB5nAyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108768; c=relaxed/simple;
	bh=GzY8e7pSrVUXoPiPhF3VTkDJnIjZdbC1UDyYNRfFvU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ri3XZT8iji9/RM6+lmvtk4S5/M6PFGkQfYklRpMgkv2AMk8lZpvOYgcJj/4RgmFLnj+Rbcsvm0UbP7x8uEQ3hLjtVAos/jx9DS3aqeyapH0LrhuVM+jB3mPSofUX+c+xQag5RG5EqP7XeEcNO3S78Nk7H++TLIpgP4GJ41HiKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts6WInNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts6WInNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619EB1F000E9;
	Wed, 15 Jul 2026 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108761;
	bh=dKw2hYrkyFz1p6xSEuwZ7CLG/ewfpHsSIXXyzqx+Ndw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ts6WInNJUc79jXSSCSMUqznHOLPCuAqTxZN3oFk6ccq7SWT/zH2+gg3ghIXfn61Dd
	 6wiquJTSr3prAAohOAZuZnJZ/OfzoMvPjEs8sDrmQLd5PhOqnwO5UiCPQmF9aEdtYR
	 UOEAuKZ+rNoyhNy01z4Dz2p+aHQvJevDR4pOTUFYMnalKJJX1cUIwB7Az73LnsAM+y
	 6pp0BOKkSxFkGjiXEwEAmxh9k5jIRgZHds/sWrKV9v9EhXfn84Q5r+VqwvLuwFxLDd
	 9X3rY2jZHxQbQljUFvb3s0SiCzQxkDKhxyRQ3Y0jW7Y5HdocIJ99iYS9T5QdvxNnCv
	 wwUF+t6LBwL7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] Input: snvs_pwrkey - add press event reporting
 to avoid event loss during suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: imx@lists.linux.dev, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260715-b4-pwrkey-v5-4-07e7353c319e@oss.nxp.com>
References: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
 <20260715-b4-pwrkey-v5-4-07e7353c319e@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:46:00 +0000
Message-Id: <20260715094601.619EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup for wake IRQ leads to memory leak and device re-bi=
nd failure.
--

--- Patch [4]: [PATCH v5 4/4] Input: snvs_pwrkey - add press event reportin=
g to avoid event loss during suspend ---
commit 0a87e611a13956d492552759681ef44d587017b8
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - add press event reporting to avoid event loss during s=
uspend

This commit introduces a pending_press flag and a spinlock to handle power
key events during system resume phases where IRQs might be disabled. It
ensures that if the key is released before IRQs are re-enabled, a press
event is still reported via the timer callback.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c

[ ... ]

> @@ -217,6 +254,32 @@ static int imx_snvs_pwrkey_probe(struct platform_dev=
ice *pdev)
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed the wake IRQ setup just prior to
this return in imx_snvs_pwrkey_probe() lacks a cleanup path:

	error =3D dev_pm_set_wake_irq(dev, pdata->irq);

Since there is no .remove callback or manual cleanup, does this leak the
struct wake_irq memory when the device is unbound?

Additionally, since dev->power.wakeirq is never cleared, would re-binding
the driver trigger the dev_WARN_ONCE ("wake irq already initialized") in
dev_pm_attach_wake_irq(), potentially causing a system panic if
panic_on_warn is enabled?

Could this be resolved by switching to the managed devm_pm_set_wake_irq()
helper?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-b4-pwrkey-=
v5-0-07e7353c319e@oss.nxp.com?part=3D4
