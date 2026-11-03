Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697620;
	b=OY5ICtNGwSkDRhOB/ZI8nwJ1yyr7ds7+O1PONiopsAuv+wtefXIqo6ZqWqsBeAH9SMUN
	 kNo5bMyI+Off1j/CCnBD0fgYYgHnNVEdx1/BUv8PKvTXdv6dbK+qTGsRxgdC5xhKkGaf2
	 WT40E/zr01tmriDEAumXQSraDakbsc4+WL7YpTy5QDq89YwveCoakvS1ipw8m7Szu5qne
	 1UitE65tUCz34XopOtOJcSdFYztOSRtx1spKRYm1rZT7XRw1j2ezI5h+YL9PDEQ3FYnmv
	 zXYY0mii13bA2y6kPMzJ72Gi/Y0BcczLmPFs1uHEe2I0u3nvcUoCFUfkiy7xscoKLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Disposition-Notification-To:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TNCUkOdrDNw6Y0YerpyggbymdScac6P000lKA53Qu5E=;
	b=R9NtgHsCQl35o1A+Ot7mb7evajV5zTpDZIzo0Eo2fU6FkJ8wBKLMrVvUcgRVyVeOW86+
	 w1xEdeJvza9NOtMH9GStyjUTMkgpXUjtMbDCErH8um1TDtTdvQLWM4k19HQbGkvA0/Zks
	 j6SOJQ60wnyOCugUnwgROWB5L55Bt3JnIGnyxwYl8cXSSZERa6la7N/4jkllK/YdWRnY2
	 ENFYfyjML2EVxAgUGbbprmqTZyvSTvq0DdR66liY8WeynaBGgzmho2aBaoWqD4TWmCrHJ
	 t/DUVKRZafGhQl0viwdkdGzpRo+C7KW71dRH5MWrYo/1RX2dzcGQkd3c1gqfy+hojoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MgAXlGvt;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D6606A338
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B8D6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MgAXlGvt
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c41d20c016fso68596366b.2
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793697619; x=1794302419; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNCUkOdrDNw6Y0YerpyggbymdScac6P000lKA53Qu5E=;
        b=MgAXlGvt3N4HPmYe4BFyl00Qw7aY4cTpOPdLrts5i12nDmokkC38bTWwSetKa3NoYY
         JZqP5sWhuckQoSdqZ0yZvL1x1kKXVozy5G9oAHmArdJizqr+uq7rA5706M7tSOuYs1R7
         RrVysGMeJe22az4/DYIain/haTwAwwdi3exTWR152z4dkQx8qDcMUj9/P/JsScc6kq13
         JxYIwmGHjXIIitvY0j1zqJlwy8BFd3BiEwOGTBmeCUr0yTm7A630uFw6YvKzHNpzxkIA
         qevdaMPZz5TY7i5N8wlW0BN5Yb5Y/81WvJ2GT0A1XVyxSShxQMP19kpKSDJqwPAvBbWu
         xPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697619; x=1794302419;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNCUkOdrDNw6Y0YerpyggbymdScac6P000lKA53Qu5E=;
        b=KQ1OhIXhhBOEBcjcqQW3XEUZHGRqiv7Wxjf7S0t/a0kT2ICV4R8RK177pzbMuHDy75
         tl4oRmb1bEIi+2AiUE4hlJFyds/BTEtwAWQ6sf7fs5gCaMdfogrMH8lan5PzFeCsoBJf
         hH+g5xTpZUHd3hpnAlSqjaWLM/J6ZfKBUFGLu3H/3ZQos40dqkXkoF8SezxOyxtyN0oK
         Os5QEZ/out6w/QRru14Ymy2IKj7dCuZKngsqyDN502dG8ekonhgsuluNHyZdCErLABhW
         TqDsH0AIDZV+kaR/OCR/3x2NI5zGDZyBlK5f23toZdmQjm2CHcn2jYLDNMxeMyMMY6i1
         TeOQ==
X-Gm-Message-State: AFq9FYLATOJdMcQMIv1bVNPO0DHMVrhjaOwmph6DDay62qCfKWyCUx+p
	R8BWMRQeNvVt/XmB4RqCYXIeoWfmL5JdAFZsZ0hQ60MeZroCeX/nFzIV
