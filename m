Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C6330645
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117514; cv=pass; b=SelekHChGKcxbDaFWhVjeczAQPJ/igVEkZVrmggNoyOfWER+CLyEztADhNMjN1vl4h3pWE0B7J7XBEq430LIFIl77XlAGxx+GU3+kSx8tX+mbG7TQf3qsIaKP7/Nbbp5LThqCjkB7hZFbstAnUtojoCe+vKm/xOcXPVwtX6Tv98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117514; c=relaxed/simple;
	bh=x0ozsReFvwxqdxxBW0bsucHLklQvL5qKhZ07z2jxlOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4MM7Q7WiqHnGZ++v5Bmw5e4qa8W5oOH13RN6tIe0pmH4IGG074sjQjcyJ+2PyB9dfVbqNHd2Q8u8XCWRNLie8b40S8gmTFx0nikF+vwnpO4tuyQ5O9YADzMjcEpgn9vmAEeOEu2fa4zf7vIy8YXZ9zqk8HU8t8da8wh2Nei0sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR38R0no; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR38R0no"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so43362445e9.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 03:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770117511; cv=none;
        d=google.com; s=arc-20240605;
        b=gCBzX22P848pOXMSbLSMKyG00X5skUnliZDu1af5WKBygDumoCdKtJ+B++Kmg/UC0s
         qo5ZXyJT3hIp/5H+IvqRgbDM0z60QdY/RipU5qlYvB8lkgooLQABbl6T7tATJULkje7c
         38mNRtsExVVjd9E7lolNwIp+hHobvDMm95nT/cLSyKtJF93IiBZVFJd6j9C0OHf9WPaJ
         A01anWBM00jz5nfAU/+zDqAUCr6vUd8fUgAlxWSBEvocFERZF/n7FPCx2G++Apft5QRl
         fA2ZxnYrX8v9EQo199RWdFTlurhE80L7GMgIIiryYPiT149qXYtNYN1ArZP8VCwJiMsK
         Vs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zZNMGa3yn75FsqDEZyP0PuDAGN3sitzxX2byO47nv0=;
        fh=QaWq+2RsV9UibrHJGXBSwJdJvJ6btEXQ3wZkphuPrTQ=;
        b=OvD2LBO7wTn85PwSJNV1GZrU7cnd4XlAF8ONAoKUrR1bmO4tZPOMLEb4ZGZ6CEoQqv
         sN6+lJpxAyNEcGJi5V8Ns35n8XhMMFZ9vJEYlwJCwoelZUM9Bcridb5QGXqj7qsU0K2r
         WN/Fwjjldt43T0TGBSO2Jd9sGL973r3MrmtvUPhUtRnBLg+mcgZ9Rsx3FI+UZLEjCBYp
         IXrlLq1alONqh/YUFfyT+X/2VlFxLsfB8mBuK9q+NAct8XozG2xrn66gHctoVROtPiJD
         P1vV/R5siLx9wcZRpgvIAuBYSlNW0BYdwGiS3WTDJQzx0cp5QaE2FlIpE+VHbCXbgq2s
         ioQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770117511; x=1770722311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zZNMGa3yn75FsqDEZyP0PuDAGN3sitzxX2byO47nv0=;
        b=CR38R0nobPSER2TyZ4NQnKNQFmU8280WcWQeveL1FiVa1jy1p0hTfo/fYR0DxZ/Dfq
         227hwIzSY8zyulWXMhJy1ilRwNdo7bOkpfKGNk/jf/3ic05KANKYyYHfwB9IcTjbiiuj
         p40E0biNTgPNkBryF/S3zEG++0TdkAlUKTdEsZZqEt2n+25QgIMklWtnzoTFzIDCMAbj
         S5fGBmTP94HJCosPKdVubJOMDNkJ1BbUnF2GJNpihtI9H6m3O0rJyF76OV8B2pbWDukj
         n8b3/KXIhhf1WA2dpRpi4dW+LVGqaij7UIXvK0mKzU1cwJnFxljqrv+FgT00wXQwYIPJ
         9kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117511; x=1770722311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zZNMGa3yn75FsqDEZyP0PuDAGN3sitzxX2byO47nv0=;
        b=nF2TlH1drIwo5VdXMBa/USaYPPfE+697QfnjA+hejo1DmRPf4Ywryqji6DTEVtZpV8
         KtHn9ClxD+ZEd0vrmH5pP7gVmqUlUcc+D7EIYAzh2lAuEyV5aRBk1qClUWFszPGsJm3F
         4AcYav8OFILJaszSK9mAFxbQI0LPnRAgYMyp8q6az4z0KAySTSR9eT75/QGWtgdch5z1
         ZxvOPYMryXvIMR4UmkWp3Ap79wj3PY54qw1c2O9ZDXcWanbJtVyOIGcBrcR2U1/EBdYp
         gFSQcQRIP1qLpHVNjT+bDHBiIInC0C9NuaOZkDkpNZ7qYBq+rgLWZZfTK0Ahl6T0nXIi
         CcSw==
