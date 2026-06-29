Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEC3C345B
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767509; cv=none; b=Uz4VIHvqxsz2hJJ5CaPGFf498FED5pqqVKTXtCFE1pEJDESSISqEmV3GzGV9zp2nC47WvXXtAqk9Qpfv2CeiQ4OESdUH1Iuxv0C3YMr5g88lBgDscUqCQkh+FgcV6oNTBH6ihZ/UCJaoW58565lq/tem0Aw87Yb+D60gPluN7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767509; c=relaxed/simple;
	bh=8v1ujR//9JoYKHXmRMZ5+TJhb0iuKUICxJbCg6/Wtds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzQPZ3vyUlYhWD7Wvx/D8nmU5OrU1huwEpTh5UwHUAZxHBe2LkrBVdveBmHujLnnxqQcdvKhePe8zjUswPguA9qfKnQlOn4BHFJEAm3UBRPHeGZ86pjMoJjYaELlRabFwnca+Bt/gI0HxPUnxX0qZizJHdoD/OpTPjbYgefeVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3Zh5/yc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3Zh5/yc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so2985290f8f.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782767494; x=1783372294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8v1ujR//9JoYKHXmRMZ5+TJhb0iuKUICxJbCg6/Wtds=;
        b=X3Zh5/yccMM6kZSkod2LjdJcQ+vStRZ3u5lMwUt4CfZSw7+8l3VpmzntYgGUGlHFmt
         w5Ku8XSD42a2Cq/olJ7lAFGql93S/GpH71XQLDG+1aHsS1r5O+ysHQHxsHxSa8wA351a
         5bPn7fCXl+CVcu5iVl0JLXkbDdq0VYIRR2YZiZUuQQ/rjEsNmEoY5Sa8AWOIaAJrd9da
         x2segZQFdfdhet5v0vTfS6ThHDctX+hyXex8QUvh6Bz7UKiyYnlI3LDfZhnBDfcjq5P5
         sRez7oLQlRoJmspNzylKPAyBHAqimdQLkU35AEUwCCS9AKghj+CEOoVq5ty1Y+lVAM9P
         RbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767494; x=1783372294;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8v1ujR//9JoYKHXmRMZ5+TJhb0iuKUICxJbCg6/Wtds=;
        b=BBc9pwWm76vQDI0aiUT9CIt+QOnGSVc8dcNze1LtNz2SuK8IwUkD6pSCT2zix5/HEI
         FiJ68/rqQZu0JXWUBN2hWedmJK/cFmwGQ8n5SOg9zV8/rFf8pPhAMlM4GEXCOzWmESfU
         641/a1hjPazeXKrDzrBZ+9gt9c1uJiyJGa/lTLfwENdWjnM07O5DH8zeq16r8OnrKjdn
         Q52CMkQZRhntFtku7/UD38avrl4prY3mvpeFlRNCaWeaJPYygyA3i52QTMuKawqk3q36
         7pi0v3scqB9j/mwbA9yyayJGn2ZZSC80iZB0R1W61SCAjcVYf3L1cxlwe6nOpvNvY+ig
         SGzg==
X-Forwarded-Encrypted: i=1; AHgh+RqzOobR+jgISBNbkFgqMMQMput+4d8pU1FNgj6TOyPIpbhdGL8tKfL/NCZR0k8SDyG76ZT8heTQ2kXQrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21TQ5dFWQ64SgyZVEQwafDlf08rat6SgGjch5x5jjE3JNmd3/
	ZyRnZ90dA+R9DmFE3phO0q7FeR4w7+dFPjc5BrdNhVV19QSpIRkTGFFEoI7TzQ==
X-Gm-Gg: AfdE7cmXuGCSWualYz32Uwa64iNwYReJzCRCmqnEpcQfvERtJA4oJfJnox6UHIgd5VA
	5Hq6IQcuVq8PdOerdfqHxg8Vx4hu54WJ7sx0Ph26PytD7f+PovQ8daS20NBFvjh0r/zhLQgYuBk
	UQVQL6YfgssVsNW4bkwKxFe5dKFLu4Mj7LXaxTvFt9vvGAd+gQDUS5GKmYHaxzt37/RNqkVxwmW
	GugUpzT8/FiiMbLH0SiQE9luZSNO2DdNq1Z4nWfoUO7f6zVa+IahAd3Za+8itFsE3sca3nVRrZu
	0jP8jINfci8cj/YXhTxCULsFZAyvbTMATrI/jOiEjysrgmUOR8Wjt/RcC/O5L1Ggg/dUOUPERNv
	XRxVFhc/CtIoEiCh7KRrE1MFzcZU//v80EVg8rW9y7kIFakhE6mw1NjgfTkEEGoTHzecBTvbWts
	/2/7ta5b2ct1+8UbzZ/vkH
