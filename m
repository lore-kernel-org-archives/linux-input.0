Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D912175A98
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384347; cv=none; b=U90jx28nK0bUS36IdflgEpzELUTxd+rHZzIVMrBKzI2JHSzmDLIWALf7MSDo5JvpiVyVOIVcJdjM3EtC/e4lqE4KCH/DtDQEhbjO5CIUiAGvtlQtT24ciQIOUirja/sD5WXL0y60rtZP2NWJ7r7oVGuF4RfRwmrroWUzCMiwRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384347; c=relaxed/simple;
	bh=QdGMZ3HzOvjLzXgbePwDh0fmOj52nxTV0qHfb61YTBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uXvgWMKPesOXvfyM2e6V7/l6a0UkoIjWus41RPNdVBbXPHLF4NqNrrdcxuQdHc1A8yNMDKJvCW3LacUNlD+AKex5pTcS8kvl6Gir4AMfyTneuEELESJ8JpyubG7cCs7bP6PTdLPOZvuLclpHM+u28ehhseyviG035yeUccYcsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T42FFZaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T42FFZaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C81F000E9;
	Sat, 13 Jun 2026 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781384345;
	bh=ibSr4voJ59nZjstlCY/yPpc6Pj93E9wkwhVSbdONLDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T42FFZaUT4vJUNdG9ATwOjETh/j2lxLsN+5RjrcunVnaBRFSKNOWlZNQrMp76wVUd
	 HsHEJvRPJxiJLpB8ypjvLOjsEbQNCUhMZlrhLiPDPl8OV7w7uWUmBi3FxkajqQq8QE
	 lCwqA8gictYA4Xad9tcjwGTuZEgPmY947d7BP96a9rZ2bt1iGTY5P4n4PzoaWWmTlT
	 jMtp00V5xXrlP9c9/MEWJVeFSKzqLDrZM7Tt6PPTkqb2FhY5l6D5B8KvFtTNgoJGyC
	 ZkuOpHiEew6zYpTHUmbCEOBQmhwJuKEN+khFYXMvqcYdfRS/aSyK3S3bhawaQw8qWG
	 Ol9jkHeOFEd/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06: correct CONFIG_DEBUG_FS macro name
 in comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613205042.80181-1-enelsonmoore@gmail.com>
References: <20260613205042.80181-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 20:59:05 +0000
Message-Id: <20260613205905.AD7C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Imbalanced disable_irq() causes the touchscreen to remain disabled=
 after resume if suspended while in factory mode.
--

commit c833a423ddc21c60c7ceaf7761d2c4e876b25fee
Author: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Input: edt-ft5x06: correct CONFIG_DEBUG_FS macro name in comment

A comment in the edt-ft5x06 driver incorrectly refers to CONFIG_DEBUGFS
instead of CONFIG_DEBUG_FS. Correct it.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index d3b1177185a3b..410be061965ec 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -825,7 +825,7 @@ static void edt_ft5x06_ts_teardown_debugfs(struct edt=
_ft5x06_ts_data *tsdata)
>  {
>  }
> =20
> -#endif /* CONFIG_DEBUGFS */
> +#endif /* CONFIG_DEBUG_FS */

[Severity: High]
This is a pre-existing issue, but I noticed an IRQ depth imbalance that
causes the touchscreen to remain disabled after resume if suspended while in
factory mode.

If the device is placed into factory mode via debugfs,
edt_ft5x06_factory_mode() calls disable_irq(), increasing the IRQ disable
depth to 1. During system suspend, edt_ft5x06_ts_suspend() unconditionally
calls disable_irq(), increasing the depth to 2.

On resume, edt_ft5x06_ts_resume() calls enable_irq() (reducing depth to 1),
but then it invokes edt_ft5x06_factory_mode() to restore state:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_resume() {
    ...
    if (tsdata->factory_mode)
        ret =3D edt_ft5x06_factory_mode(tsdata);
    ...
}

Because edt_ft5x06_factory_mode() unconditionally calls disable_irq()
again, the depth goes back to 2:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_factory_mode() {
    ...
    disable_irq(client->irq);
    ...
}

When the user later switches back to work mode, edt_ft5x06_work_mode() only
calls enable_irq() once. Does this leave the IRQ permanently disabled,
making the touchscreen entirely unusable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613205042.8018=
1-1-enelsonmoore@gmail.com?part=3D1
