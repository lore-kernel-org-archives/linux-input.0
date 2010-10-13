From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 08:16:20 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180468A9419A@EXDCVYMBSTM006.EQ1STM.local>
References: <20101012174942.GB10861@sirena.org.uk>
 <Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:36454 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752787Ab0JMGQt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 02:16:49 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>>
>> This isn't *really* about saving power in the individual device; it's
>> more about stopping the device generating events that disrupt the rest
>> of the system.  Suspending the device can be one way of doing that and
>> is useful if it can be done but is not really the immediate goal here.
>
>Runtime PM is _not_ a reliable way of preventing a device from
>generating events.  It is meant for saving energy, nothing else.
>
>If that's what this is about, then the answer is simple: Don't use
>runtime PM to try to suppress events.
>

I think it is unfair to discriminate here about saving power and turning off
events. I believe putting the device into power save leads to, if device permits
preventing generating events is valid to hook up run time PM.

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>
>I still disagree.  The user should be able to tell the driver that he's
>not going to be using the keypad, touch panel, or whatever in the near
>future... but it's up the driver to decide whether or not to go to low
>power.

Why cannot the driver decide to return failure in such a case? But why stop
the user space from requesting a power save mode?

>> Hmm. I was looking at the case with touch screen. I set my display backlight
>> to go off after say 30 seconds; my touch screen idle begins only when the
>display
>> goes off; meaning I still expect the touch screen to respond to any events before
>> the timeout. This in turn requires that the timeouts for the backlight and the touch
>> be synchronized, failing which the user might interpret the touch to be non-
>functional
>> in case the touch timeout and backlight timeout vary. Am I wrong to think that
>> such inter-dependency between devices should be avoided?
>
>Although such dependencies do sometimes make things awkward,
>occasionally you need to have them.  

Hmmm...I am not convinced that such sync'ed timeouts between devices are necessary;
I still prefer it would be better if a single user space monitor could make sure that all listed
devices are communicated for a power save rather than introduce dependencies between a
touch and the display device.

I was thinking about an another case too where device autosuspend could create issues: Imagine
a slider cover for the camera which enables the camera and the live playback on a screen; In such 
a case you have now not 2, but 3 components to sync up: the auto idle for touch, auto idle for camera;
auto idle for the display. 

Cheers!
