Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7312F60CC
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760722; cv=none; b=lFQgRLfnJame6k4upqICcxf8OR0NESEx7eHUyRWZYWdIHR0VrH0Z8rLCESK0vZPmniu44qF5cXhsR+cqubPa6mjIoRnIAV9FUGBOOG3i+11ovgpjyiDwF8X+k0yezwX92XrkoPDqD9jsZxOOpWCr2+DzqPgS8qybtPf9Vf+0u/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760722; c=relaxed/simple;
	bh=CUe/iqTYyCQV6I9AoA2tEKfvqjXEGxHxUpqRczHcHIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KyEgHG7YWm725IwPpOn/OQyJtwuSCwoqEItEjhKsZrNK2mXkm1PiF/13Q4s77XqDiFWBiuQ+23NiaJWGbA0ICpuTJKGYFH50jEidDb/8s40dN6/LymF3i3wyqce/wedoOnWqlHsW+1CMkSkQjBUu+k257ps/VO6xE1+0kuLEGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+niLdqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+niLdqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F081F000E9;
	Sat, 15 Aug 2026 02:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760721;
	bh=+t7fKWqRAvWdRWrDzviBLk+/oLHezUCnXLQYL1SJbUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a+niLdqwqpmZbjCqWFaKxztaP69ywARRPHMF9qUAt0fbDVPw0G4zd9U+JZMD9VFyR
	 LocZWAyXBhKpOW1Sr9gMkpKkOSHelRXt8DA5upzQqFp6X+y5KeU9bPsfe33vd1Sq7L
	 LKiA17gGCRI+Ba6xwo/vF3tXeAqbTrquxs/hxb7O6riSV5tI3Ny2eB5yBes2qATExI
	 m+alWLsKry8azkz9CSak7oivjCnccTYZgaQhYHtZFVJyqasFymxilEVP8GS+Rrxh2F
	 IU2ObvJ+2MOAoy6JMPPzMxmIOZ1GUvt93/1H8lCSusozTzrAnXp69QcrcP0KMveA9j
	 XV5DNeS16Yyzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: hynitron-cst816x - ignore unsupported gestures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianing Li" <m13940358460@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260815021821.2896-1-m13940358460@163.com>
References: <20260815021821.2896-1-m13940358460@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:25:20 +0000
Message-Id: <20260815022521.34F081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver passes stack-allocated variables (`tch` and `reg`) as b=
uffers to `i2c_transfer()`. Since stack memory in modern kernels is mapped =
in virtual memory (VMAP_STACK) and is not guaranteed to be physically conti=
guous or DMA-safe, this may cause a kernel panic or silent memory corruptio=
n if the underlying I2C adapter attempts to use DMA.
--

--- Patch [1]: [PATCH] Input: hynitron-cst816x - ignore unsupported gesture=
s ---
commit ac0089fd4854af750c6a0b96cd68ac7ac4980ba9
Author: Jianing Li <m13940358460@163.com>

Input: hynitron-cst816x - ignore unsupported gestures

This commit modifies the CST816x touchscreen driver to ignore unsupported
gesture IDs. It returns an invalid slot for unsupported gestures and checks
it against the configured keycodes before reporting the event.

> diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input=
/touchscreen/hynitron-cst816x.c
> index 47d9cd7412d1b..d0668ac96f9af 100644
> --- a/drivers/input/touchscreen/hynitron-cst816x.c
> +++ b/drivers/input/touchscreen/hynitron-cst816x.c

[ ... ]

> @@ -169,6 +164,7 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cook=
ie)
>  {
>  	struct cst816x_priv *priv =3D cookie;
>  	struct cst816x_touch tch;
> +	unsigned int gest_idx;
> =20
>  	if (!cst816x_process_touch(priv, &tch))

[Severity: High]
This is a pre-existing issue, but are stack allocated variables safely
passed to i2c_transfer() here?

The local variable `tch` is allocated on the stack and passed to
cst816x_process_touch(), which then passes it to cst816x_i2c_read_register(=
):

drivers/input/touchscreen/hynitron-cst816x.c:cst816x_i2c_read_register() {
	struct i2c_msg xfer[] =3D {
		{
			.addr =3D priv->client->addr,
			.flags =3D 0,
			.buf =3D &reg,
			.len =3D sizeof(reg),
		},
		{
			.addr =3D priv->client->addr,
			.flags =3D I2C_M_RD,
			.buf =3D buf,
			.len =3D len,
		},
	};
	...
	ret =3D i2c_transfer(priv->client->adapter, xfer, ARRAY_SIZE(xfer));
	...
}

Because stack memory can be mapped in virtual memory (VMAP_STACK), it is
not guaranteed to be physically contiguous or DMA-safe.

If the underlying I2C adapter uses DMA, passing `&reg` or `buf` (pointing
to `tch`) could cause a kernel panic or silent memory corruption.

>  		return IRQ_HANDLED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815021821.2896=
-1-m13940358460@163.com?part=3D1
