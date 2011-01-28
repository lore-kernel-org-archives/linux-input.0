From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 11:01:39 -0800
Message-ID: <AANLkTikgTYQvhTzEHWw0Yhigno7TLJ8jm9jaw10mOhk+@mail.gmail.com>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
	<20110128173048.GC2586@polaris.bitmath.org>
	<AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
	<20110128184654.GG6252@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44385 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab1A1TBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 14:01:41 -0500
Received: by wwa36 with SMTP id 36so3694917wwa.1
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 11:01:39 -0800 (PST)
In-Reply-To: <20110128184654.GG6252@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 10:46 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Jan 28, 2011 at 10:23:59AM -0800, Ping Cheng wrote:
>> On Fri, Jan 28, 2011 at 9:30 AM, Henrik Rydberg <rydberg@euromail.se=
> wrote:
>> > Hi Ping,
>> >
>> >> This is mainly required by the serial pen and touch devices since
>> >> both pen and touch are on the same port. Updated the USB ones to
>> >> keep MT event definition consistent among serial and USB devices.
>> >
>> > Why is this change performed? What does the patch do? Please elabo=
rate
>> > a little bit.
>>
>> Let's see if I can explain it clearer or not.
>>
>> We need to report resolution to userland for wacom_w8001.c. Since pe=
n
>> and touch data are reported through the same logical port for serial
>> devices, using input_abs_set_res =A0for ABS_X/Y, =A0we can only pass=
 the
>> resolution for pen or touch. So, I let ABS_X/Y report pen resolution
>> since most legacy ST clients process pen data over touch. However, f=
or
>> multi-touch clients, especially for those that support gestures, tou=
ch
>> resolution is needed to calculate the physical distance between two
>> touch points. Using =A0ABS_MT_POSITION_X/Y does not cause confusion =
and
>> it is quite intuitive.
>
> We just went through the round of why we should scale events from
> different tools when they use the same event devices and I do not see
> why MT data is any different.

At the time when we worked on that, we did not consider resolution. We
only scaled the logical values.

> Devices have only one set of physical axes (MT or not)

You are right if the device only supports one type of tools. Yes, ST
or pen can go with ABS_X/Y. MT goes with MT. However, we are dealing
with a dual tool case: pen and touch on the same port. Using only one
set of axes would not be able to cover both tool events and pass the
resolution to the userland.

> so I believe
> min, max and resultion should be reported on ABS_X, Y, X, etc, or, if
> you want to have this data in ABS_MT_POSITION, it should be trhe same=
=2E

max/min is different from resolution. We can scale max/min since they
are logical data. But we can not change the device's physical size.
That's the root cause of the "stubborn" nature of resolution.

> ABS_MT_POSITION is just a vehicle of delivering multipe contacts, not=
 a
> new device axis.

That is true If we have other means to pass the resolution on. I am
open to other solutions.

Thanks,

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
