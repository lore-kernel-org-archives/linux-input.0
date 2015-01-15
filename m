From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 21:00:37 +0100
Message-ID: <CAMuHMdXrRtgAahaEUh8x61E-koE25VL-6LOJrkjx4_fohKQtwQ@mail.gmail.com>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1421333655-31029-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdWmGi6qKKt5YJm1i7FqDceqKosxsSRJRd8zqXO9jMzyoQ@mail.gmail.com>
	<20150115185431.GG33214@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115185431.GG33214@dtor-ws>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 7:54 PM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I still do not understand what we are trying to fix here. Why is
> "adi,adxl34x" compatible string no good anymore? If we start using exact
> models and the physical device does not match do we abort probe? What is
> the problem that we are solving here?

Because there's no guarantee that the driver actually supports all
"adi,adxl34<x>" with <x> = 0..9, some of which don't exist yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
