From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/15] Input: synaptics-rmi4 - remove gpio handling and polling
Date: Thu, 6 Feb 2014 10:28:59 +0100
Message-ID: <CACRpkdYtGM283y71yWm-GAHXz9UuvxPRddY3wzzvcn40VfHbUw@mail.gmail.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
	<1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
	<1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
	<1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
	<1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
	<1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
	<52F172F3.7090003@synaptics.com>
	<20140205023113.GE1706@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59535 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbaBFJ3A (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 04:29:00 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so1871297obc.8
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 01:29:00 -0800 (PST)
In-Reply-To: <20140205023113.GE1706@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

On Wed, Feb 5, 2014 at 3:31 AM, Courtney Cavin
<courtney.cavin@sonymobile.com> wrote:
> On Wed, Feb 05, 2014 at 12:08:35AM +0100, Christopher Heiny wrote:
>> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
>> > Since all the configuration needed for an irq can be provided in other
>> > ways, remove all gpio->irq functionality. This cleans up the code quite
>> > a bit.
>>
>> In certain diagnostic modes, we need to be able to release the IRQ so
>> the GPIO can be monitored from userspace.  This patch removes that
>> capability.
>
> Polling a GPIO from userspace is poor design regardless of the use-case, if
> you ask me.  It certainly doesn't motivate the extra gpio<->IRQ code.

I think Courtney is right here, if you want this kind of stuff for debugging
it should be debug-add-on-patches, not part of the normal execution
path for the driver.

>> As mentioned in previous patch discussions, the polling functionality is
>> quite useful during new system integration, so we need to retain that.
>> If you have a proposal for where else it could be done, we'd certainly
>> entertain a patch that implements that.
>
> Do you actually have systems that have these hooked up to GPIOs without
> IRQ support?
>
> Regardless, if this is the case, implementing a GPIO polling IRQ chip
> should be possible, if extremely ugly.

OMG that would be quite horrible.

> Linus may have some comments in this area, though.  Linus?

A driver may rely on polling but a driver may not rely on polling
done from userspace.

Yours,
Linus Walleij
