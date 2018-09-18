From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors
 from static properties
Date: Tue, 18 Sep 2018 10:04:18 -0700
Message-ID: <20180918170418.GC177805@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-5-dmitry.torokhov@gmail.com>
 <20180918090219.GE14465@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918090219.GE14465@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Mika,

On Tue, Sep 18, 2018 at 12:02:19PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 11:16:02AM -0700, Dmitry Torokhov wrote:
> > Now that static device properties understand notion of child nodes, let's
> > teach gpiolib to tie such children and machine GPIO descriptor tables.
> > We will continue using a single table for entire device, but instead of
> > using connection ID as a lookup key in the GPIO descriptor table directly,
> > we will perform additional translation: fwnode_get_named_gpiod() when
> > dealing with property_set-backed fwnodes will try parsing string property
> > with name matching connection ID and use result of the lookup as the key in
> > the table:
> > 
> > static const struct property_entry dev_child1_props[] __initconst = {
> > 	...
> > 	PROPERTY_ENTRY_STRING("gpios",		"child-1-gpios"),
> > 	{ }
> > };
> > 
> > static struct gpiod_lookup_table dev_gpiod_table = {
> > 	.dev_id = "some-device",
> > 	.table = {
> > 		...
> > 		GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
> > 		...
> > 	},
> > };
> 
> I wonder if instead of passing and parsing strings (and hoping there are
> no typos) we could get the compiler to help us bit more?
> 
> Something like below:
> 
> static const struct property_entry dev_child1_props[] __initconst = {
>  	...
>  	PROPERTY_ENTRY_STRING("gpios","child-1-gpios"),
>  	{ }
> };
>  
> static struct gpiod_lookup_table dev_gpiod_table = {
>  	.dev_id = "some-device",
>  	.table = {
>  		...
>  		GPIO_LOOKUP_IDX("B", 1, dev_child1_props, SIZEOF(dev_child1_props),
> 				1, GPIO_ACTIVE_LOW),
>  		...
>  	},
> };

I am not sure how that would work, as there are multiple properties in
that child array, so we can't simply take the first entry or assume that
all entries describe GPIOs. Here is the fuller example:

static const struct property_entry simone_key_enter_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code",	KEY_ENTER),
	PROPERTY_ENTRY_STRING("label",		"enter"),
	PROPERTY_ENTRY_STRING("gpios",		"enter-gpios"),
	{ }
};

static const struct property_entry simone_key_up_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code",	KEY_UP),
	PROPERTY_ENTRY_STRING("label",		"up"),
	PROPERTY_ENTRY_STRING("gpios",		"up-gpios"),
	{ }
};

static const struct property_entry simone_key_up_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code",	KEY_LEFT),
	PROPERTY_ENTRY_STRING("label",		"left"),
	PROPERTY_ENTRY_STRING("gpios",		"left-gpios"),
	{ }
};

static const struct property_entry simone_key_props[] __initconst = {
	/* There are no properties at device level on this device */
	{ }
};

static struct gpiod_lookup_table simone_keys_gpiod_table = {
	.dev_id = "gpio-keys",
	.table = {
		/* Use local offsets on gpiochip/port "B" */
		GPIO_LOOKUP_IDX("B", 0, "enter-gpios", 0, GPIO_ACTIVE_LOW),
		GPIO_LOOKUP_IDX("B", 1, "up-gpios", 1, GPIO_ACTIVE_LOW),
		GPIO_LOOKUP_IDX("B", 2, "left-gpios", 2, GPIO_ACTIVE_LOW),
	},
};

static struct platform_device simone_keys_device = {
	.name = "gpio-keys",
	.id = -1,
};

static void __init simone_init_machine(void)
{
	...
	gpiod_add_lookup_table(&simone_keys_gpiod_table);
	device_add_properties(&simone_keys_device.dev,
			      simone_keys_device_props);
	device_add_child_properties(&simone_keys_device.dev,
				    dev_fwnode(&simone_keys_device.dev),
				    simone_key_enter_props);
	device_add_child_properties(&simone_keys_device.dev,
				    dev_fwnode(&simone_keys_device.dev),
				    simone_key_up_props);
	device_add_child_properties(&simone_keys_device.dev,
				    dev_fwnode(&simone_keys_device.dev),
				    simone_key_left_props);
	platform_device_register(&simone_keys_device);
	...
}

Thanks.

-- 
Dmitry
