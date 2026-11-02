Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622969;
	b=5SOe5s4Oe/eu0SwWOzgIPOC/LXdKDCkFUQr7d5WsEx6ikQF7V5IlH8DVEg6+30d9Vg8v
	 9sqteR+Ni7FFmCybamWUubjfDlZuRLDvw5OSBLcSfII7fwX10LOdxRe5lDm5AWgChzJYs
	 4TxmJSHT+jwEEO0IIsluxfKNqEhA4Y9WuHnpxblcHk2NJ23i9jCQwg/jpDCdnGxF4Mppf
	 SkNcC46COUYM3vU/R5HTFN40fA+f4XK+P5FD0K2WfTfOVMB1AH2UTCYw2SZzveK9c4czM
	 zpAJTjjmF8W1kUHrCGaFacf3xZAjWWYSb1t6p/yqjq+NRihNHKNvR7KyUnDoyBAseEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Disposition-Notification-To:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=M322gxN17KH2FpLbwEqFxfIE1eUVU6+ZQO7JUqapB7A=;
	b=3wtD7NhO+8iea/VDyqTTEV79jDHuJpk5f+dbJDdApHZRRsYC/xVhjHf4uz/7eqslUSIe
	 1zjP+KTHSoPdxx7GK0Sqn9RTMaXr9iLjPzMdWdEKt78Jy//LohFrr/scNeZQQgUWgAQcy
	 RCFhurrEoYZH/KktU19hadDv0i+C1unrRVwnwiRDP1gj8i4p7QoucLjqt/pwDnqtlRoZv
	 iKVoEN33wjZ5rcOvvLMC3uL5GMumuCmFBCSwAynNdXRSSccKhKrzjjNu2+Mb3B71DMqqS
	 sVA5BmOn/iw1TZ1Ui/C5ds8UdVXg8uBQngLRvPMQ3Ur2+rBfYiFhNy2WxI23YDCIuCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5CiVmW6;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA063606A32F
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA063606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5CiVmW6
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab3c0e7298so6058201fa.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622966; x=1794227766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M322gxN17KH2FpLbwEqFxfIE1eUVU6+ZQO7JUqapB7A=;
        b=c5CiVmW6TC6wzhilCy2vRAOjt377rQOFvnTggK30VMkmy3zHL8cjaFj3kEfM20B7V8
         S6MqGtKCdWYPj+71NvS719/pZjRnNbji4M40tk9LAAqL9+2GNQrhs5ef8hvWzRxpKF0R
         Ypu7f+N2BzXigxVRJEM2xymxy4BYBu7CATH1NeSvlsJBu6Gqe2OobIDH/CUAcysBRDS2
         DUGfWArThmDBRC5zzEMfJ+4/MY0b7CT86GFT2eAfVaEL5ZE+oaIb5H1FO3wC/43PUVVC
         6FsrVSrr3GGlULr7XBfLYmaD8AJHuw20cBeP61bZj96ONnDPk0mdhObdLXnCjbxGcGVl
         IgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622966; x=1794227766;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M322gxN17KH2FpLbwEqFxfIE1eUVU6+ZQO7JUqapB7A=;
        b=RbjAxXN3WoXb19IqPLz/bWwyCdcfgchePIkOn/PYvZRGrCnLFrlL+5lbq6zA1wnQXX
         FFJ8E9yucmX+pQVJQazqSXLLH22jEtYVRuGyJiQu1sqOe700FVMLmDIInfSZ5lSXssTm
         8DYcNLRTQ7ewxRC/Wa9RBGPU3pXOSkJc5SxQ9pIpVActoFvVo8M+NlO8YI9+LXrNnSWt
         32yv72FyyMJ1Cq1ToTnCPaGasTquhq/xXliXc+Izk8F3vg87K31THFZ300au/6nbFYes
         gg+GbndjLpiYSGvsmf/LPsKbTjNFB3CMuhQivwooD41KMwBwhhU7mLeWiSmnZ8K2uYPi
         uYQg==
X-Gm-Message-State: APuU4Z9nIvWiUG9i5qltHbPzOJKZejHBa8IAKL8Pa9g7dRuV5GXmnqxL
	wcahJnPeZ9Jj6LwlX+ahr+nx2YwJxAzwS+wDNMXNZ7yV+S+MeygnyQQdd+hShw==
