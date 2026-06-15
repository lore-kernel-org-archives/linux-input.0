Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B473BFE3A;
	Mon, 15 Jun 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510341; cv=none; b=PpBqXMuMq4JSeAX0ja00EK6lV1G8S/VRpvzltu9EmBt3kBIuZD4zkTKkvwZVv9d1Gnt7zjGfkZXCcgepTdtELR9BRjJu0d3NhsktmhC7QATRqEg3ABTClsLYihLPjHSdw9qeezVdGUzYBIULA/81/WtjNYfkXjyviINZx5q5ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510341; c=relaxed/simple;
	bh=mOrk8UR0O5zWBLwAmV1fTOqOG//c/qI4dVxeyhgumvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vCNHzNKeDWuySqFwjwcu1qKgaPVcbLOiMea9oS/bx2kf2TQf0c7Ie1eOXe0RQ6dnxB6uIYeX9O+t81Eerqr6VahLyD2kzZhkktw4GJJMpB7GbVfIC3IGDz8c4SNBlK+w4nhw4A1YAhigmyREFV3aR//vX/vSlV2bVBhAnPY8nCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZEej6Sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZEej6Sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEFC1F000E9;
	Mon, 15 Jun 2026 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781510339;
	bh=oqqQ+vGn9qm2ONhgdKz7ldcPO9q2QhchQ2x6NZ8napQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZEej6Svga7tnOpkkRHGkqNxlKV5c/hgGS8GRe5/JFS6ayo6ZRnfTIYfU7LB2ybye
	 hSDWmAENNHmLksqO+C6hz05mZLBc+AByQ6Qv60gMwS35Uten3aegIxV/iupLSP8XZ7
	 20wyzA6osmnq8a6BMarNUs65w6cCSaDVRQ5hmrS6sl3kxrUO6yF4tVyidtdU0yowI9
	 1YuU04EGHCHuEPHRtcYn0Zb5nlMnsmBtGUfY9TZhR17IcW8Ohq8lDzsbdnfl7QkRCE
	 7+wVyZdTnDa3SdBqsQwFnqpKBhfuz5vSelXqq5MEGjJsfUrmgTQLu0TWsAQ38tAvFC
	 kgr9ce8mwf0xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] Input: snvs_pwrkey - replace hardcoding -EINVAL
 with original error code
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260615-b4-pwrkey-v3-2-9510b1173f6e@oss.nxp.com>
References: <20260615-b4-pwrkey-v3-2-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:58:58 +0000
Message-Id: <20260615075859.4DEFC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup for dev_pm_set_wake_irq() causes memory leak and s=
tate corruption on driver unbind.
- [High] Systematic failure to check regmap_read() return values leads to c=
onsuming uninitialized stack memory, risking spurious system shutdown.
--

commit d2ee00e9f90457779e6f0d87a01d54e5af524f82
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - replace hardcoding -EINVAL with original error code

This commit replaces a hardcoded -EINVAL with the actual error code returned
by platform_get_irq(). This preserves valuable diagnostic information and
allows probe deferral (-EPROBE_DEFER) to work correctly.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index 748196fcce75b..a291812e6d22e 100644
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

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential lifecycle regression
further down in imx_snvs_pwrkey_probe():

drivers/input/keyboard/snvs_pwrkey.c:imx_snvs_pwrkey_probe() {
    ...
	error =3D dev_pm_set_wake_irq(dev, pdata->irq);
	if (error)
		dev_err(dev, "irq wake enable failed.\n");
    ...
}

The driver configures a wake IRQ using dev_pm_set_wake_irq(), which
allocates a wake_irq structure and attaches it to dev->power.wakeirq.
However, there doesn't appear to be a paired remove callback to call
dev_pm_clear_wake_irq() during driver unbind.

Does this permanently leak memory if the driver is unbound via sysfs?

Additionally, since the underlying IRQ is managed by devm_request_irq(), it
will be freed on unbind while dev->power.wakeirq remains configured. If the
system later attempts to suspend, could the PM core evaluate
device_may_wakeup() (which remains true since device_init_wakeup() isn't
reverted) and call enable_irq_wake() on a freed IRQ?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I also noticed that
regmap_read() return values are not checked in several places before
consuming the variables passed by reference:

drivers/input/keyboard/snvs_pwrkey.c:imx_snvs_pwrkey_interrupt() {
    ...
	u32 lp_status;

	pm_wakeup_event(input->dev.parent, 0);

	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
	if (lp_status & SNVS_LPSR_SPO) {
    ...
}

It also happens in the timer handler:

drivers/input/keyboard/snvs_pwrkey.c:imx_imx_snvs_check_for_events() {
    ...
	u32 state;

	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
	state =3D state & SNVS_HPSR_BTN ? 1 : 0;
    ...
}

If regmap_read() fails (e.g., due to an underlying clock enable failure or
MMIO bus error), it returns an error code and leaves the target stack
variables (lp_status, state) uninitialized.

Since these uninitialized stack variables are then used in logic checks,
could this lead to unpredictable behavior? For example, in the interrupt
and timer handlers, if the uninitialized stack memory randomly has the
SNVS_LPSR_SPO or SNVS_HPSR_BTN bits set, would this trigger a spurious
KEY_POWER event and an unintended system shutdown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-b4-pwrkey-=
v3-0-9510b1173f6e@oss.nxp.com?part=3D2
