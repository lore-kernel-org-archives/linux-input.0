From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/2] Input: add support for the Samsung S6SY761
 touchscreen
Date: Fri, 3 Nov 2017 16:57:40 -0700
Message-ID: <20171103235740.cmdbenzsqts2mtsy@dtor-ws>
References: <20171102060726.3745-1-andi@etezian.org>
 <CGME20171102060735epcas1p15ac186761046eb93f467cd69161e7b50@epcas1p1.samsung.com>
 <20171102060726.3745-3-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171102060726.3745-3-andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Andi,

On Thu, Nov 02, 2017 at 03:07:26PM +0900, Andi Shyti wrote:
> +
> +	err = s6sy761_hw_init(sdata);
> +	if (err)
> +		return err;
> +
> +	sdata->input = devm_input_allocate_device(&client->dev);
> +	if (!sdata->input)
> +		return -ENOMEM;
> +
> +	sdata->input->name = S6SY761_DEV_NAME;
> +	sdata->input->id.bustype = BUS_I2C;
> +	sdata->input->open = s6sy761_input_open;
> +	sdata->input->close = s6sy761_input_close;
> +
> +	/* the range has been previously read in hw_init */
> +	if (sdata->prop.max_x && sdata->prop.max_y) {

You do not need make this a conditional, if sdata->prop.max_x or
sdata->prop.max_y is 0 is it OK.

However, there is a slight problem: you call hw_init() on resume,
potentially updating prop.max_x and prop.max_y and taking them out of
sync if they have been overridden by the DT data and
touchscreen_parse_properties(). I think it would be best if
s6sy761_hw_init() had 2 additional arguments for max_x and max_y and you
passed them to input_set_abs_params() and left sdata->prop to be managed
solely by touchscreen_parse_properties().

Also, is everything in s6sy761_hw_init() needed at resume time?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
