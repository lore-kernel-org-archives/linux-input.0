Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534973;
	b=W4cBvHlz0f8fG4Sd/NmDQ5GiXcDI46VC54ctzL4n/2ytiB30Tu0l4vuQWzbpDHllasOd
	 L6ce6YHnPQ8g5unoclboOX37kT2Xf1DF25SLPp0hCMSeLrzf9UdEeHlUVkUx9fuXwxC/u
	 mpCjNXzE+TDT9Obk3Kf64EGYcCOAijQ9GNvZq2tmckf4iqWYwTXUGMXyXDxhb8e8fC5SA
	 aLFwnjXm4HrJLMe9bQvrZBrbYOPMv5JYSVcFfSoCTAdYboEdy8FsUhTLo6zDht05prLF2
	 oWKlK7Svs+EzFKoikQPd5nuqGbsIHoisFN+Zh8DKllCI/z6qekPQ3PdGe1UeYDcBSZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v64fOHDXwqHUf2DIsjtSQn/CVl+UQzq1Bb/7MMxGFXw=;
	b=ibBN6BCWe84Li+6BZBzqfY2aKtL7P7aeNc2EXJ+Rxw+dErOFxAssE/IizyyBvwTorej3
	 9+RHHJos6Rd3otjrlgR5z2SacYDy3AqOOxn5JdfX7sYR9GLMrRh5ob5qW3z/mr0mG2IML
	 mEikPVun0iKi9Th/cWAHl972d/0rQ1ph09BazDA32zoOoOQ0cazmc5lp4UFbzvYnUITiz
	 wryOjripn3JI1j8/DBqgAN0IzXcjtAo4ArhC3sLgaX2ptIy0DpMYfs7CBneooHlsio35z
	 Abt6wC6y8HjAQMAlv7+l5IR/VeIBk468+YcJMNCJJLhhMMocGhkMM5lOwsG6YeJ5gIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFInfbUH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7C606A31C;
	Fri, 13 Nov 2026 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFInfbUH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712A31F000C4;
	Fri, 13 Nov 2026 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794534973;
	bh=v64fOHDXwqHUf2DIsjtSQn/CVl+UQzq1Bb/7MMxGFXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YFInfbUHyHPemC/SJktobd5Ze+hsic2/loh7RcaLx9A8hoIcN+SfNbh54DdtVK/71
	 622TQz62nZE4AtneK8HwQM01PtRj+0HxGV+/PdOAsLR0GGCiKFIT+4rhpgGgw7ETwC
	 T2jLuuPl/vgD/CzHnzuua1ZM5d83SJ4y+Cg67L07p/ISgEplfwjjygBc90qttZPfd+
	 1/YKQbTiPPidBBjAHF4iZsKdfN/N6bF9dtHTv1p8nUELaxDDaLQX5qejJFTLUf9WWU
	 ombiRBC8/4iImFkmZAZ3vFiLzIPWy8pinRqrmlTIz6krn/RJ4vnMWUIk0QGW0SOTYM
	 SlVXNj41Fv+vg==
Message-ID: <sashiko-outbox-212076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] mfd: mxs-lradc: Pass parent IRQs to child
 drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261113013212.470981-2-festevam@gmail.com>
References: <20261113013212.470981-1-festevam@gmail.com>
 <20261113013212.470981-2-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:56:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mfd: mxs-lradc: use-after-free in release_resource() on shared
  mem resource
--

commit 976bbc1082d0f14834e0c7850fdccd2c40f13cb4
Author: Fabio Estevam <festevam@gmail.com>

mfd: mxs-lradc: Pass parent IRQs to child drivers

This commit moves IRQ resolution from the mxs-lradc child drivers into
the MFD parent and shares a single relative memory resource across both
MFD cells via devm_mfd_add_devices().

> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> index 30a66e2681699..d16dfea892076 100644
> --- a/drivers/mfd/mxs-lradc.c
> +++ b/drivers/mfd/mxs-lradc.c
[ ... ]
> +static const struct resource mxs_lradc_resources[] =3D {
> +	DEFINE_RES_MEM(0, SZ_8K),
> };
>=20
> -static struct mfd_cell mx23_cells[] =3D {
> +static const struct mfd_cell mxs_lradc_cells[] =3D {
> 	{
> 		.name =3D "mxs-lradc-adc",
> -		.resources =3D mx23_adc_resources,
> -		.num_resources =3D ARRAY_SIZE(mx23_adc_resources),
> +		.resources =3D mxs_lradc_resources,
> +		.num_resources =3D ARRAY_SIZE(mxs_lradc_resources),
> 	},
> 	{
> 		.name =3D "mxs-lradc-ts",
> -		.resources =3D mx23_touchscreen_resources,
> -		.num_resources =3D ARRAY_SIZE(mx23_touchscreen_resources),
> +		.resources =3D mxs_lradc_resources,
> +		.num_resources =3D ARRAY_SIZE(mxs_lradc_resources),
> 	},
> };
[ ... ]
> @@ -187,38 +215,15 @@ static int mxs_lradc_probe(struct platform_device *=
pdev)
> 		goto err_clk;
> 	}
>=20
> -	switch (lradc->soc) {
> -	case IMX23_LRADC:
> -		mx23_adc_resources[RES_MEM] =3D *res;
> -		mx23_touchscreen_resources[RES_MEM] =3D *res;
> -		cells =3D mx23_cells;
> -		break;
> -	case IMX28_LRADC:
> -		mx28_adc_resources[RES_MEM] =3D *res;
> -		mx28_touchscreen_resources[RES_MEM] =3D *res;
> -		cells =3D mx28_cells;
> -		break;
> -	default:
> -		dev_err(dev, "Unsupported SoC\n");
> -		ret =3D -ENODEV;
> +	ret =3D mxs_lradc_get_irqs(pdev, lradc, data);
> +	if (ret)
> 		goto err_clk;
> -	}
> -
> -	ret =3D devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> -				   &cells[ADC_CELL], 1, NULL, 0, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
> -		goto err_clk;
> -	}
> -
> -	if (!lradc->touchscreen_wire)
> -		return 0;
>=20
> -	ret =3D devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> -				   &cells[TSC_CELL], 1, NULL, 0, NULL);
> +	num_cells =3D lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
> +	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   mxs_lradc_cells, num_cells, res, 0, NULL);

[Severity: High]
Does passing the same relative IORESOURCE_MEM range in mxs_lradc_cells[]
with mem_base =3D res cause a use-after-free in __release_resource() when
the driver is unbound with a touchscreen enabled?

When num_cells is 2, mfd_add_device() gives both mxs-lradc-adc and
mxs-lradc-ts an IORESOURCE_MEM resource with parent =3D res and identical
bounds [res->start, res->start + SZ_8K - 1].  In platform_device_add(),
insert_resource() inserts the ADC resource (r_adc) as a child of res, and
then __insert_resource() places the identical touchscreen resource (r_ts)
between res and r_adc, setting r_adc->parent =3D r_ts.

On driver unbind, mfd_remove_devices() unregisters the children in
reverse order:

1. platform_device_unregister(pdev_ts) calls release_resource(r_ts) ->
   __release_resource(r_ts, true), which unlinks r_ts from res->child
   without reparenting r_ts->child (r_adc), and platform_device_release()
   frees r_ts while r_adc->parent still points to it.

2. platform_device_unregister(pdev_adc) then calls
   release_resource(r_adc) -> __release_resource(r_adc, true), which
   walks r_adc->parent->child and writes to the freed r_ts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113013212.4709=
81-1-festevam@gmail.com?part=3D2
