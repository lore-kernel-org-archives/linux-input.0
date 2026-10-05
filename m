Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254053AFD04;
	Mon,  5 Oct 2026 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233928; cv=none; b=M4ky7G0+nzIFknk6JwGHAL04jbd7+4w2zTfoFJZY4WY8GDhoNOwneYrk18d4jJZG5acZdfL7cVxZkm1Dm1+56/DcjEvFu1BieNflyfc4P73ZgQZRYEq8VegLsjnzZ8+zBY9E5vDamJood4Oe2JHTSrQEs75HR8fcDf63w5CopRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233928; c=relaxed/simple;
	bh=cWJzSeEgUOn1fONEJPm2yXbwWmEZyxZDe8jtE/MKm38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=skq1/eRAjUjgVDGQU2MlZWh5iQXa/o8GIOb8vU/2U2d+CnQ+sbTjwNt3v333kFFC/DC6LMKUWyLdanVl404SULrP23ybPdUalUi0gnY5+HEjy32qr4779c393CWbiprxa4W52Yn4ctrxQy5RU4mweVVGJ6WgIxMIvJrbaSlwD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b681qA/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b681qA/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7A51F000FF;
	Mon,  5 Oct 2026 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233924;
	bh=JkZHWJeytLHBVcPXej5UorMm99ervEZMmFzmf5ZWoXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b681qA/mWzMXKxJ7SqKiLJ8TC5gSUiyyaQMbq8NvSdfckbdpnSFcdt2rs2ZKQUlA5
	 FjUPSGxwZvw6tKtNiEIKjkSWi2DMiKdN4P9koJj8o033oOG8NcFtrY9W/0da+k7Zo0
	 WiZRiwkTApTZioPkdrfn+sa5Kh4TONlk4OXYY+ckA6qN/WF0t3LyVc2VIVUYsLUWRy
	 wZbCr0gpqkq7+0G5hvFu7hAul9CwvB8AOABrE4RW1mViUxVh+cOBdm94NUhE+ima/g
	 9nYhbEu6BTsrhY4CQFLyhzmvlScJa2KpdDc0I2m/Gjfq7/0kl7uPXdlDlhZ/H1wlmq
	 2KUvjcgmkpAyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] Input: gpio-keys - support wakeup pinctrl state
 on suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261005-upstream-gpio-wakeup-v4-2-96f092de4690@ti.com>
References: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
 <20261005-upstream-gpio-wakeup-v4-2-96f092de4690@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:58:43 +0000
Message-Id: <20261005205844.2A7A51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: spurious key press on resume due to LIFO violation in pin=
ctrl teardown
--

commit 77748a917235cbadd6477449603ad11920308ecf
Author: Kendall Willis <k-willis@ti.com>

Input: gpio-keys - support wakeup pinctrl state on suspend

This commit adds support for selecting a wakeup pinctrl state on suspend and
restoring the default state on resume for GPIO devices. This enables wakeup
support on certain platforms where the GPIO controller is powered down duri=
ng
suspend.

> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/=
gpio_keys.c
> index e196174856796..b8ecaaded6a44 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
[ ... ]
> @@ -1022,6 +1042,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *d=
data)
>  	return 0;
> =20
>  err_out:
> +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> +		pinctrl_pm_select_default_state(ddata->input->dev.parent);
> +
[Severity: Medium]
Could this error path in gpio_keys_enable_wakeup() in
drivers/input/keyboard/gpio_keys.c trigger a spurious IRQ?

The default pinctrl state is restored before the successfully configured
wakeup IRQs are disabled. If switching the pinctrl state causes a glitch
on the GPIO line, an IRQ might fire prematurely.

>  	while (i--) {
>  		bdata =3D &ddata->data[i];
>  		if (bdata->button->wakeup)
> @@ -1038,6 +1061,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *=
ddata)
>  	struct gpio_button_data *bdata;
>  	int i;
> =20
> +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> +		pinctrl_pm_select_default_state(ddata->input->dev.parent);
> +
[Severity: Medium]
Can this ordering in gpio_keys_disable_wakeup() in
drivers/input/keyboard/gpio_keys.c inject a spurious key press on system
resume?

On resume, gpio_keys_disable_wakeup() restores the default pinctrl state
before disabling the wakeup IRQs and clearing bdata->suspended. If the
pinctrl state transition causes a line glitch, the IRQ fires while
bdata->suspended is still true.

The IRQ handler then sees bdata->suspended is true and explicitly
simulates a key press to handle transient wakeup events. If this key is
mapped to a power or sleep button, it might cause the system to immediately
re-suspend or power off.

Should the default pinctrl state be restored after disabling the IRQs and
clearing the suspended state to maintain a strict LIFO teardown order?

>  	for (i =3D 0; i < ddata->pdata->nbuttons; i++) {
>  		bdata =3D &ddata->data[i];
>  		bdata->suspended =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-upstream-g=
pio-wakeup-v4-1-96f092de4690@ti.com?part=3D2
