Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8563C13E3;
	Sat, 12 Sep 2026 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249334; cv=none; b=RRfCGyhmTA7pDGExAmDzAl7eyEou9qsBbE4mlWw4eyYZ9qV0sOabGxkWPnhcYRUnL2viAnU6k+yY6oNZJ1Yupm4qx9PXs3PA6ECa6u7o3L1X1UhbTjIt0mqL4NEpo8z+Wxmm43PIHyBF7j1jMssC2kQpmmoMjMA5qG6Q1wjJyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249334; c=relaxed/simple;
	bh=GhaQwB+1++tiykO6ZXhyXoegTUqxSpNxY4kPhmzybvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b23Vb3anGzhrOLLKuFTTnOzwLTIWZVU1wxt5TuZL86mn6XoRzcfwJxKztlDsmNpqsFG6FTwJTiidDjMVsVpxdAbY3oVLd1pd6YQF1HfxpicUQUW4jXAg8PsM9797yJlIrIAMeR+asSxgPh6KnKUfXy7u3SU3nb6tIorPlStMEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VndFmp3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VndFmp3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACF91F000FF;
	Sat, 12 Sep 2026 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789249333;
	bh=7VRhvJe97XnlNmG6hQSJ3a40Q3iSFPzzB8UQSOCem00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VndFmp3o1wnFhXqAKscIZgeYI+xcfLM91rnxmhlXCw8aWKxCJKt0EHPuwfmsUgsEd
	 Ux4Jz6fNtA50G0jiuusBGxb6iGeyN7ISolMsNoG+8Vq48ci205uHZDHUgTtlif4ndl
	 J0AAmzqot8rBqGb3kfWNtOXRtaFeIFIhybvf6Mlw2SZykeYMCNS81v4vDzcU1QV30U
	 9eJC4s7cILumuw72RGwwv6n+hOBfmn14ZHCedXPFi+jEWoGWZMFIX1TuM6FA3oh93p
	 i2bMhkwk+gQFjdLKDkZIQAZplfVaeV9O5hgvIhTb+JK0r2CggIxjifi0FQJe4N+ZM0
	 fTSnceJkmNr8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-upstream-gpio-wakeup-v1-2-f0e12484b836@ti.com>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-2-f0e12484b836@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 21:42:12 +0000
Message-Id: <20260912214213.0ACF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing restoration of default pinctrl state on error path in gp=
io_keys_enable_wakeup().
--

commit 794b05f8c21f23224e4ff7b076c2d675310e6432
Author: Kendall Willis <k-willis@ti.com>

Input: gpio-keys - support wakeup pinctrl state on suspend

This commit enables GPIO controllers on TI K3 AM62 devices to act as a wake=
up
source during suspend to RAM by selecting a wakeup pinctrl state and restor=
ing
the default on resume.

> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/=
gpio_keys.c
> index 129fc4212a5ed..b409e17970519 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c

[ ... ]

> @@ -1010,6 +1017,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *d=
data)
>  	int error;
>  	int i;
> =20
> +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> +		pinctrl_select_state(ddata->pinctrl, ddata->pinctrl_wakeup);
> +
>  	for (i =3D 0; i < ddata->pdata->nbuttons; i++) {
>  		bdata =3D &ddata->data[i];
>  		if (bdata->button->wakeup) {

[Severity: Medium]
Does the error path in this function need to restore the default pinctrl
state?

Looking at gpio_keys_enable_wakeup in drivers/input/keyboard/gpio_keys.c,
the pinctrl state is changed to wakeup at the start of the function.
However, if gpio_keys_button_enable_wakeup fails for any button, the code
jumps to the err_out label:

err_out:
        while (i--) {
                bdata =3D &ddata->data[i];
                if (bdata->button->wakeup)
                        gpio_keys_button_disable_wakeup(bdata);
                bdata->suspended =3D false;
        }

        return error;

Since a failure here aborts the device's suspend transition, the PM core
will not invoke the corresponding resume callback. Could this leave the
hardware pins stuck in the wakeup configuration instead of reverting to the
default state for normal runtime operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-upstream-g=
pio-wakeup-v1-0-f0e12484b836@ti.com?part=3D2
