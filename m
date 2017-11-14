From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Tue, 14 Nov 2017 10:39:36 +0000
Message-ID: <20171114103936.4mzcmxuear5kxrtt@dell>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111175059.lwfhw2wdhlj5yxhc@dtor-ws>
 <20171112121235.GO11226@localhost>
 <20171113091144.5oz77shbu4oupoy7@dell>
 <20171113093544.GR11226@localhost>
 <20171113102028.c53rlcnwrjaey2tv@dell>
 <20171113115102.GU11226@localhost>
 <20171113215452.hqjvxjbef4dt5647@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55076 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbdKNKjk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 05:39:40 -0500
Received: by mail-wm0-f48.google.com with SMTP id r68so20977059wmr.3
        for <linux-input@vger.kernel.org>; Tue, 14 Nov 2017 02:39:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171113215452.hqjvxjbef4dt5647@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Marek Belisko <marek@goldelico.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org

On Mon, 13 Nov 2017, Dmitry Torokhov wrote:

> On Mon, Nov 13, 2017 at 12:51:02PM +0100, Johan Hovold wrote:
> > On Mon, Nov 13, 2017 at 10:20:28AM +0000, Lee Jones wrote:
> > > On Mon, 13 Nov 2017, Johan Hovold wrote:
> > > 
> > > > On Mon, Nov 13, 2017 at 09:11:44AM +0000, Lee Jones wrote:
> > > > > On Sun, 12 Nov 2017, Johan Hovold wrote:
> > > > > 
> > > > > > [ +CC: Lee, Rob and device-tree list ]
> > > > > > 
> > > > > > On Sat, Nov 11, 2017 at 09:50:59AM -0800, Dmitry Torokhov wrote:
> > > > > > > On Sat, Nov 11, 2017 at 04:43:37PM +0100, Johan Hovold wrote:
> > > > > > > > A helper purported to look up a child node based on its name was using
> > > > > > > > the wrong of-helper and ended up prematurely freeing the parent of-node
> > > > > > > > while searching the whole device tree depth-first starting at the parent
> > > > > > > > node.
> > > > > > > 
> > > > > > > Ugh, this all is pretty ugly business. Can we teach MFD to allow
> > > > > > > specifying firmware node to be attached to the platform devices it
> > > > > > > creates in mfd_add_device() so that the leaf drivers simply call
> > > > > > > device_property_read_XXX() on their own device and not be bothered with
> > > > > > > weird OF refcount issues or what node they need to locate and parse?
> > > > > 
> > > > > If a child compatible is provided, we already set the child's
> > > > > of_node.  It's then up to the driver (set) author(s) to use it in the
> > > > > correct manner. 
> > > > > 
> > > > > > Yeah, that may have helped. You can actually specify a compatible string
> > > > > > in struct mfd_cell today which does make mfd_add_device() associate a
> > > > > > matching child node.
> > > > > > 
> > > > > > Some best practice regarding how to deal with MFD and device tree would
> > > > > > be good to determine and document too. For example, when should
> > > > > > of_platform_populate() be used in favour of mfd_add_device()?
> > > > > 
> > > > > When the device supports DT and its entire hierarchical layout, along
> > > > > with all of its attributes can be expressed in DT.
> > > > 
> > > > Ok, a follow up: When there are different variants of an MFD and that
> > > > affects the child drivers, then that should be expressed in in the child
> > > > node compatibles rather than having the child match on the parent node?
> > > > 
> > > > I'm asking because this came up recently during review and their seems
> > > > to be no precedent for matching on the parent compatible in child
> > > > drivers:
> > > > 
> > > > 	https://lkml.kernel.org/r/20171105154725.GA11226@localhost
> > > 
> > > Accessing the parent's of_device_id .data directly doesn't sit well
> > > with me.  The parent driver should pass this type of configuration
> > > though pdata IMHO.
> > 
> > The child driver is only matching on the parent-node compatible string
> > IIRC, and therefore keeps its own table of all parent compatibles with
> > its own set of (child) private match data (i.e. the parent compatible
> > property is matched first by the parent driver, and then again by the
> > child).
> > 
> > Passing through pdata here is not possible since mfd_add_device() isn't
> > used, right? It could of course be described using properties of the
> > child node (e.g. by using different child compatible strings).
> > 
> > > > > > And how best to deal with sibling nodes, which is part of the problem
> > > > > > here (I think the mfd should have provided a flag rather than having
> > > > > > subdrivers deal with sibling nodes, for example).
> > > > > 
> > > > > I disagree.  The only properties the MFD (parent) driver is interested
> > > > > in is ones which are shared across multiple child devices.
> > > > > *Everything* which pertains to only a single child device should be
> > > > > handled by its accompanying driver. 
> > > > 
> > > > Even if that means leaking details of one child driver into a sibling?
> > > 
> > > Not sure what you mean here.  Could you please elaborate or provide an
> > > example?
> > 
> > I mean that the sibling node needs to be aware of the name, compatible
> > string, or other node properties of its sibling node to be able to parse
> > sibling nodes itself (rather than the sibling or parent doing so on its
> > behalf). But it seems you answer this below.
> > 
> > > > Isn't it then cleaner to use the parent MFD to coordinate between the
> > > > cells, just as we do for IO?
> > > > 
> > > > In this case a child driver looked up a sibling node based on name, but
> > > 
> > > This should not be allowed.  If >1 sibling requires access to a
> > > particular property, this is normally evidence enough that this
> > > property should be shared and handled by the parent.
> > > 
> > > > that doesn't mean the node is active, that there's a driver bound, or
> > > > that the sibling node has some other random property for example. The
> > > > parent could be used for such coordination, if only to pass information
> > > > from one sibling to another.
> > > 
> > > Right.
> > 
> > Ok, it seems we're in agreement here.
> > 
> > Given that MFD has evolved over time and device-tree support has been
> > added retroactively to some drivers, we've ended up with a multitude of
> > different ways of dealing with such issues. I think it may still be a
> > good idea to jot down some best practices for future driver developers.
> 
> FWIW here is the patch allowing attaching fwnode to an MFD cell that is
> not using of_compatible (because if historical reasons). Completely
> untested as I do not have this hardware.

I am not familiar with the device_* OF implementation, so find it
hard to provide a solid, knowledgeable review.  It looks okay in
principle.

I'd appreciate it if Rob or one of the other DT guys could cast an
eye though.

> If this is somewhat acceptable I can untangle core from twl6040
> changes.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
