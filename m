Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623474;
	b=oSxhPP+5VwWokXjr200Jbkp/jE/+3u/rJw1qyHbOH/GMs0SqoJNaB5Jg7/mntYu4W6xD
	 1Wmyn2Qtmq2S7UYMkhy7tfUXiIrwTswQtYRuTU9+gsp1P3jGYOVu/xFfZv2V1WgOA8g3e
	 LYkTuI8eNmRg1u3A24AMTH8qjXEdEn1C4xjwNZdxF67l8NKiTGpYbvCjw5rG9Jhfdonkb
	 8C+OBCxu7wOtC+HNPd8NMdp7IRCRf2Fm0CN++KLLl+8D4Vth7LPQD3nuWxwVQg7LLAQZj
	 C6OqS0+nWDpmqKOTL1NyhB48CYKTTYzYOpjGGuIDUlphoOvHbKqbzq8f0CH51gzzkhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Disposition-Notification-To:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=dYanbEJ7ydWKIVlseZIgyCbLcRNjwGo/7gUCZwqpJKs=;
	b=4AkZd1hpYEg9DQ3+/ZNxzPus9aeQ3dlnY3mLMW47B8gu+3/tOK0duhEM9RYTHhGaHu31
	 FoGf5/zWUMHr655MktvId63B2qUNCYDZdfB6LCuA0XUYUMVKAgnxCsVy47I8cD2/MCFgR
	 fdEvQ+14PrrKKh76e1CzJv6k7FKZU/vj1CXRWtsu/8zMQnLfnRJnU0Rw9s41wGQ4YFIpJ
	 b2jZ7b6mLkp6VeHuSU+PFKtXnUn/2hsY84JOpbDBavD9LjS3WaKjYctxzqu5dUPBV4fR9
	 Eif7o4ArVaN7ATXRhteeBADiQRhKEWXkM7WjkC4vW3HaIgFMh3I1wnT1fsMZbWocfyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipripHyn;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387660A3838
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D387660A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipripHyn
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14ee2d0bso789402a12.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623472; x=1794228272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYanbEJ7ydWKIVlseZIgyCbLcRNjwGo/7gUCZwqpJKs=;
        b=ipripHynXFhBUZYO3ONkgpAkySdmoxAaDbs93kVcEyX1tuR6xSxgQMnbjh+OfX4ozK
         3ROdQxJdv3Vh/6K70Ycd/gX7I1HGc+HbdWgEcCn281ZdUL5H66Hb2hfk1oIwK8OyZGCV
         YqFq0wo6Z48sEqRXQJVBxDPjcHuXWpPtINRmOjaKecvPs6TuwLfdDiPm6RuhX6UabD6J
         3PWpz/tm8vagnQFLxPv/SqjZySmGtt8OdhXGJhHWx0svC6YSsK4K/BHln98i0VrJwGQB
         +yYMwH2I5/K64IWYRaWxD1RnvziHZPS0ZDU2Yv7bxaUKh4hD44bxeluaiDP3p5/RpAKz
         ERqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623472; x=1794228272;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dYanbEJ7ydWKIVlseZIgyCbLcRNjwGo/7gUCZwqpJKs=;
        b=ABOLV9WU+AhVnxbTu8Zs5KGj4bbXQJdbd7hj9be68/pFb8OF0UW+mG44fFPY185lHC
         93n4WaInW2CseyAHhvQ9tGYoDoGQaKyV7IzgBixdcoYw+0w0RwF0QIzq3SaWQsvCliQs
         7bfNHx/Tua5aRFP51P60hIcESWUZClT/RgOUzHoP9JRsOIFF4zhW7qfyo28Eg8ITJ3In
         MM2aleUqTghTbOCFbyG/8vrY7udtKkSnyAHJPiRFZIi4//4leuEsYJuJTcbDDz5j6eeD
         Yyx3NQureq/IUofdWP/lA1vyIh2DUJ/in01GMQSkgHUD9PcqMxMxm16Og9OB8Rk7513c
         EO4Q==
X-Gm-Message-State: APuU4Z+0UbgJuLzwMLlW3IQ+3ikpVCCfdRIKaa6MQr4NwtXMvxmULLzL
	PAmy2qKQfi5Tk+/2UD1YeJqUJgoNjQ/6yyFvfHcebZsDcV4EgzTMWyMu
