From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Tue, 31 Jan 2017 20:42:02 +0100
Message-ID: <20170131204202.7b589ca6@bbrezillon>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
        <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
        <20170131010607.GC35974@dtor-ws>
        <20170131090432.72a1b1b8@bbrezillon>
        <20170131084447.GD8311@dtor-ws>
        <20170131100721.22c2388d@bbrezillon>
        <20170131091155.GH8311@dtor-ws>
        <20170131102424.7b68c0d4@bbrezillon>
        <20170131183936.GB13642@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20170131183936.GB13642@dtor-ws>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-input@vger.kernel.org

On Tue, 31 Jan 2017 10:39:36 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, Jan 31, 2017 at 10:24:24AM +0100, Boris Brezillon wrote:
> > On Tue, 31 Jan 2017 01:11:55 -0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >   
> > > On Tue, Jan 31, 2017 at 10:07:21AM +0100, Boris Brezillon wrote:  
> > > > On Tue, 31 Jan 2017 00:44:47 -0800
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > >     
> > > > > On Tue, Jan 31, 2017 at 09:04:32AM +0100, Boris Brezillon wrote:    
> > > > > > On Mon, 30 Jan 2017 17:06:07 -0800
> > > > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > > >       
> > > > > > > On Mon, Jan 30, 2017 at 04:41:48PM +0100, Boris Brezillon wrote:      
> > > > > > > > Rename devm_get_gpiod_from_child() into
> > > > > > > > devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> > > > > > > > function is operating on a fwnode object.        
> > > > > > > 
> > > > > > > I believe this is completely pointless rename. Are you planning on
> > > > > > > adding devm_of_get_gpiod_from_child()? Or
> > > > > > > devm_acpt_get_gpiod_from_child()? (I sure hope not).      
> > > > > > 
> > > > > > Of course not.
> > > > > >       
> > > > > > > 
> > > > > > > Also, on what object? Does it take fwnode as first argument? Or maybe we
> > > > > > > should call it devm_dev_const_charp_fwnode_get_gpiod_from_child() so we
> > > > > > > know types of all arguments?      
> > > > > > 
> > > > > > Linus suggested to rename this function [1]. I personally don't care
> > > > > > much about the name, though I agree with Linus that names should be
> > > > > > consistent and descriptive. Moreover, he's the maintainer, and I tend
> > > > > > to follow maintainers suggestion when I contribute to a specific
> > > > > > subsystem.      
> > > > > 
> > > > > OK, I did not know that that was Linus' request, my objection still
> > > > > stands.
> > > > >     
> > > > > > 
> > > > > > IIUC, you're concerned about the length of this function name. If I had
> > > > > > to drop something it would be the _from_child() suffix, because the
> > > > > > function is not even checking that the child parameter is actually a
> > > > > > direct child (or a descendant) of device->fwnode.      
> > > > > 
> > > > > OK, that sounds better. Actually, we already have
> > > > > fwnode_get_named_gpiod(), unfortunately it does not do suffixes
> > > > > permutations. There are also no users, except
> > > > > devm_get_gpiod_from_child(). So I would:
> > > > > 
> > > > > - rename fwnode_get_named_gpiod() -> static __fwnode_get_named_gpiod()
> > > > > - made new fwnode_get_named_gpiod() that did suffix permutation and
> > > > >   called __fwnode_get_named_gpiod() (or pulled its implementation
> > > > >   inline)    
> > > > 
> > > > Sorry but I don't follow you. Why do you need
> > > > __fwnode_get_named_gpiod(),    
> > > 
> > > You do not need it, it will just reduce size of the patch if you use
> > > it. I'd be perfectly fine not with having it and have everything in
> > > fwnode_get_named_gpiod().  
> > 
> > Okay.
> >   
> > >   
> > > > and what is the suffix permutation you're
> > > > mentioning here?    
> > > 
> > > devm_get_gpiod_from_child() tries to apply "-gpio" and "-gpios" suffixes
> > > to the supplied GPIO ID while current fwnode_get_named_gpiod() takes
> > > property name literally.  
> > 
> > fwnode_get_named_gpiod() just mimics what of_get_named_gpiod_flags(),
> > acpi_node_get_gpiod(), of_find_gpio() and acpi_find_gpio() do. It would
> > be weird/inconsistent to have the con_id suffixing logic moved in the
> > fwnode_get_named_gpiod() (if that's what you're suggesting, but I'm not
> > sure it is).  
> 
> Hmm, yeah, I agree, that would be weird. Then let's leave
> devm_get_gpiod_from_child() as is ;)

Changing the internal implementation has never been the goal of this
patch. As explained in the commit log, I'm just renaming the function
to make it consistent with other fwnode functions (as suggested by
Linus).
What's happening here is exactly the kind of discussion I wanted to
avoid, and the reason I decided to not change the
devm_get_gpiod_from_child() prototype/name in the first place.

Linus, is this something you really care about? If that's the case, can
you step in?
