From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors
 from static properties
Date: Tue, 18 Sep 2018 12:02:19 +0300
Message-ID: <20180918090219.GE14465@lahna.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917181603.125492-5-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, Sep 17, 2018 at 11:16:02AM -0700, Dmitry Torokhov wrote:
> Now that static device properties understand notion of child nodes, let's
> teach gpiolib to tie such children and machine GPIO descriptor tables.
> We will continue using a single table for entire device, but instead of
> using connection ID as a lookup key in the GPIO descriptor table directly,
> we will perform additional translation: fwnode_get_named_gpiod() when
> dealing with property_set-backed fwnodes will try parsing string property
> with name matching connection ID and use result of the lookup as the key in
> the table:
> 
> static const struct property_entry dev_child1_props[] __initconst = {
> 	...
> 	PROPERTY_ENTRY_STRING("gpios",		"child-1-gpios"),
> 	{ }
> };
> 
> static struct gpiod_lookup_table dev_gpiod_table = {
> 	.dev_id = "some-device",
> 	.table = {
> 		...
> 		GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
> 		...
> 	},
> };

I wonder if instead of passing and parsing strings (and hoping there are
no typos) we could get the compiler to help us bit more?

Something like below:

static const struct property_entry dev_child1_props[] __initconst = {
 	...
 	PROPERTY_ENTRY_STRING("gpios","child-1-gpios"),
 	{ }
};
 
static struct gpiod_lookup_table dev_gpiod_table = {
 	.dev_id = "some-device",
 	.table = {
 		...
 		GPIO_LOOKUP_IDX("B", 1, dev_child1_props, SIZEOF(dev_child1_props),
				1, GPIO_ACTIVE_LOW),
 		...
 	},
};
