From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] Input: i8042 add of_node_put()
Date: Sun, 9 Dec 2018 13:22:03 +0800
Message-ID: <CAEExFWuw5Fr_pjS1vLm-gq1VnJfZ5E7rw01LFU4-M1dwOAoM2A@mail.gmail.com>
References: <20181121143513.22961-1-tiny.windzz@gmail.com> <20181129183657.GD54791@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129183657.GD54791@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 30, 2018 at 2:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Yangtao,
>
> On Wed, Nov 21, 2018 at 09:35:13AM -0500, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/input/serio/i8042-sparcio.h | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> > index 796289846204..5495bc035518 100644
> > --- a/drivers/input/serio/i8042-sparcio.h
> > +++ b/drivers/input/serio/i8042-sparcio.h
> > @@ -108,18 +108,21 @@ static struct platform_driver sparc_i8042_driver = {
> >
> >  static int __init i8042_platform_init(void)
> >  {
> > +     int rc;
> >       struct device_node *root = of_find_node_by_path("/");
> >
> >       if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> >               /* Hardcoded values for MrCoffee.  */
> >               i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
> >               kbd_iobase = ioremap(0x71300060, 8);
> > -             if (!kbd_iobase)
> > -                     return -ENODEV;
> > +             if (!kbd_iobase){
> > +                     rc = -ENODEV;
> > +                     goto out;
> > +             }
> >       } else {
> > -             int err = platform_driver_register(&sparc_i8042_driver);
> > -             if (err)
> > -                     return err;
> > +             rc = platform_driver_register(&sparc_i8042_driver);
> > +             if (rc)
> > +                     goto out;
> >
> >               if (i8042_kbd_irq == -1 ||
> >                   i8042_aux_irq == -1) {
> > @@ -127,13 +130,18 @@ static int __init i8042_platform_init(void)
> >                               of_iounmap(kbd_res, kbd_iobase, 8);
> >                               kbd_iobase = (void __iomem *) NULL;
> >                       }
> > -                     return -ENODEV;
> > +                     rc = -ENODEV;
> > +                     goto out;
> >               }
> >       }
> >
> >       i8042_reset = I8042_RESET_ALWAYS;
> >
> > -     return 0;
> > +     rc = 0;
> > +out:
> > +     of_node_put(root);
> > +
> > +     return rc;
>
> Instead of rearranging code like this, can we instead have:
>
> static inline bool i8042_is_mr_coffee(void)
> {
>         struct device_node *root;
>         bool is_mr_coffree;
>
>         root = of_find_node_by_path("/");
>         is_mr_coffree = !strcmp(root->name, "SUNW,JavaStation-1");
>         of_node_put(root);
>
>         return is_mr_coffee;
> }
>
> ?
Yes, we should do this. The modified patch has been sent.
Also, I am very sorry to reply so late.

MBR,
Yangtao
>
> Thanks.
>
> --
> Dmitry
