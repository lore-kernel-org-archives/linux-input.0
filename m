From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Thu, 20 Sep 2018 13:16:48 +0300
Message-ID: <20180920101648.GC11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180919151026.GB11965@kuha.fi.intel.com>
 <20180919171326.GB116719@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180919171326.GB116719@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 19, 2018 at 10:13:26AM -0700, Dmitry Torokhov wrote:
> > > diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> > > index 08ecc13080ae..63f2377aefe8 100644
> > > --- a/drivers/base/pset_property.c
> > > +++ b/drivers/base/pset_property.c
> > > @@ -18,6 +18,11 @@ struct property_set {
> > >  	struct device *dev;
> > >  	struct fwnode_handle fwnode;
> > >  	const struct property_entry *properties;
> > > +
> > > +	struct property_set *parent;
> > > +	/* Entry in parent->children list */
> > > +	struct list_head child_node;
> > > +	struct list_head children;
> > 
> > Add
> > 
> >         const char *name;
> > 
> > and you can implement also pset_get_named_child_node().
> 
> Or
> 	char name[];
> 
> to avoid separate allocation.

Let's not do that, especially if you are planning on exporting this
structure. If the name is coming from .rodata, there is no need to
allocate anything for the name. Check kstrdup_const().

> Alternatively, we can add it later when we need it, and add
> device_add_named_child_properties().
> 
> I'll leave it up to Rafael to decide.

Fair enough.


Thanks,

-- 
heikki
