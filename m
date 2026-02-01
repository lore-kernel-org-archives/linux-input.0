Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B921FF3F
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929789; cv=pass; b=bTzzunYVBRwQG2Rc7rRr4DnIuATnvkws3e0nbJ0ygdeRdH0KaMOt18Hls0VNvFvD7slt8n2We0J8aUuXmyYYh7dcT4FoZDevptWlM4tDtRUqrlGXfIpnBOAnPSirTKNdAp0SLq3Pmn9Il0l1/AaLTYo3ZINfFlZ0QsOWMLzpVGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929789; c=relaxed/simple;
	bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ycgne8SbvEIswXJt6Pth9BGCVnWU4Tuxq+4jRXwQ5RW3ic+K0rS1i2PprYdDgxV6wWOs3D38dwfqZcgF0sRn1EVTcEmVH4p0tK2lNRM9wr2LCpzYDZHe2ZENFbJz/B2iDJAmVIwq38a/jVhIdI59zldz6zO4HEfL2oZBcTBfwDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/E02SDd; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/E02SDd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2190803f8f.2
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 23:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929786; cv=none;
        d=google.com; s=arc-20240605;
        b=QGpczFyks+skvZEJgKjxu/Ay760ZrSUMkgNzW0cjwbi2/gPd6bf1rIKoTHz+4wwksb
         wQc/ZKC6Dy/l5dmokn4FEOI1lDk7domxu2DQcRvaamxxLh2BpQQSvuRF+5t+/H4FFd93
         vv3WgW/DScXWor1FfvcrbuwxB2qxMzjoSOL3UBJWmHnCNGE3RT2hRemV7OtC9TRXaAzM
         x/d+ZyD0hM5i8FRA8WL3zaYA2JJzRcib/yjFMt7miSv1r6IlPVzBmx60zMAS6VhD9rng
         dXEF4rHJmgkEcBzZ43Vs921XEr3L8twisW67LnQv4mfaVZc64COBBj7qGvCAzcVEkryI
         VJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
        fh=LzKA+PiBqMtjRCRvz0q/ODhCtyGr5Go76ZOC8HzHiFw=;
        b=H9C2LtOvgW230E6zK0q5AF8CgisZS3pgshsIpZ37trKsVL+xbX6u6glm9vc6/KgeI1
         4uyvtP8gA1QICW1jMRN7Pq6HIj3ltAKU7iS4iaKj28xNhPWrLrkbKiEWXLohVAzIr/fv
         TN8JeOmW0NvEL6rm8N1FXTF6X/bdXPRDlayNlGIeWlqYNkjCdRZ/kuC57skYRWbgsRk5
         DpOMEdUdsQ6U+6u+uLtyIHbkWtMnkFwUMFe4NRRkNbtt66SarcAbSrztwvI0aq6z4NFn
         D7uyqj7wFw2jjn79+a3FOieZhNcvLOY9VcVNqKkeLoJ+YrGdAF+o3Ox0HydaCSBN1e4Q
         umVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929786; x=1770534586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
        b=c/E02SDdbVDPPQi7HL8AFN3msp3RoF3Mpiv4ztFLpwmQ02C8hdg1DqCFwXPHIN1mju
         FbIv43PIv7hBATmlP/PEOYiM++UxUYMBGg+epg6xMTgnnDEn4OlkzxPBSBbCAPr3n2AQ
         WqW31xJD/0UiMYR8As70DsGvCdsLdrE9f/EX3f5HGqg2rRnJYN+1f7gGc/lIrn1/ShZv
         SsIAKiaA4fojunyTpmjg+yqt3zFLbYN4XtQ+VAWVtSx+Tg2AMKc5kPuOHQEK9oUehzsn
         JEPwI8BDMY2FrvIspNC4uXgJh5Q9/pgmQpe7GRfrrhW9nAedb7FJR92YxVk5YdU7Lux4
         RIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929786; x=1770534586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVleZTFVGkwhs8mQsAxLo89FsklFvp22Sy0QI4BhQvE=;
        b=PAPRmsJ4Y7qFCbad7u5+7GlhAuCQGLMz+zTEA3y6JWoZUdIpvU996rN9kaeZh8XEia
         BD1kEPgWy+20leNjufHC9qOyKLkvlg059VJvx8zu5GzvfqxRQSM6XP4M5skyQjnIuzTZ
         UWWhTeSdZ+i5XE25HaOKF5luGHJ/hzfKe/00iYjoFz3xJc7rDzU6tRtOZsUFYA2qXk+2
         gp8j7YnLkT+L2vwG0JFKiZOpBl3GEGp/Hw8R4XiMzwF2TxOnBP9lKKxBTNywqc4rrRmm
         yVxBNa+FEeGtnuH4pHkFk1SkvxmNDrlCGDcqmcNJDePwWRdDKYl/wVkSymgUaips3JU4
         SZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCwplJNe0BfcbUbuWo4A1N+aI1IilDHUL9xXfa02xhx1x+p8irQwFnnIh3Sgjm0DOD30/pByoUw71l5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzisvMVR+7FYu3XtPAaJQm9QczOG9LFkp5xLUs2jz58Q/vq31Fn
	uOqAElXH+IcM0SqXcEm5v+X8nuP4EhQBpPGLlJF7zS5q7Z42feYS1zyE2GdcWOyb6wVFRsgNb2Z
	gm/Kl8timKjx2m4g+qnMntiAj+77b458=
X-Gm-Gg: AZuq6aJH6Uebjmdw1mFmDTj80cmA1v6vKcm/x5UfzosAUXsLEzzFyMhFJibFnK4WP7+
	FTlkD6Nr4XWpFulSxAKETlQRUQv8CLpYcIXtDNxLOMeh+zHjCDTWIiTmSTXfiBuLnA3fvNT1EMN
	1aChIb8yohPZRUzbcyTUGeyzLqUa16cpK0mrKwpEmlS9AjEjFn0lxTET9N1NtoOZ4FA8pKkleyT
	IKOYPu4cbr7ZkTNtNsvwJJ4bzgJreKa4giDLZyELNVWi87HUU1E836o03sD/nXWwOd18J2D
X-Received: by 2002:a05:6000:2310:b0:435:a594:33dd with SMTP id
 ffacd0b85a97d-435f3aafeb2mr12707085f8f.46.1769929786087; Sat, 31 Jan 2026
 23:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-9-clamor95@gmail.com>
 <fca2c04b-fe1c-4685-9c80-b0d7d37ced60@baylibre.com>
In-Reply-To: <fca2c04b-fe1c-4685-9c80-b0d7d37ced60@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:09:34 +0200
X-Gm-Features: AZwV_QgqhXC-zAPZm3FWrQrZKb00Emtx10eOBVUYX82Uyvi3NU9ESnDiArQ89Vo
Message-ID: <CAPVz0n3XPmYPWD=Yr8WXGn84M-9Onf+AHZK0ZpyQcBJJNHUCeA@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] dt-bindings: mfg: motorola-cpcap: convert to schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 22:07 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/25/26 7:43 AM, Svyatoslav Ryhel wrote:
> > Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML=
.
> > Audio codec bindings adjusted with common ports node for port@0 and
> > port@1. Added compatible for Mot board CPCAP. Other bindings remain the
> > same.
> >
>
> ...
>
> > +examples:
>
> Ah, I guess this covers all of the missing examples. The other commit
> messages should say that was the plan so we know why the examples were
> omitted in the other patches.
>

Subdevices schema state that they are part of MFD and link to the main
MFD schema. MFD device description mandates to have a complete device
example so having examples for each subdevice is redundant.
