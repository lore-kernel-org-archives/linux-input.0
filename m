From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Evdev: Fix bug in checking duplicate clock change request
Date: Fri, 30 Oct 2015 23:17:46 +0530
Message-ID: <CADYu3083VA0-sSYtGCTjc417kudAE+506Bpc1d=0ucCr9N=LCA@mail.gmail.com>
References: <1446062912-9181-1-git-send-email-aniroop.mathur@gmail.com>
	<20151030111526.GA29775@dtor-pixel>
	<CADYu308zJag9gh24Q-K0Dne38qgvGg+tCm9aCYv-=0CHCFC2Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35471 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759623AbbJ3Rrq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Oct 2015 13:47:46 -0400
In-Reply-To: <CADYu308zJag9gh24Q-K0Dne38qgvGg+tCm9aCYv-=0CHCFC2Lg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 30, 2015 at 6:34 PM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
>
> Hello Mr. Torokhov,
>
> On Fri, Oct 30, 2015 at 4:45 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Aniroop,
> >
> > On Thu, Oct 29, 2015 at 01:38:32AM +0530, Aniroop Mathur wrote:
> >> From: Aniroop Mathur <a.mathur@samsung.com>
> >>
> >> clk_type and clkid stores different predefined clock identification
> >> values so they cannot be compared for checking duplicate clock change
> >> request. Therefore, lets fix it to avoid unexpected results.
> >
> > Good catch!
> >
>
> Thank you :)
>
> >>
> >> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> >> Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
> >
> > You only need one signoff, which one should I keep? The Samsung one?
> >
>
> Yes, Samsung one.
>
> >> ---
> >>  drivers/input/evdev.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> >> index 08d4964..0d40f6f 100644
> >> --- a/drivers/input/evdev.c
> >> +++ b/drivers/input/evdev.c
> >> @@ -56,7 +56,7 @@ struct evdev_client {
> >>       struct fasync_struct *fasync;
> >>       struct evdev *evdev;
> >>       struct list_head node;
> >> -     int clk_type;
> >> +     unsigned int clk_type;
> >>       bool revoked;
> >>       unsigned int bufsize;
> >>       struct input_event buffer[];
> >> @@ -146,9 +146,7 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
> >>  static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
> >>  {
> >>       unsigned long flags;
> >> -
> >> -     if (client->clk_type == clkid)
> >> -             return 0;
> >> +     unsigned int prev_clk_type = client->clk_type;
> >
> > I prefer the other way around: convert to a temp and then compare. I;ll
> > fix it up on my side.
> >
>
> I thought that was the only better way of all.
> I am not sure what exactly you're referring. I guess I need little
> more elaboration here or anyways, I'll check it up up once you apply
> it.

Ahhh okay... I got the other way around.
(Filling client->clk_type in the end instead)

>
>
>
> >>
> >>       switch (clkid) {
> >>
> >> @@ -165,6 +163,10 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
> >>               return -EINVAL;
> >>       }
> >>
> >> +     /* No need to flush if clk_type is same as before */
> >> +     if (client->clk_type == prev_clk_type)
> >> +             return 0;
> >> +
> >>       /*
> >>        * Flush pending events and queue SYN_DROPPED event,
> >>        * but only if the queue is not empty.
> >> --
> >> 2.6.2
> >>
> >
> > Thanks.
> >
> > --
> > Dmitry
>
> Regards,
> Aniroop
