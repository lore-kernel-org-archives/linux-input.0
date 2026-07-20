Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376943D503
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565532; cv=none; b=WHfGWUN1wl/rBBwHy49Nqp+uk987qb5lQhGcGUfemzq5rbYi394OBz4RxeLZE8Q71DncwfkPgxC7WdYRDG9bZ6XtDhBXEp9y8qub1j/njnRo2UtYGqPTpCSgUR2Z737d/OmpXdDenympBqYjFG9MNFiaK+det8Nyaj1HV20nG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565532; c=relaxed/simple;
	bh=bZ3KihH2JCFbVXumotQL+Qus3DmCupPcspDDs2fC8/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OgTglP1GPa0LB3MAp/GtZeY2Wiousn/B7URh1+6vh7vrR1+rXLiHOfTVKwaH+dhYd8mmU5tho2L+QEZoVymVVDi6tSyfrTSVM/VmruEFI/tNp2c4b1FEtAI7P8301B0GqIYSVoBZ4gXiBV896X4qOsVh0wC7K7YZG6AC2jgcyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDftemdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDftemdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DBB1F000E9;
	Mon, 20 Jul 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784565530;
	bh=0RX7PnErAgjiJIcrymAFteEl2aCJ2Fm8ZmxubwKjUJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDftemdwUsxY5pjk3lSKTWPBTLRKgYPYoYcEWvqg+vH0lRe7J+ZTsbFJs7BfkOli8
	 yxY9U2zXMM6i+/47byO4rX1eh31XZUXk/zeiq8z4pApvjSI4q08G35IFWy4/H7iSWe
	 hKPlyN+caigqv7ocZOC41hMgm1dbs5RIoXDUeitHVnoJEWmmbdR0VdDrPndUoSbQNB
	 K7BRJDFzIWVFDP74P2ITejMOZOAEzpfVmTfbbyId9Eho1AlftpNH7mwfZ3Wr1n1uwh
	 t0800PNK9VaaZYZZ8QrFvWWeiqT2bzIRJzQBHgI2f0qkm1HJjY3P6lVDBmq6dgH5HR
	 vDj+cn2oUtG9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] Input: applespi - prefer asynchronous driver
 probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720162219.32324-5-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
 <20260720162219.32324-5-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:38:50 +0000
Message-Id: <20260720163850.84DBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent data race on the global `touchpad_dimensions` array d=
ue to asynchronous probing.
--

--- Patch [4]: [PATCH v3 4/5] Input: applespi - prefer asynchronous driver =
probing ---
commit b9f1c9a61a0fcf093f49319a208df622cfeba00e
Author: Shih-Yuan Lee <fourdollars@debian.org>
Input: applespi - prefer asynchronous driver probing

This commit enables asynchronous probing for the applespi driver to avoid
blocking the main kernel thread. It also cleans up product ID retrieval
in applespi_tp_dim_open().

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
[ ... ]
> @@ -2044,6 +2045,7 @@ static struct spi_driver applespi_driver =3D {
>  		.name			=3D "applespi",
>  		.acpi_match_table	=3D applespi_acpi_match,
>  		.pm			=3D pm_sleep_ptr(&applespi_pm_ops),
> +		.probe_type		=3D PROBE_PREFER_ASYNCHRONOUS,

[Severity: Medium]
Could enabling asynchronous probing here cause a data race on the global
touchpad_dimensions array?

Looking at applespi_register_touchpad_device(), it reads from and modifies
the global touchpad_dimensions module parameter without locking:

drivers/input/keyboard/applespi.c:applespi_register_touchpad_device()
        sts =3D sscanf(touchpad_dimensions, "%dx%d+%u+%u", &x, &y, &w, &h);
        ...
        touchpad_dimensions[0] =3D '\0';
        ...
        snprintf(touchpad_dimensions, sizeof(touchpad_dimensions), ...

If a system has multiple instances of the APP000D ACPI device, the driver
core could probe them concurrently, potentially corrupting this string or
causing incorrect dimensions to be read and parsed.

>  	},
>  	.probe		=3D applespi_probe,
>  	.remove		=3D applespi_remove,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720162219.3232=
4-1-fourdollars@debian.org?part=3D4