X-Gm-Gg: AYBFou3l8UbEDLNgOREe7buer9qA4L2PuZ/mn2vwy4w/707xVC1dKsVUSjyMGoiDvte
	LwlvTN+KMcvDnvb0m8agIqaWUSypx6b7FqsknW4/ZqhqHUMJdJYSZEcnzFgysge3ABxkxcspkFH
	mE4kesnOlVc95gIHKDQAgHSDrghJnfLOR3VTM4RePhvTTCw4nakg2Wxf4C7N4Q9fra03cIZlK7j
	zS0dtNE1PGZCqmbSZEmfRwRs03ViqoQtHulcmnf0T03q9y3UxTV34lF40exm/qabmV+zaS7Ieei
	4CbFLZKVFZj3UraBhT555fgDR894YIVCAyTcTptn+Donv6Wd2KgCzco9elFCnORi2SR0TF60Iu8
	Pilk9LrYNPcKfGMWZivtE8FSi7dsa/dzwkk9ubp733F8mWDrCvIFzBXIxFl89ZAPDvBhzxiz7dg
	QBxszdDN0SfvWcrBiK54QlpeBuHnfIE2edJlLl22bCz518s8YlHKLkU7c6HhErbNu/w1Q9oR5r4
	P0xSZdO1ItnHJljAiFl10FUUsLJ3WM8uo95h1A50vTaQ0EmAcsgA0/65Hfhs/tQT9kLldJfs5F8
	6pTdDWXLTff/kQAd2xltfOAOiOgFgJqTY9d26Wqz1r4fi5PQQ+WuN1SaFlh5YJM9Cj8zcq8GZ9n
	j9kWBXu8kcF/msA==
X-Received: by 2002:a17:906:351a:b0:c34:db91:aa1e with SMTP id a640c23a62f3a-c4ca7aa020amr977638966b.4.1793697618437;
        Tue, 03 Nov 2026 01:20:18 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebf37c9bsm67920366b.48.2026.11.03.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:20:18 -0800 (PST)
Message-ID: <86a644201b1938155af01f3e2b7dfb71dcca159d.camel@gmail.com>
Subject: Re: [PATCH v2] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Nov 2026 10:20:14 +0100
In-Reply-To: <20261102-b4-pidff-rescale-exponent-v2-1-a75bcca65fd0@cherr.cc>
References: <20261102-b4-pidff-rescale-exponent-v2-1-a75bcca65fd0@cherr.cc>
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

On Mon, 2026-11-02 at 23:23 +0800, Shengzhuo Wei wrote:
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
> Also warn during initialization if the duration field's unit exponent
> is outside the range -8 to 0. This helps identify unusual device
> descriptors without logging on every effect upload or changing the
> rescaling result.
>=20
> Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field unit=
s")
> Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>

Afaik, the tags should be in a chronological order (my review on the
bottom) + reviews should be removed if patch contents have been changed.
My review is no longer viable for this v2

> ---
> v1: https://lore.kernel.org/r/20261029-b4-pidff-rescale-exponent-v1-1-3ba=
54accf767@cherr.cc
>=20
> Changes in v2:
> - Following Tomasz's suggestion, warn during initialization when
>   the duration field's unit exponent is outside -8..0.
> - Add Tomasz's Reviewed-by.
> ---
>  drivers/hid/usbhid/hid-pidff.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..4540f49fe6e3 100644
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
> @@ -1428,11 +1428,19 @@ static int pidff_find_effects(struct pidff_device=
 *pidff,
>   */
>  static int pidff_init_fields(struct pidff_device *pidff, struct input_de=
v *dev)
>  {
> +=09int exp;

This driver no longer enforces C90 standard (in line with kernel) so
please, declare the variable where it's needed.

> +
>  =09if (PIDFF_FIND_FIELDS(set_effect, PID_SET_EFFECT, 1)) {
>  =09=09hid_err(pidff->hid, "unknown set_effect report layout\n");
>  =09=09return -ENODEV;
>  =09}
> =20
> +=09exp =3D pidff->set_effect[PID_DURATION].field->unit_exponent;

So here, int exp =3D ...

> +=09if (exp < -8 || exp > 0)
> +=09=09hid_warn(pidff->hid,
> +=09=09=09 "duration field has unusual time unit exponent %d\n",
> +=09=09=09 exp);
> +
>  =09PIDFF_FIND_FIELDS(block_load, PID_BLOCK_LOAD, 0);
>  =09if (!pidff->block_load[PID_EFFECT_BLOCK_INDEX].value) {
>  =09=09hid_err(pidff->hid, "unknown pid_block_load report layout\n");
>=20
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d
>=20
> Best regards,
> -- =20
> Shengzhuo Wei <me@cherr.cc>
