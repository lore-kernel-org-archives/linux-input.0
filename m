Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA63F4DD8
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515215; cv=none; b=ErpVLvB93FtZaA+1KtEWQStkHDWmCEmkxSDqiNy0wpQKJC4g0rgTpWX008Nceg2TZbYr8XOg75gK/EbV4A/wQruh1djhU82SAfrzycNx0d/AixWOBTtLhkMQqqizDSBQi+5iCww7vW5RW5Q5UbahMNHug1lQiiKfbGIkxtD5S1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515215; c=relaxed/simple;
	bh=D7Px72jNDHFKm+ztTno2uzVKuyVEEiIBvud/ZHQkg0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sy9belgRaufDwYE4bBj5+8peDMzfxubSeF0wZYvydaG31mvMMeMcWa+3y+STE5VemRgXpqZPyrxB1K5Sw5ZBYMTxgGDFHYox+YjwufZNHPCh+oiW+7Z8bGJVpPxvVN+5gxhPPSXKGWyOAXIag9BT6TgaOYuVfn2ddU3ELm2GLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw9dAGRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw9dAGRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884B11F00893;
	Wed,  3 Jun 2026 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780515213;
	bh=NeIsHM8qmCj1S5kCYGTfsr62nvGrNN3uaC5aKt1Cu2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cw9dAGRkcQznd1qq/CipDlz1/xaGJeQpC4t/FLk65UJgQFIkwBTyATG5s4umKTr07
	 zKIzQdpT6kN7dTbhIcf/sfBb8Y1Qih8CaY6D+Sd7ybglrsyAwRsAeb/adbnPVyWomZ
	 szWifYOU3DEdTb/3be41lLRHSO3kwk5QJtNw0Vv1ha1G12UaOkfHZFSSu376Ox0no0
	 jNIGJSG5ZVXP2rk1VmckKWU/baZJXmlZicKF4IIzdD//QFX8iaIlOmxC896o0Omiw1
	 6qyMwa3I6YZ6VwXdB+jc6aoIYE8aStWbAWErHOIMYv4B4bdEGBrCJX/m8HOFd++vpj
	 toJ797k2sdCJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: apbps2: Simplify resource mapping and IRQ
 retrieval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260603192415.6679-1-rosenp@gmail.com>
References: <20260603192415.6679-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 19:33:33 +0000
Message-Id: <20260603193333.884B11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Requesting a shared IRQ before the serio port is fully allocated a=
nd initialized leads to a potential NULL pointer dereference or uninitializ=
ed spinlock access in the interrupt handler.
- [High] Mixing `devm` managed interrupts with manual resource unregistrati=
on causes an incorrect teardown order, leading to a use-after-free if a sha=
red interrupt fires during device removal.
--

commit d306647eec008111ed14c378d300aa2cb98191b6
Author: Rosen Penev <rosenp@gmail.com>

Input: apbps2: Simplify resource mapping and IRQ retrieval

Simplify resource mapping by using devm_platform_ioremap_resource()
instead of the longer devm_platform_get_and_ioremap_resource() helper
as the last argument is NULL.

Additionally, use platform_get_irq() to retrieve the interrupt
instead of irq_of_parse_and_map() and propagate its error code on
failure. irq_of_parse_and_map() requires irq_dispose_mapping, which is
missing.

> diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
> index 0aa4ab00af352..5f21acdd41139 100644
> --- a/drivers/input/serio/apbps2.c
> +++ b/drivers/input/serio/apbps2.c
[ ... ]
> @@ -148,7 +148,10 @@ static int apbps2_of_probe(struct platform_device *o=
fdev)
>  	iowrite32be(0, &priv->regs->ctrl);
> =20
>  	/* IRQ */
> -	irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +	irq =3D platform_get_irq(ofdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
>  	err =3D devm_request_irq(&ofdev->dev, irq, apbps2_isr,
>  				IRQF_SHARED, "apbps2", priv);

[Severity: High]
This is a pre-existing issue, but requesting a shared IRQ here before the
serio port is fully allocated and initialized creates a window for a NULL
pointer dereference.

If a shared interrupt fires immediately (triggered by another device on the
same line) and there is leftover data in the PS/2 FIFO, apbps2_isr() will
execute:

drivers/input/serio/apbps2.c:apbps2_isr() {
    ...
    serio_interrupt(priv->io, data, rxflags);
    ...
}

Since priv->io is either NULL or not fully initialized until later in probe:

drivers/input/serio/apbps2.c:apbps2_of_probe() {
    ...
    priv->io =3D ... /* allocated later */
    ...
}

Could this lead to a crash if the ISR fires early?

[Severity: High]
This is another pre-existing issue, but does mixing a devm-managed interrupt
here with manual unregistration in apbps2_of_remove() cause a teardown order
issue?

In apbps2_of_remove(), the driver manually unregisters and frees the serio
port:

drivers/input/serio/apbps2.c:apbps2_of_remove() {
    ...
    serio_unregister_port(priv->io);
    ...
}

Because the interrupt was requested with devm_request_irq(), its handler
remains active until devres runs free_irq() after apbps2_of_remove() return=
s.
If a shared interrupt fires during this window and there is pending data,
apbps2_isr() will execute and pass the already-freed priv->io pointer to
serio_interrupt(), resulting in a use-after-free.

Could the interrupt teardown order be adjusted to prevent this race?

>  	if (err) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603192415.6679=
-1-rosenp@gmail.com?part=3D1
