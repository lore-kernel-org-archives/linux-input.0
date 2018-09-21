From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Fri, 21 Sep 2018 16:31:19 -0700
Message-ID: <20180921233119.GA44099@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920135348.GF11965@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Heikki,

On Thu, Sep 20, 2018 at 04:53:48PM +0300, Heikki Krogerus wrote:
> Hi Dmitry,
> 
> On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> > +/**
> > + * device_add_child_properties - Add a collection of properties to a device object.
> > + * @dev: Device to add properties to.
> 
> In case you didn't notice my comment for this, you are missing @parent
> here.
> 
> But why do you need both the parent and the dev?

I could go by parent only and fetch dev from parent.

> 
> > + * @properties: Collection of properties to add.
> > + *
> > + * Associate a collection of device properties represented by @properties as a
> > + * child of given @parent firmware node.  The function takes a copy of
> > + * @properties.
> > + */
> > +struct fwnode_handle *
> > +device_add_child_properties(struct device *dev,
> > +			    struct fwnode_handle *parent,
> > +			    const struct property_entry *properties)
> > +{
> > +	struct property_set *p;
> > +	struct property_set *parent_pset;
> > +
> > +	if (!properties)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	parent_pset = to_pset_node(parent);
> 
> For this function, the parent will in practice have to be
> dev_fwnode(dev), so I don't think you need @parent at all, no?
> 
> There is something wrong here..

Yes, I expect majority of the calls will use dev_fwnode(dev) as parent,
but nobody stops you from doing:

	device_add_properties(dev, props);
	c1 = device_add_child_properties(dev, dev_fwnode(dev), cp1);
	c2 = device_add_child_properties(dev, c1, cp2);
	c3 = device_add_child_properties(dev, c2, cp3);
	...

> 
> > +	if (!parent_pset)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	p = pset_create_set(properties);
> > +	if (IS_ERR(p))
> > +		return ERR_CAST(p);
> > +
> > +	p->dev = dev;
> 
> That looks wrong.
> 
> I'm guessing the assumption here is that the child nodes will never be
> assigned to their own devices, but you can't do that. It will limit
> the use of the child nodes to a very small number of cases, possibly
> only to gpios.

If I need to assign a node to a device I'll use device_add_properties()
API. device_add_child_properties() is for nodes living "below" the
device.

All nodes (the primary/secondary and children) would point to the owning
device, just for convenience.

> 
> I think that has to be fixed. It should not be a big deal. Just expect
> the child nodes to be removed separately, and add ref counting to the
> struct property_set handling.

Why do we need to remove them separately and what do we need refcounting
for?

> 
> > +	p->parent = parent_pset;
> > +	list_add_tail(&p->child_node, &parent_pset->children);
> > +
> > +	return &p->fwnode;
> > +}
> > +EXPORT_SYMBOL_GPL(device_add_child_properties);
> 
> The child nodes will change the purpose of the build-in property
> support. Originally the goal was just to support adding of build-in
> device properties to real firmware nodes, but things have changed
> quite a bit from that. These child nodes are purely tied to the
> build-in device property support, so we should be talking about adding
> pset type child nodes to pset type parent nodes in the API:
> fwnode_pset_add_child_node(), or something like that.

OK, I can change device_add_child_properties() to
fwnode_pset_add_child_node() if Rafael would prefer this name.

Thanks.

-- 
Dmitry
