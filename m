From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Wed, 1 Feb 2017 14:22:28 +0100
Message-ID: <20170201142228.053e2041@bbrezillon>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
        <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
        <20170131010607.GC35974@dtor-ws>
        <20170131090432.72a1b1b8@bbrezillon>
        <20170131084447.GD8311@dtor-ws>
        <20170131100721.22c2388d@bbrezillon>
        <20170131091155.GH8311@dtor-ws>
        <20170131102424.7b68c0d4@bbrezillon>
        <20170131183936.GB13642@dtor-ws>
        <20170131204202.7b589ca6@bbrezillon>
        <CACRpkdbr6BGm3mJ_2XOAuootK-ruibiGsG8=LvKhrz1cpUrnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50868 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdBANWm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2017 08:22:42 -0500
In-Reply-To: <CACRpkdbr6BGm3mJ_2XOAuootK-ruibiGsG8=LvKhrz1cpUrnhA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>

Hi Linus,

On Wed, 1 Feb 2017 14:05:43 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Jan 31, 2017 at 8:42 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Tue, 31 Jan 2017 10:39:36 -0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:  
> 
> >> Hmm, yeah, I agree, that would be weird. Then let's leave
> >> devm_get_gpiod_from_child() as is ;)  
> >
> > Changing the internal implementation has never been the goal of this
> > patch. As explained in the commit log, I'm just renaming the function
> > to make it consistent with other fwnode functions (as suggested by
> > Linus).
> > What's happening here is exactly the kind of discussion I wanted to
> > avoid, and the reason I decided to not change the
> > devm_get_gpiod_from_child() prototype/name in the first place.
> >
> > Linus, is this something you really care about? If that's the case, can
> > you step in?  
> 
> I can only throw up my hands...

Sorry for forcing your hand like this, but this is the kind of
discussion I'm not comfortable with (when I need to argue on something
I'm not completely convinced of, or I don't have opinion on).

> The way I percieved it, a new function
> was added, but I guess it could be that the diffstat was so
> convoluted in the other patch (by the way that diff sometimes give
> very confusing stuff unless you use the right fuzz) so I misunderstood
> some other renaming as introducing a new function.

Indeed, a new function is added (see patch 2), and this new function is
taking an additional 'index' parameter. If that's a problem, I can also
change the prototype of devm_get_gpiod_from_child() and patch all
existing users of this function, but I fear we'll end up with pretty
much the same discussion :-/.

> 
> Please drop the patch if it is controversial.
> 
> The name of the function *is* confusing though but maybe it's not
> the biggest problem in the world.

I can still name the new function as you suggested
(devm_fwnode_get_index_gpiod_from_child()), and keep the existing one
unchanged if you want.

Just let me know what you prefer.

Thanks,

Boris