X-Forwarded-Encrypted: i=1; AJvYcCVWG9jrXIM5h1drwcS+fZ8UQ8zzSFVjnQrXh9i0J9tJRJa7798Ygo//nmtLeFRW3u4KU598pDTLN/QhYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxy5QLl8iRfYRL6HXknN1coChyIl+OfFbFEtFmz/iKSi1AUusB
	IkFKjLpPgVYvnWXSC4A/HQDYaIMdnYFgrglWeaYCPa+Fr2Oa7dXKw++lXtrvBFVqtJrJ8or137R
	ejzvTFtpuCfuZZY+FFtSnSiyAvRUgWL0=
X-Gm-Gg: AZuq6aJ3B04p5yo+FNleDM7EG53vrJQNeacoyY/0/JVNZiePYVQ0AfEwY5LIyhhkTbp
	4BkNhmBXJnUqnW9xxwO0pxhVCX/trBmYcAeUyqfzHyfcQH+2aj/0f0MMnyBoGef+gYtK0TLjvrG
	CxIdnjgXFoYD551SiUtJhbSVooUM6DvuWBn6ondJlB57JnwdRVt05M7WbkNFfcXJVstMc/wufBJ
	UlKPjPtSY1Jkoy7W1f8zT9/i1AHky2LZ9wEc9LdbOT+6GP7ZL+o4N4MoonRzzKy6lgwkcBi
X-Received: by 2002:a05:600c:1c06:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-482db4d859amr196633815e9.21.1770117510819; Tue, 03 Feb 2026
 03:18:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-7-clamor95@gmail.com>
 <aYHU5g5iOVjrHrE_@google.com>
In-Reply-To: <aYHU5g5iOVjrHrE_@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 13:18:19 +0200
X-Gm-Features: AZwV_QheFCGeHv9dTwRKbCZ3hfG3HmOrfJbSWa64fyut6TH7i-1Px0zxlCCElGo
Message-ID: <CAPVz0n0YXJ2KdO2LPJ8gYr_8=TuaEnY+=sVy1AsiiNtJG=nx3w@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] input: keyboard: Add driver for Asus Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:00 Dmitr=
y Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sun, Feb 01, 2026 at 12:43:40PM +0200, Svyatoslav Ryhel wrote:
> > +static void asus_ec_input_event(struct input_handle *handle,
> > +                             unsigned int event_type,
> > +                             unsigned int event_code, int value)
> > +{
> > +     struct asus_ec_keys_data *priv =3D handle->handler->private;
> > +
> > +     /* Store special key state */
> > +     if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> > +             priv->special_key_pressed =3D !!value;
>
> Is this functionality supposed to be triggered by any keyboard or only
> the dock one?
>

Any keyboard. Dock keyboard is basically a regular keyboard fused with
a multimedia top row.

> Thanks.
>
> --
> Dmitry
