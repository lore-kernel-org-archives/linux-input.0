Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AB1E3DDE
	for <linux-input@vger.kernel.org>; Sun,  8 Feb 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770562162; cv=pass; b=fAkJ24jo6tSVW4/vbaWf6BVXj3vrVaB0DwUrpgGYnl9Ct8sOF5C5i7iEz4op8p2QvbAs+rR70x3saboBVUaTshJzoGVP8ovaNnwwHYVxvN2Pi+592RO65+Psc/XkysVXAYqiMgeSfJNEVPs5am5FATWGwxlIFS4SZq8tKYDDKY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770562162; c=relaxed/simple;
	bh=FmHJHscw4UGRqf6tadsbey53/7alBZ0goPH23uKBsZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYNyKUWE1JXkZfdToyhkgGtrEREDTIWs9j2sJTyWUz9vt3ssP7G0vTi857+2i/6TKk9JHs8j1AVuyfzUUZ+KnUWARgApCYjbryzfaB4+tNXE3CbWHOlK91y+OFGfBH109S4s8QhdWseqELN6mIkm0gDSsEg6FmQJB6VDhd5I4sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+hiCOLF; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+hiCOLF"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so4806632a12.1
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 06:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770562161; cv=none;
        d=google.com; s=arc-20240605;
        b=Fx7V/MpeMJvlpohksdih0N6mihUqU316rUEEjyr+pMBAGpN+SJdRu4Z9AD3zBX3ZlM
         0Aj1TC3oksSnzhGfHlFlmQD/epFuvpd5ON7QwLwKIY/XcdBDn2/aHwQ7eDcLcbRTaCYg
         EgE0wSK5MLESg+AG7ReN5Y7D9d+rVfwMhVZcRb4lGOsa0c9PIaq80TcHgcCQ1oekRj9F
         bwiwE6PVjC22z5uig52UH0umj3YxdesgRgReNeq5Ya/KHmme+mdmcmtD+pPMTjxAvqgR
         9Dw0AjtoKJtvDcFuzoUxfxS8JwhZDWONZyLKxlQJaA/u4BXElj1IkKlKYs155VrU+R6D
         f8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7QS0VkNqOpSXotrnDMRD5sTIzzQObxdRFOn5/qTfAgQ=;
        fh=iUR3ZSjWZt7BV9g3PNDnXGu+BN1TI2HYvcjDLi8enWw=;
        b=Jh7icwaYqkmmX3i5o860si1qbkmYK7rtqlD7GmMolFuhKDtbh2Q4G2HHtmniQYNERm
         Dqios/F4F33K7uNhdguz1bistaHR14Gh839URYrcXmCJnL+fy+lWp1sDMpxY02P/QRxv
         5nA0IDZnS3nd5Ln250tMlptTGBLYeeW7q1aXQ4mUFXfY8SrG+z+rLcGyMJ2Wk2UupB5R
         ynuTbPjLqPbXg5WMWIJMbScZqpF+L7B3WHrluGe1x/VgWOTussEeXlwG0K26sj5+ww/e
         YsUbLNXl9VOfXeaTPNz7rlGyeA6ncM+H427gaFltCGhmt65s6CbJXyeeoKg/KLKS+aVb
         drUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770562161; x=1771166961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QS0VkNqOpSXotrnDMRD5sTIzzQObxdRFOn5/qTfAgQ=;
        b=T+hiCOLFdGVaRU4AS5E60jFWT27jFP/yUq2q3RU/DhEQvXsB1HWbwojWFVn0RONcCp
         NwbnVVVBX6OIIFMZqcOsEw3co9xxpT90WlSLJyxJ3NGMOVB62Enn5j6zCGRusNX412ak
         qABLXe/BFjyrEkc5xm+/zRs8iYkDtx0zzIn/uQwTafbKKEPjfBc4pBHir3EcnyOoQtfB
         mAGmM7X2Uu1yChZkbh8shRxdHkyTzaHe/Z0mWcByCsUY9zTu/SSlPy7RRvApo7i9wzmD
         YqCJaBuJU5kWkPUvv0kUbFIbwU9PenncD04ST7UxABy6dhVB4eaHP83SSZPR1Nic1S7m
         hdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770562161; x=1771166961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QS0VkNqOpSXotrnDMRD5sTIzzQObxdRFOn5/qTfAgQ=;
        b=wOOgo38hAaA2yvDqw2gbfgUIh7B0oYEY4sdS6Fs94Xfq30gH/iArkXHWOxD9El0lSN
         Y98qaYkd8VbYH7llQ+V4nWpClK1ZNqnZ8UEa8Y/IddkemyUCO5h3PcxpJzv92p4WsOhT
         RM8Eu8Z6hPzgyCAEuFpy0senxPYw4qyBVamCGO9kCMB4m41XuMfEgCdRRV403vJqgvKS
         pErDmwmcyFkpVbycCMEijVYWxcmQi3rZeYuWJUT2SmOOIph/LQgm1h2x5TUy5vkAkDRj
         +KpK1c4mdxA3H3hA8OUrucxXgkeo7+abMbUOQLaW1yvsnB6Y4iEcl2Qv1noZWngaH1r+
         B4PA==
