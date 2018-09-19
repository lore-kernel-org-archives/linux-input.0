From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Wed, 19 Sep 2018 10:13:26 -0700
Message-ID: <20180919171326.GB116719@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180919151026.GB11965@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180919151026.GB11965@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Heikki,

On Wed, Sep 19, 2018 at 06:10:26PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> > Several drivers rely on having notion of sub-nodes when describing
> > hardware, let's allow static board-defined properties also have it.
> > 
> > The board files will then attach properties to devices in the following
> > fashion:
> > 
> > 	device_add_properties(&board_platform_device.dev,
> > 			      main_device_props);
> > 	device_add_child_properties(&board_platform_device.dev,
> > 				    dev_fwnode(&board_platform_device.dev),
> > 				    child1_device_props);
> > 	device_add_child_properties(&board_platform_device.dev,
> > 				    dev_fwnode(&board_platform_device.dev),
> > 				    child2_device_props);
> > 	...
> > 	platform_device_register(&board_platform_device.dev);
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/base/pset_property.c | 110 +++++++++++++++++++++++++++++++----
> >  include/linux/property.h     |   4 ++
> >  2 files changed, 102 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> > index 08ecc13080ae..63f2377aefe8 100644
> > --- a/drivers/base/pset_property.c
> > +++ b/drivers/base/pset_property.c
> > @@ -18,6 +18,11 @@ struct property_set {
> >  	struct device *dev;
> >  	struct fwnode_handle fwnode;
> >  	const struct property_entry *properties;
> > +
> > +	struct property_set *parent;
> > +	/* Entry in parent->children list */
> > +	struct list_head child_node;
> > +	struct list_head children;
> 
> Add
> 
>         const char *name;
> 
> and you can implement also pset_get_named_child_node().

Or
	char name[];

to avoid separate allocation.

Alternatively, we can add it later when we need it, and add
device_add_named_child_properties().

I'll leave it up to Rafael to decide.

Thanks.

-- 
Dmitry
