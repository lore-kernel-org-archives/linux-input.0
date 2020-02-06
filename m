Return-Path: <SRS0=PE//=32=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EFFC2D0B1
	for <linux-input@archiver.kernel.org>; Thu,  6 Feb 2020 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194EF21741
	for <linux-input@archiver.kernel.org>; Thu,  6 Feb 2020 14:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBFO0j (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:26:39 -0500
Received: from mta-out1.inet.fi ([62.71.2.202]:35710 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgBFO0j (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Feb 2020 09:26:39 -0500
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrheefgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomhepnfgruhhrihculfgrkhhkuhcuoehlrghurhhirdhjrghkkhhusehpphdrihhnvghtrdhfiheqnecukfhppeekgedrvdegkedrfedtrdduleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrdeggedrudeigegnpdhinhgvthepkeegrddvgeekrdeftddrudelhedpmhgrihhlfhhrohhmpeeolhgruhhjrghkqdefsehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqpdhrtghpthhtohepoehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
Received: from [192.168.44.164] (84.248.30.195) by julia1.inet.fi (9.0.019.26-1) (authenticated as laujak-3)
        id 5E3B5CC700026679; Thu, 6 Feb 2020 16:26:36 +0200
Subject: Re: [PATCH v6] USB: HID: random timeout failures tackle try.
From:   Lauri Jakku <lauri.jakku@pp.inet.fi>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
References: <20200205153944.11955-1-lja@iki.fi> <20200205171230.GV1778@kadam>
 <14bdd24e-1e69-60b4-f5f6-2def804710c1@pp.inet.fi>
Message-ID: <3e7bf686-963e-e668-0af9-ddd3e2196d58@pp.inet.fi>
Date:   Thu, 6 Feb 2020 16:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <14bdd24e-1e69-60b4-f5f6-2def804710c1@pp.inet.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi, inline comments.

On 6.2.2020 12.37, Lauri Jakku wrote:
> Hi,
>
> I make small descriptions as you suggested and remove dumb comments
>
> .. this is my first time patching kernel publicly so, I'm not used to
>
> the Proper way, but i'm learning all the time :)
>
>
> --Lauri Jakku
>
> On 5.2.2020 19.12, Dan Carpenter wrote:
>> I never recieved v2-v5 so I can't really comment on those.  If you
>> didn't send those to linux-usb then let's just pretend we're still on
>> v1 otherwise it's just confusing.
>>
>> This is not how we send v2 patches.  Put [PATCH v6], that's good.
>> Then the normal changelog and the Signed-off-by: then under the ---
>> cut off put a small comment.
>>
>> Signed-off-by: you
>> ---
>> v6: changed commit message
>> v5: fixed error reported by kbuild
>> v4: blah blah
>>
>>
>>> +/* Wrapper function to send control messages */
>> Don't include obvious comments like this.
Done.
>>> +static int usbhid_control_msg(struct usb_device *dev, unsigned int pipe,
>>> +				_u8 request, __u8 requesttype, __u16 value,
>>> +				__u16 index, void *data, __u16 size,
>>> +				int timeout)
>>> +{
>>> +	/* calculate timeout per call, to archieve total timeout requested */
>> This should be obvious if the variables and functions are named well.
>>
>> It's weird that we're passing the total timeout and then dividing it
>> into littler chunks...  Normally we would know the timeout from the
>> spec and then the total would be something like "a timeout of 400ms
>> won't annoy users."  (This seems wrong).
>>
Yeah, I tought it also, and this happened: i broke my mouse

when trying to clean up, and just now got new mouse and

keyboard (Microsoft Keyb, Locitech M100 mouse) same

vendors, and identical to old ones) and there seems not to

be any random behavior. so i'm thinking to put to rest this

patch (what I now thing bit bad thing, if some one is

depending on timeout).


>>> +	int call_timeout = USBHID_CONTROL_COMMAND_TIMEOUT_CALC(timeout);
>> CALC is a bad name because obviously it's going to calculate something.
>>
>>> +	int call_count   = USBHID_CONTROL_COMMAND_RETRY_COUNT;
>> Just call it "int retry = USBHID_CONTROL_COMMAND_RETRY_COUNT;".  Don't
>> do anything fancy with the white space.
>>
>>> +	int ret;
>>> +	int timeout_looping;
>>> +
>>> +	do {
>>> +		ret = usb_control_msg(dev, pipe, request, requesttype,
>>> +				value, index, data, size, call_timeout);
>> The indenting is wrong.  Use checkpatch.pl --strict
>>
>>> +
>>> +		timeout_looping =	(call_count-- > 0) &&
>>> +					(ret == -ETIMEDOUT);
>>> +	} while (timeout_looping);
>> Delete the "timeout_looping" variable.
>>
>> 	} while (ret == -ETIMEDOUT && retry-- > 0);
>>
>> Have you tested with just one retry?

Not yet, and i think more that this whole thing was due HW error.

Maybe some component was giving up, from mouse (that i broke), but

I make v7 version, one can integrate it to mainstream, or just archive it.


I'll fix the things brought up.


>> regards,
>> dan carpenter
>>
-- 
Br,
Lauri J.

