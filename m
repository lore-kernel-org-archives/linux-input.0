From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: gpio_keys - fix NULL pointer dereference for
 dt case
Date: Tue, 21 Aug 2012 22:58:16 -0700
Message-ID: <20120822055816.GF20624@core.coreip.homeip.net>
References: <1345488520-3997-1-git-send-email-fabio.estevam@freescale.com>
 <CADhrpJ4xYNjRxcfnN-+ijGE-fNSNYfsTqumiKsodZiw41yk9+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58675 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299Ab2HVF6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 01:58:21 -0400
Received: by dady13 with SMTP id y13so475333dad.19
        for <linux-input@vger.kernel.org>; Tue, 21 Aug 2012 22:58:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADhrpJ4xYNjRxcfnN-+ijGE-fNSNYfsTqumiKsodZiw41yk9+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan M Butler <alanbutty12@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, aletes.xgr@gmail.com, linux-input@vger.kernel.org

On Mon, Aug 20, 2012 at 09:44:40PM +0100, Alan M Butler wrote:
> On 20 August 2012 19:48, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> > Commit 30161f6b2e7d1 (Input: gpio_keys - clean up device tree parser)
> > introduced the following kernel crash for a dt based kernel:
> > ..
> > Unable to handle kernel NULL pointer dereference at virtual address 00000004
> > pgd = 80004000
> > [00000004] *pgd=00000000
> > Internal error: Oops: 805 [#1] ARM
> > Modules linked in:
> > CPU: 0    Not tainted  (3.5.0-next-20120802+ #1366)
> > PC is at gpio_keys_probe+0x154/0x8c0
> > LR is at of_gpiochip_find_and_xlate+0x54/0x70
> > pc : [<803ddbac>]    lr : [<801ed2f4>]    psr: 60000013
> > sp : 9f851df8  ip : 00000002  fp : 9f851e5c
> > r10: 9f873d00  r9 : 00000001  r8 : 9fa2f900
> > r7 : 809c0920  r6 : 9f873d08  r5 : 00000000  r4 : 809c09d4
> > r3 : 805af10c  r2 : 000000c0  r1 : 9f851db4  r0 : 000000d5
> > Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> > Control: 10c5387d  Table: 90004019  DAC: 00000015
> > Process swapper (pid: 1, stack limit = 0x9f8502e8)
> > Stack: (0x9f851df8 to 0x9f852000)
> > ....
> >
> > The reason for the crash was due to 'button = &pdata->buttons[i++];'
> > returning a NULL pointer, and then 'button' was accessed afterwards
> > without checking for NULL.
> >
> > Fix this by correctly assigning 'pdata->buttons' and also add a NULL
> > pointer check for 'button' pointer.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Changes since v1:
> > - Fix the location of 'button = pdata->buttons'. This fixes the probing of multiple keys.
> >
> >  drivers/input/keyboard/gpio_keys.c |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 6ee68ec..c90c152 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -559,7 +559,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >         struct gpio_keys_button *button;
> >         int error;
> >         int nbuttons;
> > -       int i;
> >
> >         node = dev->of_node;
> >         if (!node) {
> > @@ -580,9 +579,12 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >                 goto err_out;
> >         }
> >
> > +       pdata->buttons = (struct gpio_keys_button *) (pdata + 1);
> > +       pdata->nbuttons = nbuttons;
> > +
> >         pdata->rep = !!of_get_property(node, "autorepeat", NULL);
> > +       button = pdata->buttons;
> >
> > -       i = 0;
> >         for_each_child_of_node(node, pp) {
> >                 enum of_gpio_flags flags;
> >
> > @@ -592,7 +594,10 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >                         continue;
> >                 }
> >
> > -               button = &pdata->buttons[i++];
> > +               if (!button) {
> > +                       error = -ENOMEM;
> > +                       goto err_free_pdata;
> > +               }

This tests impossible condition.

> >
> >                 button->gpio = of_get_gpio_flags(pp, 0, &flags);
> >                 button->active_low = flags & OF_GPIO_ACTIVE_LOW;
> > @@ -614,6 +619,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
> >                 if (of_property_read_u32(pp, "debounce-interval",
> >                                          &button->debounce_interval))
> >                         button->debounce_interval = 5;
> > +
> > +               button++;
> >         }
> >
> >         if (pdata->nbuttons == 0) {
> > --
> > 1.7.9.5
> >
> >
> 
> Tested-by: Alan M Butler <alanbutty12@gmail.com>

I took the part initializing pdata->buttons and pdata->nbuttons and
folded it into the offending patch.

Thank you!

-- 
Dmitry
