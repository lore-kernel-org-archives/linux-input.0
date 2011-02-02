From: Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH] Input: serio - clear serio event queue after sysfs driver rebind
Date: Wed, 2 Feb 2011 14:41:38 -0800
Message-ID: <AANLkTiknhubSN37ChYebWxd9Wx=R4dN38ETdZv2BZYee@mail.gmail.com>
References: <1290467390-25302-1-git-send-email-dlaurie@chromium.org>
 <20101127084153.GC28745@core.coreip.homeip.net> <AANLkTik1TE9zgKaiLQZ=1uFgMyZt43xp8VJBWfxdVyMY@mail.gmail.com>
 <20101208051211.GB4140@core.coreip.homeip.net> <20110201092126.GC17706@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:44433 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab1BBWl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 17:41:57 -0500
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p12MfuNt013966
	for <linux-input@vger.kernel.org>; Wed, 2 Feb 2011 14:41:56 -0800
Received: from vws11 (vws11.prod.google.com [10.241.21.139])
	by hpaq7.eem.corp.google.com with ESMTP id p12Mfsli021210
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 2 Feb 2011 14:41:55 -0800
Received: by vws11 with SMTP id 11so255172vws.15
        for <linux-input@vger.kernel.org>; Wed, 02 Feb 2011 14:41:54 -0800 (PST)
In-Reply-To: <20110201092126.GC17706@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 1, 2011 at 1:21 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Dec 07, 2010 at 09:12:11PM -0800, Dmitry Torokhov wrote:
>> On Mon, Nov 29, 2010 at 01:37:35PM -0800, Duncan Laurie wrote:
>> > On Sat, Nov 27, 2010 at 12:41 AM, Dmitry Torokhov
>> > <dmitry.torokhov@gmail.com> wrote:
>> > > Hi Duncan,
>> > >
>> > > On Mon, Nov 22, 2010 at 03:09:50PM -0800, Duncan Laurie wrote:
>> > >> When rebinding a serio driver via sysfs drvctl interface it is =
possible for
>> > >> an interrupt to trigger after the disconnect of the existing dr=
iver and
>> > >> before the binding of the new driver. =A0This will cause the se=
rio interrupt
>> > >> handler to queue a rescan event which will disconnect the new d=
river
>> > >> immediately after it is attached.
>> > >>
>> > >> This change clears the serio event queue after processing the d=
rvctl
>> > >> request but before releasing the serio mutex, which will clear =
any queued
>> > >> rescans before they can get processed.
>> > >>
>> > >> Reproduction involves issuing a rebind of device port from psmo=
use driver
>> > >> to serio_raw driver while generating input to trigger interrupt=
s. =A0Then
>> > >> checking to see if the corresponding i8042/serio4/driver is cor=
rectly
>> > >> attached to the serio_raw driver instead of psmouse.
>> > >>
>> > >> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
>> > >> ---
>> > >> =A0drivers/input/serio/serio.c | =A0 =A01 +
>> > >> =A01 files changed, 1 insertions(+), 0 deletions(-)
>> > >>
>> > >> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/=
serio.c
>> > >> index 405bf21..a66307e 100644
>> > >> --- a/drivers/input/serio/serio.c
>> > >> +++ b/drivers/input/serio/serio.c
>> > >> @@ -454,6 +454,7 @@ static ssize_t serio_rebind_driver(struct d=
evice *dev, struct device_attribute *
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_disconnect_port(serio);
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D serio_bind_driver(serio, =
to_serio_driver(drv));
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_driver(drv);
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 serio_remove_pending_events(serio);
>> > >
>> > > Hmm, makes sense, although should we limit events being removed =
to
>> > > rescan events only?
>> > >
>> >
>> >
>> > That seems reasonable. =A0It would mean adding a new function or a
>> > parameter to the existing serio_remove_pending_events function, do=
 you
>> > have a preference?
>> >
>>
>> I wonder if a boolean parameter (rescan_only) would not be the best
>> option.
>>
>
> Hi Duncan,
>
> I eneded up with the following patch, could you please try and see if
> it still works for you?
>


Hi Dmitry,

I tested the patch on a CR-48 device (which is where I was seeing the
problem because we switch to serio_raw at boot for the trackpad) and
it does fix the problem.

Thanks for sending this, it had slipped off my todo list.

-duncan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
