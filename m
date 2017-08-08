From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Mon, 7 Aug 2017 19:49:02 -0700
Message-ID: <20170808024902.GA12328@dtor-ws>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 07, 2017 at 11:03:53AM +0200, Linus Walleij wrote:
> On Tue, Aug 1, 2017 at 12:24 AM, Danilo Krummrich
> <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org> wrote:
> 
> > +config SERIO_GPIO_PS2
> > +       tristate "GPIO PS/2 bit banging driver"
> > +       help
> > +         Say Y here if you want PS/2 bit banging support via GPIO.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called gpio-ps2.
> > +
> > +         If you are unsure, say N.
> 
> As mentioned
> 
> depends on GPIOLIB
> depends on OF

I do not think this driver has to depend on OF. It should use gpiod and
generic device properties.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
