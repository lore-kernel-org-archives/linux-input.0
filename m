Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74838837F
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689411; cv=none; b=X2xkAmV7wW8TDIKc6ZkODxukh8Uq/Gal7S5XImdXo0CsxKrOCfFFEwHoFzkqmIj6uo0RqllmQZmIU+SYV42Mi9RLJFnBVwn0gQZoaT5p5RvqBCwJWzLuxjwpd7wXCc0ed4yeUoCEak41R0Z76wtGA5M/Hb57/4JgWyPXHUZKb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689411; c=relaxed/simple;
	bh=mHT50Wv4OQ+BhKjsRd+nxJd4BBBzIMccPneD3PppYP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxLKq2h/TrPUwwGlvrONmuCvlGAmcB6Dz0D7U1BHpaGt5qkgxmVpJRh6i7u9CRP5P+VGqIscNVgOIF5DenLfV4BnRgZ29C/Z9GnCFs0W04y25PqMyMl+5y38oEAi7lP4x1oSTWAaWaeISuHA079VmVlKyANs7eeN4GyDROSgBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIH98A+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIH98A+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7621F000E9;
	Wed, 22 Jul 2026 03:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784689409;
	bh=l7Q3tnU/P+qSSVoqJYRG/W3IdEnbPhc6bpon3p2X1e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIH98A+j6D1niLDHEqiRclWcP+BdS1cGklnThbdxuHub148HquYrtfu+6bIw4xvFb
	 pWAo/4yjZoCyTbrfEzFOoAMK7rg456hSBHJK0PrkMHtCsysh/O0uzPJZw7cwj/CTxV
	 DMl21XXP+hi8I9ppOdjo6MsBuXtVX2MZOh3/4HDku01fHfMTe5nismS3FfFQBAdakl
	 2NbeVNLhc5lhJJQXghv2Kxa6+w4cmBU0GnEb4v+jUdw2iQExCUJTGQKIR9C1HAtDga
	 Srf+EfRSftJqi+o19zhgMPZzvNoODX8enpN2SqzQOG2Fd2Ch9rcOWPySd/lcBbkmzl
	 7GzAKnnN/NvKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: wm831x-ts - drain pen-down work at teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260722024518.3253280-1-fanwu01@zju.edu.cn>
References: <20260722024518.3253280-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 03:03:28 +0000
Message-Id: <20260722030329.6F7621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free / Lifecycle Bug due to devres and manual IRQ teardo=
wn mismatch.
--

--- Patch [1]: [PATCH] Input: wm831x-ts - drain pen-down work at teardown -=
--
commit 084d696661fe76ff6ec20cb061d22484763d2522
Author: Fan Wu <fanwu01@zju.edu.cn>

Input: wm831x-ts - drain pen-down work at teardown

This patch explicitly disables the pen-down and data IRQs and cancels the
pd_data_work before freeing the IRQs in the error path and during device
removal. This aims to fix races where the work might run or be pending
while the IRQs are being freed.

> diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchs=
creen/wm831x-ts.c
> index 98f8ec408cad6..7057720256487 100644
> --- a/drivers/input/touchscreen/wm831x-ts.c
> +++ b/drivers/input/touchscreen/wm831x-ts.c
[ ... ]
> @@ -378,6 +382,10 @@ static void wm831x_ts_remove(struct platform_device =
*pdev)
>  {
>  	struct wm831x_ts *wm831x_ts =3D platform_get_drvdata(pdev);
> =20
> +	disable_irq(wm831x_ts->pd_irq);
> +	disable_irq(wm831x_ts->data_irq);
> +	cancel_work_sync(&wm831x_ts->pd_data_work);
> +
>  	free_irq(wm831x_ts->pd_irq, wm831x_ts);
>  	free_irq(wm831x_ts->data_irq, wm831x_ts);
>  }

[Severity: High]
This is a pre-existing issue, but does freeing the IRQs here lead to a
use-after-free when the input device is closed during devres cleanup?

Because the input device is managed via devres (allocated with
devm_input_allocate_device()), the input core will automatically unregister
it after wm831x_ts_remove() returns.

If the input device is held open by userspace while the driver is unbound,
the unregistration process will call the device's close callback. That call=
back
operates on the IRQs that have already been freed:

wm831x_ts_input_close() {
    ...
	if (wm831x_ts->pen_down) {
		disable_irq(wm831x_ts->data_irq);
		enable_irq(wm831x_ts->pd_irq);
		wm831x_ts->pen_down =3D false;
	}
    ...
}

Calling enable_irq() on an already freed IRQ can drop its depth to 0 and
unmask it without an action handler, leading to an IRQ shutdown and a loud
kernel 'irq X: nobody cared' warning. In a shared IRQ environment (like an =
MFD),
could this disrupt other devices sharing the same line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722024518.3253=
280-1-fanwu01@zju.edu.cn?part=3D1