X-Forwarded-Encrypted: i=1; AJvYcCXfhRJmWIosz2oQzgz2Pw+36dH3rdmiJObNEcbTsOd/jVW6Ik3SQEZyJItDXVeSUbBVmW8L0RBAk4hqWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/TrO2GlfuQF4dZ+iFctwjRS60HdVXfW5XOdJ2Lt+4KAjaiLG
	AIdhyolhecm7EB0RAF5CqrqusFHqVEoZLgm+LFTfjT1oS2/1cu6KyUSMENEBVRmnEuosvypFuim
	8DKqnTrxuzBwPn3Q2dd4qAl2lpOtpl1w=
X-Gm-Gg: AZuq6aKKurqzpvI1s+Sm4FnnqSiPeWvefprQkZRZTJhhsuKQChADkpfX7jcYqvVguV+
	BXD8ClI6ngvZy0kYc29Cxq4IqgQ82A3TknLHctCLf7M9cos24TQFPzTb24GxuD5AhBLJJQntsbJ
	56/C+RPGzyTv572VkFPWdkg8UYBiOjR9Ifx/NAj14a27tiMQ4cf/Nagg3GB9Yxm7fM+Nu0o4LUS
	Zhwov+H3fORf0P4wbdpMpxf+EYSVk19lcGrHj51RhFXwon96jQi3XactGpwfQLGd/XUJhtVR3mf
	wFuBxdu1KH/ROzUGjpI4mouajjpxo/sRV1LDXd+l9P/YMTGffc2R/bltSg8eZqBIu16zoG8=
X-Received: by 2002:a17:907:9413:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b8edf25c528mr436693266b.29.1770562160683; Sun, 08 Feb 2026
 06:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-12-clamor95@gmail.com>
 <aYiH8iwetvRfWxGI@smile.fi.intel.com> <39B7F089-5B4A-47F7-B2EA-A526B290FA77@gmail.com>
In-Reply-To: <39B7F089-5B4A-47F7-B2EA-A526B290FA77@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Feb 2026 16:48:43 +0200
X-Gm-Features: AZwV_QinSJks_QhB591HGO3jm53Tp3IPIh1wwVGFN0DYduqCRz4P0_2il4ahi50
Message-ID: <CAHp75VdatO1c5DvFghpSOLvr9PomrT3=tEADHJ7U8Xf2tgN2ag@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mfd: motorola-cpcap: add support for Mot CPCAP composition
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 4:41=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:
> 8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 14:56:18 GMT+=
02:00, Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> >On Fri, Feb 06, 2026 at 07:28:45PM +0200, Svyatoslav Ryhel wrote:

...

> >>      { .name =3D "cpcap", },
> >>      { .name =3D "6556002", },
> >>      { .name =3D "mapphone-cpcap", },
> >> +    { .name =3D "mot-cpcap", },
> >
> >Drop inner trailing comma.
> >
>
> That would be a stray change, wouldn't it?

Have you read below?

> >>      {},
> >
> >Drop a comma at the terminator.
> >
>
> That would be a stray change as well, wouldn't it?

Have you read below?

> >>  };
> >>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
> >
> >This can be done in the patch that adds driver data.

^^^

> Then lets move there.

Exactly!

--=20
With Best Regards,
Andy Shevchenko
