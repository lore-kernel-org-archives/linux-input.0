From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4] Input: matrix-keypad - Add device tree support
Date: Fri, 09 Nov 2012 10:19:39 -0700
Message-ID: <509D3B2B.9000608@wwwdotorg.org>
References: <1352280725-452-1-git-send-email-anilkumar@ti.com> <509BE405.60204@wwwdotorg.org> <331ABD5ECB02734CA317220B2BBEABC13EA68909@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42766 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab2KIRTm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Nov 2012 12:19:42 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA68909@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 11/09/2012 04:07 AM, AnilKumar, Chimata wrote:
> On Thu, Nov 08, 2012 at 22:25:33, Stephen Warren wrote:
>> On 11/07/2012 02:32 AM, AnilKumar Ch wrote:
>>> Add device tree support to matrix keypad driver and usage details
>>> are added to device tree documentation. Driver was tested on AM335x
>>> EVM.
>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>>
>>> +Optional Properties:
>>
>>> +- clustered-irq:	have clustered irq number, that is needed if the irq
>>> +			is a combined irq source for the whole matrix keypad.
>>> +			This is useful if rows and columns of the keypad are
>>> +			connected to a GPIO expander.
>>> +- clustered-irq-flags:	clustered irq flags to specify the interrupt line
>>> +			behavior among IRQF_TRIGGER_*
>>
>> I still don't understand why there's a need for a clustered-irq-flags
>> property; if those flags are the flags for an interrupt, why aren't the
>> flags part of the clustered-irq interrupt specifier, just like any other
>> interrupt in DT?
> 
> Exactly, I agree with you on this.
> 
> Honestly, I added clustered_xxx properties to DT considering the 
> platform_data currently implemented in driver. And I do not have
> hardware to  validate clustered_xxx execution flow.
> 
> I looked at the commit which adds support for clustered_irq,
> 
> Commit Description:
>  
> "This one adds support of a combined irq source for the whole matrix
> keypad. This can be useful if all rows and columns of the keypad are
> e.g. connected to a GPIO expander, which only has one interrupt line
> for all events on every single GPIO."
> 
> 
> So I believe this was meant for matrix keypad interfaced over I2C
> expander, But I am not sure how it is being used.
> 
> The hardware is connected in any of the following methods, the driver
> should supports the same.
> 
> i) gpio interrupt can be used as keypad interrupt, connection is
> like this (MPU<===>IOEXP)
>             |_______| (gpio line)
> 
> Here I expect driver should have gpio_to_irq implementation, but
> its missing from driver. So platform code must be doing it, but
> surprisingly I couldn't able to find any platform which uses this.
> 
> ii) i2c interrupt can be used as keypad interrupt
> 
> Here driver is not using threaded irq.
> 
> As a reference I looked tca6416-keypad.c driver and it has right implementation,
> 
> if (pdata->irq_is_gpio)
> 	chip->irqnum = gpio_to_irq(client->irq);
> else
> 	chip->irqnum = client->irq;
> 
> 
> As per my understanding matrix-keypad driver has to change
> accordingly to tca6416-keypad.c driver to handle clustered-irq.

That sounds correct.

> So I left with below options,
> 
> 1. Lets only support normal GPIO based matrix key-pad, without
> clustered_irq support in DT.
> 
> 2. Cleanup the driver to remove clustered_irq all together,
> considering the fact that we do not have any platform in kernel
> to use it. And once we get known platform in the future, we can
> again add it.
> 
> I vote for option-1, what do you think?

I think that's fine.

The only issue is that it means the DT binding will not be complete the
first time around, and will probably need to be extended in the future.
I know that some people will want to see the binding be complete right
from the very start, to make sure the binding has been fully thought
through. However, it seems clear that the binding can be extended in a
backwards-compatible fashion to support clustered IRQs later, so I don't
think there's any issue here myself.
