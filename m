Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39539D6F2
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033028; cv=none; b=IdPOMizoQnJUIhT6HPMNI7PKQ+OdGf8W8OAHksw5R/6JFqb9Evus1AznBtwt263mm+lNstVRo1SB6I+r63Ge9SBWKV0ztkh/r3+rQoKE2xeSywbErdHIzg/IMwZfbCzje1Bi2Qear6sEh40EnSYgw0NCp+r56YsyuNAcD7ZMmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033028; c=relaxed/simple;
	bh=U/u+I7Fjs+lyPrjV5mTGiCw54swil5vB5IqkaePU3UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/IWEnsSoTHVg4yU+MEtsddCI8W38AUkQ38PRoo85yinU+eUfUd6NSum/kDsjmm8ZGtyNCnVVZdWPeCC7ofpRbilX1OEcPpNnaer8E1JeGwRNG48W+naUE1RHsCYxXvwy9PJ2eVu3lXJYWbsNjYp0J0jWsfdfGi/fa8fannHy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGrftDdx; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGrftDdx"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1363e78746eso9885031c88.1
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033026; x=1780637826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=gGrftDdxpBqeEcytuF5cMQivW8TLP4X3skIaFHpeJvM0bkgwWiUxNyfbJQ6N0n9Nnv
         23NhooJzbJjpL3HS//soTiF2H1Jz1hokAV61p6wLnyy7muOB5dVjifRy6Q/vJhGGRQsP
         9od7sc2lJz1LE7pvzI4Cv5Ymik3J5VXURow1bXTxx1meU8D/tMLumKW2voUjQIc58P6B
         xcn00iQe+BNYjmW7eNBTCIqwcBptl1MSod/KdGsU92p1KzWHrmEy/1se9JrHn9cO7F+O
         XVzU0QckkcIitEwwHaQdY1TIGeeEBHjW80XpoGehapMt7ZYnXgQACsnmFxuYbTievMKK
         tNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033026; x=1780637826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3mngTSiQ9G4QDQdoy3QdNFGLu5UDTjPqyOy5Rx/Ffg=;
        b=nnWebKSYmYhYH3A6ZVTg/mycq5VpFhm7t3Q/8+3xDaudE3VGRP2etAF7OsedvL4LPB
         RmHTf7IYUu3EhA3pZi2TgZFdtS3IwjlwCc9UM+/yoGzTaMHpnCfs7xf5G5reig8GbMtS
         S2LTryXpwBtZguRzE/ig2FSQjo3SeJ9viyjRu+lFDbmvtKF55Ip2euH21ZvXfNVjyYSy
         pvEaB3ZcWTLwW3dea+8l2aBvWWrHxjGZe4c28d1Ye1qmcZfE8q83YSlkCimURVqFxvHs
         rQoqCMAYt+n6ATt209VSyMXDhAdk3tRdXqp+RDFkDFI/UPepvDiTCDML4+OzlCdcPgLG
         lCkA==
X-Forwarded-Encrypted: i=1; AFNElJ+WJWS7ZLKX1oMi8tthVwCpbIuize9csLSVXHWAxmRBTowyXnQpDqerp/QQh4/cVu+MjYq5/nKGzMDMyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCZSjfs2tHxJq3tvLw8uTjCUzq3i1Smb2QK1Mt5+c1ITzgy5L
	OkWRZAZYEHniOuIgWwdsb7O9dlXANacQ+Ja9UCJcjw3ZpFQhPXs2CVxu
X-Gm-Gg: Acq92OFmr9e0wPT7tBrrGCvzRIj+Dl53Ff2IRrGuqFsJA1L68Nowt/rvUTHDoJnPumc
	DEiqSQqNl+wWRE3tcybhqss4BTug6VkrCPObhb2o4teKQXZGqZcvlrtYV8FWZlsdArybD/Pqv6j
	+11MatvhC7DKcwaO9wPB8+xAJImJQ3ifSYgSwnIG0KE4PCXnXirnbZIIXc1mW5aQMMK+arvb49q
	TzLLGOtAly3nf67IpJlKlveVxsm2kOjEXBbMLbN2604DNpnIbqm2+slSdSHeCtNvaGl3/Zpq8A4
	cFZYIJzp6cawifxlwpuPqaxkSeXnEQiMi6qLywye0xXseEVM0UXv7qjqDGzfRnGhG1UGed2D5Pr
	7CEuT3ndsovy9Ej5PiC979epJzue45xPrsImCmFk40r6PPBTi4HNwR2y5cqbRsOeXFehT0NPuJq
	yIXkFrp4y1SV0VJdR/eT9OZIXND5sdRpI6/CWOagHZ9ZQxmRDV8Jr6+vqLzsNGTBQNGs5li3fa4
	+w=
X-Received: by 2002:a05:7022:2223:b0:135:d76a:aedc with SMTP id a92af1059eb24-137aeee5faemr536827c88.33.1780033026219;
        Thu, 28 May 2026 22:37:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e169:a62b:d3ca:e8c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm832719c88.0.2026.05.28.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:37:05 -0700 (PDT)
Date: Thu, 28 May 2026 22:37:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Lamparter <chunkeey@googlemail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Message-ID: <ahklyAUMaOxy3Z9X@google.com>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnYeh3GfEfNXfCYdcdg_j2RAU63TYewwaTx3tm0tM531w@mail.gmail.com>

On Mon, May 25, 2026 at 10:57:44AM +0200, Linus Walleij wrote:
> On Wed, May 20, 2026 at 8:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> > interfaces, but there are still number of ancient sh, arm32 and x86
> > machines that have never been converted.
> >
> > Add an #ifdef block for the parts of the driver that are only used on
> > those legacy machines.
> >
> > The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> > passing an IRQ number instead. In order to keep this working both with
> > and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> > the gpio number if an IRQ is passed.
> >
> > Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> > Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>

OK, if Lee Acks MFD changes I can pick this up.

Thanks.

-- 
Dmitry
