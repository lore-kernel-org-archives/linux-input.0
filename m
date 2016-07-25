From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/mouse/elantech.c: Remove trackpoint related label
Date: Mon, 25 Jul 2016 11:33:32 -0700
Message-ID: <20160725183332.GF27415@dtor-ws>
References: <1469281960-27572-1-git-send-email-marcos.souza.org@gmail.com>
 <20160725095356.GI19383@mail.corp.redhat.com>
 <CAH0vN5J=hEJ0-BgTDUnRi0Jny34mAGxZ+V9pY3Jnx9uwjxaPKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33936 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbcGYSdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 14:33:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id g202so12427772pfb.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 11:33:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH0vN5J=hEJ0-BgTDUnRi0Jny34mAGxZ+V9pY3Jnx9uwjxaPKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Souza <marcos.souza.org@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, Takashi Iwai <tiwai@suse.de>, Duson Lin <dusonlin@emc.com.tw>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN),
	linux-kernel@vger.kernel.org (open list)" <linux-input@vger.kernel.org>

On Mon, Jul 25, 2016 at 10:34:28AM +0000, Marcos Souza wrote:
> Hi,
> 
> On Mon, Jul 25, 2016 at 6:54 AM Benjamin Tissoires <
> benjamin.tissoires@redhat.com> wrote:
> 
> > Hi,
> >
> > On Jul 23 2016 or thereabouts, Marcos Paulo de Souza wrote:
> > > by rearranging the code to release the trackpoint resource when some
> > error
> > > happens.
> >
> > Is there any advantage of doing so beside trying to remove one goto?
> > Because if not, that's the kernel failure style and this is much better
> > given that if somebody needs to add other commands after initializing the
> > trackstick, and if those command fail, we can then remove the
> > trackstick.
> >
> 
> My only reason was to shrink the code a little, by removing a label used

Shrink executable code or source code? I do not see either of them
shrinking, you have the same number of code lines and compiler is going
to rearrange the instructions the way it sees fit anyway.

> only once. Yes, we may need to add more more and the this label could be
> used to avoid duplication, but for now we don't have such code.
> 
> But OK, you can drop it if you don't think it's worth applying.
> 
> Thanks,
> 
> 
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > ---
> > >  drivers/input/mouse/elantech.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/input/mouse/elantech.c
> > b/drivers/input/mouse/elantech.c
> > > index be5b399..8c53a17 100644
> > > --- a/drivers/input/mouse/elantech.c
> > > +++ b/drivers/input/mouse/elantech.c
> > > @@ -1725,8 +1725,10 @@ int elantech_init(struct psmouse *psmouse)
> > >               __set_bit(INPUT_PROP_POINTING_STICK, tp_dev->propbit);
> > >
> > >               error = input_register_device(etd->tp_dev);
> > > -             if (error < 0)
> > > -                     goto init_fail_tp_reg;
> > > +             if (error < 0) {
> > > +                     input_free_device(tp_dev);
> > > +                     goto init_fail_tp_alloc;
> > > +             }
> > >       }
> > >
> > >       psmouse->protocol_handler = elantech_process_byte;
> > > @@ -1735,8 +1737,6 @@ int elantech_init(struct psmouse *psmouse)
> > >       psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
> > >
> > >       return 0;
> > > - init_fail_tp_reg:
> > > -     input_free_device(tp_dev);
> > >   init_fail_tp_alloc:
> > >       sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
> > >                          &elantech_attr_group);
> > > --
> > > 2.7.4
> > >
> >

Thanks.

-- 
Dmitry
