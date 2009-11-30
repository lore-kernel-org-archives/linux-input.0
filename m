From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Mon, 30 Nov 2009 21:51:02 +0100
Message-ID: <87aay3losp.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911301424511.4478-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:42089 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbZK3UvD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 15:51:03 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911301424511.4478-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 30 Nov 2009 14:30:22 -0500 (EST)")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 30 Nov 2009, Ferenc Wagner wrote:
>
>>>> Also, it is not really runtime PM but rather user-initiated action of
>>>> putting device into lower power state we are talking about here.
>>>
>>> This is in fact the definition of runtime PM -- except for the
>>> "user-initiated" restriction (runtime PM can be initiated by anything
>>> or anybody).  So it really _is_ runtime PM.
>> 
>> But runtime-pm.txt says for example:
>> 
>>     Generally, remote wake-up should be enabled for all input devices
>>     put into a low power state at run time.
>> 
>> But in this case the requirement is to suppress input events from a
>> given device, effectively muting and putting it into low power state,
>> even though it's still open by some other parties.  Runtime PM, on the
>> other hand tries not to interfere with the normal usage of the device.
>
> That's why the text says "Generally".  You're free to do it a different 
> way if you want.
>
>> Later:
>> 
>> (3) ->runtime_idle() and ->runtime_suspend() can only be executed for a
>>     device the usage counter of which is equal to zero _and_ [...]
>> 
>> which underlines the difference again: the usage counter (defined by
>> common sense) won't be zero in our case, because the device is
>> constantly kept open, while we want to mute it, putting it into a low
>> power state.  Probably, the rules could be bent so that the platform
>> bus could suspend these devices and achieve our aim, but I'd consider
>> that an abuse of the runtime PM infrastructure.  Wouldn't you?
>
> The usage counter can be set whenever you want; it doesn't have to be
> incremented during open and decremented during close.  You could leave
> it equal to 0 permanently.  Or you could make it nonzero precisely
> during the times when you don't want the input to be muted.

And what would be the user space interface for controlling the power
state of the device?  The documentation doesn't talk about this, and if
we need to make up new ioctls or sysfs files, what do we gain by using
the runtime PM framework?  Especially if there's no uniform (bus- and
system-wide) semantics?

>> Actually, this could be implemented by the various users cooperating
>> in closing the device, letting it go to sleep automatically.  But
>> this requires strictly cooperating parties and is more complicated
>> that flipping some master switch of the device.  We're looking for
>> this master switch, before needlessly building our own.
>
> Just out of curiosity, how do you decide when the input should be 
> muted and unmuted?

That's application logic.  For example, the user touches the "Lock"
button, then slips the gadget into his pocket.  Then most other buttons
(like volume control) are muted until the device is unlocked again by
some very specific action.  My mobile phone doesn't work like this, it
reacts to each button even when it's locked (though of course does
nothing but says how to unlock it).

>>> But if you prefer to implement it without using the runtime PM 
>>> framework, that's fine.
>> 
>> We're also looking for a framework to implement it in.  Now I feel like
>> the runtime PM framework is not a good fit for what we want, but it's
>> the first time I'm reading its documentation, so please correct my
>> misunderstandings.  That's why I cross posted linux-pm, after all. :)
>
> The framework was intended to be pretty flexible.  You should think it 
> over a little more before deciding against it.

Well, I thought runtime PM is intended to have some "common sense"
semantics, so it can be automatic.  After all, it's perfectly reasonable
for somebody else to want the "normal" runtime PM for gpio-keys: to
autosuspend when not in use.  If we stole the callbacks for our purpose,
the "expected" behaviour couldn't be implemented later.  In other words,
the wanted behaviour is not device specific, but usage specific.  And
the runtime suspend behaviour of a device can't be usage specific, it
should match common expectations (to the extent it's possible to talk
about common expectations wrt. runtime PM -- but you may still want to
build one up).  Are these fears unfounded?  Is runtime PM not what I
think it is?
-- 
Thanks,
Feri.
