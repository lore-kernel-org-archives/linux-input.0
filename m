From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Thu, 20 Sep 2018 16:53:48 +0300
Message-ID: <20180920135348.GF11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917181603.125492-3-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> +/**
> + * device_add_child_properties - Add a collection of properties to a device object.
> + * @dev: Device to add properties to.

In case you didn't notice my comment for this, you are missing @parent
here.

But why do you need both the parent and the dev?

> + * @properties: Collection of properties to add.
> + *
> + * Associate a collection of device properties represented by @properties as a
> + * child of given @parent firmware node.  The function takes a copy of
> + * @properties.
> + */
> +struct fwnode_handle *
> +device_add_child_properties(struct device *dev,
> +			    struct fwnode_handle *parent,
> +			    const struct property_entry *properties)
> +{
> +	struct property_set *p;
> +	struct property_set *parent_pset;
> +
> +	if (!properties)
> +		return ERR_PTR(-EINVAL);
> +
> +	parent_pset = to_pset_node(parent);

For this function, the parent will in practice have to be
dev_fwnode(dev), so I don't think you need @parent at all, no?

There is something wrong here..

> +	if (!parent_pset)
> +		return ERR_PTR(-EINVAL);
> +
> +	p = pset_create_set(properties);
> +	if (IS_ERR(p))
> +		return ERR_CAST(p);
> +
> +	p->dev = dev;

That looks wrong.

I'm guessing the assumption here is that the child nodes will never be
assigned to their own devices, but you can't do that. It will limit
the use of the child nodes to a very small number of cases, possibly
only to gpios.

I think that has to be fixed. It should not be a big deal. Just expect
the child nodes to be removed separately, and add ref counting to the
struct property_set handling.

> +	p->parent = parent_pset;
> +	list_add_tail(&p->child_node, &parent_pset->children);
> +
> +	return &p->fwnode;
> +}
> +EXPORT_SYMBOL_GPL(device_add_child_properties);

The child nodes will change the purpose of the build-in property
support. Originally the goal was just to support adding of build-in
device properties to real firmware nodes, but things have changed
quite a bit from that. These child nodes are purely tied to the
build-in device property support, so we should be talking about adding
pset type child nodes to pset type parent nodes in the API:
fwnode_pset_add_child_node(), or something like that.

I'm sorry to be a bit of pain in the butt with this. The build-in
property support is a hack, it always was. A useful hack, but hack
nevertheless. That means we need to be extra careful when expanding
it, like here.


Thanks,

-- 
heikki