X-Received: by 2002:a5d:4283:0:b0:460:67e0:563e with SMTP id ffacd0b85a97d-475529730ddmr783305f8f.35.1782767494007;
        Mon, 29 Jun 2026 14:11:34 -0700 (PDT)
Received: from [10.80.0.99] ([151.49.228.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cde2sm1123683f8f.20.2026.06.29.14.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 14:11:33 -0700 (PDT)
Message-ID: <abca959e-8757-426c-b641-f18cebfbeed5@gmail.com>
Date: Mon, 29 Jun 2026 21:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] HID: asus: security fixes and more hardware
 support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Denis Benato <denis.benato@linux.dev>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Connor Belli <connorbelli2003@gmail.com>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
 <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet>
 <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
 <CAGwozwFgw5aj1k_h60whKhTkzSf+vc=eEGvFz9sa-0rGoWOoww@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwFgw5aj1k_h60whKhTkzSf+vc=eEGvFz9sa-0rGoWOoww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/29/26 22:21, Antheas Kapenekakis wrote:
> On Mon, 29 Jun 2026 at 22:12, Denis Benato <denis.benato@linux.dev> wrote:
>>
>> On 6/29/26 11:21, Jiri Kosina wrote:
>>> On Fri, 19 Jun 2026, Denis Benato wrote:
>>>
>>>> Hi all,
>>>>
>>>> I have added support for controlling the (way too bright) XG mobile
>>>> LEDs in hid-asus and added the i2c version of already supported
>>>> hardware that was probed only when it's a USB: these are two separate
>>>> features changes and are the only two that are not fixes for
>>>> pre-existing issue (see below).
>>>>
>>>> Auto-review bot has spotted a bunch of pre-existing problems alongside
>>>> problems in my own code therefore at this point I am going to fix the
>>>> more problems I can and including those fixes and improvements in this
>>>> patchset.
>>>>
>>>> For v4 I decided to follow Antheas' suggestion of reusing the existing
>>>> workqueue and by making it more generic I solved a good bunch of issues.
>>>>
>>>> The v5 iteration is simply me fixing a bunch of bugs in new code spotted
>>>> by the bot. Thanks for providing such a useful tool!
>>>>
>>>> On a side node this patchset has a few more warnings: specifically
>>>> "WARNING: Prefer kzalloc_obj over kzalloc with sizeof" but it's a false
>>>> positive as that would introduce sleeping calls in atomic contexts.
>>> Denis,
>>>
>>> thanks. Could you please flag which patches you'd prefer to go in still
>>> for 7.1 and which ones are not critical and could wait for 7.2? The whole
>>> lot is quite big.
>> Hi Jiri!
>>
>> Patch 1 contains multiple fixes, mainly use of sleeping calls in atomic contexts:
>> I'd say slap it in 7.1 fixes.
>>
>> Patch 2 is a minor improvement removing an OOM message to align the driver
>> to newer code where that would have been a flagged warning: probably a fix for
>> 7.1 but there's no rush for this one.
>>
>> Patch 3 is a logic fix, condition is very rare (not sure if even possible) but belongs
>> to 7.1 almost certainly.
> I would like to take my time on reviewing patch 4 in the next cycle.
> The patch 5 does the backlight for the station? That looked _fine_ to
> me but a second pair of eyes would be good because it is big.
Mmhh I think you may have a mistake here? Patch 4 has your reviewed-by
and it's for the xgm led.

Patch 5 adds backlight for TUFs 2025 and 2026 models: asus is using
the (almost) same firmware as recent ROGs just i2c instead of usb,
so patch 5 add i2c to the list.

> Antheas
>
>> Patch 4 new feature support: goes to 7.2.
>>
>> Patch 5 unsure. It adds support to the backlight, but to properly do it I'll need
>> to wait for lamparray to be merged since autonomous mode must be disabled
>> to take effect. I'd say 7.2 just because of the missing lamparray. Merging in 7.1
>> has no downsides, yet IDK if putting in 7.1 violates some rule (probably yes?).
>>
>> Please give a (very) quick read to the following link:
>> https://github.com/OpenGamingCollective/asusctl/issues/119#issuecomment-4723566635
>>
>> This is something I am full of tickets for, probably we have reached the thousand
>> between discord, github and gitlab: very prominent issue and I'm eagerly waiting
>> for lamparray support to appear upstream.
>>
>> Thanks,
>> Denis
>>> Thanks,
>>>
