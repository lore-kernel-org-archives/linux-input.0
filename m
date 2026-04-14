Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C2289367
	for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131506; cv=none; b=P4OCdFSYkWQ0yvKjvDvzW7mJ+qz+KeE4bYcGmmKhSNhnzIKIGODsmWxmDHzNiTBHUerpjfEIeC51oVFfP6PiOiticuHjE+w6JxVbQ/BzsE69QLmG3dIVtSDbDRKRLVVsKaMH9lHYV3jts9JG45YLFHedNxEIi6hZICc8PxD+tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131506; c=relaxed/simple;
	bh=wp6e3uo7vpMuSgCicjDDkZi6aeRkNINYBkhWcCLpG5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOPQR0roALPORIlw/ieTE5U9zlM8wGEKhptCIYMBnJ8Cnmoy/yq9AU7poS4/dHRSJGLvFsXQelfYQ5CEIzPQ9tp2EdZbkl07fnaLn2ltgoa1LU9hQnnjvBreA2fFJlovlKPxwGYc9xR6gjuA1HMZKrWZVjETvGctltc186ot4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=PIzx4JNQ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="PIzx4JNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1776131497; bh=wp6e3uo7vpMuSgCicjDDkZi6aeRkNINYBkhWcCLpG5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PIzx4JNQXdZBgWcxbkOa3Cs6+o5leF1IzfbnWITP+p+9ClqNPBh1+0OQbsQgZZlEQ
	 PimXWLA2Sh70JbCH1OxnT4hvy65tcKFS/EY7pIz+4Xzm1rLQQjDaTnku3wzfzj0mdd
	 6J0VnGVOvZJ7TYAaDN5sjlD30EGwNkPfdj8I0Z4h4cB4H6x60kKwVe7xMixYAW7m/Z
	 iEINUXnunrjLdGkTd+vkS0NnTff+1E5zq4VZio7pPl0cS/GtjyLL5yasTpexyr1gW7
	 ca9iLB5UXWoc4H+zzrfM0n5/nvChfv/19vmpJ2v3kp4dIpWjdzreM8Piig8gfHAOs3
	 HBwq1F/u4LgYg==
Received: from [192.168.1.158] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 956C1A028;
	Mon, 13 Apr 2026 18:51:37 -0700 (PDT)
