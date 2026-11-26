Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671391;
	b=JULBztv9fDbL6iXbylUrpEzDN53xR+wU015HbqBKWkiaQBen1YqSCn/Xs6I3XQ4juz/9
	 D3O/PiUxz3ZmM9oW2Y7JqzBAlzKp089fDK53w9faT1wl9N3F5rK7W/GKvmrO/5o/3m7vY
	 w0vMddMg63VPMuitCQ0Mug92irCiVvA55ES0KNNj09PZAP8bXHOspgJgRynRXtqNqLtRy
	 ofIj4Hp21cHb06nVaEPnLK2iptfygTD7B91NKJefCPPwJepAsfMhEotwx6LJt71Oaj+tQ
	 JG7Se4M5k4UYWOtjZ8GSkkqtOkgzlT+aeiXNiqDAD3YaE0YII/wB70uEgQA4SwrESXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5dK6+Mzn5t+r55VLgXke8ayjNPvYDWOxmT2Go8+ae3s=;
	b=KXCE1okPqpvY3kM5S2h6ldT8vdm9djoj+nBa0sQHV90093ZFUhEk2BykLB/zScNsSxQn
	 0+5Swl7WOTkLrDc6Ni1CDCPC7Ie2NLINZ4HThuXrJqrHffg5WX+c30aejIXkQfPmAc4Vp
	 0lt7lh60tyA7hyFATGTDyFNv2ux4L1qw0vpYWzGMZXFj6nKbbuesjKerpXCEcVLt+thGA
	 VEL8cWag/zONwXlV/HcO2TvvRGL62WBQEC7bI2ujVm/ulFFa4fmvFa0eDVRmni34W1Dh1
	 PAO2/LpX5611XpPtSzzRZbQieoHEHZsx2A4w1nEBhC5UElWpjgPTfifMJz8y0o/qX9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIg4WuE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5728606A31E
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIg4WuE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DC81F000CA;
	Thu, 26 Nov 2026 05:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795671391;
	bh=5dK6+Mzn5t+r55VLgXke8ayjNPvYDWOxmT2Go8+ae3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIg4WuE5+cS+D35iEiGt/l1euOODTJetfAVKYICXiyNP76ETzjU/trEhTTqNrngtv
	 4jxYomDA7AOPRIJiWQuTU43v+oHyvj4q4f4tigaKuzhRgzryOiwFD4+l/xkao9GwSC
	 QqqmVWGhn+NQCoPDn9TtHsjxX0oKB5NHWc1nef6RYnv2FrmXcUSMPY34MNdAUteM7B
	 pJt3cr9FnndbJXAq6tvk3ehvR3ZEW4xn/Yj4HERcIT4QrlhFqod3stqakGpry2+Ne/
	 eUg6l8fG9z+xpk7fvZu2VZQTkNEqT6LSm3snCCNWk5nTI1vVC035Ogu0QW2ts0IRWL
	 Svkthhn3zcHwA==
Message-ID: <sashiko-outbox-234797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: adi - use scnprintf() for the device name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aibing Chen" <chenaibing@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261126053234.455-1-chenaibing@cmss.chinamobile.com>
References: <20261126053234.455-1-chenaibing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:36:30 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] Input: adi - out-of-bounds access from unvalidated counts
  in adi_id_decode() [1]
--

commit cf403ee49ba4ff0238dcadf0ca631e797a95d76f
Author: Aibing Chen <chenaibing@cmss.chinamobile.com>

Input: adi - use scnprintf() for the device name

This commit switches from snprintf() to scnprintf() when formatting
adi->name in adi_init_input() to avoid -Wformat-truncation warnings.

> diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
> index e07b71978509b..0b60c8067faf8 100644
> --- a/drivers/input/joystick/adi.c
> +++ b/drivers/input/joystick/adi.c
> @@ -392,7 +392,7 @@ static int adi_init_input(struct adi *adi, struct adi=
_port *port, int half)
>  	t =3D adi->id < ADI_ID_MAX ? adi->id : ADI_ID_MAX;
> =20
>  	snprintf(buf, ADI_MAX_PHYS_LENGTH, adi_names[t], adi->id);
> -	snprintf(adi->name, ADI_MAX_NAME_LENGTH, "Logitech %s [%s]", buf, adi->=
cname);
> +	scnprintf(adi->name, ADI_MAX_NAME_LENGTH, "Logitech %s [%s]", buf, adi-=
>cname);
>  	snprintf(adi->phys, ADI_MAX_PHYS_LENGTH, "%s/input%d", port->gameport->=
phys, half);
> =20
>  	adi->abs =3D adi_abs[t];

[Severity: Critical]
This problem wasn't introduced by this patch, but can the capability loops
further down in adi_init_input() read out of bounds on adi->abs and
adi->key [1]?

drivers/input/joystick/adi.c:adi_init_input() {
	...
	adi->abs =3D adi_abs[t];
	adi->key =3D adi_key[t];
	...
	for (i =3D 0; i < adi->axes10 + adi->axes8 + (adi->hats + (adi->pad !=3D -=
1)) * 2; i++)
		set_bit(adi->abs[i], input_dev->absbit);

	for (i =3D 0; i < adi->buttons; i++)
		set_bit(adi->key[i], input_dev->keybit);
}

adi_id_decode() only checks the axis, hat, and button counts parsed from
the raw gameport ID packet against the packet bit length (< 256), which
allows up to 49 total axes and 126 buttons (or 252..255 buttons on
unsigned char underflow when subtracting 4 for ADI_ID_TPD or ADI_ID_WGP).
Because the per-device tables in adi_abs[] and adi_key[] hold at most 9
axes and 11 keys, indexing them with unvalidated counts in
adi_init_input(), adi_init_center(), and adi_decode() reads past the end
of the arrays and passes out-of-bounds bit indices to set_bit() and the
input reporting helpers, corrupting memory or crashing the kernel.

[1] https://sashiko.dev/#/bug/linux-92046c21-e0a8-4274-a502-20ca723131b1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126053234.455-=
1-chenaibing@cmss.chinamobile.com?part=3D1
