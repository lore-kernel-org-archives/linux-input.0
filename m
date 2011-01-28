From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 12:08:18 -0800
Message-ID: <AANLkTi=31ckFhy28R30=64+BBmHkn43DA8js1b0pdoQ4@mail.gmail.com>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
	<20110128173048.GC2586@polaris.bitmath.org>
	<AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
	<20110128184654.GG6252@core.coreip.homeip.net>
	<AANLkTikgTYQvhTzEHWw0Yhigno7TLJ8jm9jaw10mOhk+@mail.gmail.com>
	<20110128193731.GH6252@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34072 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab1A1UIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 15:08:19 -0500
Received: by wyb28 with SMTP id 28so3593382wyb.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 12:08:18 -0800 (PST)
In-Reply-To: <20110128193731.GH6252@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 11:37 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Jan 28, 2011 at 11:01:39AM -0800, Ping Cheng wrote:
>> On Fri, Jan 28, 2011 at 10:46 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Fri, Jan 28, 2011 at 10:23:59AM -0800, Ping Cheng wrote:
>> >> On Fri, Jan 28, 2011 at 9:30 AM, Henrik Rydberg <rydberg@euromail=
=2Ese> wrote:
>> >> > Hi Ping,
>> >> >
>> >> >> This is mainly required by the serial pen and touch devices si=
nce
>> >> >> both pen and touch are on the same port. Updated the USB ones =
to
>> >> >> keep MT event definition consistent among serial and USB devic=
es.
>> >> >
>> >> > Why is this change performed? What does the patch do? Please el=
aborate
>> >> > a little bit.
>> >>
>> >> Let's see if I can explain it clearer or not.
>> >>
>> >> We need to report resolution to userland for wacom_w8001.c. Since=
 pen
>> >> and touch data are reported through the same logical port for ser=
ial
>> >> devices, using input_abs_set_res =A0for ABS_X/Y, =A0we can only p=
ass the
>> >> resolution for pen or touch. So, I let ABS_X/Y report pen resolut=
ion
>> >> since most legacy ST clients process pen data over touch. However=
, for
>> >> multi-touch clients, especially for those that support gestures, =
touch
>> >> resolution is needed to calculate the physical distance between t=
wo
>> >> touch points. Using =A0ABS_MT_POSITION_X/Y does not cause confusi=
on and
>> >> it is quite intuitive.
>> >
>> > We just went through the round of why we should scale events from
>> > different tools when they use the same event devices and I do not =
see
>> > why MT data is any different.
>>
>> At the time when we worked on that, we did not consider resolution. =
We
>> only scaled the logical values.
>>
>> > Devices have only one set of physical axes (MT or not)
>>
>> You are right if the device only supports one type of tools. Yes, ST
>> or pen can go with ABS_X/Y. MT goes with MT. However, we are dealing
>> with a dual tool case: pen and touch on the same port. Using only on=
e
>> set of axes would not be able to cover both tool events and pass the
>> resolution to the userland.
>>
>> > so I believe
>> > min, max and resultion should be reported on ABS_X, Y, X, etc, or,=
 if
>> > you want to have this data in ABS_MT_POSITION, it should be trhe s=
ame.
>>
>> max/min is different from resolution. We can scale max/min since the=
y
>> are logical data. But we can not change the device's physical size.
>> That's the root cause of the "stubborn" nature of resolution.
>
> This is the same device so it should have the same physical dimension=
s,
> right?

No, pen and touch use different chips. They can have different sizes.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
