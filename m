From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Wed, 1 Feb 2017 14:05:43 +0100
Message-ID: <CACRpkdbr6BGm3mJ_2XOAuootK-ruibiGsG8=LvKhrz1cpUrnhA@mail.gmail.com>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170131010607.GC35974@dtor-ws> <20170131090432.72a1b1b8@bbrezillon>
 <20170131084447.GD8311@dtor-ws> <20170131100721.22c2388d@bbrezillon>
 <20170131091155.GH8311@dtor-ws> <20170131102424.7b68c0d4@bbrezillon>
 <20170131183936.GB13642@dtor-ws> <20170131204202.7b589ca6@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170131204202.7b589ca6@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 31, 2017 at 8:42 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 31 Jan 2017 10:39:36 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

>> Hmm, yeah, I agree, that would be weird. Then let's leave
>> devm_get_gpiod_from_child() as is ;)
>
> Changing the internal implementation has never been the goal of this
> patch. As explained in the commit log, I'm just renaming the function
> to make it consistent with other fwnode functions (as suggested by
> Linus).
> What's happening here is exactly the kind of discussion I wanted to
> avoid, and the reason I decided to not change the
> devm_get_gpiod_from_child() prototype/name in the first place.
>
> Linus, is this something you really care about? If that's the case, can
> you step in?

I can only throw up my hands... The way I percieved it, a new function
was added, but I guess it could be that the diffstat was so
convoluted in the other patch (by the way that diff sometimes give
very confusing stuff unless you use the right fuzz) so I misunderstood
some other renaming as introducing a new function.

Please drop the patch if it is controversial.

The name of the function *is* confusing though but maybe it's not
the biggest problem in the world.

Yours,
Linus Walleij
