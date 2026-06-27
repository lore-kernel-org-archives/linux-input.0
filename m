Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98E331EDB
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782528547; cv=none; b=SK1goj4K34NkAz9HKnjfd4Dr7yjBWfb0SH8g2x5GafRsOwKv01ztNyOJxrHbRh+B/86nOtS8IuhVTxjKgwReHmfLVk/aao7OEkHCYhFUgWuuJnUd1/mPO9xg57fjd1N+r07eyqj4OMEWQ9WNgCQpFUu1ql+dXxjwO/4EmtgFZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782528547; c=relaxed/simple;
	bh=jPLnq9IkllUduvJMQq8tSFBLws/cOlxc+i3QLLMxLZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbLTV/Z3inr70ZUhtbJ4m6mOmofbloCnq3kie2TJ3/IxnSIp+A4gxEx35WFWsOXQEfwbXXbM2MjnOpXu8oSJy+aa2nSv7gslWFuU+v78PK/BvIA9Ju8r0IGzFpLv1V1ugb50Uj0RacRLd4Ctkdo7UYCBjHU14QfDj8uGDG1efgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=pV8fHis/; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="pV8fHis/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782528540; bh=jPLnq9IkllUduvJMQq8tSFBLws/cOlxc+i3QLLMxLZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pV8fHis/EH91kx38B/7mZd/s/NEZ4uWejuB5r3qGnTBSwzAtYdfGPAgNZiJFVXfYT
	 sZB+3GCKZ7OlSybo88DNfm9aQOlOFQWFDSNfJAYm/cY6XaBJ2kdozNzIBq6Trb95fV
	 GTgMMrJNi9FGPxm8upWY/Yk/8BRVGkq4n9cuisvmGiVuTS1R0OyD+8PCTnhIXGDBKW
	 BBKfKPIXDV2xaetJ+d9aj05HOLMj/iOlCp5t8XT7BcXXVBYr0z7mB6+C3RN+fivXj0
	 YwfQvq8XP0o1KUApAbg2Fh08gTi4vyM6eRI5J84KZhe1btkDh8L0L/75Il+lYagrrm
	 vPu7iVnAYzXeQ==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 56F40A018;
	Fri, 26 Jun 2026 19:49:00 -0700 (PDT)
Message-ID: <39371007-e06c-49d9-8465-2f9de2955c63@endrift.com>
Date: Fri, 26 Jun 2026 19:48:58 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
References: <20260625045948.2343168-1-vi@endrift.com>
 <20260625045948.2343168-3-vi@endrift.com>
 <20260625051833.C1A131F000E9@smtp.kernel.org>
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
In-Reply-To: <20260625051833.C1A131F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/26 10:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Unsynchronized accesses to ns2->hdev allow rumble work to read a closing device pointer, leading to a TOCTOU NULL pointer dereference.
> - [High] cancel_delayed_work_sync() is called on an uninitialized work structure if the configuration interface detaches without the HID interface probing.
> - [High] Use-after-free of ns2 due to the input core's memless force feedback timer outliving the driver's private data.
> - [Medium] Arithmetic underflow in schedule_delayed_work() delay calculation causes the rumble worker to permanently hang if its execution is delayed.
> - [Low] Unused static constant array switch2_zero_data leads to dead code.
> --
> 
> commit 93841885eb908e1356dc311955f33fee3d1428c6
> Author: Vicki Pfau <vi@endrift.com>
> 
> HID: nintendo: Add rumble support for Switch 2 controllers
>     
> This commit adds basic rumble support for the Switch 2 controllers. It
> introduces delayed work and force feedback support.
> 
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index 6573fd31a232a..ae360f4d15d1a 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
> 
> [ ... ]
> 
>> @@ -3133,9 +3183,12 @@ static const uint8_t switch2_init_cmd_data[] = {
>>  };
>>  
>>  static const uint8_t switch2_one_data[] = { 0x01, 0x00, 0x00, 0x00 };
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +static const uint8_t switch2_zero_data[] = { 0x00, 0x00, 0x00, 0x00 };
>> +#endif
> 
> [Severity: Low]
> Is this unused variable intentional? It appears switch2_zero_data is never
> utilized anywhere in the codebase.

