From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Mon, 30 Nov 2009 20:05:12 +0100
Message-ID: <87einfltp3.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:40595 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbZK3TFS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 14:05:18 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 30 Nov 2009 10:00:19 -0500 (EST)")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 30 Nov 2009, Dmitry Torokhov wrote:
>
>> On Sun, Nov 29, 2009 at 11:04:57AM -0500, Alan Stern wrote:
>>
>>> On Sun, 29 Nov 2009, Ferenc Wagner wrote:
>>> 
>>>> I thought we'd better ask our friends over at linux-pm, if they've got
>>>> some interface for this task.  To summarize: an embedded application
>>>> wants to go into a "locked" state, where some input devices (gpio keys
>>>> in this case) are "muted", ie. they don't even generate interrupts to
>>>> minimize power consumption.  This could be solved by adding a new
>>>> interface to gpio-keys, but the problem seems more general, so I wonder
>>>> if something like the USB selective runtime suspend is already available
>>>> (or preferable to develop) for such tasks.
>>> 
>>> See Documentation/power/runtime_pm.txt.  I don't know to what extent 
>>> the input layer has implemented any runtime PM.
>> 
>> Input layer is not implementing any PM since it consists of virtual, not
>> physical devices, and leaves PM for the appropriate bus drivers (USB,
>> serio, platform, etc.).
>> 
>> Also, it is not really runtime PM but rather user-initiated action of
>> putting device into lower power state we are talking about here.
>
> This is in fact the definition of runtime PM -- except for the
> "user-initiated" restriction (runtime PM can be initiated by anything
> or anybody).  So it really _is_ runtime PM.

But runtime-pm.txt says for example:

    Generally, remote wake-up should be enabled for all input devices
    put into a low power state at run time.

But in this case the requirement is to suppress input events from a
given device, effectively muting and putting it into low power state,
even though it's still open by some other parties.  Runtime PM, on the
other hand tries not to interfere with the normal usage of the device.

Later:

(3) ->runtime_idle() and ->runtime_suspend() can only be executed for a
    device the usage counter of which is equal to zero _and_ [...]

which underlines the difference again: the usage counter (defined by
common sense) won't be zero in our case, because the device is
constantly kept open, while we want to mute it, putting it into a low
power state.  Probably, the rules could be bent so that the platform bus
could suspend these devices and achieve our aim, but I'd consider that
an abuse of the runtime PM infrastructure.  Don't you?

Actually, this could be implemented by the various users cooperating in
closing the device, letting it go to sleep automatically.  But this
requires strictly cooperating parties and is more complicated that
flipping some master switch of the device.  We're looking for this
master switch, before needlessly building our own.

> But if you prefer to implement it without using the runtime PM 
> framework, that's fine.

We're also looking for a framework to implement it in.  Now I feel like
the runtime PM framework is not a good fit for what we want, but it's
the first time I'm reading its documentation, so please correct my
misunderstandings.  That's why I cross posted linux-pm, after all. :)
-- 
Thanks,
Feri.
