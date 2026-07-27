Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C83DA7F1
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147756; cv=none; b=sb6hs9GntSbbvSF7UCgNctClGFrHtCH949Mn+ck9BlJEnjwJ4ogTaZjnTW6fVTuU4SnBsPLqsfukSWkD/XNHjcJMulRiiczTx9p4P3oIFtHmzIyj2zbubO3hxKzCkeXLiwmg1D/jLs3QYGYyIO4j77FBRhKT+695omK2oLhIEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147756; c=relaxed/simple;
	bh=4fYek21/W4hsnlFT88YohMlY+hoxoiF0U9uZi0IF77Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K8n0nXzis1Hx8pzNf36UB6qCnqdLjw6Fw9g8lbyBUBBMKcJVugNxRIPutBMCq7qEMZcwqj9lj3BlovT2wyZQHXbuZ74VtxuQ2cHmG12tztDAJXh9YwF4mmo8JWFhtfCPm8l0Wn0u+JUzPs/WcmA8oD+vglVSCZ9BbqrQ6JBnmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6NjtwUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6NjtwUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4257B1F000E9;
	Mon, 27 Jul 2026 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147754;
	bh=0fK2uLUPSiUgA5PWNqVX1cUrmGts6ErFlSyf7kL28w0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6NjtwUnOcKmesDqLq4zwcqX/k+v4hcRuZ4/1iyheMw8PU6sIltd1OhY4+HHRz29X
	 uyCw7m5XXRdIVMYVrLKNvEZ5cBa8Ln7Mf0rpy9cqQnUpLvI1eGFHBlxqHf4aU62Ppr
	 9PVY0GGIpewGyh5PMlibq5xB8FYbkj/sKC5WQ34lOFn5msTfXeG7Yj/UmngYMNlfgF
	 C8aXQz4nXr1RsUKL+ca0/DWBSsIgXB65PSjMuef40q35r1MH24/iiTvGIsQ+gsbvuv
	 LJJt1Dmvq/qZsSHyFFKirQdvx9tQdHZUDSDltQJj2WQ5zCNHX3fJJupNP5CVPqyc3A
	 YnibxUV5s5AkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: snvs_pwrkey: Improve probe error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727101125.28291-1-phucduc.bui@gmail.com>
References: <20260727101125.28291-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:22:33 +0000
Message-Id: <20260727102234.4257B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Direct use of `input_event()` instead of specific reporting helpers.
--

--- Patch [1]: [PATCH v2 1/2] Input: snvs_pwrkey: Improve probe error handl=
ing ---
commit 1bfa57ab7fcf3071071b3cf879e2dfcda7662e49
Author: bui duc phuc <phucduc.bui@gmail.com>

Input: snvs_pwrkey: Improve probe error handling

Use dev_err_probe() for devm_clk_get() to prevent log spam when probe
returns -EPROBE_DEFER. Return the original error from platform_get_irq()
instead of replacing it with -EINVAL. Drop the redundant error message
after devm_request_irq().

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index 954055aaf6e29..fa08ac561bf23 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -142,16 +142,15 @@ static int imx_snvs_pwrkey_probe(struct platform_de=
vice *pdev)
>  	}
> =20
>  	clk =3D devm_clk_get_optional_enabled(&pdev->dev, NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "Failed to get snvs clock (%pe)\n", clk);
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +				     "Failed to get snvs clock\n");
> =20
>  	pdata->wakeup =3D of_property_read_bool(np, "wakeup-source");

[ ... ]

[Severity: Low]
This isn't a bug introduced by this patch, but since you are improving this
driver, should imx_imx_snvs_check_for_events() use input_report_key() rather
than calling input_event() directly?

drivers/input/keyboard/snvs_pwrkey.c:imx_imx_snvs_check_for_events() {
    ...
	if (state ^ pdata->keystate) {
		pdata->keystate =3D state;
		input_event(input, EV_KEY, pdata->keycode, state);
		input_sync(input);
		pm_relax(pdata->input->dev.parent);
	}
    ...
}

The subsystem guidelines suggest using the specific reporting helpers like
input_report_key() instead of generic input_event() when the event type
is known.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727101125.2829=
1-1-phucduc.bui@gmail.com?part=3D1
