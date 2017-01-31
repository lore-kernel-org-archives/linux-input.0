From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Tue, 31 Jan 2017 00:44:47 -0800
Message-ID: <20170131084447.GD8311@dtor-ws>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170131010607.GC35974@dtor-ws>
 <20170131090432.72a1b1b8@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35341 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdAaIwB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 03:52:01 -0500
Content-Disposition: inline
In-Reply-To: <20170131090432.72a1b1b8@bbrezillon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>

On Tue, Jan 31, 2017 at 09:04:32AM +0100, Boris Brezillon wrote:
> On Mon, 30 Jan 2017 17:06:07 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Mon, Jan 30, 2017 at 04:41:48PM +0100, Boris Brezillon wrote:
> > > Rename devm_get_gpiod_from_child() into
> > > devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> > > function is operating on a fwnode object.  
> > 
> > I believe this is completely pointless rename. Are you planning on
> > adding devm_of_get_gpiod_from_child()? Or
> > devm_acpt_get_gpiod_from_child()? (I sure hope not).
> 
> Of course not.
> 
> > 
> > Also, on what object? Does it take fwnode as first argument? Or maybe we
> > should call it devm_dev_const_charp_fwnode_get_gpiod_from_child() so we
> > know types of all arguments?
> 
> Linus suggested to rename this function [1]. I personally don't care
> much about the name, though I agree with Linus that names should be
> consistent and descriptive. Moreover, he's the maintainer, and I tend
> to follow maintainers suggestion when I contribute to a specific
> subsystem.

OK, I did not know that that was Linus' request, my objection still
stands.

> 
> IIUC, you're concerned about the length of this function name. If I had
> to drop something it would be the _from_child() suffix, because the
> function is not even checking that the child parameter is actually a
> direct child (or a descendant) of device->fwnode.

OK, that sounds better. Actually, we already have
fwnode_get_named_gpiod(), unfortunately it does not do suffixes
permutations. There are also no users, except
devm_get_gpiod_from_child(). So I would:

- rename fwnode_get_named_gpiod() -> static __fwnode_get_named_gpiod()
- made new fwnode_get_named_gpiod() that did suffix permutation and
  called __fwnode_get_named_gpiod() (or pulled its implementation
  inline)
- renamed devm_get_gpiod_from_child() ->
  devm_fwnode_get_named_gpiod(dev, fwnode, con_id)
  and called fwnode_get_named_gpiod().

This would indeed match the pattern with other fwnode/property handling
APIs.

Thanks.

-- 
Dmitry
