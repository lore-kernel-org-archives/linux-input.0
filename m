Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C27414A17
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421578; cv=none; b=QDQkNn9zOcmrBHKnoUU2MS/wT6z3+VdtJOdnTJzi4ZyZXlAGJvKsbdBdJaCW31dyTpyytSl8xJBwEHyHXSr03VHZkaMfA0VWxya1FiqeyWW+BZvrebkibepOvpH6g0mELsMhnJps47TmnaOrxcCRgLonBJEBbBenydk/d+B2LWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421578; c=relaxed/simple;
	bh=9CMc557Cc7K6GehtOnt+fj0LjqlTs5c0Sochzb2O11E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GcEJ/irpR2+fglx/KNmaSPTebUWF/NQ5KGjaZ0qlMDRyZE2smAj6acSHu9l6J9WO7znH7GqkjyzYFWaDsQ+x72wMwORtSbS6THW4uQDCwGwlMQkZ9i86DXE+aurPsQTcVoomKs4QLHD3qyOmRqHiWSZwoZKcD9u1xK1RsBfj9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGLD/xZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGLD/xZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919651F000E9;
	Thu,  3 Sep 2026 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421576;
	bh=H0ILlGajfpiFJoxwSXLsT0XKRaXfWO5DwpNUhFmFc2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGLD/xZJrgz/f5U0MwiIORurZTvJxUs87qwQU7RVc73a57PfBbp9EklA9HgltYzPu
	 TPndax6t6SAaSJUqc1OnkdYwEp1t4VAK8AZagBGNfSaqBUyGoxXWTLtZvqObqmS34t
	 9Fdy7WHU0qhU+a0RasDjcHItcL8N8eYisDOX8H0oKJaQhSeBe+4WyumfCHCmiYcnsz
	 oMtwhSJsow2fKFDxMzTiagS6rtZa5FW94bUrnDa6nzioyrlEjMfopEfxvcZsaqUb5g
	 Hn1S+xpplNZEV6jKxoR4WBYWLguxFPEvnR6cDfTLzkrqhoEYoXEzNTWP7CJFbbxn4m
	 RiFRtojlhRy0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] HID: generic: add LampArray support via
 hid-lamparray helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260903073602.3815258-3-aer@tuxedocomputers.com>
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
 <20260903073602.3815258-3-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:46:16 +0000
Message-Id: <20260903074616.919651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The generic HID driver depends on HID_LAMPARRAY if HID_LAMPARRAY, =
which forces the core HID generic driver to be a module if the optional Lam=
pArray helper is a module.
--

commit de92bcafc34d337da4d9893ee22e49ef91520c6c
Author: Aaron Erhardt <aer@tuxedocomputers.com>

HID: generic: add LampArray support via hid-lamparray helper

The hid-generic driver now optionally registers a lamparray instance after
hid_parse(). LampArray resources are released on driver remove.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4afd80a67b394..a0fcd89c2bb02 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -82,6 +82,7 @@ config UHID
> =20
>  config HID_GENERIC
>  	tristate "Generic HID driver"
> +	depends on HID_LAMPARRAY if HID_LAMPARRAY

[Severity: High]
Does this restriction inadvertently force the core generic HID driver to be=
 a
module when the optional LampArray helper is built as a module?

If a system relies on hid-generic for keyboard input during early boot
(e.g., to enter a LUKS decryption password or interact with a panic
shell) and expects the driver to be built-in, forcing it to compile
as a module could result in a total loss of early boot keyboard support.

Could this be avoided by dropping the "depends on" restriction and instead
using IS_REACHABLE(CONFIG_HID_LAMPARRAY) in both the header (for stubs)
and the C file? This would allow a built-in generic driver to gracefully
degrade to stubs while the optional helper remains a module.

>  	default HID
>  	help
>  	Support for generic devices on the HID bus. This includes most
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903073602.3815=
258-1-aer@tuxedocomputers.com?part=3D2
