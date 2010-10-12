From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 18:32:38 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180468727083@EXDCVYMBSTM006.EQ1STM.local>
References: <33A307AF30D7BF4F811B1568FE7A9B180468726AB4@EXDCVYMBSTM006.EQ1STM.local>
 <Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:60434 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019Ab0JLQc4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 12:32:56 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Tuesday, October 12, 2010 9:04 PM
>To: Sundar R IYER
>>
>> >-----Original Message-----
>> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> >Sent: Tuesday, October 12, 2010 3:39 AM
>> >
>> >
>> >I do not believe there is a generic answer - different devices,
>> >different options. For example I could see buttons split into 2 gro=
ups -
>> >"important" ones that bring the system from sleep or "stupor" and "=
not
>> >so important" that gets to be ignored. Or user woudl need to "flick=
"
>> >the screen. Or toss the phone into a corner cussing :)
>> >
>>
>We're not talking about waking up the system.  I'm concerned more abou=
t
>how the keypad is supposed to work in the scenario Dmitry brought up.
>But evidently things are too variable to say much for certain.
>
>I get the impression that in many cases the entire keypad will have to
>remain functional, and it will be up to userspace to discard keys that
>aren't wanted at a particular time.

What I meant was that various keypad controllers provide different opti=
ons.
=46or one TC35893 keypad controller I know, it allows putting the keypa=
d module
into the deepest low power mode while enabling the keypad module to wak=
eup
via a combination of specific keys. In such a case, the user space isn'=
t even going
to get events to ignore.

>"Kicking devices into low power mode" is ambiguous.  How about
>"requesting that an idle device go into low-power mode" instead?  This
>doesn't carry an implication that the user could force a non-idle
>device to suspend or could force the driver to do something against it=
s
>will.
>
>Of course, if the device is idle then it's natural to ask why it isn't
>already in low-power mode.  Maybe it's waiting for an autosuspend
>timer to expire; anything else doesn't make much sense.
>

Okay. I messed up the kicking part; but why should the device solely wa=
it=20
for an auto suspend timer to expire. Don't you agree that the keypad mo=
dule=20
be turned off when a keypad slider is pushed back into a phone?

>> Coming in late, I would just like to summarize some of the points; p=
lease
>> correct if I am wrong:
>>
>> - user space intervention is required to communicate specific events
>>   to individual devices to put them into an appropriate power state.
>
>Stop after "communicate specific events to individual devices" (or
>drivers).  I don't agree that userspace should always have the ability
>to put devices into specific power states.
>

Yes not always; but examples of keypads, touch panels could.

>> - auto suspend isn't the correct choice for input devices as they ma=
y
>>   conflict with system suspend (touch screen off/idle needs to be sy=
nc'ed
>>   with system suspend as with a lock switch)
>
>I don't understand this at all.  How does autosuspend conflict with
>system suspend?  Your example isn't clear.

Hmm. I was looking at the case with touch screen. I set my display back=
light
to go off after say 30 seconds; my touch screen idle begins only when t=
he display
goes off; meaning I still expect the touch screen to respond to any eve=
nts before
the timeout. This in turn requires that the timeouts for the backlight =
and the touch
be synchronized, failing which the user might interpret the touch to be=
 non-functional
in case the touch timeout and backlight timeout vary. Am I wrong to thi=
nk that
such inter-dependency between devices should be avoided?

>PM does indeed provide a sysfs attribute for enabling/disabling
>individual devices for low-power mode.  It doesn't provide an attribut=
e
>for _forcing_ a device into low-power mode, and I don't think it
>should.  The driver should always be in charge.
>

Agree.

>> However a new
>>   "suspend_ondemand" flag can enable such devices to be put into app=
ropriate
>>   states via a /sys/devices/.../power/ by the user space.
>
>This has not yet been settled.  Why do we need an "ondemand" flag when
>we already have power/control?
>

Oh am sorry again; my bad choice of words :( I didn't intend to settle =
that as
the final outcome). Well the idea of accelerated suspend too looks prom=
ising.

Also, for some of the keypad behavior, apart from Dmitry's replies,

> On Tue, Oct 12, 2010 at 3:24 AM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> =A0 =A0 =A0 =A0Does suspending the keypad truly put it in low-power m=
ode?
>

The examples that I can see are truly low power states; the STMPE/TC358=
93(or X)
and ones have the ability to disable the keypad clocks and as explained=
 above ability
to either come back to active mode via magic key presses or some host a=
ctivity on
the usual MFD.

> =A0 =A0 =A0 =A0What happens if a key is pressed while the keypad is s=
uspended?
> =A0 =A0 =A0 =A0Do you want to prevent all the keys from working or ju=
st some
> =A0 =A0 =A0 =A0of them?
> =A0 =A0 =A0 =A0How would the user un-suspend the keypad if the system=
 no
> =A0 =A0 =A0 =A0longer responds to keystrokes?

As Dmitry replied, there are variations possible. Controllers part of a=
 MFD group
usually allow returning to active mode via specific bus transactions be=
tween the
MFD host and the CPU; dedicated controllers on SoCs cannot wakeup via t=
hemselves;
but some dedicated GPIO lines wakeup the CPU and in turn the CPU can wa=
ke up the
controller and etc etc

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
