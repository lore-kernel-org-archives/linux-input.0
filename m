From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Sun, 29 Jan 2012 07:08:45 +0100
Message-ID: <CABxcv==L=F4+jkJ9Q-BFmsovH+k+-AH7sD0vhCi6rFAjno+V5g@mail.gmail.com>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org>
	<20120127181846.GA22462@core.coreip.homeip.net>
	<CABxcv=n8kFJiL01WEVdFat5Y=W9xQeG6_2oNV=_45UUFr+0gtw@mail.gmail.com>
	<3249126.MSECh6D9S6@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48834 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2A2GIq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 01:08:46 -0500
Received: by iacb35 with SMTP id b35so3770797iac.19
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2012 22:08:46 -0800 (PST)
In-Reply-To: <3249126.MSECh6D9S6@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Fri, Jan 27, 2012 at 10:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Friday, January 27, 2012 10:01:22 PM Javier Martinez Canillas wrot=
e:
>> On Fri, Jan 27, 2012 at 7:18 PM, Dmitry Torokhov
>>
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Fri, Jan 27, 2012 at 04:57:12PM +0100, Javier Martinez Canillas=
 wrote:
>> >> On Fri, Jan 27, 2012 at 9:18 AM, Dmitry Torokhov
>> >>
>> >> <dmitry.torokhov@gmail.com> wrote:
>> >> > On Thu, Jan 26, 2012 at 01:12:50AM +0100, Javier Martinez Canil=
las
> wrote:
>> >> >> On Tue, Jan 24, 2012 at 8:54 AM, Dmitry Torokhov
>> >> >>
>> >> >> <dmitry.torokhov@gmail.com> wrote:
>> >> >> > On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Ca=
nillas
> wrote:
>> >> >> >> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
>> >> >> >>
>> >> >> >> <javier@dowhile0.org> wrote:
>> >> >> >> > Cypress TrueTouch(tm) Standard Product controllers are
>> >> >> >> > found in
>> >> >> >> > a wide range of embedded devices. This driver add
>> >> >> >> > support for a
>> >> >> >> > variety of TTSP controllers.
>> >> >> >> >
>> >> >> >> > Since the hardware is capable of tracking identifiable
>> >> >> >> > contacts, multi-touch protocol type B (stateful) is
>> >> >> >> > used to report contact information.
>> >> >> >> >
>> >> >> >> > The driver is composed of a core driver that process
>> >> >> >> > the data sent by the contacts and a set of bus
>> >> >> >> > specific interface modules. This patch adds the base
>> >> >> >> > core TTSP driver.
>> >> >> >> >
>> >> >> >> > Signed-off-by: Javier Martinez Canillas
>> >> >> >> > <javier@dowhile0.org>
>> >> >> >> > ---
>> >> >> >> >
>> >> >> >> > Changes for v10: Fix issues called out by Dmitry
>> >> >> >> > Torokhov
>> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0- Remove use_sleep and put dev=
ice to sleep
>> >> >> >> > unconditionally on suspend - Cleanup
>> >> >> >> > cyttsp_power_on() and remove cyttsp_bl_app_valid()
>> >> >> >> > function
>> >> >> >> >
>> >> >> >> > =C2=A0drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 31 ++
>> >> >> >> > =C2=A0drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A03 +
>> >> >> >> > =C2=A0drivers/input/touchscreen/cyttsp_core.c | =C2=A0682
>> >> >> >> > +++++++++++++++++++++++++++++++
>> >> >> >> > drivers/input/touchscreen/cyttsp_core.h | =C2=A0141
>> >> >> >> > +++++++ include/linux/input/cyttsp.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|
>> >> >> >> > 68 +++
>> >> >> >> > =C2=A05 files changed, 925 insertions(+), 0 deletions(-)
>> >> >> >>
>> >> >> >> Hello Dmitry,
>> >> >> >>
>> >> >> >> Any comments on this version?
>> >> >> >
>> >> >> > Looking at it... If you do not hear from me by Wednesday
>> >> >> > please ping me again.
>> >> >> >
>> >> >> > Thanks.
>> >> >> >
>> >> >> > --
>> >> >> > Dmitry
>> >> >>
>> >> >> ping :)
>> >> >
>> >> > Is it still Wednesday by any chance? ;)
>> >>
>> >> Hi Dmitry,
>> >>
>> >> Thanks for the review and the cleanup patch!
>> >>
>> >> > Anyway, the driver looks pretty good, still below are some chan=
ges
>> >> > that I'd like to get in as well:
>> >> >
>> >> > - do not return EAGAIN when operation times out, EIO I believe
>> >> > suits
>> >> > =C2=A0better.
>> >> > - introduce ttsp_send_command() to replace host of custom
>> >> > functions.
>> >> > - reduce numver of states to 3 - IDLE, ACTIVE and BL mode.
>> >> > =C2=A0Suspended/full power is already covered by "suspended" at=
tribute.
>> >> > - streamline some functions.
>> >>
>> >> Seems that your patch handlers all these issues.
>> >>
>> >> > Please see the FIXME comment in cyttsp_enable() - is there a
>> >> > generic way to wake up the device, similarly to the way we put =
it
>> >> > to sleep?>>
>> >> I guess that CY_OPERATE_MODE works but I have to try it since I d=
on't
>> >> have the hw data-sheet.
>> >>
>> >> > Please tell me if the device still works with this patch.
>> >> >
>> >> > Thanks!
>> >> >
>> >> > --
>> >> > Dmitry
>> >>
>> >> Strange enough, it doesn't apply cleanly on my tree...
>> >>
>> >> with patch -p1 < your_patch
>> >>
>> >> It should since only the files for this driver are modified and I=
've
>> >> only applied the v10 patches I sent to you.
>> >> Anyway I will manually do the changes, try it and resend to you.
>> >
>> > Hmm, not sure why it gives you trouble, I tried not to change anyt=
hing
>> > when applying your v10 patches except for folding them all togethe=
r.
>> >
>> > I am attaching the version of the driver I've used as a base - may=
be it
>> > will save you some time instead of applying the changes manually.
>> >
>> > Also, could you please send changes needed to make my patch work a=
s
>> > incremental patch so that I can apply on top of mime locally and f=
old
>> > all 3 together? It will be easier to see what exactly changed.
>> >
>> > Thanks!
>> >
>> > --
>> > Dmitry
>>
>> Hi Dmitry,
>>
>> Using that merged patch as a base your patch applies cleanly (not su=
re
>> what happened with my branch)
>>
>> Sadly the driver is not working with your modifications.
>
> I was afraid it could happen - hazards of chaging the code without th=
e way of
> testing it... =C2=A0I'll try to double check and see what I might hav=
e done wrong.
> What device did you test - I2C or SPI? Or do they both fail?
>

