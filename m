Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603018;
	b=LoFEdbqeVfCKiwYKIISNoBqIRuvnH8eN34YwcTGARm3hQtm7Xx5YR0mGaxdLEhgC4eUl
	 Zkxq3zV2dS7dQoljs7cnpgiyYedQ/Wboaw+Q95VYKc4yEw3O2GUg0NgQn3isTzJkg8SgC
	 01BIqqY4LxcmCwFeR7pf6Hdg7fb3FmO6E8fajg0qVk7Vdc6dIBVJ2bHuZ1dn28calDCb7
	 QfoyKMUOn4aFKdOD4n7kfU/u7hKiEn+byIGNcW3Rfd84S2+hgZEO6OU4zkuIpPP448VnT
	 HYhVv/29LL5XApEg05eENlhzsU3meSLtUFOZcXC3TbQssHhC1N3SHFk1R50tmwlvZuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0uGVdqw1cUG+jYneBUBB2quro9jHiY9dYgBcdfEkjcA=;
	b=dPP2+GF0/l3L6EXQaf9xpVKPUxWK8XwuBZY97MAiua+jrFaSEio+KQniAt8dskyW9QO1
	 xljbWkGPB00nm3EyYeZ2H4ekYT2x6yc3SYa3552Odmx9haRRj/onqf3/eOHEwtHo46Kh1
	 /RweLvCEAM33uQrnYUvKO634x2PXDk94Yt3lHsuARmpmAbecZZxbpvdxOCtxcDfO5u5ol
	 M2W00n1GihLFfLTfCGUjxorD7Cm+vNFWJmXCErMGQCmhtWCDgDewfrSxl1+lrVZ+1nvK2
	 zgDK9C0ZId03iRjq2emMQz9HRk7pWeecySBTdLC07goEZz4uyU/FAEfTYrF7lDpcrJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqghTt76;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442D606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 17:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7442D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqghTt76
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535a54bed9so1306663eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792603018; x=1793207818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0uGVdqw1cUG+jYneBUBB2quro9jHiY9dYgBcdfEkjcA=;
        b=VqghTt76eLCzZfFRs5YNUaWU0L5lTwxAo46eI6Pcn74RJ4HgqlH69DnhvW4FmZPy0G
         4wwK5gFOYgQ5uGSkmou4UM5hp4NJ9gLjsRZ08qUXnl6enMzjB53lD6Fh53+IVWG2brPk
         OS8qF7DybBDwxXj3RSvWYFF/Q3Syk8wimdEaqQsa79j4iswWbDCADR+irlcPTTJj741q
         TVaOiZL5i+vK5mBAhOdFuEc6QxwXZ5ReTdrPSIgggtt20B/fLXL9cGEI/JkSawRFyW2W
         SmwA6WdG02pewUKBMtQk/G5qK6i2z0M7gEIlp0inHn0H93KLvXpwur74t98nBkNU5WP9
         GTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603018; x=1793207818;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uGVdqw1cUG+jYneBUBB2quro9jHiY9dYgBcdfEkjcA=;
        b=zbJJN2wEh27mhDbxMXycjGY2ktYCri5PR1/zo7X57ZljysVYoyyTvoUWA3mrciyi7e
         ckFV4bFe+C1gNJqz3/t6fvHoWTnBOGEbYcq03/wVKLFohUlC9JEM3ZXOuYllUUfyGHqv
         YAgwAeAwGO7w5CUxpvB65RW7NDcnOrTsB+HB4ziF+zcnkWNasOr4wnisF3cISQAHzNWd
         9gYZxAycOIMVbnEjG/ITz00+Tjf6fE1H4N935/X+GJhtnaSBF3vKVNGXmz5iawFGwnda
         LfOhonfymDTP04Y+88fQzN4Y8kFYZlanAUf26nUrE7pkftO3O6FIZucsiJU5eP/U9pux
         S9bQ==
X-Forwarded-Encrypted: i=1; AKwUvByijMcpeTw/XP4pQsFUmrUZhIyQnSY9tg/fhfp/xTeFULz/syOOXjxdQs9jOro1rOODHEaEZDNbFglSiA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgYlliXOPKE9+RrBVYVk88Xk4nfGSjok4pEagS/4n48zsb4NGf
	THMY3jedLx6j/CWNW6x8VTQt+7+ENK7LyZlMbphZw3PaecNJfTBUy6Kk
