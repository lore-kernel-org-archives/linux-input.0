From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate polarity
Date: Mon, 24 Jun 2013 17:14:04 -0600
Message-ID: <51C8D2BC.9010507@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-5-git-send-email-gsi@denx.de> <51C4C6C9.6030000@wwwdotorg.org> <20130622093649.GF24305@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56889 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3FXXOJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jun 2013 19:14:09 -0400
In-Reply-To: <20130622093649.GF24305@book.gsilab.sittig.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/22/2013 03:36 AM, Gerhard Sittig wrote:
> On Fri, Jun 21, 2013 at 15:34 -0600, Stephen Warren wrote:
>>
>> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
>>> extend the device tree adjustable hardware configuration:
>>> - allow for differing polarity of the row and column GPIO pins
>>> - optionally fully drive column output pins instead of the former
>>>   unconditional open collector emulation approach
>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>>
>>> +- row-gpios-activelow:	row GPIO pins are active low
>>> +- col-gpios-activelow:	column GPIO pins are active low
>>>  - gpio-activelow:	row pins as well as column pins are active low
>>> +			(provided for backward compatibility, and useful
>>> +			for matrix layouts of identical polarity for
>>> +			rows and columns)
>>
>> Those should all come from the existing GPIO flags, and may even differ
>> for each GPIO.
>>
>>> +- col-gpios-pushpull:	fully drive the column selection pins in either
>>> +			direction (high and low signals), the default
>>> +			behaviour is to actively drive low signals and
>>> +			be passive otherwise (emulates an open collector
>>> +			output driver)
>>
>> We don't actually have GPIO flags defined for pushpull-vs-open-collector
>> etc. Perhaps we should do so. Then, we wouldn't need to invent custom
>> properties to represent that in this binding.
> 
> I see your concerns and understand, but chose the above way to
> just extend the existing implementation in the least intrusive
> way without changing its nature.  See the reply on the first
> patch for more details on the motivation.
> 
> Of course I agree that pin properties belong to the GPIO layer
> and that "application drivers" on top should not worry about
> that.  Were I allowed to break backwards compatibility, then I
> could have done more shuffling.  But lacking the capability to
> test the affected setups puts more burdon on others, which I
> wanted to avoid.

Can't you add this enhancement as follows:

Update the driver to look at the per-pin GPIO flags in all cases.
Presumably in any existing cases, those flags all say "active high"
anyway, since specifying anything else was useless. In the very unlikely
case this isn't true, one could always add a quirk based on the
HW-specific compatible value.

If gpio-activelow is set, mark all pins as active-low.

This way, any future extensions (i.e. what this patch implements: just
rows active low, just columns active low) can be implemented using
purely the standard GPIO flags, but the existing behaviour of the
existing gpio-activelow property is maintained.
