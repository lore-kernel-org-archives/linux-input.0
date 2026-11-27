Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774052;
	b=DKNxeTOp8JLGA/5FYg6hVz3yopgOFcEkKheXFoVIRShHvdNA71F063Q3RZmXHi6OX51Q
	 B7Xhe+beBjSLIfvyRTahlBCMIxoNDqkCslAEpaPgHFgL70TOowirky0BEXYlRtQy6yCWD
	 MdSNVjqnaM/4hm5p89ZhJ/GinyXFaa8xjwdamfIZOaihL4l+xN/MmNCwKQQni7lOTlLVW
	 p7nFW2lWt3/S/fWtm8ey61uSjEdmc400NC/7THEPTZJQda67ku40zXSVKxHSeargvUTos
	 BDYFJI7ezJ0b9N0mNgGLm+PgxFA0srHoyGb9hZNQoiY+3Hy0aAFNjYb4WNEMRM7Afow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
	b=FdVNzPlKxUox1NnhiMGUnPmHnL2f6cfuWiu9dfrVq6e5UiTuK3ZT/0rFC2LBO8/lQ+KA
	 W6i5hVwx7Phmq3rURFfnUpT1lkgmwOJHb2l8+zVMOrS/hekbw2xb/9Mzz40qkb1D4h1Q/
	 LQZfV/jYuTkecjKpwouEN7dDbanmqpgyHpOn+t2Su9kNVPjPmOMpolyqKO27zbbIOzsPi
	 Yr/JdBlNgp29GVhTE5dzdK0qvOpSH8dKw1lwzmimQ2t2lH3OGf+i5usBzpWiJ0+64zlMp
	 Px9w1dH2w/rOa9/iX5xe7szW3EwYJGmMVDruQ7pD6kKP8gIREGalw70u41JmSreUtfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8ZERY7z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF4606A327
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 10:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62AF4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8ZERY7z
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c126f80426so7551785e87.1
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 02:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774050; cv=none;
        d=google.com; s=arc-20260327;
        b=iSn28whAAErAyupd8J/At3/sF1F7wncJovc4EI+5/tqg/q3HiqZuy/sST593hggW51
         BfYZFqx/7pHOpsTIwOHYMRm5ZHSSIC4uYqV0+l1KPfE045oCjwKFvD8OaRSpzrA46l4E
         Rs5Bxenc2rXSb5qT/QIejm2UuPhLDsbF/5xqqRSUIds/prSxeQ4QJPexE5rqz7bECL3C
         /BAeS3llmkAjjP96E89jy8Rbw0ZAFv4HmDtryFV1fFL5x9hPWf4vJH1AZx7mjRk2nhA7
         CAxIHb9iqjJV4YasCxBtog0kUyhnC/24Qn/atwn+irtcnC/0WswC0fw0RqgWhDUyLvYF
         ZD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
        fh=kzMrixHn8RQTQ0zBKuaD9Cesv6P/cSsbcAF1uKmBdUs=;
        b=rWO0GIPDrKuaRCi3Do/FLTkCaGx7SakEpuc+DqxXNzMDjNMvl6oynnYWJSAeq8ar/W
         CdKK8uxJHTEjKP7yLhd6tbiJqQNtxDfa3v215lsdM63xZJoLcBIHWKFUsfRSRv9SQwno
         Og7VGgGBHMZsadFIOZBa8iu6IhPJJ5cA59/xeJNm5wT13HfE4zom9pnexy7+F3B3vUaE
         hUSECoIfogZnxuHnk9hStVaLRMERkLN1NQY76+Qr+fdOpTX/2IC+bHVAdQvcgE/UjSsd
         LND1YEvTd8oZ4Pwza8700JkWRw4El0uhaAfoeuMsT6drY9+h2xgUl34PZhYnZk+XNc/K
         csJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774050; x=1796378850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
        b=T8ZERY7zD/vy0H1Rb2du90/b67CWcF96NyZsqFxOi/RYxzLhB+qwyRH8qcWPBraa8v
         mW2zbzSP49Foraqc+NQDAmXZ1wubTXXFWND6ZtkJhZsKeALOmqaWo2ukNLoEvE2+62ZK
         6cLWHCumugFsUXIOtnP1I6tOsdCFTb7E+KqpznZQ9CJe95VPa1CX5Q3G6qZlNTsxFj7I
         +oKRx6WVXOXR0C9HVFtpTdRHu+eXoKolZFYEVFXpOd1/gQmHnPvjxoxPAEZfwuB0CqQj
         ZwCKClrm4FF4FjWeUhiqnMc9RPcBVLJs6R10KN7KtdHAmOMrEx1LzrMDpPSd3zjZIM7o
         EtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774050; x=1796378850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
        b=sjz68nwf+t+N7ydLa9f3htVBmcaRMbxerY5htVy+q/idMEQHwdE4/QO/aDoiKu1x6Y
         Tvy7gyLI8BK/fZgBOuhyK7JQPLhzq3uwpy+KOiRSYhSn3EUABF6z2WSZzPRniO2rqDRP
         z0HK4M6D5sSE4KUSU7KyAa9Vfrprrr5YJEfx6D/wkytUrk7lotSyN4cANVv0G7fo2Wpb
         t/mynrEpadCg1x3s6Q2l7dvnuwEMsbC4EJUHvyqmsdahKsma5wc8083UeOBDkPjx46pp
         /MlNob7YlehRDs0qeFlvOm+Uptfj3NzOFEsjN3L3ChQKtZjwmF9bmcckgh4q0co3JjoJ
         M15w==
