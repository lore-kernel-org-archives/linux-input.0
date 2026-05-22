Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72531A23A6
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453932; cv=none; b=aEzm4uiAjprIwhu4q+DX/tiG0WxLuKt1/vkM0ap2EMLOUCA0gJOCSpfVN8IBqI6O+6n4DLUjphblBchw+YpStamL8lRdICnZCOkbwqvi/zOxs8P4KYqFYa3CoIytPaBFnYNKebOGBbZn0hoZfR92+L4kBIMZ75zFns4htkvKwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453932; c=relaxed/simple;
	bh=B6Wrx8wptznPEXE7GgI4oCIpRWZlbijf1SHKh604G6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWShlf7r/PNNUJnARAucr86B2+cdFPVGkfMDW/GWHBz/z16c/5d86Cjs7M7ONuL6NfuZS5YyoWWM1YC176iFloLmJa1GCj31uIfFBIqkH6inbY6lJ0z7lX99at60jihtwmZwU54Ar23KFdf2CKjKNaKfUe4yaqV+sIEdrz7gmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9TdA1s9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9TdA1s9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so7840500e87.2
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453928; x=1780058728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEx08WhtJbuH9Jvv5ffuVG6XRuDs6AIyFWz3HRiJmYw=;
        b=S9TdA1s9sU06k7pAAsQhZgPt6Jm2cy1jpfHiVjy/+4+phsKTB39AbQjFrUaHHvTuHa
         7xcha/kC9qOvlrvOc+x2JTP+jZxZ/e3H1ei/X60CDqJpjGmR8Nzbf9OwEeh6jXSYmMe6
         1lqGhLX9WLcsDUNoRDwB8RN2/7jcZGUB/8QVzZr9eANTujcgTuVz1xsDUvY1h5CzWkhw
         CjjnUJzTgxZB4Xvh+ERZIfoeKsbVY7GHoFXwuSABK574IaI9xqc2uETLj3zU1ZFqV2YS
         GuqN5wtrNjE3MnCX7eUhhI4j839ntAaSS2DRdL1e8/Q6vQSCXDKpTqbm32FekGdEJyes
         Fk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453928; x=1780058728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEx08WhtJbuH9Jvv5ffuVG6XRuDs6AIyFWz3HRiJmYw=;
        b=mg4sl+CRvZNyxVgsoerOm+VsmfQmqbZ5CJD/oxiDISOwMk8rWVL8ym4WJFcBduQqLm
         mWaYnr9vO1TBwWsetzqYz3jeZLJmakvdhNJEsOdf5cwb0Ci2O35Jq3miH3oftw00dKeO
         3jo2YunLjbqlJMbbscNoaAbNjFqfmHDy51HD3REpgOuWoCB9HPo/aiAwgIt4Fvd5NIba
         BVF+1HQgu9LaMf+LhARn3FX5cYhuV3+zaFbufPFMZvB1F7cJ66ic+yew7X1y7hIiEsRZ
         MBLd9izmkUDgcA2pcgG2KQnkQnvYvaT+95bfgylgH5aFrcHeUlbUx0u9G9uo8MHP5u/j
         m+OA==
X-Forwarded-Encrypted: i=1; AFNElJ8sNOojY6weeo3mSXGaGwRFz1hhKyrklzPdD1Jq4B32K3f8ByghR+9RnirxVt+3tSvd/md6k1TA4Gk3SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygF8Am1E9uNVpztWtbzs00E9xOChtaZgF9MjHF2j/VrTyk7Az+
	BFROQO4VKaHVIdR0qYhR0RAJCBRlMbabJ8twaA57NMs+lJDdkXf9luGU
X-Gm-Gg: Acq92OG00wAEYBBwAVfpP+hieCFrq0RaHLKkl672ld/RghQgLhenHdHlCNhqUhJAJzU
	GKkJg/5FlpeF0fSCH75BCW/wi0nYIuO1/uuK2m0edxaIXHlHjjFwGiw8wfHBM2qz1CnCAem+7W3
	5T+VFdKyqyId+T7oM8nuhEFceJLAM+xln07EZJY3fisvD6+gd9ZgkpaFn1nqFH0WB7nxmtkNdCM
	x55Q5WjvXT43a218GoSxNuLim5W36lYnjjWSrKNBRVOhNdO9LTHaGwcF8NVWGkUE19PRZ9xxTph
	C5+orfzMd3Xv6TO5OkGwZUTZkIV3tkwxR2SBlbfWmmMaTl1w2DtL0tMZTB+Yry4xjxTmVOG0CoJ
	m1NQ8bAlDD32NPN7CVJu0EDOnQvv7+VGIS//7a8T3KO6TdPwnm/sFFUJY5/bU/56mZoKT6I0X8m
	vNqQ14iZ8YOQjgd3FT81PDj6agsOYdPME0rPqtVpo3HnJkquHNVrum7Skv21VgxUH1xYOiSyp4u
	OlacdB9
X-Received: by 2002:a05:6512:33c9:b0:5a8:64c4:38c4 with SMTP id 2adb3069b0e04-5aa32314258mr1031399e87.8.1779453927777;
        Fri, 22 May 2026 05:45:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb37bfsm401018e87.11.2026.05.22.05.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 05:45:27 -0700 (PDT)
Message-ID: <55c36da0-6cc4-4c95-88ef-3dd5b2181b0d@gmail.com>
Date: Fri, 22 May 2026 15:45:25 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, Netdev <netdev@vger.kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
 <681f328c-bc8a-4410-b876-f8c5f116325d@app.fastmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <681f328c-bc8a-4410-b876-f8c5f116325d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2026 11:28, Arnd Bergmann wrote:
> On Fri, May 22, 2026, at 06:55, Matti Vaittinen wrote:
>> On 20/05/2026 21:38, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
>>> passing an IRQ number instead. In order to keep this working both with
>>> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
>>> the gpio number if an IRQ is passed.
>>>
>>
>> I am (still) all fine with this, even though I like Dmitry's set. I
>> suppose you already have a plan for merging this, but I still have to
>> ask - why the MFD changes aren't in own patch? I feel it would have
>> simplified merging, backporting, reviewing and reverting if needed.
> 
> Splitting it out would break bisection: The gpio-leds change without
> the mfd change causes a build failure when assigning the .gpio
> field, and the reverse causes a runtime failure when .gpio=0 is
> a valid line.

Ah, yes. Thanks for explanation. (I feel a bit [a lot] stupid, as I 
somehow missed the problem of .gpio = 0 being valid. That even though I 
had it explicitly set to -1 myself :rolleyes: ).

No further questions ;)

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
