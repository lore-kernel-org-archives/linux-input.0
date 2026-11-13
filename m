Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794565755;
	b=aqs0IZKfIEBqq6gaJ8E/NDfdTLxYs9mYCfQz7bb9P6QvNhVAIEBoAO7e/D8+SSVFKql6
	 ukPFNyEzBv0Zv2pv3e4OulW6itt91hj+Ix/UAobksajxh62UR4iSyse4lHKpMmUIq5ViD
	 UTISwP5fI1a6l0U5UeKCGswEQ/Q5YQ+TcX7+j6GOmVY8CHpOahXvd4ZhOftOBvklQRuRD
	 FoI3oo7H4+N/c9Xs8JN5fRn3EkyMeXPIBm5sN0K+dFzz/rzD+cPv4LP/K6ksdYiW1gwSb
	 r1E6OaVtvDZu51RG1vOJFF2tHHq2c5vqtRIFq5D23maw91JyeaWelZishEzJzd0p5Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
	b=DsvOXt/VE9yMqB2x5LAyW4G1QqNhOhdDMXll0gJOEbfUm9elzJMaalXc9iIBb2wYD/K0
	 8HIaUB7H0tRJt7kLtGHga9b7Va/vNCX2y0IAZNOmSKGlJGo2hvgeyUVia2vqZrPf91dri
	 EDCz215YROMQtXcrwcZBFwqxXr3Cdh9SICmLknJnUM2er4EwywBH4NAS5jH1G88ucTgJD
	 GFNBO25fKL3xT7MZ712wRVkhE+Zvhru9M1HOZAp1U/jcF1gqxdw32vIy88x+jbZ+a1Zqz
	 XxY3Hf4ktO4iCms9kKWo/F/1kap49D09qnmc/YflmGC6mx8VokonmJ+s24MN3PiNRwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDvS+YtY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EA606A89F
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 10:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 735EA606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDvS+YtY
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3704d30b84fso1047864eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 02:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794565754; cv=none;
        d=google.com; s=arc-20260327;
        b=T1hfswyj/jPudAqKBCRDOBRwvFKU3lkCUPpggQeJon6q6Yo1dLVho4UwGU1/P+jmvG
         eYfJ6tSDneuHA4g3RRfUe3MtE4cMF0/zokPhqZgHEnAiVA2GXMXMFdAf7u625JDKo4wC
         YZAwv1vLGQIUnkDLGqYheqGAfn/Jw1ZEj4lPt1JY5pSYcY1AAq1aY7JHRONo4cnzB1CC
         EEpKE5Fdh9nYJ6uJbj3QIGXMLMV/0SiolVqKuN0IScu4NofC8znnx3Yq07x8aQl1cyS3
         pKTQGUlGsKTFNmQYUFjsfEr4E6Me1ElOGJRQ1+FD9rEWrrFnOOojyg2eueR1e7LAhRgE
         Z9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
        fh=mOZLxK37QL5zTQq8aDlY+9nXyaPu/f5HjO1uW6p9tAE=;
        b=hFsl5hkmoCKyehfPg4ubqXgxEy9lVNgU+WIm6qV/+OnLUtG26jhp6pBiQjMeiMdnxj
         CQfEdSdomNFMdcs0IuNrbYgddrO4NbVntzIpymheb+fzhyShmUHsB2wXfjvbNIuTwy0Z
         dUIrjj2EyansC04LIhNs21U0I5W8CIlkv+FssaU00kxy/yWdGzm4bxOiuymfSN1FHqVr
         q9JB+KOAQ2kCkZbS8+flyppc4y6cBtqim97Ggc3YBgrv0/NYGQxf3V20qHkS3GvWJkFK
         B3Xx6azAIOjQ2uYrMtc1nA0C0QNz2Fi8NXRTGCWsGatpl7hwnr0ZhAxb4EN7x4pTZabz
         1fNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794565754; x=1795170554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
        b=TDvS+YtY1AbTqAyGZ1p120oYrqqEBQUua5EF2onSOkfyB/igjcBk3zHmxtaBIRmn6m
         /cUajT0QY1fRwVR1QGJm3pufwc+P59LwlfISZLTOlcmRjhS6wM21yfW30POC51d0yD53
         nJ5KZJ1F8EvA2NWXMe77ZbSnv1tgaMkch19sjHlswpQF299Po21Exby0G8lgI2WosR+d
         gmJQJphxlR2jQf1/f7DYhhNcHoYeqdSCeM4GbVh8GW7YfM2+U31//1elpRZBJMEElWQi
         6mNISV/+yZ1T1N4f2mmexYBdxnMpxWX/2SD4cLqAXQo4+bR6UIaK+ywFgs749NOO6uLM
         NDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565754; x=1795170554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLlqqY0k7diIlhrzv1M1aVJOoeE1a6tJkKZXoZP0rU0=;
        b=wLVY7DrRrUblLi7bcR3andzwp5bkAEhB5kmgWjjH2Ie92ZhMEuy/eU/UVhmdqEUosi
         zTsgSQAl3URZtLa7ZloULpmSBfjHBMx6qwQWsNfvQ5tExtS9rD4AVl1xBzocX9eXk/Hm
         p0KtbkYDXkX8WAd7/FfuMB4ABg8frdyxcFJPFUwjdNF1g55SZGnkdiHSyfg87x91nm7b
         iab/5nCxJxO5bMNB+AIXF22oO8/IoL+Ik59ymAx99KpUk2TpWiS+7CgsPPwgeHvnzvzJ
         zw938csGJig7VC+rzNYjRAJ3R0s3iRh/p2GbQYRtIhDjGF4lffggjk/oDU1K48vllygN
         Oi5Q==
