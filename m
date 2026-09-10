Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEC4AB1B6
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065491; cv=none; b=S5LNNTFvbbxMQ16wUxGSvdxvg5xzrqLP7H/7hgXzUjZMDCFOvQiN3oLX4/5RCbix0BvWfyK8BRc7ac8UpoFUElun1UgRyNhjJeVftL3D2v6XS4KNHAyrLU+EVDpDlEUijCqnazxv1riKVPTld10ivZbel/9Rl/KQ4EWhbaaxmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065491; c=relaxed/simple;
	bh=XqQ/TBdyys53bJSV2TlOxB+9gn0LoZosuGJ+Op+jijg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knwsOTRQRqreG7zZ200GK6zXufpgajm3CFnvCQ/heQtEVP+fB25q8f8cwv1cMjCSXZAFCOHk+0zmvcUTcWhBGT+z2LTHmkZ4o4zx11druGpad7/whr0pn1TqyOcd2mNpPqZzY6Kt8Ia9hRhwBNzWcatQPalSDoI9C/obavoVj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByiblXtc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByiblXtc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso37666a91.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065487; x=1789670287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9u7TJ9tgwm2KnuZFSYIca8LwnX5gbxqDtxG2LPSH6i0=;
        b=ByiblXtc3+xG0Oh2cV0vBgSMKuqQtcRusXb89NrFQsnx41PBnsEtuNsoJ95Wrw2fMF
         8RdITLXQ2BAgyIbQRdFDCTbBCNvrWhrhglJ4fSPw2G/Khp+aha2xy60L8EX92MDwC2q5
         1n2d0lhk9L90B8Z/IHmcEnGRpAQnUFQFzweH2z+xskdkPUzwkiB042sQ7k7UdKKxP3yX
         PjE0jP1l9ISxDvP7PJWkgkGSdf8PCnNj8gqSJkOXxuU3GgyB8xVrLSpJm9qkg2INdzs9
         jC6zyRl7S5N2xWI4TPbPYsnMtmFELgKVjgZBfteAxH2aL7ec56dgJvSvbqM3k5hg961W
         BVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065487; x=1789670287;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9u7TJ9tgwm2KnuZFSYIca8LwnX5gbxqDtxG2LPSH6i0=;
        b=Q+1Ig3yS/D2bphZQM0GwuoU5CCETLW2tsegWc/H7quvt11cRMhaiL2WNNgfiaAWYBg
         7bYhlBYJHAIglEqicNqtQlBv9RpQJnm1/r5ogFgJJuh86b2pHHXSAI3GnHpj1UnmP3uX
         6hUKakyxowV9ytfKeyGPtibteOiyOtvcAURwWmdUp1qbQS7+Ifr8MzdUlraq/hk76Bto
         j6FgLxrY+gekFbiNNjEo6UCcCMKYqubY2iMhz1CJt3kMRoPH0ZU0OOqrut5nq8M7QgG/
         qSaT1Sg5qojQA8PVawYDP0eIG7+T2CX4sAAkgZuKECV3xK/RfbjWzLrqFfKYLEmktZPZ
         dEPA==
X-Forwarded-Encrypted: i=1; AKwUvBxXzJ/nBJlC24Af/LJkEZPW2UlwzX4RG1+Ex5gxOpQQBLD13AHyzdM893IfCFybGVYEC/jGJYQpLmxsWg==@vger.kernel.org
X-Gm-Message-State: AFuF++mR5j70Q4p4Dpw/y42mO47CFUmtiCt9zZe2aVGcTPlJkSFxfHmB
	u6x5Bg2FF+ZR/CzpVBICTVfW0fBjBeN0379gKoDfE8/ztLOMzomKgOU0
X-Gm-Gg: AYBFou2sfCHPAN0mA5Rf0/OYckmJ2TIWjCPPRO2LINmLrlu9yZkYFTNmsJZlXBDSyO9
	9ocuN2hNIgtrzzqDc3CgrJGX4fUqCiMomxT/KwyycmQf9NEPGEX5ERZxAyjtEF/491rwSXQ5oAF
	rSmjgVoMpTBaVnLenPa/fV011Njkpw19CPsclggLIjaN4I0CyKKEwYE+8ALszAarTGuFrBZvWTq
	jdryJM5DreMiQ+tqe54BO571zH4+9Ys2BWc+NrmUJkLdZK20Ln0Iv59rQqtANzK5NDjjA7kJexw
	s+bUvttfJ1BBL7XUryVMng8VFrholRskX1ayKBoHcXHvwm4P+/BdOB55MbqMVciTd2SZz3N8Tbz
	njMcTm98sVnlCY/Mm6q8KzGP7B6oSmMuVlPdBIWm42XgNQWORrgVPu8NwUIJEDxEpsvhF3UbLcc
	/7Iqg11M+/kTCtyoYH9RO/9xt4v3EEIUmPBwSj4wKYWJHxq62eKDgzSW9BLvn2Kzlh30u4hj2dq
	1NFzxoOt5ShEis+aPL98fcHwtN7XDuEFss+mAYfov3rm3OI
X-Received: by 2002:a17:90b:35d2:b0:39d:8d38:8b04 with SMTP id 98e67ed59e1d1-39d9bbea1d3mr52593a91.1.1789065486698;
        Thu, 10 Sep 2026 11:38:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm851731a91.13.2026.09.10.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 11:38:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7a92a79e-e22a-4e34-9f11-4086b88f62cc@roeck-us.net>
Date: Thu, 10 Sep 2026 11:38:03 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: Arnd Bergmann <arnd@arndb.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Jonathan Cameron <jic23@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
 Mauro Carvalho Chehab <mchehab@kernel.org>, mfd@lists.linux.dev,
 Michael Hennerich <michael.hennerich@analog.com>,
 patches@opensource.cirrus.com, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Support Opensource <support.opensource@diasemi.com>
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 11:14, Arnd Bergmann wrote:
> On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
>> __
>> Hello Arnd! May you please spare AAT2870 from being removed? I have a
>> device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed
>> yet, but in process as well) and atm I am working on converting this
>> driver to use OF. Thank you!
> 
> Sure, I have removed this patch from my series now.
> 
>> P. S. If you are planning to remove more old drivers, please CC me in
>> since I may be interested in some additional driver upgrades for
>> devices I own.
> 
> Please have a look at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
> 
> I tried to be careful about figuring out exactly which drivers are
> unused, but I'm sure there are still a few false positive and false
> negative ones in there. I've added the current list of driver files below,
> let me know if you see something that shouldn't be there.
> 
>       Arnd
> 
...
> drivers/hwmon/ds620.c
> drivers/hwmon/f75375s.c
> drivers/hwmon/max1111.c
> drivers/hwmon/max197.c

I missed the rationale for removing those, but then I don't really
mind either. I guess we'll hear if someone still uses any of those
drivers/chips.

Guenter

