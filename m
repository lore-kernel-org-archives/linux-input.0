From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH] input: pxa27x_keypad: fix NULL pointer dereference
Date: Wed, 18 Sep 2013 07:28:20 -0700
Message-ID: <5239B884.20809@newsguy.com>
References: <1379349842-13089-1-git-send-email-mikedunn@newsguy.com> <201309161849.53556.marex@denx.de> <20130916170617.GA20734@core.coreip.homeip.net> <523926A2.1010607@newsguy.com> <20130918042423.GA13196@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.newsguy.com ([74.209.136.69]:61281 "EHLO smtp.newsguy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab3IRO3o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 10:29:44 -0400
In-Reply-To: <20130918042423.GA13196@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, linux-input@vger.kernel.org, Chao Xie <chao.xie@marvell.com>, Robert Jarzmik <robert.jarzmik@free.fr>

On 09/17/2013 09:24 PM, Dmitry Torokhov wrote:
> On Tue, Sep 17, 2013 at 09:05:54PM -0700, Mike Dunn wrote:
>> On 09/16/2013 10:06 AM, Dmitry Torokhov wrote:
>>> On Mon, Sep 16, 2013 at 06:49:53PM +0200, Marek Vasut wrote:
>>>> Dear Mike Dunn,
>>>>
>>>>> A NULL pointer dereference exception occurs in the driver probe function
>>>>> when device tree is used.  The pdata pointer will be NULL in this case,
>>>>> but the code dereferences it in all cases.  When device tree is used, a
>>>>> platform data structure is allocated and initialized, and in all cases
>>>>> this pointer is copied to the driver's private data, so the variable being
>>>>> tested should be accessed through the driver's private data structure.
>>>>>
>>>>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>>>>> ---
>>>>>  drivers/input/keyboard/pxa27x_keypad.c | 6 ++++--
>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/input/keyboard/pxa27x_keypad.c
>>>>> b/drivers/input/keyboard/pxa27x_keypad.c index 134c3b4..3b2a614 100644
>>>>> --- a/drivers/input/keyboard/pxa27x_keypad.c
>>>>> +++ b/drivers/input/keyboard/pxa27x_keypad.c
>>>>> @@ -795,8 +795,10 @@ static int pxa27x_keypad_probe(struct platform_device
>>>>> *pdev) goto failed_put_clk;
>>>>>  	}
>>>>>
>>>>> -	if ((pdata->enable_rotary0 && keypad->rotary_rel_code[0] != -1) ||
>>>>> -	    (pdata->enable_rotary1 && keypad->rotary_rel_code[1] != -1)) {
>>>>> +	if ((keypad->pdata->enable_rotary0 &&
>>>>> +	     keypad->rotary_rel_code[0] != -1) ||
>>>>> +	    (keypad->pdata->enable_rotary1 &&
>>>>> +	     keypad->rotary_rel_code[1] != -1)) {
>>>>>  		input_dev->evbit[0] |= BIT_MASK(EV_REL);
>>>>>  	}
>>>>
>>>> Nice find. Acked-by: Marek Vasut <marex@denx.de>
>>>
>>> Excellent booby trap. I would prefer if we explicitly did
>>>
>>> 	pdata = keypad->pdata;
>>>
>>> after calling the parse DT fucntion with a nice comment, because we
>>> somebody might want to rearrange the code and accidentially revert the
>>> checks to the original state.
>>
>>
>> Yes, that would have been better.  Is someone picking this up?  I'm not familir
>> with the input subsystem maintainer (sorry).
> 
> That would be yours truly.
> 
>> If this will be upstreamed in
>> someone's tree, I'll be glad to resubmit with this change.
> 
> If you could resubmit that would be great - I do not have the hardware
> and I prefer applying patches that were tested, if possible.


OK, will do.  Yes, I'm testing this on a palm treo 680 with matrix keys and one
direct key.

Thanks,
Mike

