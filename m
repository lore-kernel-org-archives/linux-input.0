Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24B3A1DB;
	Sun, 12 Jul 2026 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783823080; cv=none; b=NZY83US2dBi4hak5QZup/Rxt9HgzAdxw1vCx1xpLqPUIPsU9DGPiA7uNt7oQcgKsvSkDqsmq+ccyY6Cbg4D5d9Q6vTpVswFk7bJRROx4i6DqR8aKFhLyW3cZcwFI5KCPeis3My8IctQ0GXQbVx5prLLykKWp87thOaaOYaRCF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783823080; c=relaxed/simple;
	bh=B16271FM15730QMd4sHuPZU9q3MpuPcEKq91UbQZDQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=riMBBuQaIWpP8isUdMhplVCUHNDBQU5Uujnk74s6M8YMEbTgj0oPjz+Erw++tTd+BGRUGBTd1CpFvScN4//j7ApOO/CToaLm0FermPTFImjUTcXtx0hTg+HrklnbrTASPx/SPjjIzFHUqUCQ6roef46eG+dN7lJcF2L9oEhWhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkLZBgEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkLZBgEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A511F000E9;
	Sun, 12 Jul 2026 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783823079;
	bh=Rf7u0BpTyC6NvAFqLALM3wQTxRpBOT5VgA6ifCTY0QY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkLZBgEI4MT2SenICqEsrwdNAVQbH5loWcM+5hqWArZRj+3WmpgvXaK/kbnYxIzuW
	 kEiawV7JaHled+lS1VYL7h/tNK0xZ/BwroeChyqnBDOIrsWs7u2bjY5INyBeary3vd
	 MEgxkut9zWoULE0V/iITgeA8uFpv5Wyiz/v7F1ndiEab7qBEtt8OhCro2gKCrXxHbQ
	 /jNoiWJ0tYRSBGQTCxBhd2u/D/ZnSu6AqAk1mKRv2yhj43fSRFbkql24H/yuWyuJ82
	 F3jDnsa+TQWW2BeYkQ7x/hrk8CatTzcw2EOj/sJr8jWKfPUir7oedLZKEqLaOvym9U
	 PlLwufmF4AxeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] ARM: s3c: register and attach software nodes
 for Samsung gpio_chips
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260711-samsung-kp-v3-3-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-3-b2fcaba77aff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 02:24:37 +0000
Message-Id: <20260712022438.B7A511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The 4-bit and 4-bit2 GPIO direction configuration functions perfor=
m read-modify-write operations on shared configuration registers without ho=
lding the chip's spinlock, leading to race conditions.
--

--- Patch [3]: [PATCH v3 03/10] ARM: s3c: register and attach software node=
s for Samsung gpio_chips ---
commit 8053fb79cb15e3c5c2e66691008b5adc30b3e152
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

ARM: s3c: register and attach software nodes for Samsung gpio_chips

This commit defines and registers software nodes for the Samsung GPIO chips=
 on
legacy platforms. It attaches the matching software node to each gpio_chip's
fwnode during registration, providing the infrastructure to convert board f=
iles
and drivers to use software nodes instead of legacy platform data.

> diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-sa=
msung.c
> --- a/arch/arm/mach-s3c/gpio-samsung.c
> +++ b/arch/arm/mach-s3c/gpio-samsung.c

[ ... ]

> @@ -659,49 +695,49 @@ static struct samsung_gpio_chip s3c64xx_gpios_4bit[=
] =3D {
>  		.chip	=3D {
>  			.base	=3D S3C64XX_GPA(0),
>  			.ngpio	=3D S3C64XX_GPIO_A_NR,
> -			.label	=3D "GPA",
>  		},
> +		.swnode	=3D SAMSUNG_GPIO_NODE('A'),

[Severity: High]
This is a pre-existing issue, but since we are updating the 4-bit GPIO chip
registrations here, should the underlying 4-bit configuration functions be
updated to use the chip->lock?

Currently, functions like samsung_gpiolib_4bit_input() perform
read-modify-write operations on shared configuration registers without lock=
ing:

samsung_gpiolib_4bit_input() {
    ...
    con =3D __raw_readl(base + GPIOCON_OFF);
    if (ourchip->bitmap_gpio_int & BIT(offset))
        con |=3D 0xf << con_4bit_shift(offset);
    else
        con &=3D ~(0xf << con_4bit_shift(offset));
    __raw_writel(con, base + GPIOCON_OFF);
    ...
}

Similar unprotected read-modify-write sequences exist in
samsung_gpiolib_4bit_output() (for both GPIOCON and GPIODAT) and
samsung_gpiolib_4bit2_input().

If two threads concurrently attempt to change the direction of different
GPIO pins in the same bank, could this lead to lost or corrupted
configuration updates?

>  	}, {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-samsung-kp=
-v3-0-b2fcaba77aff@gmail.com?part=3D3
