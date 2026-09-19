Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DC547041
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807467; cv=none; b=IKBwbom1CCY+EihVhQnd9BlMxBZWswvAkHxdhues7hSMQdrHd1huNwaPz0Axuk6rj7ppZe7nXAEfxpPPcOfU9YdLH0Wk34wFPeFEYSkwgfYWvC7D1Sn1Tdg9woFY56Vuey2w5KxZHpf+sSANbNwMRtn5gZ8/8U5inEbYW7p4ucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807467; c=relaxed/simple;
	bh=ZDiBZ8vW07kiHjM+zfOyS7UJyZIiMccuGpVu5voYyfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTXBl5sS/6DRnAUOkeL42YMT/gmP62djoCYYfXLKZht+xGyly6bDT2F4QfeI8ydrQz6bNW4n1/bva94zmnwooKB2CwBwzGbrrpWPuWx6zyFocKZEVfOZVckqlwKmefCmFOyyAApFpBh1Ofj7fBpqY+R90q28EJyR2G7nGiqwwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn3joxvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn3joxvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F271C1F000FF;
	Sat, 19 Sep 2026 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789807464;
	bh=FDJPdmrvx92c8ESp97OqIlnq8Lc2+7A8K6QSQ2Vs/Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jn3joxvMeZpugUJgBtJh6lTh9sjOr90/TyLEDTn2TBTSeS97cIjnJD9c0pQzJvaQO
	 IIFMyE/bzeq///jJWrQiMnFRbvVeFn8cA41U8Dr1Z5ry9kLpQF8ojME0/cWQpDtr+e
	 ffj4O4nU9mdVBkFmd1ThuocrfKprZHGWAW85NHalZf2tmDKlim760GzyIXr7A7SYQb
	 JZwUQC1khq02zQda0GegkVh+AnVg9xyvnOvZwB/CBku21LbHeANt2+Zl5zHEJhu6jw
	 cTZLh08LK7qz69w+jIHSfS0W0CpXwDumevNcZlpRI37d+x0Z4ChGy66Y7i/sxX69wG
	 eDm5hA+9tUmUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: gpio_mouse - remove driver that has never been
 used in the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260919083655.586922-1-enelsonmoore@gmail.com>
References: <20260919083655.586922-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 08:44:23 +0000
Message-Id: <20260919084423.F271C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] input: gpio_mouse: driver removal speculatively breaks device tr=
ee ABI
- [Low] input: gpio_mouse: incomplete cleanup leaves orphaned DT binding
--

commit ff6ae0c9a42236905d35103b1b6b9ce3be08070e
Author: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Input: gpio_mouse - remove driver that has never been used in the kernel

This commit removes the gpio_mouse driver. The driver has been present since
2007 but lacks any in-tree references from platform data, device tree files,
or ACPI probing.

> diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_=
mouse.c
> deleted file mode 100644
> index 18ccbd45004ad..0000000000000
> --- a/drivers/input/mouse/gpio_mouse.c
> +++ /dev/null
> @@ -1,170 +0,0 @@
[ ... ]
> -static const struct of_device_id gpio_mouse_of_match[] =3D {
> -	{ .compatible =3D "gpio-mouse", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, gpio_mouse_of_match);

[Severity: Medium]
Could removing this driver break the Device Tree ABI for any out-of-tree
boards that currently rely on the "gpio-mouse" compatible string?

If a system bootloader or firmware passes a DTB with the "gpio-mouse"
compatible string, the driver will no longer exist to bind to it.

[Severity: Low]
Does this patch also need to remove the devicetree binding schema for
"gpio-mouse"?

The schema file Documentation/devicetree/bindings/input/gpio-mouse.yaml
appears to be left behind, leaving it as an orphaned document now that
the driver is removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919083655.5869=
22-1-enelsonmoore@gmail.com?part=3D1
