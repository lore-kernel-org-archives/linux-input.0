Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622730DEBA
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830036; cv=none; b=B+RZTA73O3Wmx+7szd6rbr3IZigflmF139CnaLkUAPMdLPR6QBPJQGUefc0QUkkxgWaqZCfYVxUwY0723LrsRvuJFvbjrjG7/8HEtWluok824afPpk29vf+lmp3+UWXTyCxOiEOD1bwDj6My7hOeQ4+ichQnGo0x8YxmPN3I7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830036; c=relaxed/simple;
	bh=8Mo3sRki/6zCRQCkS72BDrtMcOf5/at7s4xSf2etDvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kSMUEISQBnLxSn+CP4AZgkTK5P0eBuvFIuCju/O9fmv0diIsrLLhSB11cXpWYPHtvkMa+0mBKImRMoYRjvpmLS0FOaON7aS5cyhsjFFz5FMhdJZJiGQAEB4oUXwy+YKNKbwIe7wEeN3Wf0foe/AI1SCs8KI2/5PVT0XEVsSj+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+j/EUj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+j/EUj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFE81F000E9;
	Tue, 30 Jun 2026 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830035;
	bh=rEuybrKHGBTaLT5K3HGhC417Q+R1HqWQxgeiSyy3yaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i+j/EUj5s5XCle6YdLW+67bjJ+quYbE/lNGvY1GZppwqblE1GkdsPXBLIgTDXvGBS
	 wtD7DV1wSzbmLpNUI0M2LpOi7dcJ+7qsDswG/X10kJJ1UQ6L3Zw6F/9p/OmCMDtsEo
	 bSUKUw5cJOlUQBdhHjdLIK0DT8MvlhBla0MQ/LbDD9cYWXpUoF01WWpJh8ggqgnvtN
	 8wLdkt5swhihtTqTeWiMI1+wHHjdm2Ok+CQ7czLC1u8LjPKs5EyvxwPmQ5QJ/gfx9D
	 ZxkYa436JC+GgcqSpj1dqclfd3HkCED+bga44mJO4/kXo+q6Bwdbeo85QcacTgH9lT
	 4GlS+6TlQ8Vaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: cleanup help indentation in kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Braha" <julianbraha@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630142043.496559-1-julianbraha@gmail.com>
References: <20260630142043.496559-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:33:54 +0000
Message-Id: <20260630143354.EEFE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Malformed Kconfig help text indentation in `config HID_LENOVO` intr=
oduces a syntax error that breaks the kernel configuration process.
--

commit a32d9e3aafce015a8cfc25d49c3d96d9d8d186de
Author: Julian Braha <julianbraha@gmail.com>

HID: cleanup help indentation in kconfig

This commit standardizes the Kconfig help text indentation in the HID
subsystem to 2 spaces.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f9bcaeb66385b..9b04ef19a4d24 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig

[ ... ]

> @@ -608,12 +608,12 @@ config HID_LENOVO
>  	tristate "Lenovo / Thinkpad devices"
>  	depends on LEDS_CLASS
>  	help
> -	Support for IBM/Lenovo devices that are not fully compliant with HID st=
andard.
> +	  Support for IBM/Lenovo devices that are not fully compliant with HID =
standard.
> =20
> -	Say Y if you want support for horizontal scrolling of the IBM/Lenovo
> -	Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
> -	standalone keyboards, e.g:
> -	- ThinkPad USB Keyboard with TrackPoint (supports extra LEDs and trackp=
oint
> -	  configuration)
> -	- ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn keys)
> -	- ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
> +	  Say Y if you want support for horizontal scrolling of the IBM/Lenovo
> +	  Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
> +	  standalone keyboards, e.g:
> +	  - ThinkPad USB Keyboard with TrackPoint (supports extra LEDs and trac=
kpoint
> +	    configuration)
> +      - ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn=
 keys)
> +      - ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)

[Severity: Low]
Does this indentation cause a Kconfig syntax error?

These last two lines in the config HID_LENOVO block appear to be indented
with 6 spaces instead of matching the preceding lines. Because 6 spaces is
less than the indentation of the first line of the help text, the Kconfig
lexer will prematurely terminate the help block here.

Will this cause the parser to treat these lines as top-level Kconfig
statements and result in a syntax error when trying to build or configure
the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630142043.4965=
59-1-julianbraha@gmail.com?part=3D1
