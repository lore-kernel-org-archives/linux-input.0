From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v5 1/2] input: add support for Nomadik SKE keypad controller
Date: Wed, 15 Sep 2010 14:27:29 +0530
Message-ID: <4C908A79.7020004@codeaurora.org>
References: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com> <4C9076BA.80106@codeaurora.org> <20100915075259.GA28348@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:56451 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0IOI5f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 04:57:35 -0400
In-Reply-To: <20100915075259.GA28348@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org, Kwangwoo LEE <kwangwoo.lee@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Hi Dmitry,

On 9/15/2010 1:22 PM, Dmitry Torokhov wrote:
> On Wed, Sep 15, 2010 at 01:03:14PM +0530, Trilok Soni wrote:
>> Hi Sundar,
>>
>> On 9/15/2010 12:54 PM, Sundar Iyer wrote:
>>> Add support for the keypad controller in the Scroll Key Encoder (SKE)
>>> module on the Nomadik family and the DB8500 SoC.
>>>
>>> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>>> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
>>> ---
>>> Thanx a bunch to Dmitry for being such a nice and persistent help :)
>>>
>>> v4:
>>>  - IRQ handler is no longer threaded
>>>  - incorporated Dmitry's comments to make sure multikey is working
>>>  - assorted comments from Trilok
>>>  - pin configuration mistake pointed out thanx to Kwangwoo LEE
>>
>> Looks good to me. Thanks.
>>
>> Acked-by: Trilok Soni <tsoni@codeaurora.org>
>>
> 
> Hmm, now how to merge it... namely the arch code... Should it come
> through my tree or you guys want to merge it yourselves?
> 

I guess Linus Walleji takes care of ST mach-xxx code.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
