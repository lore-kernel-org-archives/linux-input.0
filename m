From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Sat, 22 Mar 2014 17:51:32 +0100
Message-ID: <20140322165132.GC20668@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBPP6W2MQKGQERQOIG7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140318155919.GS25478@lee--X1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:
> > +static struct mfd_cell axp20x_cells[] = {
> > +	{
> > +		.name		= "axp20x-pek",
> > +		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
> > +		.resources	= axp20x_pek_resources,
> > +	}, {
> > +		.name		= "axp20x-regulator",
> > +	},
> > +};
> 
> nit: The format of these two structs are inconsistent.

Uhm, what do you mean?

> > +static int axp20x_i2c_probe(struct i2c_client *i2c,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct axp20x_dev *axp20x;
> > +	const struct of_device_id *of_id;
> > +	int ret;
> > +
> > +	axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
> > +	if (!axp20x)
> > +		return -ENOMEM;
> > +
> > +	of_id = of_match_device(axp20x_of_match, &i2c->dev);
> > +	if (!of_id) {
> > +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> > +		return -ENODEV;
> > +	}
> > +	axp20x->variant = (int) of_id->data;
> 
> No need to cast from void *.

My compiler says otherwise :)

> [...]
> 
> > +static const struct i2c_device_id axp20x_i2c_id[] = {
> > +	{ "axp202", AXP202_ID },
> > +	{ "axp209", AXP209_ID },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> 
> Isn't this redundant now that you're using of_id?

It is not. Even it is unused it has to be in the driver otherwise the
driver is not loaded. Probably it is something wrong in the I2C core.

Best,

-- 
Carlo Caione