X-Forwarded-Encrypted: i=1; AL+hErGCRAwM4KQrcZ3QjaqFG8o5c1Azpz8scveRgXmqnUG9Uo8QoyFxYhRBjqLvXasK2EaYIr3/MzUJ+0Xp5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xqFIUa2DmEhcSE9owEr+FtGwv/puJ1vToph9fp6ZkG0VnynCP
	cXsASJNdMhWECtC63J7lHT8JYQaSqNW5KD9gLh4PDaNqnkTZWNkiZOIDHO9+cQSBw2cn4x9QFdB
	vd1EibnJmOO7yg+r4S376Y+uENAE48JU=
X-Gm-Gg: AZFdTZdo6YQftQMcimf1Nkd3KekSGwlkEVSEW5p1WdTkLbE+CoV6787GMP8dqdb3cmQ
	wesiLrJoeWTS7aV/MowNeo4IhABPrSk/k6ZInZa+KJuWJ2oqvNls0f0fDbyUEAhhd7B6BAxvH9t
	yTQGPj1L/H8YSdaam1kuaoEy5cpAZkb6CJ06mys/w+qggPdKLLAD0Czi9pbp8P3z+fEtWQ43jD+
	hzzXPd3s++oPuRPIqYD5PyZFdYaUJEWd+VRAHek/Uaj9XriVxpzWH/hU4xAVPZ5ceAcAfRzo8oE
	Demwt3t2DO2ZgxXMtS3xy101L17rQrLOXdbPjMy8JZcNLn/+YIvrZNppcEJZz3GpyxfrS0mGsPw
	zsz54y43BAZua6rg62+f62ENUWD7BVVf2A3u+GkUzoyR1uoIKik6ZdnWEK2QZmEmdPmVGlq9qMA
	XY2E/nKnm1TUHwhpwC4WzkwX9MYNbHZZY=
X-Received: by 2002:a05:6512:10cd:b0:5bf:f8fc:7b5e with SMTP id
 2adb3069b0e04-5c1bc89c61fmr6700305e87.55.1795774050347; Fri, 27 Nov 2026
 02:07:30 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-8-b0309d0789b2@gmail.com> <awQEP9bHA0RPfRUA@monoceros>
In-Reply-To: <awQEP9bHA0RPfRUA@monoceros>
From: =?UTF-8?B?57Gz55Sw5oKg56KB?= <yogo.0917.sabu@gmail.com>
Date: Fri, 27 Nov 2026 19:07:18 +0900
X-Gm-Features: Aa3M54o3XA2vGbw-lT3h-QsKcDE27T0mWx-80FMotXTw-keuMBkBtHCZ9WsWU5c
Message-ID: <CAJGK9zaVJ-42c-AnZuXBW1uskvmRQv1ePHQsx=BMz55RfznomA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/13] Input: add polled SiRF AT550 resistive
 touchscreen driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-doc@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:16:56AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Sat, Nov 21, 2026 at 09:43:18PM +0900, Yuugo Yoneda via B4 Relay wrote=
:
> > diff --git a/drivers/input/touchscreen/at550-ts.c b/drivers/input/touch=
screen/at550-ts.c
> > new file mode 100644
> > index 000000000..89c2d2701
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/at550-ts.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* SiRF AT550 coordinate acquisition. Layout cross-checked with AT551 =
draft. */
> > +#include <linux/bits.h>
> > +#include <linux/input.h>
> > +#include <linux/input/touchscreen.h>
> > +#include <linux/io.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
>
> <linux/platform_device.h> already provides of_device_id without the
> implied dependencies you get by including <linux/mod_devicetable.h>. So
> please drop the latter.

Hi Uwe,

Thanks for pointing this out. I verified both built-in and modular
builds without <linux/mod_devicetable.h>, and I'll drop it in v3.

Best regards,
Yuugo
