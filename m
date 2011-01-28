From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 12:08:54 -0800
Message-ID: <AANLkTikJt7So41PP06ac6JvsOg5L1tKLDYHzVzqsFzTP@mail.gmail.com>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
	<20110128173048.GC2586@polaris.bitmath.org>
	<AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
	<20110128191203.GA2729@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44269 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab1A1UIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 15:08:55 -0500
Received: by wyb28 with SMTP id 28so3594007wyb.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 12:08:54 -0800 (PST)
In-Reply-To: <20110128191203.GA2729@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Jan 28, 2011 at 11:12 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
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
>> We need to report resolution to userland for wacom_w8001.c.
>
> Thanks, perfect - sentences like this one is great to put in the patc=
h
> description.

Thanks for the encouragement ;).

>> Since pen
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
> I thought this was solved by reporting both pen and touch on the same
> scale, which would render this problem moot. Or?

Yeah, see my reply to Dmitry for detail.

> [...]
>> > Is this for the BAMBOO_PT case? What about the extra x/y scaling f=
or
>> > some of those devices?
>>
>> Yes, it is for Bamboo. We do not need to scale the value here since
>> touch and pen are on different ports. We had to scale the value for
>> wacom_w8001 since both pen and touch are on the same port. Without
>> scaling the data, the pen/finger tip will not follow the cursor on t=
he
>> screen (wacom_w8001 is a touchscren device).
>
> I was thinking of the scaling quirk in effect for the Bamboo
> Touch. The resolution would have to change as well.

Yes, If we need to report the right values ;).

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
