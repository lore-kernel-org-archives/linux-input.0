Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA623D283
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842661; cv=none; b=d88fUKq8qJakuixICx7iCguCVAdsMbVQIeH16O8WDCDSwtFlnn0Dabug/xzLydG/udr6bA/8T3Db+yoptoCZlNNVlBQKU2CYRUsQT27huX0g7f34AxBlBTgjVmB8NSpRvvRHqdDpH4NmTFQ1zf8jMC4MDJtwIeWM/YMYuZqEa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842661; c=relaxed/simple;
	bh=0oMelPJSOtVZGavYCdIfgJZMKb5FseBD1M2xuqmgUD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cV+UMffxoZLlKVY2e3E88qZ+QAUuZccQ1CY6vhrtqzGMf8ioboJeuPE18Ry3gyU6T8vptwa5ucHGP58T6XW/P2xRyVZ8XVeJOK/kTAuZYjlqLO+Q/JpZU61gbSOASTNyPnfoWe+OwUmtmIoqdyYhhf5OuuZ6+1l+hmSs23wedcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=rMhaJxSA; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="rMhaJxSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1781842658; bh=0oMelPJSOtVZGavYCdIfgJZMKb5FseBD1M2xuqmgUD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rMhaJxSAggeKwFfGCEExdgCjPrI89B2iz0+pTy4mMXjL5hABk+ZE1uZI5ggzYEOgL
	 dRVUZtN3EfvqWd/GCmiw412Qu+4j1e7/mppjgYRDB9W53V0NtspaL7r2oPdUAEZTzs
	 o7O948BKdYRmNv+PsbxgIT3L3XHjTlhkti7ag3maHfnlG+DZuep0VOwa37njslrICU
	 6MvpGP8XjqAL95ksEWdRpCQCRzYjzXNKL9uAiXfXkSvHt8Vo+2u8j3FW3Fq9XnU0Iy
	 GPuSKUO9Z7aI62WbtekS+xYzVYZAG11GM5obr1V6T3hxcfQ1YAZZmB0/uP/fU2i2E9
	 OQjP10S9oAxPQ==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 5FCCBA043;
	Thu, 18 Jun 2026 21:17:38 -0700 (PDT)
Message-ID: <7550515b-0474-453e-b219-77d2f31be318@endrift.com>
Date: Thu, 18 Jun 2026 21:17:36 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
References: <20260512200051.2534081-3-vi@endrift.com>
 <20260514005353.EF8D8C19425@smtp.kernel.org>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <20260514005353.EF8D8C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let's tackle some more hallucinations.

On 5/13/26 5:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Mixing jiffies and milliseconds in delayed work scheduling logic causes an integer underflow, permanently stalling the haptic rumble.
> - [High] A guaranteed NULL pointer dereference occurs in the error logging path of switch2_rumble_work, as well as a TOCTOU race condition.
> - [Medium] `ns2->ctlr_type` is checked before it is dynamically initialized, causing union corruption for GameCube controllers.
> - [Low] Implicit type promotion in the max() macro causes a compiler warning.
> - [Low] Kconfig documentation claims individual motor control for the Pro Controller, but the implementation identicalizes the rumble data for both motors.
> --
> 
> commit d72f0f8e0dadde2cacc27050b92088c2e5cbea0e
> Author: Vicki Pfau <vi@endrift.com>
> Subject: HID: nintendo: Add rumble support for Switch 2 controllers
> 
> This commit introduces rumble support for Switch 2 controllers, handling both HD
> Rumble linear resonant actuators and eccentric rotating mass haptics. It adds
> state machines for rumble scheduling and output reporting via hdev.
> 
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 26ef589f652c6..a7fe74d982475 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -850,10 +850,10 @@ config NINTENDO_FF
>>  	depends on HID_NINTENDO
>>  	select INPUT_FF_MEMLESS
>>  	help
>> -	Say Y here if you have a Nintendo Switch controller and want to enable
>> -	force feedback support for it. This works for both joy-cons, the pro
>> -	controller, and the NSO N64 controller. For the pro controller, both
>> -	rumble motors can be controlled individually.
>> +	Say Y here if you have a Nintendo Switch or Switch 2 controller and want
>> +	to enable force feedback support for it. This works for Joy-Cons, the Pro
>> +	Controllers, and the NSO N64 and GameCube controller. For the Pro
>> +	Controller, both rumble motors can be controlled individually.
> 
> This isn't a bug, but is the help text accurate regarding individual motor
> control? The implementation in switch2_rumble_work() appears to encode the
> exact same rumble configuration to both the left and right motor offsets,
> which would make both motors vibrate identically.

I didn't add this text, so I'm ingoring this.

