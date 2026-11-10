Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291946;
	b=Y2imxo/KhzkDM/g2iXNs5hKfIKpF1EQrIl4Lwz5wGBk5sg0F0swUGhOjHuyT8g67R2Sj
	 lpq8dIBzP/jONlBYrknybRRYWyBXZ5bquc9lVKeo/Wtf4qfk/sCkSAfn8B7p++Z3DjyqI
	 07+ea1+0eeWchRgiQLR5RTLUz1gID8jd13gnYly7nbTmQqldvT6Zt5pyUitVvmoaAQnDo
	 5QMOrGdanz/yFTP9ooIDAVqxiaVTDMf6oGHY6c8V//EHNjXAWosAtGNCK6svahRbM8fA2
	 1QkCP18WLfm1D3HzL+vkCSD+KMCK134YN79Rw7OlYj2DfDJ8gt6icrnEwa6SHGwFbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BOK+rYjyV+z1yxqqh1YiuCbJZFvJ0kG/2jZctJFxWVs=;
	b=gNh/tho3etSop/OphP0afvAf96kVxXOwZa7iTEaF55bSDkD6zRQhd00h63geuMf0lNKk
	 e9g+diu/EDn5Ddch3C1vdxnDrXuzrK4mY1+8l2r6j8M/kUguyKiM3LSdA0nMQlhVipTQm
	 JiWj1XsNyj24WiP0raIhULTkQ6GnO+I+bPQXm5uNYAa1rYJZBDbJDfHdC1dFI6ccH6Yjk
	 64EiyjLzjNV+VHd/doQ6eBa3r6EK6d8aTiVF4XOuGPM8dbIA0bFICjHgzjuBDPLj8ryKS
	 BquITgw642FrToLxiHn/s+uYb3E3hRy3484OU1Y4RO8LWGP1+0nPzcFwHkp1G2ngOEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UaL3P/pP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CD606A31C;
	Tue, 10 Nov 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaL3P/pP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DE51F0089F;
	Tue, 10 Nov 2026 06:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794291945;
	bh=BOK+rYjyV+z1yxqqh1YiuCbJZFvJ0kG/2jZctJFxWVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaL3P/pPjtvL2zOvb9zXBUzzpf2TR6RRcyZ1YLYG/pBtektp8JFeExTfCE08TP2+y
	 BoYAo87BRh1yENokyXVEU89sgGbdEBcWAu9bsEsxFidRK5j6/+s231UY0WEKZzArFP
	 XZu9XClKLeRqSUsTY7JXVG21/HtUrurupizfUpp4iWi6HcMIixH49FDOWKrcMeaxOF
	 oiIkLRS8mmYLC6kQrBl+D+PaK8sqVZ7fBv+QbKCGPvNixOBIvRDW2u23FszD83wXWS
	 9CJUF/8MjKVqxGVtSMo8yaze3atsRFw6C27A2hbJ3h+WFvUCRi5g+h3A5MYtJNy3oy
	 VvAZgRw3kgN8Q==
Message-ID: <sashiko-outbox-206414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: apm-power - Rename to apm-power-input
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Chancellor" <nathan@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Nicolas
 Schier" <nsc@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kbuild@vger.kernel.org, "Sasha Levin" <sashal@kernel.org>
In-Reply-To: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
References: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 06:25:45 +0000
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
- [Low] Input: apm-power-input - update module name in INPUT_APMPOWER
  Kconfig help
- [Low] Input: apm-power-input - missing Fixes trailer for module name
  conflict
--

commit 8f18f8cadb4c04ceefb13fb63bb9751daa2db15a
Author: Nathan Chancellor <nathan@kernel.org>

> Input: apm-power - Rename to apm-power-input
>
> When scripts/modules-check.sh is fixed to normalize the module's name
> like name-fix-token does in scripts/Makefile.lib before checking that it
> is unique [1], there is an error due to drivers/input/apm-power.ko and
> drivers/power/supply/apm_power.ko having the same module name.
>
>   error: the following would cause module name conflict:
>     drivers/input/apm-power.ko
>     drivers/power/supply/apm_power.ko
>
>   $ modinfo drivers/input/apm-power.ko drivers/power/supply/apm_power.ko =
| grep name:
>   filename:       drivers/input/apm-power.ko
>   name:           apm_power
>   filename:       drivers/power/supply/apm_power.ko
>   name:           apm_power
>
> Rename drivers/input/apm-power.c to apm-power-input.c to make the module
> name unique and clear up the error.
>
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://lore.kernel.org/20261108225808.1809266-1-sashal@kernel.or=
g/
> Link: https://lore.kernel.org/20261103110411.11698-1-info@daylightlinux.c=
h/ [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

[Severity: Low]
Since drivers/power/supply/apm_power.c already existed when
drivers/input/apm-power.c was added, should this include:

  Fixes: e17bb1de3b7f ("Input: add input event to APM event bridge")

> diff --git a/drivers/input/Makefile b/drivers/input/Makefile
> index 2cd6e1c9a7784..842a7e4f7b508 100644
> --- a/drivers/input/Makefile
> +++ b/drivers/input/Makefile
> @@ -27,6 +27,6 @@ obj-$(CONFIG_INPUT_TOUCHSCREEN)	+=3D touchscreen/
>  obj-$(CONFIG_INPUT_MISC)	+=3D misc/
>  obj-$(CONFIG_INPUT_KUNIT_TEST)	+=3D tests/
> =20
> -obj-$(CONFIG_INPUT_APMPOWER)	+=3D apm-power.o
> +obj-$(CONFIG_INPUT_APMPOWER)	+=3D apm-power-input.o
> =20
>  obj-$(CONFIG_RMI4_CORE)		+=3D rmi4/

[Severity: Low]
Should the help text for INPUT_APMPOWER in drivers/input/Kconfig also be
updated to say that the module will be called apm-power-input instead of
apm-power?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-apm-power-=
input-rename-v1-1-0609e7b91825@kernel.org?part=3D1