X-Forwarded-Encrypted: i=1; AL+hErFvCYEHmjtr3o+PcBlnTSg6gUOxcB7TYkdK92p1NjPnPcuYChNo1VM0L2680HiAn1geaM0c5e4U3lLEJA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KkEFXJ5LEru28f+PGzpCB2jlJ7LmIkpwlTLGBei8q+tS3Ftpz
	9J1RjFCtAH48O69dKd+UTOw8fZBXn0QPsAFx06HriKGjMX37sCSzEjBWC3ZLNKk+YmMVjBqamnZ
	DbPudTp4wK/4gV+n3l5lgY5XdgkbGtZg=
X-Gm-Gg: AYBFou34Hop+43ALrDIwuP052wmEUsBYhlS+Avpi6/6i0JoFINj1nc8s/Vn8wa2kR3H
	BJ/5WGbp0VVLr32xvjqK7k9YcS8t6B83mjW5AbWGK8ckxMfQx/EdZwuSTo7H51KJzQ1Hv6MH6bl
	xl4XMlLY/3jfZrB4LGYgNSOYNTsPaP2jngiIvcH2E34SG1vL3HswOIpUIeqqsNNT/n4G1Tn0KqD
	niWiKClVlk1K0H/fa83S8I9RUCp4kTZQgn2j102L6H1oUkZzsJZQLeKQcxxQyqSDv6BtuAtE65V
	7sOyvtY0ji/ABWuam1RSqt/hK/eXUbLJHO8v9QWqrXgCQNdcYjcZ2f/pT7AjngMOXZRiHwjIMMd
	xI2+km8yiYR/bOExhGPMUJfJWpR6fClUCIAX+y68O+xYfkesy30u2uoez4XUQ1ugdiDKQvZCv1S
	YSajb3GYNE8MW8jJt7VndiMURXIUxMr5s=
X-Received: by 2002:a05:693c:8813:20b0:376:77e6:a66 with SMTP id
 5a478bee46e88-37967315a29mr1873378eec.16.1794565754508; Fri, 13 Nov 2026
 02:29:14 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
 <CAPVz0n25-LyOFFu-h7Sc0iUcjLMk0njOuAAHr-NepQbnZU6gxg@mail.gmail.com> <5e3fbef26b8500de7c4192bd6cb6eb5248496e14.camel@physik.fu-berlin.de>
In-Reply-To: <5e3fbef26b8500de7c4192bd6cb6eb5248496e14.camel@physik.fu-berlin.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 12:29:02 +0200
X-Gm-Features: AclHuK-Fxw1Wk4d0-g4CX6-_wsdY0XEuPYGBEZCmvji7RJCYCeNHh-w-hBV3HBw
Message-ID: <CAPVz0n3SU1eJ9=zzXmaB=y_c8faNMFB2HZfUwZQg6jJkNgRSjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Input: tsc2007 - drop platform data support and cleanups
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 13 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:5=
5 John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Fri, 2026-11-13 at 11:33 +0200, Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 12 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
08:50 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
> > > have been converted to generic device properties, this series drops
> > > legacy platform data support and its header file, removes redundant
> > > memory barriers, fixes minor coding style issues, skips registering a
> > > non-functional input device when no interrupt is wired (when the chip=
 is
> > > used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting t=
he
> > > threaded interrupt.
> > >
> > > Thanks.
> > >
> > > Dmitry Torokhov (5):
> > >   Input: tsc2007 - drop platform data support
> > >   Input: tsc2007 - remove unneeded memory barriers
> > >   Input: tsc2007 - fix minor coding style issues
> > >   Input: tsc2007 - do not register input device without IRQ
> > >   Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
> > >
> > >  arch/sh/boards/mach-ecovec24/setup.c     |   1 -
> > >  drivers/input/touchscreen/tsc2007.h      |   5 +-
> > >  drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++-------------=
--
> > >  include/linux/platform_data/tsc2007.h    |  23 ---
> > >  4 files changed, 60 insertions(+), 152 deletions(-)
> > >  delete mode 100644 include/linux/platform_data/tsc2007.h
> > >
> > > --
> > > 2.56.0.567.gdb80ae8cd5-goog
> > >
> >
> > Hello Dmitry!
> >
> > I have tested this series on top of the latest next/master on the LG
> > Optimus Vu P895. My device uses this chip as an ADC for battery
> > temperature measurements.
> >
> > Your patches works as expected. Input device was no longer registered,
> > ADC part was present and worked as intended. Thank you!
> >
> > All series
> >
> > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895
>
> Interesting. What kind of device is this? Is this a SuperH-based phone?
>

Quote from wiki:

The LG Optimus Vu (Also known as LG Intuition on Verizon) is an
Android phablet smartphone released in August 2012 and noted for its
4:3 aspect ratio 5.0-inch screen size - between that of conventional
smartphones, and larger tablets (sigh). It is powered by a 1.5 GHz
quad-core Nvidia Tegra 3 CPU with Nvidia ULP GeForce GPU.

> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
