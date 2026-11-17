Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923193;
	b=e20Pyqz0E+jeHzY1SHYef2kwlz8fqhWjQQCSEioKDYxSZ52BEb5M2FdxYgYBojShM22G
	 l2M73zxWJW69M+YrfBHfwz9uDNEv6WI8Sz7yxPlCdMEAPAKYiRqyYatzOWujaqc+XH5H/
	 YB74NQ8sOTLXKF1uvFqKyLesV7iKhvSgK1hkymrVAd4nnXaI7+XqhtiaaXHVMSvwKu75K
	 r1gsM/BnjhWWMV8Hr+q08GwVqeLgm87J7V4zZyYMENLsKVu2RCNY8zKX4JHBKA3SahbMi
	 1zB6WiXJIcg8OJnavgXBquhKvdIVQFZGtoeWD6KdNIpcGyAnDBScnl9ddwKO/DSQA+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923193;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LP94j3UlsH7aCoih1Uuu8wTFC9ZoMGfhYizU9HKsF+A=;
	b=CPcbGXq7Rgv+An+Bt+4d/lNESsFwtgyW0y0guDmdVpTMPE6fZki/BEiEeVB8WZwzOgq0
	 AMLH+iBah3Z7H3g3Pipg6aIuGPNiTf6YO7qy3/Ojbv7ohnHSCnHdYf2yEgN26M8PSYhfO
	 CM1Eykah6ZTUqGp/viSeRvIwyzBC7sboGnYBLe6FpuyVj5g3tOVbkmBo3TtsYJvHXJg1Y
	 jk4FoF9wKhPLJvctxvtrfnzHNQ3LjFQe3ckZIV7BxBKj1pXvihBR8VB6BgzWjj0Y3T2eU
	 UQPW9rr7xrUHR3vhM6J2W69Vr+ioZXaoJciI73rbkuZuYtIN8LYniuzX3kun3hkE97A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MG6/i1af";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417C606A329;
	Tue, 17 Nov 2026 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MG6/i1af
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278B91F000C4;
	Tue, 17 Nov 2026 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923193;
	bh=LP94j3UlsH7aCoih1Uuu8wTFC9ZoMGfhYizU9HKsF+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MG6/i1afZPDMMaCPlKd0YWju1LzBsvlHMehj5DRLGzL3wwuijHGNGKsHeA7xEoMF8
	 jYO8umbiFGQpWRi6f90zyjSyUhHGGI4CfjTDJgFCGU2PBtCqb6TWthLX1esz+xiY/O
	 5wp8wswaNplAcmZVvIvZDR2GmZ0IZprHTN/bGxL3hJH2A3utMdiqmmPrHu2SSyrpW8
	 VTYFdy5UUqFVfWvdwlgBZHfwMhfgXDkyj+B1tJozueSkAmxRP+5d7CgI9JJDgcAwZg
	 XHST6bGeAp0sgp01AFoO9OLhgy5ypEt6yY921u6tGkWotB3UtiROJNsXWrD0h5cRpt
	 X31etdBhoj8Yg==
Message-ID: <sashiko-outbox-218902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/6] mmc: sdhci: add SiRF AT550 programmed-I/O
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: yy-Local-LLM <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117-at550-rfc-v1-v1-5-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-5-5879573cb825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:46:32 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] mmc: sdhci-at550: non-real identity in Signed-off-by trailer
- [Low] mmc: sdhci-at550: duplicated sdhci-pltfm helpers and premature
  caps check
--

commit 9cd2cf298aedb4fdaa50a3e4221492eb7dc0dfa9
Author: yy-Local-LLM <yogo.0917.sabu@gmail.com>

> mmc: sdhci: add SiRF AT550 programmed-I/O support
>
> Add a platform SDHCI host with PIO because CPU-to-controller DMA address
> translation has not been validated. Reject unsupported
> capability/version combinations and use the current managed host
> allocation API. Board discovery and frequency restrictions are described
> by the DT, rather than forcing removable-SD policy in the controller
> driver.
>
> Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use "yy-Local-LLM", which is a
handle or LLM identifier rather than a real person's full name as required
by the Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst.

> diff --git a/drivers/mmc/host/sdhci-at550.c b/drivers/mmc/host/sdhci-at55=
0.c
> new file mode 100644
> index 0000000000000..100a0fdb2b106
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-at550.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivalenc=
e. */
> +#include <linux/module.h>
> +#include <linux/mmc/host.h>
> +#include <linux/platform_device.h>
> +#include "sdhci-pltfm.h"
> +static const struct sdhci_ops at550_sdhci_ops =3D {
> +	.set_clock =3D sdhci_set_clock,
> +	.set_bus_width =3D sdhci_set_bus_width,
> +	.reset =3D sdhci_reset,
> +	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
> +};
> +static const struct sdhci_pltfm_data at550_sdhci_data =3D {
> +	.ops =3D &at550_sdhci_ops,
> +	.quirks =3D SDHCI_QUIRK_BROKEN_DMA | SDHCI_QUIRK_BROKEN_ADMA,
> +	.quirks2 =3D SDHCI_QUIRK2_NO_1_8_V,
> +};
> +static int at550_sdhci_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host;
> +	u32 caps;
> +	int ret;
> +
> +	host =3D sdhci_pltfm_init(pdev, &at550_sdhci_data, 0);
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if ((sdhci_readw(host, SDHCI_HOST_VERSION) & SDHCI_SPEC_VER_MASK) >
> +	    SDHCI_SPEC_200 || !(caps & SDHCI_CLOCK_BASE_MASK)) {
> +		ret =3D -ENODEV;
> +		return ret;
> +	}
> +	ret =3D mmc_of_parse(host->mmc);
> +	if (ret)
> +		return ret;
> +	sdhci_get_property(pdev);
> +	ret =3D sdhci_add_host(host);
> +	if (!ret)
> +		return 0;
> +	return ret;
> +}
> +static void at550_sdhci_remove(struct platform_device *pdev)
> +{
> +	sdhci_pltfm_remove(pdev);
> +}

[Severity: Low]
Does at550_sdhci_probe() need to read SDHCI_CAPABILITIES and
SDHCI_HOST_VERSION here?  This runs before sdhci_add_host() ->
sdhci_setup_host() -> __sdhci_read_caps() resets the controller and applies
the sdhci-caps-mask and sdhci-caps device tree overrides, and
sdhci_setup_host() already rejects a zero base clock when
SDHCI_CLOCK_BASE_MASK is clear.

Also, at550_sdhci_ops is identical to sdhci_pltfm_ops, which
sdhci_pltfm_init() sets automatically when pdata->ops is NULL, and
sdhci_pltfm_remove can be assigned directly to at550_sdhci_driver.remove
without the at550_sdhci_remove() wrapper.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-at550-rfc-=
v1-v1-0-5879573cb825@gmail.com?part=3D5