> 
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index 2193afcdefabc..9801799a90758 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
> 
> [ ... ]
> 
>> @@ -3103,6 +3155,107 @@ static inline bool switch2_ctlr_is_joycon(enum switch2_ctlr_type type)
>>  	return type == NS2_CTLR_TYPE_JCL || type == NS2_CTLR_TYPE_JCR;
>>  }
>>  
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +static void switch2_encode_rumble(struct switch2_hd_rumble *rumble, uint8_t buffer[5])
>> +{
>> +	buffer[0] = rumble->hi_freq;
>> +	buffer[1] = (rumble->hi_freq >> 8) | (rumble->hi_amp << 2);
>> +	buffer[2] = (rumble->hi_amp >> 6) | (rumble->lo_freq << 4);
>> +	buffer[3] = (rumble->lo_freq >> 4) | (rumble->lo_amp << 6);
>> +	buffer[4] = rumble->lo_amp >> 2;
>> +}
>> +
>> +static int switch2_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
>> +{
>> +	struct switch2_controller *ns2 = input_get_drvdata(dev);
>> +
>> +	if (effect->type != FF_RUMBLE)
>> +		return 0;
>> +
>> +	guard(spinlock_irqsave)(&ns2->rumble_lock);
>> +	if (ns2->ctlr_type == NS2_CTLR_TYPE_GC) {
>> +		ns2->rumble.sd.amplitude = max(effect->u.rumble.strong_magnitude,
>> +			effect->u.rumble.weak_magnitude >> 1);
> 
> Will this max calculation trigger a compiler warning? The strict type checking
> in the max macro might fail because effect->u.rumble.weak_magnitude >> 1
> promotes to an int, while strong_magnitude is a u16.

It doesn't cause a warning locally, but my warnings seem lax for some reason. I'm not sure how to fix that, but I guess adding a cast here is harmless.

> 
>> +	} else {
>> +		ns2->rumble.hd.hi_amp = effect->u.rumble.weak_magnitude * RUMBLE_MAX >> 16;
>> +		ns2->rumble.hd.lo_amp = effect->u.rumble.strong_magnitude * RUMBLE_MAX >> 16;
>> +	}
>> +
>> +	if (ns2->hdev)
>> +		schedule_delayed_work(&ns2->rumble_work, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static void switch2_rumble_work(struct work_struct *work)
>> +{
>> +	struct switch2_controller *ns2 = container_of(to_delayed_work(work),
>> +						      struct switch2_controller, rumble_work);
>> +	unsigned long current_ms = jiffies_to_msecs(get_jiffies_64());
>> +	unsigned long flags;
>> +	bool active;
>> +	int ret;
> 
> [ ... ]
> 
>> +	if (active) {
>> +		unsigned long interval = msecs_to_jiffies(4);
>> +
>> +		if (!ns2->last_rumble_work)
>> +			ns2->last_rumble_work = current_ms;
>> +		else
>> +			ns2->last_rumble_work += interval;
>> +		schedule_delayed_work(&ns2->rumble_work,
>> +			ns2->last_rumble_work + interval - current_ms);
> 
> Does this code underflow the scheduled delay?
> 
> The current_ms variable is retrieved in milliseconds using jiffies_to_msecs(),
> but interval is calculated in jiffies using msecs_to_jiffies(). Since
> ns2->last_rumble_work is initialized to milliseconds but incremented by
> jiffies, subtracting current_ms could yield a negative value.
> 
> On systems where HZ is not 1000, could this underflow the delay parameter and
> schedule the next work millions of jiffies in the future?

Fixing in v6.

> 
>> +	} else {
>> +		ns2->last_rumble_work = 0;
>> +	}
>> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
>> +
>> +	if (!ns2->hdev) {
>> +		cancel_delayed_work(&ns2->rumble_work);
>> +		ret = -ENODEV;
>> +	} else {
>> +		ret = hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
>> +	}
>> +
>> +	if (ret < 0)
>> +		hid_dbg(ns2->hdev, "Failed to send output report ret=%d\n", ret);
> 
> If ns2->hdev is NULL, we set ret = -ENODEV and then reach this hid_dbg call.
> Could this result in a NULL pointer dereference, as the hid_dbg macro passes
> ns2->hdev to dev_dbg()?

Fixing in v6

> 
> Also, since ns2->hdev is accessed locklessly and without READ_ONCE(), is there
> a time-of-check to time-of-use race where the compiler might reload the pointer
> between the check and hid_hw_output_report()?

This can only get changed in switch2_remove, which is missing a cancel_delayed_work_sync. Fixing in v6.
> 
> [ ... ]
> 
>> @@ -3881,6 +4048,14 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
>>  
>>  	switch2_leds_create(ns2);
>>  
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +	if (ns2->ctlr_type != NS2_CTLR_TYPE_GC) {
>> +		ns2->rumble.hd.hi_freq = RUMBLE_HI_FREQ;
>> +		ns2->rumble.hd.lo_freq = RUMBLE_LO_FREQ;
>> +	}
> 
> Are we checking ns2->ctlr_type before it is dynamically initialized?
> 
> During probe, ns2->ctlr_type appears to be 0 since the struct is freshly
> allocated and the type is discovered later during the init state machine.
> This would cause the high and low frequencies to always be written.
> 
> Since hd and sd share a union, could this corrupt the sd.error and
> sd.amplitude fields for actual GameCube controllers?

Really, really unimportant and technically "works by accident" territory but I'll move the logic anyway.

> 
>> +	spin_lock_init(&ns2->rumble_lock);
>> +	INIT_DELAYED_WORK(&ns2->rumble_work, switch2_rumble_work);
>> +#endif
>>  	hid_set_drvdata(hdev, ns2);
> 

