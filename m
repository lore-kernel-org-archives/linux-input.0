From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] Input: i8042 fix refcount leak
Date: Sun, 9 Dec 2018 14:15:38 +0800
Message-ID: <CAEExFWsu-tUMv3M=i-B+tNa5bL7boOfaAs3PjcFjbDx6LAXV+Q@mail.gmail.com>
References: <20181209051900.19035-1-tiny.windzz@gmail.com> <20181209054014.GA237502@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181209054014.GA237502@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Dec 9, 2018 at 1:40 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sun, Dec 09, 2018 at 12:19:00AM -0500, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/input/serio/i8042-sparcio.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> > index 796289846204..cc6777b4c4ea 100644
> > --- a/drivers/input/serio/i8042-sparcio.h
> > +++ b/drivers/input/serio/i8042-sparcio.h
> > @@ -111,13 +111,17 @@ static int __init i8042_platform_init(void)
> >       struct device_node *root = of_find_node_by_path("/");
> >
> >       if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> > +             of_node_put(root);
> >               /* Hardcoded values for MrCoffee.  */
> >               i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
> >               kbd_iobase = ioremap(0x71300060, 8);
> >               if (!kbd_iobase)
> >                       return -ENODEV;
> >       } else {
> > -             int err = platform_driver_register(&sparc_i8042_driver);
> > +             int err;
> > +
> > +             of_node_put(root);
> > +             err = platform_driver_register(&sparc_i8042_driver);
> >               if (err)
> >                       return err;
>
> This is not really what I asked for, as in this version you left out
> leaky reference in i8042_platform_exit(). Please make the "detect Mr
> Coffee" function and use it in both i8042_platform_init() and
> i8042_platform_exit().
How about the newer?

Yours,
Yangtao
>
> Thanks.
>
> --
> Dmitry
