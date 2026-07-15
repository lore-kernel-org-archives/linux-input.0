Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69755438491;
	Wed, 15 Jul 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108559; cv=none; b=CdRRraTaSi9fEirXaSxnBrIIj3Lvtmejorko+YaPFmZlmjDsDi+uilOb+OJ1z11hlNLEV9hh+1XiTZyu9r/4ZpotcZFr2yCP5nykZVYjFIXDN4YIbQknr6FRsILOhwGoSdUbNjs04kK6GoqQQgolzwooDf+QxkI0zjNmZaQR3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108559; c=relaxed/simple;
	bh=RRUkS+kgcz2rb5DUSYhe/shcSy/nQStie/tyDv6qSYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bJzBuXy0nauu7tSFqH4tav3877aUw8axAX1AQF96luMy/bmx4x+h//P+k3t5jaOO7Ivhah7ofZph45OXMrRRyW+tTVXSp6yLTXOHfS8/l2VJsqwIFGHJzqRWoJo2I9f8AdEGd3G4GWg2gN7NY0t+vS0vJg18oxiJvs9Mnrvtr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8DQDKvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8DQDKvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498111F000E9;
	Wed, 15 Jul 2026 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108550;
	bh=h2FWIOjW7fgAt6jQDo4F5L/M4obAfczmzg0iZWcd10M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8DQDKvYNGIqhO8SujSEqX60A0SMZZY934UPxBpz6pVCxEZetJyy1p4YKh67IhFEx
	 czPuzNLOepKzC41otv5GFwgttcO8ZhhvZRkYYV7ALOKRDJWmQeT1F/nc48q4/Wa8p9
	 f6P0jfA2dXvVKy2wo5RYYJ+ZM/d4fCyfvidJkhGBx28ftLLhZctCeSr2QC4XDjmcxD
	 L5pnjefKg8KlkfUn1aGpFRRKEGDmZLR9+T2kFg0xeLWf8SH+9AljzOQC+KJdr/vF8G
	 Ei7bWsNPsXxFJculfD6no09xiQlCwJaDx3TtetTCi0LVB+cwVutH9GkikkeZk2WbIU
	 q4oFULBreCnJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] Input: snvs_pwrkey - propagate error code of
 platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: linux-input@vger.kernel.org, Frank.Li@kernel.org, dmitry.torokhov@gmail.com, imx@lists.linux.dev
In-Reply-To: <20260715-b4-pwrkey-v5-2-07e7353c319e@oss.nxp.com>
References: <20260715-b4-pwrkey-v5-0-07e7353c319e@oss.nxp.com>
 <20260715-b4-pwrkey-v5-2-07e7353c319e@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:42:29 +0000
Message-Id: <20260715094230.498111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver uses `dev_pm_set_wake_irq()` and `device_init_wakeup()`=
 during probe but provides no `.remove` callback to clean them up, causing =
a resource leak and permanently breaking driver rebind.
- [High] The driver ignores the return value of `regmap_read()`, leading to=
 the use of uninitialized stack variables which can trigger spurious system=
 shutdowns.
--

--- Patch [2]: [PATCH v5 2/4] Input: snvs_pwrkey - propagate error code of =
platform_get_irq() ---
commit 353345395cd42cd8e38b32a7bbc24dfad430ba99
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - propagate error code of platform_get_irq()

This commit updates the driver to propagate the actual error code from
platform_get_irq() instead of hardcoding -EINVAL. This ensures probe
deferral and other diagnostic information are preserved.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index 8cc6863d26ed8..d58bbbe9fd58f 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -148,7 +148,7 @@ static int imx_snvs_pwrkey_probe(struct platform_devi=
ce *pdev)
> =20
>  	pdata->irq =3D platform_get_irq(pdev, 0);
>  	if (pdata->irq < 0)
> -		return -EINVAL;
> +		return pdata->irq;
> =20
>  	error =3D of_property_read_u32(np, "power-off-time-sec", &val);
>  	if (!error) {

[Severity: High]
This is a pre-existing issue, but does this driver leak the wake IRQ upon
unbind?

Looking at imx_snvs_pwrkey_probe() in drivers/input/keyboard/snvs_pwrkey.c,
the driver sets up a wake IRQ:

    error =3D dev_pm_set_wake_irq(dev, pdata->irq);
    if (error)
        dev_err(dev, "irq wake enable failed.\n");

However, there is no corresponding .remove callback in the platform_driver
struct (imx_snvs_pwrkey_driver) to call dev_pm_clear_wake_irq() or
device_init_wakeup(..., false):

    static struct platform_driver imx_snvs_pwrkey_driver =3D {
        .driver =3D {
            .name =3D "snvs_pwrkey",
            .of_match_table =3D imx_snvs_pwrkey_ids,
        },
        .probe =3D imx_snvs_pwrkey_probe,
    };

If the driver is unbound via sysfs and rebound, does this leave a dangling
wakeup source and cause the subsequent bind to fail with -EEXIST?

[Severity: High]
This is a pre-existing issue, but can unhandled regmap_read() errors cause
spurious system shutdowns?

In drivers/input/keyboard/snvs_pwrkey.c, imx_snvs_pwrkey_interrupt() reads
the status register without checking the return value:

    regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
    if (lp_status & SNVS_LPSR_SPO) {

A similar pattern exists in imx_imx_snvs_check_for_events():

    regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
    state =3D state & SNVS_HPSR_BTN ? 1 : 0;

And also in imx_snvs_pwrkey_probe():

    regmap_read(pdata->snvs, SNVS_HPVIDR1_REG, &vid);
    pdata->minor_rev =3D vid & 0xff;

If regmap_read() fails due to a clock glitch or bus fault, won't these
stack variables remain uninitialized? Could an uninitialized variable
randomly evaluate to true and be interpreted as a button press,
immediately propagating a spurious power key event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-b4-pwrkey-=
v5-0-07e7353c319e@oss.nxp.com?part=3D2
