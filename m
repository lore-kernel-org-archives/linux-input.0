Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC04418FF
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749494; cv=none; b=n7Qyt/UjT/dJ/BObBhLTAO3vN0iD3ZVHMiJFC2YUmyfV+upcJoPzxTMJ5dfZXf7oYeFk1v6EG6OzX2Q7Kj00AvFDXqWxoKTh4t7f7RDEbZpE9uxYAiPqv5GkKculZolQbPPCNUX9GocP6vBAjFb2wdTjEI+CuC+CQEDxp0NcOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749494; c=relaxed/simple;
	bh=LHZ+CtSrs1sFgqxg1SDgUv6SV2Q72AbvoN/75du65As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN5WMj2god+SPbeLAl2vT0vwg6erJY2dTV616I7828XiSXzsJOORepfT+BBUE9miCq1srvwrsQ5a5qJ5eDBJgXSC/q/WGD+GvO0BgDQGCpWSelzEdQf8wSmX9gfsXr3qD/1X/zaoxiSt2J73HiJtMG7mqGx1bOUkB+37HaKthOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e57a753f9so109504785a.2
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 09:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749491; x=1783354291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEWuyLm9nvyhq9LS7vVK2FWNUi6758jMrQo6mncWdtU=;
        b=l9wH687tBlxl8iggfJeU2FkxS/ToPTxH8u1fAu28/CZ3WjILjD4L2b5Wo+DFZ/2p/n
         Y264CzILVHmBPSb5OId73LV5uqF6yPwkC9BKOLHrRVSMMNHlcEO8+aGlFCGb75RvGxLi
         HI/oEqCHNTqYCNLwu1vmYTe+3Bp39stlzLjRJxzEKUee/cxEDVbvfGj5OYvmrH3iZ5+c
         sQwjnaV6udSRezWEoxf/GlOCHVT755nKbJEEmTEGBRMRqadwB19WoSnKpg1qqYNwdpiP
         YKbcq5o6mky4xYLS9k8c3CMVuRE+dspx+TRhsA7R8Hvi5lyUX8+mwWOXPuE/c9O/Rkeu
         WFTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fsID1w9AxaYBiXKWH0diXHIztYc6dH72cI3FAlgo2OEE5jEbOmfWK33ukrcI0nOFF+1FAcBHeKu9/4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3RsGkwJpPiXpeb2X5iqmgwPzgwAWsJ0LwtiQcuC3FllPnweq
	zipAFo++8IBL/AcZ/6tnixMhL9kCsbYM+BAOq/qbS5u7kgPFXDaF42o8+V82glN3pmU=
X-Gm-Gg: AfdE7ckD/5avLX1Uxhb4FJQJ1F/OAZb2K9PUcWTmLIDxZejdIXWjC1gNHDE3Y/vqf3Q
	hlXAXnXlyPYIhNpOa42c2KJF6aieNyhoAXVQHSWK+qoJgN77yWN6fIlNV2KE7wxE3LaW6mGt5TU
	eWgzR0w/IDnjQAc8jlJnkrG5+za5hA9Vpkg3phUNTfme81A175Xzjvj0XuCnvL1heGEkTDQq6BB
	MX6ClpUShfDFEqMnFlr2ntdwPkGZy5Gls19uH18+5KbZw9h0SLSHBUXVub7pqfIrm3QiwOtdopC
	ZPkKp/+y9m161x7k0MeDkmx7mQIHqxHd9dZ62Hz6LzaUSy5kkAUqUH3DV/DHg6VFUUQ/PfO9vC6
	eQ3fgdgXZ748Y3ONcyHDH4kQZNYk4p81B1zUCC4whXdSAqloNMKUFIa//PvhAXdsd1BBj/+LKZ6
	cbljBvSRF+ssYKCPmg981Frc4fangz3m+1qVbGYPdsmGQ7wlv0VQ==
X-Received: by 2002:a05:620a:6018:b0:92e:4f79:2c22 with SMTP id af79cd13be357-92e6287431amr30750485a.69.1782749490630;
        Mon, 29 Jun 2026 09:11:30 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm18132485a.4.2026.06.29.09.11.30
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 09:11:30 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f0079614b2so19486126d6.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 09:11:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqn7GlCik7GKux4uSurKJJ8ShGcUgvl21V+bqWE8aDpDJIwtN9W59+/sJWgf2d2IEQVtsn0uVffBnFM0w==@vger.kernel.org
X-Received: by 2002:a05:6102:148a:b0:738:ff1b:940 with SMTP id
 ada2fe7eead31-73a365e2846mr277383137.4.1782749070424; Mon, 29 Jun 2026
 09:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629130329.1291953-1-arnd@kernel.org> <20260629130329.1291953-7-arnd@kernel.org>
In-Reply-To: <20260629130329.1291953-7-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 18:04:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjJRCW2v=ocjaG1xv2Bhhn1fcgL1YKsV3+MWbhboFtpw@mail.gmail.com>
X-Gm-Features: AVVi8CeLP4wAatdqRaN_LpUF4e5DDi2Drj76tc85gOykWJhBx1i_jZadj7vLGOk
Message-ID: <CAMuHMdXjJRCW2v=ocjaG1xv2Bhhn1fcgL1YKsV3+MWbhboFtpw@mail.gmail.com>
Subject: Re: [PATCH 6/6] [v5] gpiolib: turn off legacy interface by default
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 15:18, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
> so it can be turned off by default and only get built on platforms
> that still have one unconverted driver.
>
> Allow turning it on manually for compile testing, in order to keep
> the build coverage of the legacy drivers in allmodconfig and
> randconfig.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v5: added patch, now that we are getting closer to completing
>     the series

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