X-Gm-Gg: AYBFou2LJVN2FkSuOit44z8rK0VilkcSVlWMBY40ixfouXZbPexDuxgezSbkjtxXBu5
	ArMz0fD1tlrATjiexzAy9CmUWVfl7PrTE3vwoPXp4Z6JeNXHseWvVRIL9r/1bAyaBSdPRRzfUZ3
	lsyCarihd+dMrn0RaPP37/xtK4ApEGC9wUPPxTLbJ7/+/xUVa5wMnrCQBctb74QC6kLJIPHjcp7
	3Vcd2h29iV7A0E0XJEhrF+telMhK0oSWORdNkqYt328ZRZyQSjhLSspqgOGuxLLZylWeQoO+y+U
	ziawy+qpACczSyUXOMV12SVY3lC0fxKvFXSJdMC7ffvbezfi9x2ZHCA3qtBDaUjfz9dH3eBjq2U
	3eUb4kRvYUY+zQCL+yE92SMdiF0hD9n+t/0WnOj65sF9zKUuFo0YOmbpItl1vdPLzZLQvpI7p7H
	4fTWHAvC/nn5GXmqCXCdE+f7NBROnxDmKILZE4S7gey7AyNlKFoMNYxTRlJ3z5EHM0yB0GyCHDa
	kKr45a/1y+71Be3H6Uy1oEQWZjwi4ZsAslXiu8Avc8JUJFwWIdi6cbRLKQThxtLXmuEucCGZeds
	0tku8SaTiavb6O8PseAROIMwV4usbx978vgQXQfmmvj54MBplhOLnktg6XmtKGgZDTl9qOr2sDh
	qeEkGq1cZLrpXJw==
X-Received: by 2002:a05:6512:159d:b0:5bf:ba43:fa67 with SMTP id 2adb3069b0e04-5bfd95989a1mr4171090e87.6.1793622965865;
        Mon, 02 Nov 2026 04:36:05 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07551e2sm1599770e87.84.2026.11.02.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:36:05 -0800 (PST)
Message-ID: <b27645a5948ec37836a9186f0eb4699b6d6fd87a.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: fix undefined shift for infinite duration
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:36:02 +0100
In-Reply-To: <20261028-b4-pidff-duration-shift-v1-1-65028c6b4a37@cherr.cc>
References: <20261028-b4-pidff-duration-shift-v1-1-65028c6b4a37@cherr.cc>
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

On Wed, 2026-10-28 at 18:55 +0800, Shengzhuo Wei wrote:
> pidff_set_duration() computes the infinite duration as
> (1U << report_size) - 1, but report_size comes from the device's
> report descriptor and can be 32 or greater. This causes an undefined
> shift. A UHID test on x86-64 triggers UBSAN and programs a 32-bit
> duration field as zero instead of 0xffffffff.
>=20
> For report sizes of 32 or more, store -1 in the s32 field value to
> set all 32 bits without shifting. Keep the existing calculation for
> smaller fields.

Yeah, that's a good idea even though finding a real device that would
trigger this would be quite difficult.

>=20
> Fixes: 1a575044d516 ("HID: pidff: Compute INFINITE value instead of using=
 hardcoded 0xffff")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> HID: pidff: fix undefined shift for infinite duration
> ---
>  drivers/hid/usbhid/hid-pidff.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..25b82e7d0b9e 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -394,7 +394,11 @@ static void pidff_set_duration(struct pidff_usage *u=
sage, u16 duration)
>  {
>  =09/* PID defines INFINITE as the max possible value for duration field =
*/
>  =09if (pidff_is_duration_infinite(duration)) {
> -=09=09usage->value[0] =3D (1U << usage->field->report_size) - 1;
> +=09=09if (usage->field->report_size >=3D 32)
> +=09=09=09usage->value[0] =3D -1;
> +=09=09else
> +=09=09=09usage->value[0] =3D
> +=09=09=09=09(1U << usage->field->report_size) - 1;

I prefer default operations instead of if/else. Just a style preference.
Would you mind changing this to unguarded
`usage->value[0] =3D -1;`
and then the previous calculation behind
`if (usage->field->report_size < 32)` ?

>  =09=09return;
>  =09}
> =20
>=20
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261028-b4-pidff-duration-shift-8df4f6451448
>=20
> Best regards,
> -- =20
> Shengzhuo Wei <me@cherr.cc>
