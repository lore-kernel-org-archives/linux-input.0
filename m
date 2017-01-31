From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Tue, 31 Jan 2017 09:04:32 +0100
Message-ID: <20170131090432.72a1b1b8@bbrezillon>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
        <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
        <20170131010607.GC35974@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170131010607.GC35974@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-input@vger.kernel.org

On Mon, 30 Jan 2017 17:06:07 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Jan 30, 2017 at 04:41:48PM +0100, Boris Brezillon wrote:
> > Rename devm_get_gpiod_from_child() into
> > devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> > function is operating on a fwnode object.  
> 
> I believe this is completely pointless rename. Are you planning on
> adding devm_of_get_gpiod_from_child()? Or
> devm_acpt_get_gpiod_from_child()? (I sure hope not).

Of course not.

> 
> Also, on what object? Does it take fwnode as first argument? Or maybe we
> should call it devm_dev_const_charp_fwnode_get_gpiod_from_child() so we
> know types of all arguments?

Linus suggested to rename this function [1]. I personally don't care
much about the name, though I agree with Linus that names should be
consistent and descriptive. Moreover, he's the maintainer, and I tend
to follow maintainers suggestion when I contribute to a specific
subsystem.

IIUC, you're concerned about the length of this function name. If I had
to drop something it would be the _from_child() suffix, because the
function is not even checking that the child parameter is actually a
direct child (or a descendant) of device->fwnode. Also, if we want to
be consistent with the rest of the GPIO API, we could rename it
devm_gpiod_get_from_fwnode() (with the function in added in patch 2
renamed into devm_gpiod_get_from_fwnode()).

Linus, what do you think?

One last thing, I don't want to start a discussion where we're
bikeshedding on a function name instead of focusing on the
functionality, so if it turns into this kind of discussion I'll
probably implement devm_fwnode_get_gpiod_from_child() directly in the
atmel NAND driver and wait for an agreement before switching to the
official version.

Regards,

Boris

[1]https://www.spinics.net/lists/arm-kernel/msg558986.html
