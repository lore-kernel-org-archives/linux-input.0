From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/2] drivers: base: swnode: link devices to software nodes
Date: Mon, 29 Jul 2019 15:07:15 +0300
Message-ID: <20190729120715.GA28600@kuha.fi.intel.com>
References: <20190713075259.243565-1-dmitry.torokhov@gmail.com>
 <20190713075259.243565-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190713075259.243565-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jul 13, 2019 at 12:52:58AM -0700, Dmitry Torokhov wrote:
> It is helpful to know what device, if any, a software node is tied to, so
> let's store a pointer to the device in software node structure. Note that
> children software nodes will inherit their parent's device pointer, so we
> do not have to traverse hierarchy to see what device the [sub]tree belongs
> to.
> 
> We will be using the device pointer to locate GPIO lookup tables for
> devices with static properties.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/property.c  |  1 +
>  drivers/base/swnode.c    | 35 ++++++++++++++++++++++++++++++++++-
>  include/linux/property.h |  5 +++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 348b37e64944..3bc93d4b35c4 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -527,6 +527,7 @@ int device_add_properties(struct device *dev,
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
>  
> +	software_node_link_device(fwnode, dev);
>  	set_secondary_fwnode(dev, fwnode);
>  	return 0;
>  }
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 7fc5a18e02ad..fd12eea539b6 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -24,6 +24,9 @@ struct software_node {
>  
>  	/* properties */
>  	const struct property_entry *properties;
> +
> +	/* device this node is associated with */
> +	struct device *dev;
>  };

Let's not do that! The nodes can be, and in many cases are, associated
with multiple devices.

Every device is already linked with the software node kobject, so
isn't it possible to simply walk trough those links in order to check
the devices associated with the node?


thanks,

-- 
heikki