Hi Dmitry,

Just sent an email with the fix of the two bugs I found in your
clean-up patch. With those two fixes the device is working again.

Also I remove the wakeup() platform function. That function told me
Kevin that was in the original Android driver because the device can
be wakeup by flipping the direction of the GPIO ping connected to the
touchscreen IRQ line. But also the device wakes up when there is an
I2C or SPI slave memory address match and by reading one of the device
registers. So trying to read will fail if the device is in sleep mode
but it will wake up the device so the first retry will succeed. I
documented that hardware behavior in the driver to make it clear.

I have only an device connected through I2C device but Kevin has been
testing with a device using SPI.

>> I'll make it
>> work changing as less as possible what was in your patch. Only to ma=
ke
>> the device work again and will send you as an incremental patch as y=
ou
>> suggested.
>
> Thank you for your patience with me.
>

Thank you for your patience and your reviews.

>>
>> Just to be clear, do you want me to send as an incremental patch of =
my
>> series (v10) or as an incremental patch of your last patch?
>>
>
> Incremental to mine please - so in your working branch you should hav=
e the
> original change + my patch as a separate commit + your commit fixing =
my mess.
>
> --
> Dmitry

Perfect, the patch I sent is an incremental one on top of my three
last patches (v10) + your clean-up patch.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