Message-ID: <092fa3e7-da59-4b3a-b3e4-c412e391fd3d@endrift.com>
Date: Mon, 13 Apr 2026 18:51:36 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
To: Silvan Jegen <s.jegen@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
References: <20260318030850.289712-1-vi@endrift.com>
 <20260318030850.289712-2-vi@endrift.com>
 <3GWQPE79MJ7Y0.2LOOIA8A83N7R@homearch.localdomain>
 <ee55d9f8-506d-4b95-a63b-01844e4e1bdf@endrift.com>
 <2Z2BPKWVI345D.3HJTS194G9TXN@homearch.localdomain>
 <a2b087ef-e814-444a-9c1e-716310ed1948@endrift.com>
 <3GLFHF2SBGI6U.3O3D6XCXP4074@homearch.localdomain>
 <631510d1-2b9a-4288-a0ac-1c3d1253a0fa@endrift.com>
 <3D95AXVJ22C7J.26Z5DELLJGZTA@homearch.localdomain>
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
In-Reply-To: <3D95AXVJ22C7J.26Z5DELLJGZTA@homearch.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/26 8:29 AM, Silvan Jegen wrote:
> Vicki Pfau <vi@endrift.com> wrote:
>> On 4/10/26 12:44, Silvan Jegen wrote:
>>> Vicki Pfau <vi@endrift.com> wrote:
>>>> Replies inline
>>>>
>>>> On 4/8/26 12:51, Silvan Jegen wrote:
>>>>> Heyhey!
>>>>>
>>>>> Vicki Pfau <vi@endrift.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Replies inline
>>>>>>
>>>>>> On 4/2/26 12:09 PM, Silvan Jegen wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> Thanks for the patch!
>>>>>>>
>>>>>>> Just some comments and questions inline below.
>>>>>>>
>>>>>>> Vicki Pfau <vi@endrift.com> wrote:
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>> +
>>>>>>>> +static int switch2_set_report_format(struct switch2_controller *ns2, enum switch2_report_id fmt)
>>>>>>>> +{
>>>>>>>> +	__le32 format_id = __cpu_to_le32(fmt);
>>>>>>>> +
>>>>>>>> +	if (!ns2->cfg)
>>>>>>>> +		return -ENOTCONN;
>>>>>>>> +	return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_SELECT_REPORT,
>>>>>>>> +		&format_id, sizeof(format_id),
>>>>>>>> +		ns2->cfg);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int switch2_init_controller(struct switch2_controller *ns2)
>>>>>>>
>>>>>>> This is now a recursive call while in v1 it wasn't. I think I preferred
>>>>>>> the non-recursive version as there was one place where init_step
>>>>>>> state was changed while now I am not sure where it happens (and whether
>>>>>>> there is a code path where we end up in an infinite recursion)
>>>>>>>
>>>>>>> What is the advantage of the recursive version compared to the
>>>>>>> non-recursive one?
>>>>>    >
>>>>>>
>>>>>> The old version incremented the step regardless of whether or not it
>>>>>> could confirm it had happened. Since the confirmation is now handled
>>>>>> with an external step, calling into switch2_init_step_done, the loop
>>>>>> condition would become somewhat complicated.
>>>>>> I replaced it with explicit tail calls since that make the
>>>>>> control flow simplier, and it is always matched with a call to
>>>>>> switch2_init_step_done to ensure that the state is always advanced. As
>>>>>
>>>>>   From what I can tell switch2_init_step_done currently only advances
>>>>> the state if the current state is the expected one. This seems fine,
>>>>> but it also means that if the state is not the expected one, the
>>>>> state is not advanced and the recursive call continues anyway (in the
>>>>> NS2_INIT_READ_USER_SECONDARY_CALIB case, for example). I assume this
>>>>> should never happen but if we end up in this case for some reason we
>>>>> will recurse forever.
>>>>
>>>> That's correct, and the only way it would happen forever is if there's a
>>>> bug. The same would be true in a loop version if it doesn't advance the
>>>> state properly either, fwiw, which happened during development of this
>>>> version. Regardless, I can reduce the chance of introducing such a bug
>>>> by passing ns2->init_step instead of a constant, so I'll make that
>>>> change in v4.
>>>>
>>>>>
>>>>> The same case also potentially calls switch2_read_flash and it isn't
>>>>> clear to me if this means that the initialisation is done (as there
>>>>> is no switch2_init_step_done call and we are not in the FINISH state
>>>>> either). There is also the possibility of switch2_read_flash calling
>>>>> switch2_init_controller again, which one then has to check ... (note
>>>>> that this is not the case here though)
>>>>
>>>> switch2_handle_flash_read will advance the state once it's verified that
>>>> the read actually happened. If the step failed for whatever reason, this
>>>> same codepath will retry the specific read, as the caller
>>>> (switch2_receive_command) will always call into switch2_init_controller
>>>> if setup isn't done. This is how the retry logic works.
>>>
>>> Ah, so the call chain looks something like the below?
>>>
>>> switch2_read_flash->
>>> switch2_usb_send_cmd->
>>> switch2_usb_message_in_work (?)->
>>> switch2_receive_command->
>>> switch2_handle_flash_read->
>>> switch2_init_step_done
>>
>> Yes, and then switch2_init_controller is called again at the end of 
>> switch2_receive_command
>>>
>>>>
>>>>>
>>>>> To me it seems like it would be clearer to do a `ns2->init_step++` and
>>>>> then `continue` to make the progress of the state more visible and to
>>>>> do an explicit `break` when we are supposed to stop the initialisation.
>>>>>
>>>>
>>>> The problem with the loop approach, in my opinion is due to the fact
>>>> that the loop is the *exception*, not the rule. The loop idiom makes it
>>>> look like a loop is expected. Further the ns2->init_step++ in the
>>>> previous version means that the verification does not occur, so in the
>>>> case of any sort of failure it'll plow ahead anyway instead of retrying.
>>>> The point of this approach is to avoid that.
>>>
>>> In my mind a while-loop like you mentioned it above would make the state
>>> changes more obvious (since they could all be done in the loop body), while
>>> still allowing for retries. Something like the below, perhaps (untested).
>>>
>>> while (ns2->init_step < NS2_INIT_DONE) {
>>> 	switch (ns2->init_step) {
>>> 		...
>>> 		case NS2_INIT_READ_FACTORY_TRIGGER_CALIB:
>>> 			if (ns2->ctlr_type != NS2_CTLR_TYPE_GC) {
>>> 				ns->init_step++
>>> 				continue;
>>> 			}
>>>
>>> 			ret = switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB,
>>> 			        NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB);		
>>> 			if (ret) {
>>> 				// if it makes sense to retry here
>>> 				continue;
>>> 			}
>>>
>>> 			ns->init_step++
>>> 			break;
>>>
>>> 		case ...
>>> 	}
>>> }
>>>
>>
>> This can't be done because the process is fundamentally asynchronous. 
>> We'd have to block on waiting for a reply to the USB packet, which is 
>> not a good idea. This is why switch2_receive_command calls into 
>> switch2_init_controller at the end: it's resuming where it left off. 
> 
> Ah, that wasn't clear to me either.
> 
> I assume having the code wait for the reply is not allowed because
> otherwise it would stall the whole bootup process (or will there be some
> sort of dedicated Kthread for this)?

I'm not sure there is a synchronous USB API at all, but if there is it should really only be used when absolutely necessary. If you can get away without blocking, do.

> 
> Are you aware of any documentation where I can read up on how the probing
> of USB HID devices work in the Linux Kernel?

This has nothing to do with HID, actually. The Switch 2 controllers have a proprietary side-channel interface that we need to poke at here to get it to do anything. It's called cfg in the code and over USB it uses a bulk interface, which is unusual. Presumably because the side-channel doesn't care about latency, whereas the HID interface does. Something similar happens over bluetooth where they're accessed through disparate attributes. The latter isn't handled here yet, though.

> 
> Thanks for the help!
> 
>> Each of those returns is a step that interacts with the hardware, and we 
>> need to wait for the hardware to reply.
>>
>> There is a potential weird interaction here whereby if we get an 
>> unprompted command and/or reply from the controller it will retry a step 
>> before it gets a reply for it, but in practice this doesn't happen. The 
>> controllers, as far as we know, only reply and never initiate any 
>> commands. Furthermore, all of these steps are also idempotent, so it's 
>> not a big deal of they get repeated erroneously.
> 
> Could there be another reply incoming while the driver is still processing
> the previous one? I assume at least at probing time that shouldn't be
> the case. I wouldn't expect an USB HID device to send unsolicited replies
> in general ...

Replies only come in one at a time. Unless we send multiple messages without waiting for a reply first, which this code is specifically designed *not* to do, I don't think it will happen in practice.

> 
> Cheers,
> Silvan

