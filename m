Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE339DBFC
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475988; cv=none; b=g+GbN8ctja0oDKgGy0hUMPLJs50synIQhnbS+fbwTj+OcNRdzWTlTXcxZRPACoiy3MtZfXrx3s8UVvqBIKqw6S3r2JvNWbvVEAM/TLJWFZuxv92m/6RiiKH/fnce35tZ7uidtpoDMOi98NVCDBdWQF3aJVNY8PAFCrBpVNwGYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475988; c=relaxed/simple;
	bh=pgGtvJmuk++NSPtWZaHnVXay2F71s3xh+vnc44lDfBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B3qJby2BJ6ZRZBYgyB+MR7btpyg2dq2AMFYeuz0HAfZ8/U/NXDyYiNApM4eiEuNyMqk1tBEncHcABj5R0APJqjGUn7vdJPgFmErEX0lwnQJSsBuaEOEz0I4onxkSUpCieISvzIjYNZvbUjRfpseTVODXUFD10pnaESAQ7LkEf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePz73TCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePz73TCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923AD1F00893;
	Wed,  3 Jun 2026 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780475986;
	bh=BHxhGVj8bX50wdQi5WdnpPySbrGZ4+yramU7TOB8/gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePz73TCynbpRJSQBK7gqyM4d3D+AvkLFWVMCVyHTb9glkZZjxyadaUshjlTEuhg4x
	 MoMqC1rpccWi479TfCG0fx6thHvFvgh+KwlpI2lgtzJvVI55AFs3FEIEx7a3rpsiax
	 HlseXs71+uCwK2oxTEA7q1upVIt0Z7Uty6FUWPL1ZCxNGYbny3us375IbgtVyWHlJL
	 NC+x4qySjvczUxatRFvst4v6lqS1WvrfXm1SF41noIt6pmUDaM45bQ+hLajVH1gnWb
	 bFOaEz2kjwT09v+wr4T1fHalrLIbyEyVqRbwf75wi5b8onOwT3/FdxWJGNRBTGLLyD
	 lCHhcPjq6+FLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] HID: nintendo: Use %pM format specifier for MAC
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260603082808.119958-1-andriy.shevchenko@linux.intel.com>
References: <20260603082808.119958-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 08:39:46 +0000
Message-Id: <20260603083946.923AD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] ABI Breakage: The patch changes the MAC address exposed via sy=
sfs from uppercase to lowercase, breaking userspace tools that rely on exac=
t string matching.
--

commit 6c8c4e53eb547a4381d6f8dabe9201540c4f0168
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

HID: nintendo: Use %pM format specifier for MAC addresses

This commit refactors the MAC address string generation in the nintendo HID
driver. It replaces a custom sprintf format string with the standard %pM
format specifier.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 29008c2cc5304..77b14dfdae867 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2431,14 +2431,8 @@ static int joycon_read_info(struct joycon_ctlr *ct=
lr)
>  	for (i =3D 4, j =3D 0; j < 6; i++, j++)
>  		ctlr->mac_addr[j] =3D report->subcmd_reply.data[i];
> =20
> -	ctlr->mac_addr_str =3D devm_kasprintf(&ctlr->hdev->dev, GFP_KERNEL,
> -					    "%02X:%02X:%02X:%02X:%02X:%02X",
> -					    ctlr->mac_addr[0],
> -					    ctlr->mac_addr[1],
> -					    ctlr->mac_addr[2],
> -					    ctlr->mac_addr[3],
> -					    ctlr->mac_addr[4],
> -					    ctlr->mac_addr[5]);
> +	ctlr->mac_addr_str =3D devm_kasprintf(&ctlr->hdev->dev, GFP_KERNEL, "%p=
M",
> +					    ctlr->mac_addr);

[Severity: Critical]
Does this change the sysfs output from uppercase to lowercase?

The original format string %02X explicitly generated an uppercase MAC
address string, while %pM delegates to hex_byte_pack() and generates a
lowercase string.

Since ctlr->mac_addr_str is exposed to userspace via the uniq attribute,
could this cause an ABI regression?

Userspace utilities and gaming libraries (like SDL and the joycond daemon)
often map USB controllers to their Bluetooth pairings by performing
case-sensitive matching against the uppercase Bluetooth MAC addresses
exposed by BlueZ.

>  	if (!ctlr->mac_addr_str)
>  		return -ENOMEM;
>  	hid_info(ctlr->hdev, "controller MAC =3D %s\n", ctlr->mac_addr_str);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603082808.1199=
58-1-andriy.shevchenko@linux.intel.com?part=3D1