X-Gm-Gg: AYBFou2HaXqgnbJ6WNe8d55YRPsBQgvZ2zSo7zyHxKa3PrmYqEZ/ALUY6WP14yzZPSx
	BWfwOJ1Llbhl0/SGjUhPpvNoXNBeaofQXZdCDDP0evwh5n25DlXVFUR0dQ+NDqmw/olH7XrypA9
	Q+Fui6m5IYEzwjXGY90bfXP+YFh/3EvJ8+HibCko/6SwiXqmVf1hanMiLSPARNlOyoU49vayE15
	GkPV0sGq+N1IZdmBxfU3lcgL8pSsIZn6soU3AvFPKUJMU7Wp+veQBY5Ok4S9UnmofcZSlP2H0VF
	AAEPWVFr71axZVDc7xsdjKU0OXvBuWB09UdkqmmLbZI0ky5aILo1KWSSd9N7icsrwWYykagpd32
	gp7ANbycknzF9bebqe4zhub3bIXQajsXNPV5Z69m4NuAUexF1jTZXqaYoYoHIBwDAn+KQLXB5Fj
	H/mPMuicv82zLaQtE00WEyF0SOzi9Wzc9MB+SSWufx/lSM0Wt2PtxY75oYS8CKAqpmnaChOVB5n
	NB4qV0vlkE4TTpqZ8PD1UysBHi/yPzq/tMoZiqzYZiCSN2cCBqCmG2aQPmbY68isHazQZMQp0xu
	UBoRlUgQ5RjZFhx7g9+BQmgFDYwhvTrvegCL58zre6A=
X-Received: by 2002:a05:693c:8345:b0:367:68c:860d with SMTP id 5a478bee46e88-3674d65d2e0mr3958768eec.29.1792603017470;
        Wed, 21 Oct 2026 10:16:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cca3d8sm8748248eec.14.2026.10.21.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:16:56 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:16:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 3/3] Input: soc_button_array - convert to software nodes
Message-ID: <atjzUS_zdVf_2KzV@google.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
 <CAMRc=MfZg36BULXh3n-ce_x_4B_xOn3Jp4Jgo5BN1LsB2FqaTw@mail.gmail.com>
 <atjuDNi0_SXs4y2d@google.com>
 <9496ea3b-563f-4517-86d6-e20694e2ec9b@app.fastmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9496ea3b-563f-4517-86d6-e20694e2ec9b@app.fastmail.com>

On Wed, Oct 21, 2026 at 07:02:32PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 21, 2026, at 18:56, Dmitry Torokhov wrote:
> > On Wed, Oct 21, 2026 at 05:11:32AM -0500, Bartosz Golaszewski wrote:
> >> >
> >> > -	*gpio_ret = desc_to_gpio(desc);
> >> > +	gdev = gpiod_to_gpio_device(desc);
> >> > +	fwnode = dev_fwnode(gpio_device_to_device(gdev));
> >> > +	if (!fwnode) {
> >> > +		gpiod_put(desc);
> >> > +		return -ENODEV;
> >> > +	}
> >> > +
> >> > +	*gpio_ref = SOFTWARE_NODE_REFERENCE(fwnode, gpiod_hwgpio(desc),
> >> > +					    active_low ? GPIO_ACTIVE_LOW :
> >> > +							 GPIO_ACTIVE_HIGH);
> >> 
> >> Sigh... I hate it and it looks hacky but I also don't have a better idea. :(
> >
> > Thanks, that is quite common reaction to the code I write ;)
> 
> When I looked at this one in the past, the only other idea I had was to
> completely separate it from the regular gpio_keys driver and just make
> it a separate input driver. I think that would make this driver a bit
> cleaner, but it would also require a bit of code duplication and I
> can't tell if that is worth it.

Yes, I had the same idea and tried doing this. And pretty much ended
duplicating gpio-keys in soc-button-array...

Thanks.

-- 
Dmitry
