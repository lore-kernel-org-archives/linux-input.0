Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D76246BD5
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189840; cv=none; b=QMHB6eo3NarCRp/JitAyGrM0wR1R0FCGB+3GxNnti6Hh2+Kafd8zc3t7/X5B9CAkebLk3pKNAryLFMbXnE9ftgKPBMUo5pS4I4HCnugLVp7JfunDh/a2HGeSWoPiybMte/QLeZlznl4PWq9aeZttqH8y15kxnrmx9rmS6BFmKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189840; c=relaxed/simple;
	bh=X19FsDYIMLT1lkSqcvcA5oY3H0tQ3BfrSn0siWu3TKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYLxBzrBjK6BsyLx7FnNZHddGpfU2lgihciHf0OxbBpooVrDiL0p/LMqSAonqtrZHP5jyhViSKh3Lwa8XEZ3QwVC5xwQoFRrCJ4fWqK5GnxthEKaY/oPOm81NMz1ZOKopCpe/nsvVEGa9BjS+VZqS+Uwzr1/qynyOy6IRVSlZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuK/yZD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuK/yZD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E307D1F00A3A;
	Thu, 16 Jul 2026 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189839;
	bh=RyDOziSOXy2VpUNP3lOox5bw2tpvb+UgK9TYalOLzIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CuK/yZD9640Fsy+22jqSzR4LvQAz9WsknW3q80MAbnflcs0BEUUpAuQ5y8qZORNjd
	 J1gIITLDGfmhxbE8hs7Pb/TvEWFLN+p77j2nmRg/vG6Z9T5jQXeVkf9h6MQ/ussKeh
	 MldfGOGGP73OhGj4k3uBJvLvB6M836mgUZWiAaCKNexduzqH9658d3XcI4K6aZq3UY
	 kBX0kwcrvDGM8Njc4mLE27ZR14hNEqkZ/g2Sy7DtavzDpAAcH0/eJY/7gNlNykes+v
	 BFR1A4QMVWKjL3HCyCYytOL5UMKRiAW4JXKjZ7vfr6iraY//FZW4F9n7DxhxZoD/4l
	 rFse0EQJqH6fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: intel-ish-hid: ipc: Remove redundant
 dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260716075203.593012-4-panchuang@vivo.com>
References: <20260716075203.593012-1-panchuang@vivo.com>
 <20260716075203.593012-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:17:18 +0000
Message-Id: <20260716081718.E307D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing call to `pci_free_irq_vectors()` in the error paths of `is=
h_probe()` after a successful `pci_alloc_irq_vectors()`.
--

--- Patch [3]: [PATCH v2 3/4] HID: intel-ish-hid: ipc: Remove redundant dev=
_err() ---
commit e6d17c39d85bf24754ef698f7e6d06f53c4283e2
Author: Pan Chuang <panchuang@vivo.com>

HID: intel-ish-hid: ipc: Remove redundant dev_err()
   =20
Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-=
ish-hid/ipc/pci-ish.c
> index ed3405c05e73c..cef1030643f15 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -232,10 +232,8 @@ static int ish_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
> =20
>  	ret =3D devm_request_irq(dev, pdev->irq, ish_irq_handler,
>  			       irq_flag, KBUILD_MODNAME, ishtp);
> -	if (ret) {
> -		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
> +	if (ret)
>  		return ret;

[Severity: High]
This is a pre-existing issue, but does this error path leak the IRQ vectors
allocated earlier in ish_probe()?

If devm_request_irq() fails, the function returns directly. Similarly, if
ish_init() fails further down in ish_probe(), it also returns directly:

    ret =3D ish_init(ishtp);
    if (ret)
        return ret;

Should there be a call to pci_free_irq_vectors() in these error paths
since pci_alloc_irq_vectors() was successfully called previously?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716075203.5930=
12-1-panchuang@vivo.com?part=3D3
