Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108247;
	b=4gbvLxkxPw5EJNplHDegDYex3m4BsH8EjVoTo1jo8x0aKLf/xZCrjZCmPMISM8t6AL9/
	 QXKZEiZD9E5xB3ZsTijmGVB/Gcx+DSeDED1AEGTVlqkit0UkSjfeptlPtx/pekqzIxNxC
	 tocxXeR2UKu6YU1CKWuCSIeNyukMmG4KNC0uU6g81YwR2HKp7EHyJ7JgfREnoASNq+hx/
	 hBKHA5bY5DmUnpNFaXbKSIN/BUTQ9fEJ9lyMkmKatLiF8d4jek+Taja3Wqfzx/EcLoysS
	 sboGx2y/W/4Ay+ul8JBeRN4lvRP5WgFaO6LTPWRG6MqIr9/aSVbQwy83MIxK5xvx5Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108247;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zno5VvMMG/oF44eLzQpcjMF1qT17JskbbSBTiHkfKOc=;
	b=U4ky54yAOrcD2dSQZHD/ysfEoF1cJ9ewMUxINroVh3D+9rJ0medfOOX9lgz1FJJ7xJqu
	 KQpFb7sZmHS+iIjsGedvWVyBfa39Yq4NRo+jNfTIEdamAM/BMsvu0qCQyLZdHdFislAvl
	 x4dIHTUH1x5liNhlpd86HaE1YIbeWrw9UaHipTcScmZm0dQSmLhOBspQ0V9F63VvMi/B2
	 dpzmLit1ZdVmDhaO9LhuH4eTq/ABOkB+I+UfBXV3OtNpzMXHpbTuNb+X88peRGd8dU004
	 PaPAp4Gd/8K4cbIE7CT40GAA561LynJyPVgqxI9YWobLuQIaRgY4V1vMTjvwLBEKPsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrmHozkH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDB606A31A;
	Tue, 27 Oct 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrmHozkH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100771F031E4;
	Tue, 27 Oct 2026 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108246;
	bh=Zno5VvMMG/oF44eLzQpcjMF1qT17JskbbSBTiHkfKOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrmHozkHy7PovB0xG6swk6TdG3uzoqJAqi1RN6ugnc2kCKxVUuUYp6xsxu20JhPuT
	 SdGXcKU9amNs1dOhgYYRohWOA5XVHlNN0ggE3F1Q3eEOBTh6dql4r9+ZKZqjdT57Ek
	 NvltvimBqEFWpXAv8XStXJ3yXIp3HjEFsvZImBD3umBX9Sbr2yR/f+hoflN4vZctGA
	 I5lqhdc2HMWJi+zz9gtLbmE6Qz90Mlfyml9TaW4tFGF5YJjq9eEZDahi2QwJoUqwWm
	 X1i3l3qwvKLJjb0JCmm2plnaZNbZ2g6qcFqXmIzlyGApm+2x6UDL8W+TjnmUQPMI4d
	 q4qoH139EBMJA==
Message-ID: <sashiko-outbox-186657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] Input: aw86927 - handle the AW8693X play and boost
 register layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261027132929.242158-5-xiaqinghuan@mail.ustc.edu.cn>
References: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261027132929.242158-5-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:37:25 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Input: aw86927 - 1-bit AW86938_PLAYCFG1_BST_MODE_MASK in aw86927=
_play_mode()
--

commit c20411cd705818dd58facc17d48437366131a42a
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

Input: aw86927 - handle the AW8693X play and boost register layout

This commit updates the aw86927 driver to handle the play, boost, VBAT,
and two-step stop register layout differences on AW86937 and AW86938
devices.

> diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
> index 42eb531c7e3b3..e8fd880ac1ded 100644
> --- a/drivers/input/misc/aw86927.c
> +++ b/drivers/input/misc/aw86927.c

[ ... ]

> @@ -291,9 +299,14 @@ static int aw86927_play_mode(struct aw86927_data *ha=
ptics, u8 play_mode)
> =20
>  		err =3D regmap_update_bits(haptics->regmap,
>  					 AW86927_PLAYCFG1_REG,
> -					 AW86927_PLAYCFG1_BST_MODE_MASK,
> +					 haptics->model =3D=3D AW86927 ?
> +					 AW86927_PLAYCFG1_BST_MODE_MASK :
> +					 AW86938_PLAYCFG1_BST_MODE_MASK,
> +					 haptics->model =3D=3D AW86927 ?
>  					 FIELD_PREP(AW86927_PLAYCFG1_BST_MODE_MASK,
> -						    AW86927_PLAYCFG1_BST_MODE_BYPASS));
> +						    AW86927_PLAYCFG1_BST_MODE_BYPASS) :
> +					 FIELD_PREP(AW86938_PLAYCFG1_BST_MODE_MASK,
> +						    AW86938_PLAYCFG1_BST_MODE_BYPASS));
>  		if (err)
>  			return err;

[Severity: Medium]
The commit description notes that on AW86937 and AW86938 "the boost mode in
PLAYCFG1 is a two-bit field at bit 5 instead of bit 7", but
AW86938_PLAYCFG1_BST_MODE_MASK in drivers/input/misc/aw86927.c is defined as
a 1-bit mask:

#define AW86938_PLAYCFG1_REG			0x06
#define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(5, 5)
#define AW86938_PLAYCFG1_BST_MODE_BYPASS	0
#define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)

When aw86927_play_sine() -> aw86927_play_mode(haptics, AW86927_RAM_MODE) ru=
ns
on AW86937 or AW86938, regmap_update_bits() only updates bit 5 of
AW86927_PLAYCFG1_REG and leaves bit 6 untouched.

Should AW86938_PLAYCFG1_BST_MODE_MASK be defined as GENMASK(6, 5) so both
bits of the boost mode field are masked when configuring bypass mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027132929.2421=
58-1-xiaqinghuan@mail.ustc.edu.cn?part=3D4
