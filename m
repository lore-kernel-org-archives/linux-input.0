From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Fri, 27 Jan 2012 16:57:12 +0100
Message-ID: <CABxcv=muzq2d+hJZCc0+r-wnE6vLBYwr4jOvXNiJG9_-nY9uEA@mail.gmail.com>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org>
	<CABxcv=kE4-8mGVw9F0sFu_DsC2fU_HNsU-Q4+QEs_FDDqMzKTw@mail.gmail.com>
	<20120124075430.GA9775@core.coreip.homeip.net>
	<CABxcv=k_e3Pdx=OaLWW-xTGoDXEQKKGWYzcLLWvZEnYBPSv6qw@mail.gmail.com>
	<20120127081833.GA21903@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63383 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab2A0P5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jan 2012 10:57:13 -0500
Received: by ggnb1 with SMTP id b1so879179ggn.19
        for <linux-input@vger.kernel.org>; Fri, 27 Jan 2012 07:57:13 -0800 (PST)
In-Reply-To: <20120127081833.GA21903@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Fri, Jan 27, 2012 at 9:18 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jan 26, 2012 at 01:12:50AM +0100, Javier Martinez Canillas wr=
ote:
>> On Tue, Jan 24, 2012 at 8:54 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Canillas=
 wrote:
>> >> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
>> >> <javier@dowhile0.org> wrote:
>> >> > Cypress TrueTouch(tm) Standard Product controllers are found in
>> >> > a wide range of embedded devices. This driver add support for a
>> >> > variety of TTSP controllers.
>> >> >
>> >> > Since the hardware is capable of tracking identifiable contacts=
, multi-touch
>> >> > protocol type B (stateful) is used to report contact informatio=
n.
>> >> >
>> >> > The driver is composed of a core driver that process the data s=
ent by
>> >> > the contacts and a set of bus specific interface modules. This =
patch
>> >> > adds the base core TTSP driver.
>> >> >
>> >> > Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> >> > ---
>> >> >
>> >> > Changes for v10: Fix issues called out by Dmitry Torokhov
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0- Remove use_sleep and put device to=
 sleep unconditionally on suspend
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0- Cleanup cyttsp_power_on() and remo=
ve cyttsp_bl_app_valid() function
>> >> >
>> >> > =C2=A0drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 31 ++
>> >> > =C2=A0drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A03 +
>> >> > =C2=A0drivers/input/touchscreen/cyttsp_core.c | =C2=A0682 +++++=
++++++++++++++++++++++++++
>> >> > =C2=A0drivers/input/touchscreen/cyttsp_core.h | =C2=A0141 +++++=
++
>> >> > =C2=A0include/linux/input/cyttsp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 68 +++
>> >> > =C2=A05 files changed, 925 insertions(+), 0 deletions(-)
>> >>
>> >> Hello Dmitry,
>> >>
>> >> Any comments on this version?
>> >
>> > Looking at it... If you do not hear from me by Wednesday please pi=
ng
>> > me again.
>> >
>> > Thanks.
>> >
>> > --
>> > Dmitry
>>
>> ping :)
>
> Is it still Wednesday by any chance? ;)
>

Hi Dmitry,

Thanks for the review and the cleanup patch!

> Anyway, the driver looks pretty good, still below are some changes th=
at
> I'd like to get in as well:
>
> - do not return EAGAIN when operation times out, EIO I believe suits
> =C2=A0better.
> - introduce ttsp_send_command() to replace host of custom functions.
> - reduce numver of states to 3 - IDLE, ACTIVE and BL mode.
> =C2=A0Suspended/full power is already covered by "suspended" attribut=
e.
> - streamline some functions.
>

Seems that your patch handlers all these issues.

> Please see the FIXME comment in cyttsp_enable() - is there a generic =
way
> to wake up the device, similarly to the way we put it to sleep?
>

I guess that CY_OPERATE_MODE works but I have to try it since I don't
have the hw data-sheet.

> Please tell me if the device still works with this patch.
>
> Thanks!
>
> --
> Dmitry
>

Strange enough, it doesn't apply cleanly on my tree...

with patch -p1 < your_patch

It should since only the files for this driver are modified and I've
only applied the v10 patches I sent to you.
Anyway I will manually do the changes, try it and resend to you.

Thanks a lot for your help and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
