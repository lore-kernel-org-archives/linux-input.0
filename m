Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDD40BCC9
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043959; cv=none; b=ViQ0UKrndGYgzetokp9g/zePdRQyn0SwViNoYbCpLbbP3tv5kncnYiBXXVpN4eCj0forz3j/QAeBXHF/AQNDXS2g+4dgBPBCqMVbxdLzr/rxomVJJWPEEYjY9wuVnekemq7lCsmbrg/O6gWg1GNXywhHgd+pe/ml3WKF8pk4IaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043959; c=relaxed/simple;
	bh=gC5RijoMreJ37E+ZXnO6sSCfWOZUThbmrEidBKcTv9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TzESouch8sXGszTsBnOnvngi/4eQ0NmiwsP8baQ4V03KuL66H3i7BE43ZUD2BTR0kr53aVXYKX4la9zRm3DeZm8pJmeGkgGbbY/3sOHS0RRyKCEn+0diA1oEERAf72pXgcoYxlr2mxydmYmY0qyj7/2osY8UDg39cKjy0WcEaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ckt5g5mh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ckt5g5mh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf22d29dabso40821525ad.2
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781043956; x=1781648756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D7duqRcD3fdsTRow2UhPRWiLjw5TIDW3U11ZLjAtzg=;
        b=Ckt5g5mhS8YR2cizTWbJ5Fwk8gGj6VebB+0OEJgvf02706OxaHIh/MLoWUZkdc8W2v
         tDVO9ou14uqgirHWrZKF4TT22SL8Kw6c9cIfwgHoNv09ym9tEccqMSP/b5lQeWoqDES9
         4Y/1fE4bs5q1c26wMjvtkzwBbmD6R5ZssJo+Ql4XeIs+Yw9IhdJtj3WObSFvTKV2NsRh
         KdAHyJOP9ZzIAXpBIl9bEt8fkARYApQC8HuCBb+LFcyPHM7jM2nhfg7jU3w/egVF/fFg
         eqBE7VWfKHsswmA0XGrVNRgAu6OAU+Z/4WuvEPeIm2Pew6bt4mI47RFHA/Njj5qWoKdw
         N24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043956; x=1781648756;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6D7duqRcD3fdsTRow2UhPRWiLjw5TIDW3U11ZLjAtzg=;
        b=rdzf302wHrEf25LKgcv0bPAHaJhDAFQoEWMmglGTAiECDNZLibUQfiHCCSa30ytWv4
         iI1LDHJRrgupEVsuTLOqcbanYAWrQUFGZPovWYNdrbd49ATBvvxjF+Hb4xnXm1oaIzP0
         Zc6f4XJz9ZfutI8gjDGvwsp4NaP1ucuweKnNP3sDpF8BAr6nwvqIAH+JQXmdecMPLQ83
         tGF9owJj6tngUm0JEg7mBr+7qoIDYMmZnBih9wrIFl+H1d6NwR6yInQcFXZE+1rUVA9P
         z8lOsFAeXgDAwCxCR1O5Qvr++eRukSa+6Yu2tbgZGuXouy9mFHdvBqC9lkL5xqpu+GtX
         eO7A==
X-Forwarded-Encrypted: i=1; AFNElJ850nmf+mV/32yloVG8yaNYuSr9y9ixiMK+5dDahJYE327ABDKegCOEVXxZ2SYZ9cCl+Sy6SIfVJQ4Fpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4Ct0XB6F/AfqeKyJd9LpYUXlhtx+Qca/T792OliTcDPW5JdD
	f9ZTmn425zUUJIXyXauZPHlXEi8SHHNZmfrGiqsgkaxu0cKC35G03VAsN+qgmllduLo=
X-Gm-Gg: Acq92OGP6Ms1aFh6nKJ7d5y62QdlDWGYyW29yrJM7BijekQzgnvYz4vatKcAn+Dj9s3
	6ThKyoYvPSiIhAFoV0qLBzfCdQW6Ay9AyIS3I5u41vr1Bsvk+0j6Lqi66uSmzCWbntAhbFUBtks
	dNpCcVYjGIkRIzjhEbJO2WbfOilTZdQNrEicXmmZWPz4rfDq+XIp4CaTGurFyDN9GE9hAuBf1Uh
	ONwd7Z5viT14lhDjVdJefLcanGJoz3x5xGRJzBZuhOGZWnLJUbKG6BagCmpFIOakGlkmzgAMU3E
	9wDiAuhPOCiIaAGbrAe1N2goe/ILevWyjmSnm1Wbqy3grInmgxv6TMuhF1FbCmelP5gRhOxze2M
	BdDHts4GYSwP3USHpdB0G57MoGXTPCsn0pF2wOCBlORMehuE79aOc9G7BTHReAFGfaX85nhiX44
	UGhl2q/H+9q5UlbkxheTsPC/NxWf/JLZs=
X-Received: by 2002:a17:903:2381:b0:2c2:27be:39a7 with SMTP id d9443c01a7336-2c2a1c9ac2emr57718625ad.29.1781043956535;
        Tue, 09 Jun 2026 15:25:56 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2c164f6e2adsm238181875ad.5.2026.06.09.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:56 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Lamparter <chunkeey@googlemail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260520183815.2510387-1-arnd@kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH v2 00/10] gpiolib: fence off legacy interfaces
Message-Id: <178104395573.234140.4413143072350533512.b4-ty@b4>
Date: Tue, 09 Jun 2026 15:25:55 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 20 May 2026 20:38:05 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is an update of all the patches that are still required before
> we can actually turn off CONFIG_GPIOLIB_LEGACY for most platforms
> in the final patch of this series.
> 
> I originally posted this as a series in
> https://lore.kernel.org/all/20250808151822.536879-1-arnd@kernel.org/
> 
> [...]

Applied, thanks!

[09/10] ARM: dts: omap2: add stlc4560 spi-wireless node
        commit: c5a0ac76b364bbd1d4fb7e440edabcd2a369343c

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

