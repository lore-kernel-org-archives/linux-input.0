From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 05/15] Input: synaptics-rmi4 - remove gpio handling and
 polling
Date: Thu, 6 Feb 2014 12:05:09 -0800
Message-ID: <52F3EAF5.7030203@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>	<1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>	<1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>	<1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>	<1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>	<1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>	<52F172F3.7090003@synaptics.com>	<20140205023113.GE1706@sonymobile.com> <CACRpkdYtGM283y71yWm-GAHXz9UuvxPRddY3wzzvcn40VfHbUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:64944 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbaBFUFK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 15:05:10 -0500
In-Reply-To: <CACRpkdYtGM283y71yWm-GAHXz9UuvxPRddY3wzzvcn40VfHbUw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

On 02/06/2014 01:28 AM, Linus Walleij wrote:
> On Wed, Feb 5, 2014 at 3:31 AM, Courtney Cavin
> <courtney.cavin@sonymobile.com>  wrote:
>> >On Wed, Feb 05, 2014 at 12:08:35AM +0100, Christopher Heiny wrote:
>>> >>On 01/23/2014 04:00 PM, Courtney Cavin wrote:
>>>> >> >Since all the configuration needed for an irq can be provided in other
>>>> >> >ways, remove all gpio->irq functionality. This cleans up the code quite
>>>> >> >a bit.
>>> >>
>>> >>In certain diagnostic modes, we need to be able to release the IRQ so
>>> >>the GPIO can be monitored from userspace.  This patch removes that
>>> >>capability.
>> >
>> >Polling a GPIO from userspace is poor design regardless of the use-case, if
>> >you ask me.  It certainly doesn't motivate the extra gpio<->IRQ code.
 >
> I think Courtney is right here, if you want this kind of stuff for debugging
> it should be debug-add-on-patches, not part of the normal execution
> path for the driver.

I'm OK with replacing the current polling implementation with an 
add-on-patch, as long as the support for the debug-add-on-patches 
doesn't get torn out of the driver because "hey, I don't see what this 
is used for in the core driver code, so it must be unnecessary".


>>> >>As mentioned in previous patch discussions, the polling functionality is
>>> >>quite useful during new system integration, so we need to retain that.
>>> >>If you have a proposal for where else it could be done, we'd certainly
>>> >>entertain a patch that implements that.
>> >
>> >Do you actually have systems that have these hooked up to GPIOs without
>> >IRQ support?
>> >
>> >Regardless, if this is the case, implementing a GPIO polling IRQ chip
>> >should be possible, if extremely ugly.
> OMG that would be quite horrible.
>
>> >Linus may have some comments in this area, though.  Linus?
 >
> A driver may rely on polling but a driver may not rely on polling
> done from userspace.

Fortunately, the driver doesn't rely on polling from user space.
