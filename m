From: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Subject: Re: [PATCH] touchscreen: mms114: add support for mms152
Date: Tue, 19 Dec 2017 19:04:09 +1100
Message-ID: <20171219080409.GA27703@lineageos.org>
References: <CGME20171218124955epcas3p3d776375b0dadbc3e0291da6ffb0eb6b6@epcas3p3.samsung.com>
 <20171218124933.1803-1-simon@lineageos.org>
 <20171219062252.GC25647@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171219062252.GC25647-8vUhnHFVuGn35fTxX1Dczw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Andi,

Thanks for the review.

On Tue, Dec 19, 2017 at 03:22:52PM +0900, Andi Shyti wrote:
> Hi Simon,
> 
> > +	if (data->pdata->type == TYPE_MMS152) {
> > +		/* MMS152 has no configuration or power on registers */
> > +		return 0;
> > +	}
> > +
> 
> Please drop the brackets here accorting to the
> Documentation/process/coding-style.rst file.
> 
> > +	pdata->type = (enum mms_type)of_device_get_match_data(dev);
> > +
> >  	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
> >  		dev_err(dev, "failed to get x-size property\n");
> >  		return NULL;
> > @@ -411,6 +437,7 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
> >  	if (of_find_property(np, "y-invert", NULL))
> >  		pdata->y_invert = true;
> >  
> > +
> 
> Please do not add extra lines
> 
> >  	return pdata;
> >  }
> >  #else
> > @@ -456,7 +483,15 @@ static int mms114_probe(struct i2c_client *client,
> >  	data->input_dev = input_dev;
> >  	data->pdata = pdata;
> >  
> > -	input_dev->name = "MELFAS MMS114 Touchscreen";
> > +	switch (pdata->type) {
> > +	case TYPE_MMS114:
> > +		input_dev->name = "MELFAS MMS114 Touchscreen";
> > +		break;
> > +	case TYPE_MMS152:
> > +		input_dev->name = "MELFAS MMS152 Touchscreen";
> > +		break;
> > +	}
> > +
> >  	input_dev->id.bustype = BUS_I2C;
> >  	input_dev->dev.parent = &client->dev;
> >  	input_dev->open = mms114_input_open;
> > @@ -569,7 +604,13 @@ MODULE_DEVICE_TABLE(i2c, mms114_id);
> >  
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id mms114_dt_match[] = {
> > -	{ .compatible = "melfas,mms114" },
> > +	{
> > +		.compatible = "melfas,mms114",
> > +		.data = (void *)TYPE_MMS114,
> > +	}, {
> > +		.compatible = "melfas,mms152",
> > +		.data = (void *)TYPE_MMS152,
> 
> You are not documenting the new "melfas,mms152" compatible in
> Documentation/devicetree/bindings/input/touchscreen/mms114.txt

Yes I am - "melfas,mms152" is added to the documentation
as part of this patch. Is there something wrong with what I've done
there?

> 
> Andi

I will send a v2 addressing the style issues.

Cheers,
Simon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
