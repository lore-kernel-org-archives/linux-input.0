From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - switch t460s 20FN to use RMI4 over
 SMBus
Date: Mon, 26 Jun 2017 17:38:56 +0200
Message-ID: <20170626153856.GV26073@mail.corp.redhat.com>
References: <CAE4xfVLxhF29jLoFWwa4o6_0G_5VMQ8YN1BVP4=8+Y3u_BERPw@mail.gmail.com>
 <20170626082626.797-1-benjamin.tissoires@redhat.com>
 <CAE4xfV+Z8Yq=5rGP7H5CcWYfJrNLDPVjgqFOb_ebk0QOYat7Hw@mail.gmail.com>
 <CAE4xfV+ygZ5Z9VsFdzmkQQgZZyH79zM4Jr2PHS2s0b9NYG7fqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdFZPjD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2017 11:39:03 -0400
Content-Disposition: inline
In-Reply-To: <CAE4xfV+ygZ5Z9VsFdzmkQQgZZyH79zM4Jr2PHS2s0b9NYG7fqQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Bachner <b.christopher.92@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 26 2017 or thereabouts, Christopher Bachner wrote:
> Hello,
> 
> I am assuming that if the inertouch message is not showing up in dmesg,
> then it is working. Is that a correct assumption?
> 
> Either way I also attached my dmesg.
> 
> I am not sure, though, why the scroll mode still freezes if I move the my
> fingers quickly on the touchpad while also using the trackpoint. Is that
> maybe a future fix and this change is just the foundation for it? Overall
> the usage of the trackpoint is better now for sure.

Sadly, you are also hit by:
[    6.355378] i801_smbus 0000:00:1f.4: BIOS is accessing SMBus registers
[    6.355380] i801_smbus 0000:00:1f.4: Driver SMBus register access inhibited

Which disables entirely the RMI4 over SMBus module. And then we can not
probe for it, meaning you are stuck with the PS/2 crappy mode.

We are aware of this bug and we'll try to fix that. I think the test you
provides are valid (the patch works as expected), but a different bug
prevents rmi-smbus to fully initialize the touchpad :(

Cheers,
Benjamin

> 
> 
> (Resending again without attachment since the linux-kernel@vger.kernel.org
> and linux-input@vger.kernel.org don't accept attachments)
> 
> 
> ---
> Thanks,
> 
> Christopher Bachner
> 
> ---
> Thanks,
> 
> Christopher Bachner
> 
> On Mon, Jun 26, 2017 at 8:12 AM, Christopher Bachner <
> b.christopher.92@gmail.com> wrote:
> 
> > Hello,
> >
> > I am assuming that if the inertouch message is not showing up in dmesg,
> > then it is working. Is that a correct assumption?
> >
> > Either way I also attached my dmesg.
> >
> > I am not sure, though, why the scroll mode still freezes if I move the my
> > fingers quickly on the touchpad while also using the trackpoint. Is that
> > maybe a future fix and this change is just the foundation for it? Overall
> > the usage of the trackpoint is better now for sure.
> >
> >
> >
> > ---
> > Thanks,
> >
> > Christopher Bachner
> >
> > On Mon, Jun 26, 2017 at 1:26 AM, Benjamin Tissoires <
> > benjamin.tissoires@redhat.com> wrote:
> >
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >>
> >> ---
> >>
> >> Hi Christopher,
> >>
> >> Could you please test this patch without appending synaptics_intertouch=1
> >> to the boot command line? If this still works, we will have the RMI4 over
> >> SMBus by default for your laptop.
> >>
> >> Cheers,
> >> Benjamin
> >>
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >> ---
> >>  drivers/input/mouse/synaptics.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/input/mouse/synaptics.c
> >> b/drivers/input/mouse/synaptics.c
> >> index f4fbe1a..a8fb26bc 100644
> >> --- a/drivers/input/mouse/synaptics.c
> >> +++ b/drivers/input/mouse/synaptics.c
> >> @@ -173,6 +173,7 @@ static const char * const smbus_pnp_ids[] = {
> >>         "LEN0046", /* X250 */
> >>         "LEN004a", /* W541 */
> >>         "LEN200f", /* T450s */
> >> +       "LEN2016", /* T460 20FN */
> >>         NULL
> >>  };
> >>
> >> --
> >> 2.9.4
> >>
> >>
> >
