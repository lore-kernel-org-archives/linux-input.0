Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288341C2F2
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949699; cv=none; b=QQDqKwAKO5SdQaA9XHfZvt5yQNT6Mu8VwriwnU4PLLc3t4mkWluu5iWQ9icURxxHCLHDmHwg5gtfRf85hHgJWVOyxAkDJZ0yJG5gZBgkAwmAcVS937kpyowiJQybaoKfBC+udq/DV/2hr5cqKjzv0D330QTV44uuDgsroowT2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949699; c=relaxed/simple;
	bh=y48Zq2hMn2ASa8LuMhwsKDTxTGKrgkwYJ5as16s2REY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AI+3CAOEHBPCB3oqN5Vf/DFKel0oLh9PTjHAmVD1UkSajL4+lq3NXsS6uzaKPnXhqt0Uk68AuQ9hNT62WFRaQVkvjkIL48Ls7nhv1qSpvEl66UqC21Ef7qNbKXO+w3TeHLJ1JFQI41YNEvR6+P4KY1UBw2MBIXo/QcPFiQV6xqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVJEOm9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVJEOm9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB9E1F000E9;
	Mon, 13 Jul 2026 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949697;
	bh=/2orIoVJl+6DXyQZd1Rsa4e7nCEkeVNOxPSpWcT6kOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVJEOm9N4iI9j47oC22Rqi+Fl4NKDJVnkLLmnPNWyBd2o9+ODtlwWH+cis7/KkPnX
	 DqFQ5ICScRtm/EG3r5/3h78nknBnJ/JEePsoNuSaP6GbJBZy3LPx0BV/9Z4M02O7PO
	 EiQ9YcA8woxqkXs1zSnskGhPWkDtKjupswNKJ4bfV4/Rgvwsa73GLj9V2/RiQKM8+x
	 agFpkCN8Sxl3oJoO8THA6NgzjIpT7DAb/noBAPjHn1hq3WN7KMhSX0j/fojWVG+50m
	 lGgBfZZEr47TpgVTpWFG+Tlh2nK+WnuLgkF1BWY3gyyWeZFy0pEK2m8fbArsNQ0RR8
	 atKYj9Xjs8uKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: amd_sfh: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713132439.380121-2-panchuang@vivo.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
 <20260713132439.380121-2-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:34:57 +0000
Message-Id: <20260713133457.AEB9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver requests a legacy PCI interrupt without the IRQF_SHARED=
 flag and unconditionally returns IRQ_HANDLED.
--

--- Patch [1]: [PATCH 1/4] HID: amd_sfh: Remove redundant dev_err() ---
commit 545a05506a276434e2b80762c55fb8e2b1f6fc64
Author: Pan Chuang <panchuang@vivo.com>

HID: amd_sfh: Remove redundant dev_err()

This commit removes a driver-specific error logging call after
devm_request_irq() because the core API now automatically logs detailed
error messages on failure.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index 4b81cebdc3359..a2acd3ca20e2c 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -128,11 +128,8 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
> =20
>  	rc =3D devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
>  			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);

[Severity: High]
This is a pre-existing issue, but does this code need to handle shared
interrupts?

Since this requests a legacy PCI interrupt (INTx) with irqflags=3D0, it req=
uests
exclusive access to the IRQ. If the interrupt is routed to a shared line wi=
th
another device, will devm_request_irq() fail with -EBUSY and prevent the
driver from probing?

Additionally, the interrupt handler unconditionally returns IRQ_HANDLED:

drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:amd_sfh_irq_handler() {
    amd_sfh_clear_intr(data);

    return IRQ_HANDLED;
}

If this driver successfully claims the IRQ first and the line is shared,
would this unconditional return erroneously suppress the kernel's unhandled
interrupt detection for other devices on the same line?

> -	if (rc) {
> -		dev_err(&privdata->pdev->dev, "failed to request irq %d err=3D%d\n",
> -			privdata->pdev->irq, rc);
> +	if (rc)
>  		return rc;
> -	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713132439.3801=
21-1-panchuang@vivo.com?part=3D1
