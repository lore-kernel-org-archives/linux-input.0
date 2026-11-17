Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922073;
	b=gWcxfm29Rh1Kve5cv6SKuqwdjYsM5voFD/IBzZ43UaJTRpKrnPlbds1HqVowxA0aBorr
	 2w75RnbeuvldZAsgyRpNSJKVVIV9TNNpADbBbKZsbWcSd8vWcRM9p5TYYIW9h+jvFY49N
	 HpggVEQokbCx61zn+35Gfn+dcmQI/IXZJnaxMRs2Zd6d9hH3uexSV6K3ILuxzwvv4MaUZ
	 v30FRRbqBaGznNqLimrs8cPvIj+zwDoInjh25GkD5sXTnTyfWAQc6o/ujyoIgiv83S9Kk
	 bCpkWsxLzpti4Dm+BS/TcW0Gyn+tljJwVjKLk2IB/uYBxSKxfvHPof2HANn1FNVAgzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YhjXNHza9stxE6aDiZMREAEWAEnmWCKBDC0S5X7bxvY=;
	b=nmUC0t33KIjVunzx3DqXnI+fwshmuV2n5ll2XVoMwLwJ9cTxbT3rIEe3GW+0NQdDFCh4
	 gywXrVCjRoeDwzH40J+JPv0/gRi8hU4HyKuBCebGkpTEOD6aP+5LtlXILhsLYV7Mw2M1y
	 Z9OKjY2h3UPwgwghRfP0CoRZXZ/Wmg2XmDoxE583prkpoAIAQ4/RUZU1l9xdIljowCguh
	 ShGebFWa7W0+xs7QY63ZHj49TEFDUk2F3ueuqwC+YY7XDxCbgmec85FEGfBQH0BDaTfQf
	 Zl7obIiQAzz0n6hy0E5WA2FHt86quWWAYw5AYA3Hl/XLF/ls1BoIoX9WEHyn7qudBUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/r4+/gI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E5606A31C;
	Tue, 17 Nov 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/r4+/gI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAFF1F000C4;
	Tue, 17 Nov 2026 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794922072;
	bh=YhjXNHza9stxE6aDiZMREAEWAEnmWCKBDC0S5X7bxvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/r4+/gITyGZlxzXBACe/JxVESNv8GaswYw6gp5XoFfeY2fTKGsYA2ojT5CyANwpm
	 ZuUPcZM4RIZL+scmI2yPyLolkZ3NUyw9CxO+/376iMWntrgglPbwFq7W8qP8bI7PZJ
	 dgaD2wcNq76oPBcw6yYvpa6GMt3YRdYE+uQ72V2Cf2MfVubc8U8Y9aHbEs5grh6Hpd
	 E5tf1XjlTrfYjHHGhWNKgBF9JXNQxukkZljRJG72qXhdAC3Wq0azMC3JPcGLDoADdn
	 3/AycKSp0xwkkc2RgKCq7xSrHumaFC86ULjyK0aJbQLsh7ABW2E1X+a5WMM12WSvFV
	 3/cQLlztUw5mg==
Message-ID: <sashiko-outbox-218876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/6] irqchip: add the SiRF AT550 interrupt
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: yy-Local-LLM <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117-at550-rfc-v1-v1-2-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-2-5879573cb825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:27:51 +0000
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
- [High] irqchip:at550: non-human handle in Signed-off-by trailer
- [Medium] irqchip:at550: missing IRQ_LEVEL flag in at550_irq_map()
--

commit d5dea66e73a21d9dc175a050a6d6978545bc229c
Author: yy-Local-LLM <yogo.0917.sabu@gmail.com>

> irqchip: add the SiRF AT550 interrupt controller
>
> Register the root controller through IRQCHIP_DECLARE and a linear
> domain. Validate the chip ID before writes, mask both banks during setup
> and route sources to IRQ. Keep dispatch bounded and leave the DSP mask
> registers alone. The register operations derive from the 6.12.60
> YPL514si bring-up. The device owner has now booted the 7.4-rc3 candidate
> through JWM on this upstream initialization path.
>
> Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use the handle "yy-Local-LLM"
rather than a known real full human name, which does not comply with the
Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst.

> diff --git a/drivers/irqchip/irq-at550.c b/drivers/irqchip/irq-at550.c
> new file mode 100644
> index 0000000000000..33eb18cd1e9ec
> --- /dev/null
> +++ b/drivers/irqchip/irq-at550.c
[ ... ]
> +static int at550_irq_map(struct irq_domain *domain, unsigned int irq,
> +			irq_hw_number_t hwirq)
> +{
> +	if (hwirq >=3D AT550_IRQ_COUNT)
> +		return -EINVAL;
> +	irq_set_chip_and_handler(irq, &at550_chip, handle_level_irq);
> +	irq_set_noprobe(irq);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops at550_domain_ops =3D {
> +	.map =3D at550_irq_map,
> +	.xlate =3D irq_domain_xlate_onecell,
> +};

[Severity: Medium]
Should at550_irq_map() also call irq_set_status_flags(irq, IRQ_LEVEL)?

Because at550_domain_ops uses irq_domain_xlate_onecell() and at550_chip has
no .irq_set_type callback, IRQ_LEVEL is never set on the descriptor.  If a
level interrupt fires while lazily disabled via disable_irq(),
handle_level_irq() masks the source and sets IRQS_PENDING, and a later
enable_irq() -> check_irq_resend() sees irq_settings_is_level(desc) as
false and schedules a software resend on top of the unmasked hardware line,
running the handler twice and reporting the interrupt as edge-triggered in
procfs and sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-at550-rfc-=
v1-v1-0-5879573cb825@gmail.com?part=3D2