X-Gm-Gg: AYBFou2qoGPXiAr3KBky7/nxq03+TZTXq0TXrGFGVlhn9s9797/PebuPbzdDMdB5Pf8
	LLMw9G8zTKdWkA4b6Gzc9fNmvS5H0ewjvZf0EP/lqqYlhUYIFzUmW94c3v0LhCAVGntP47blrX3
	dbhgsoQY2YLMvuhTSYxPZffwOpr+bqRnRU6IpYxMJYhGSa4WPtG/gNY1h51qNoHcZ2GeCCsWXEl
	w7xepsyuWMGqX6vuYkhmL1CaPDZM6dlMQprJLCGasnGkO2zVpQLYeQ6Wos0xZ2mMkI4R0xzWrrk
	hUDlp9vWOZ42zaTl6g6kysLkvUOkf5oPF85GKwom/Zj+WGsL3iQoJ4Pz6+kb94GJoDpVZkJr6aZ
	NFHUzYT14dJZuacLrO5cGHfjZwEXabiC0nEuqd6sZjL4SJ9asTWGXhlW2lfGN3MGDqJVfy4AdXx
	x7ov5K2JfOmvNYCQtoRbGCgk8TDN7EcbqG9QmIpSkJXV1e054A9QbhLxJLam0+sMjfiXPJE/X99
	z9nJzs8JXxVM1yZCcKj3ULg2EdXjEjYwyigE/o5ojBJOYh5PvpM4Eu83/KPF9TUmu7SiG0jpXHy
	u9rLJ8wYtj6SO98ZaXGO0kcgCWEHTWIN5cx7XhMaAZTxhDD0C+gNJ3OHZ/5mbk0ub/N4j2hgAZd
	IrbXT0nIVvGe18iB5u49lXuZgxICsKqrkTFI=
X-Received: by 2002:a17:906:178e:b0:c46:b5a7:5b29 with SMTP id a640c23a62f3a-c4ca7a50798mr780727266b.2.1793623472076;
        Mon, 02 Nov 2026 04:44:32 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca214fdsm3152504a12.36.2026.11.02.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:44:31 -0800 (PST)
Message-ID: <bbd1ec87a9fff50b189f74cbd21e1d5bddf41136.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:44:28 +0100
In-Reply-To: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
References: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-29 at 00:04 +0800, Shengzhuo Wei wrote:
> pidff_rescale_time() walks the device-provided unit exponent one step
> at a time, allowing extreme values to cause billions of iterations
> while ff->mutex is held. In a UHID test with an INT_MIN exponent,
> EVIOCSFF took 3.1 to 4.3 seconds to upload a finite-duration effect.
>=20
> Stop rescaling once scaled_time becomes zero, since further
> multiplication or division by 10 cannot change the result. The u32
> value becomes zero within 32 multiplications by 10, and the u16
> input within 5 divisions. This bounds the loops while preserving
> their results for all exponents, including wraparound.
>=20
> Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field unit=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>  drivers/hid/usbhid/hid-pidff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..1a2fffcf204e 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -354,9 +354,9 @@ static u32 pidff_rescale_time(u16 time, struct hid_fi=
eld *field)
>  =09int exponent =3D field->unit_exponent;
> =20
>  =09pr_debug("time field exponent: %d\n", exponent);
> -=09for (; exponent < FF_TIME_EXPONENT; exponent++)
> +=09for (; scaled_time && exponent < FF_TIME_EXPONENT; exponent++)
>  =09=09scaled_time *=3D 10;
> -=09for (; exponent > FF_TIME_EXPONENT; exponent--)
> +=09for (; scaled_time && exponent > FF_TIME_EXPONENT; exponent--)
>  =09=09scaled_time /=3D 10;
> =20
>  =09pr_debug("time calculated from %d to %d\n", time, scaled_time);
>=20
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d
>=20
> Best regards,
> -- =20
> Shengzhuo Wei <me@cherr.cc>

Tested this locally and works nice.

Should we maybe add a warning to the driver that the time exponent might
be out of a sane range? Sane range being, say, 10 to 0? This of course
would have to happen during init stage not to spam dmesg.

Regardless of that:
--=20
Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
