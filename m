From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: which driver to choose for a GPIO connected switch
Date: Thu, 24 Feb 2011 16:17:50 +0100
Message-ID: <87r5axa2ch.fsf@tac.ki.iif.hu>
References: <201102240958.38401.alexander.stein@systec-electronic.com>
	<87ipw9u3si.fsf@tac.ki.iif.hu>
	<201102241207.56652.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:42578 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248Ab1BXPRw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Feb 2011 10:17:52 -0500
In-Reply-To: <201102241207.56652.alexander.stein@systec-electronic.com>
	(Alexander Stein's message of "Thu, 24 Feb 2011 12:07:56 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-input@vger.kernel.org

Alexander Stein <alexander.stein@systec-electronic.com> writes:

> On Thursday 24 February 2011, 11:26:21 Ferenc Wagner wrote:
>
>> Alexander Stein <alexander.stein@systec-electronic.com> writes:
>>
>>> I'm just wondering which existing input driver I can choose to use an
>>> GPIO connected switch. The switch I'm talking about is connected via 3
>>> (interruptable) GPIOs and those GPIOs can be inverted.
>> 
>> How is the switch connected to the three GPIO inputs?
>> 
>>> I think gpio-keys is wrong as they will generate events on each state
>>> change. Note: The switch is likely to bounce
>> 
>> The gpio-keys driver has debouncing support.
>> 
>>> and the current GPIO state might be invalid (all 3 GPIOs are 0).
>> 
>> Why is this state invalid?
>> 
>>> I also think gpio-keys can't make sure only one switch state is currently
>>> present. So I may get a current state 1 on 2 or more GPIOs which is
>>> obviously wrong.
>> 
>> Sorry, I don't understand this.
>> 
>>> My use case is the userspace polls the current switch state if it needs
>>> to know.
>> 
>> EVIOCGKEY or EVIOCGSW ioctl, perhaps?  You can make it three keys or
>> switches in the driver, and put the validation logic into user space...
>> 
>>> Do you have any suggestions which driver to use or even write?
>> 
>> Maybe it's just me, but I think you'd better give a clearer description
>> of your problem to get useful suggestions.
>
> Ok, let's give it a try. I have a sliding switch which has 3 positions, namely 
> run, stop and reset. There can only be one position active at a time. None of 
> them or more at the same time are invalid. At least none active GPIOs is 
> possible due to the mechanical structure.
> Each position has a GPIO connected which affects the mounted pull-down or 
> pull-up. e.g. run GPIO has a pull-down to GND and when the switch goes to run 
> state the GPIO is raised to Vcc. The other positions are similar.

Got it, thanks.

> The problem I have with EV_KEY or EV_SW is they have just binary states. Maybe 
> I just should create a new driver which uses EV_ABS. Or is there already 
> something similar?

I don't know of anything similar, which doesn't mean anything at all.

I'd simply settle for using three gpio_keys switches (one for each
position) and poll all of them simultaneously by EVIOCGSW, filtering out
invalid combinations in user space.  This avoids driver development.

But don't listen to me, wait for the experts to chime in. :)
-- 
Good luck,
Feri.