Looks like leftover from a previous iteration. Removing.

> 
> [ ... ]
> 
>> +static int switch2_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
>> +{
>> +	struct switch2_controller *ns2 = input_get_drvdata(dev);
>> +
>> +	if (effect->type != FF_RUMBLE)
>> +		return 0;
>> +
>> +	guard(spinlock_irqsave)(&ns2->rumble_lock);
> 
> [Severity: High]
> Can this result in a use-after-free when the input device outlives the driver
> data?
> 
> During device removal, switch2_controller_put() explicitly calls kfree(ns2).
> However, the input device is devres-managed and its lifetime is tied to
> userspace holding its file descriptor open. Since the input core's memless
> force feedback timer is only destroyed when the input device is released,
> the timer callback switch2_play_effect() could potentially fire after ns2
> has been freed.

I will see about tying this into the ref system I added for patch 1 to delay the free.> 
> [ ... ]
> 
>> +static void switch2_rumble_work(struct work_struct *work)
>> +{
> 
> [ ... ]
> 
>> +	if (active) {
>> +		unsigned long interval = msecs_to_jiffies(2);
>> +		uint64_t current_jiffies = get_jiffies_64();
>> +
>> +		if (!ns2->last_rumble_work)
>> +			ns2->last_rumble_work = current_jiffies;
>> +		else
>> +			ns2->last_rumble_work += interval;
>> +		schedule_delayed_work(&ns2->rumble_work,
>> +			ns2->last_rumble_work + interval - current_jiffies);
> 
> [Severity: Medium]
> Could this delay calculation underflow?
> 
> If the worker thread is delayed by the scheduler such that current_jiffies
> exceeds the expected execution time (ns2->last_rumble_work + interval), the
> unsigned arithmetic could underflow to a value near ULONG_MAX. This would
> schedule the next rumble update weeks in the future, permanently hanging the
> force feedback mechanism.

I think I've seen this. I have trouble reproducing it but I'll fix this and hopefully it'll stop reproducing.

> 
>> +	} else {
>> +		ns2->last_rumble_work = 0;
>> +	}
>> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
>> +
>> +	if (!ns2->hdev)
>> +		cancel_delayed_work(&ns2->rumble_work);
>> +	else
>> +		ret = hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
> 
> [Severity: High]
> Is it possible for a concurrent removal to cause a NULL pointer dereference
> here?
> 
> Because ns2->hdev is read outside of any lock, there may be a window where it
> is verified as non-NULL, but then set to NULL by a concurrent
> switch2_remove() before being passed to hid_hw_output_report(). This appears
> structurally possible if userspace invokes switch2_play_effect() and
> reschedules the worker right after the initial cancellation in
> switch2_remove().
> 
> [ ... ]

Fixing.

> 
>> @@ -3358,6 +3521,10 @@ static void switch2_controller_put(struct switch2_controller *ns2)
>>  	if (input)
>>  		input_unregister_device(input);
>>  
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +	cancel_delayed_work_sync(&ns2->rumble_work);
>> +#endif
> 
> [Severity: High]
> Could this cancel operation act on an uninitialized work structure?
> 
> The switch2_probe() function initializes the work structure:
> 
>     INIT_DELAYED_WORK(&ns2->rumble_work, switch2_rumble_work);
> 
> If the configuration interface detaches before the HID interface probes,
> ns2->rumble_work might remain zero-initialized. When switch2_controller_put()
> is called, unconditionally invoking cancel_delayed_work_sync() on this
> uninitialized work structure could trigger lockdep warnings and kernel panics.
> 

This will be fixed by my probe refactor already.
