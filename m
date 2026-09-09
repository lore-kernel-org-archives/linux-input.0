Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16773358367
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945285; cv=none; b=bgFWrXpJbigGlAUk6qsz13luskhQbE+iCPYrefZm5y8pQqW8mKEL7iuQUQJSZQe7vfPG0W2cydzdPxatrj2yA0y33rD4qOot0fx3q+YbRz2LDvH/py8RYMwGrFx8SniwZ286me3HvsWm7M3G36TsV6LQ8dM2LgrQLhYsYrGBwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945285; c=relaxed/simple;
	bh=5hzLZZMc1NmQivxuXhwGASAzDgDOV9vRW0FtxdnriwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j85DkCACdb927daugOUkFgJ5u0e3E5Vkc1qAGXduLha2crm6TrRtDYDLxO02EiCCSV7SR6bCV4wMlQy8f1H+HIeTAZew5KyibqvjsVjUOUjZlbIBfJvE6XYElgxgQJxapwlSMwNE7IdQL4EiD6LhGKOm1D3EFq6IwTS/zbsfbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWoEHXDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWoEHXDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3384C1F00A3A;
	Wed,  9 Sep 2026 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945280;
	bh=xdFMdn0cLtbQwjjqh6arnaRKQl56627hMfF54OyHdY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NWoEHXDdmHh1Piqz9hilSSAeCDp8J6J44Rmx/jJ3iZK/Qs8fm+vEIixqCbR+xkY2h
	 kuMEIoXSwUUXBv0ka0+ewkBco5p1ffAmAFP1IzLoOgJaAN5rEIdKiYyqOhcmDGNygm
	 WR9ZCJA0K+i3CfuShXj9UYZkPPbbiDCL5Xa6rmulMorwi19RwQcvK34j6MAmh/ZJRE
	 ZtN9YcFq8tRDf7cVDBEmFvFRcpvPt0dItQYY/2S+kbRKhq1RUHNNC4okWKjacFIpgw
	 GGUkYvjcYy2BlNhMkbuk6FSVzh7cGigJFFonLiR7M1tiHRKp7gl/2Hc6476sl/GOey
	 uKH9gKe+FivRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: soc_button_array - fix MS Surface Pro 11
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260909090721.20869-1-johannes.goede@oss.qualcomm.com>
References: <20260909090721.20869-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:14:39 +0000
Message-Id: <20260909091440.3384C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The local variable `irq` is evaluated without being initialized wh=
en `soc_button_lookup_gpio()` returns an error other than `-EPROBE_DEFER` (=
e.g., `-ENOENT`).

Pre-existing issues:
- [High] Missing bounds check on `btns_desc->package.count` before accessin=
g the first element of the ACPI package.
--

commit 71e6e56f2553b9410815c77e8b20ed9b2b9a2d37
Author: Hans de Goede <johannes.goede@oss.qualcomm.com>

Input: soc_button_array - fix MS Surface Pro 11 probe failure

This commit alters the error handling in soc_button_device_create() to
propagate EPROBE_DEFER on platforms other than older Bay Trail and Cherry
Trail tablets. This allows the MS Surface Pro 11 to correctly retry probing
when racing with the GPIO driver.

Link: https://lore.kernel.org/lkml/20260830141355.55898-1-lsa.uz@pm.me/

> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/s=
oc_button_array.c
> index b8cad415c62ca..f838b7d72e49f 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
[ ... ]
> @@ -191,8 +192,9 @@ soc_button_device_create(struct platform_device *pdev,
>  		error =3D soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, =
&irq);
>  		if (error || irq < 0) {
>  			/*
> -			 * Skip GPIO if not present. Note we deliberately
> -			 * ignore -EPROBE_DEFER errors here. On some devices
> +			 * Propagate -EPROBE_DEFER, skip button on other errors.
> +			 *
> +			 * -EPROBE_DEFER is ignored on Bay & Cherry Trail. Here
>  			 * Intel is using so called virtual GPIOs which are not
>  			 * GPIOs at all but some way for AML code to check some
>  			 * random status bits without need a custom opregion.
> @@ -201,6 +203,12 @@ soc_button_device_create(struct platform_device *pde=
v,
>  			 * we do not have a driver for these so they will never
>  			 * show up, therefore we ignore -EPROBE_DEFER.
>  			 */
> +			if ((error =3D=3D -EPROBE_DEFER || irq =3D=3D -EPROBE_DEFER) &&

[Severity: High]
Can this evaluate the uninitialized local variable irq?

When soc_button_lookup_gpio() encounters an error other than -EPROBE_DEFER,
it returns early without setting irq_ret:

soc_button_lookup_gpio()
    desc =3D gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
    if (IS_ERR(desc))
        return PTR_ERR(desc);

If error is -ENOENT, the short-circuiting of the || operator means the
condition evaluates irq =3D=3D -EPROBE_DEFER while irq is uninitialized sta=
ck
memory.

This will trigger KMSAN warnings, and if the uninitialized memory happens to
contain -517 (-EPROBE_DEFER), it would falsely abort the entire probe inste=
ad
of just skipping the missing button.

> +			    !(soc_intel_is_byt() || soc_intel_is_cht())) {
> +				error =3D -EPROBE_DEFER;
> +				goto err_free_mem;
> +			}
> +
>  			continue;
>  		}

This is a pre-existing issue, but does soc_button_get_button_info() lack a
bounds check on the ACPI package element count?

soc_button_get_button_info()
    /* The first package describes the collection */
    el0 =3D &btns_desc->package.elements[0];
    if (el0->type =3D=3D ACPI_TYPE_PACKAGE &&

If the system provides a malformed ACPI table with an empty package where
btns_desc->package.count is 0, this will access out-of-bounds memory or
dereference a NULL pointer, potentially causing a panic during boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909090721.2086=
9-1-johannes.goede@oss.qualcomm.com?part=3D1
