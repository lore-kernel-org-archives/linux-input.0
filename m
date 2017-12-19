From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] touchscreen: mms114: add support for mms152
Date: Tue, 19 Dec 2017 18:10:09 +0900
Message-ID: <20171219091009.GD25647@gangnam.samsung>
References: <CGME20171218124955epcas3p3d776375b0dadbc3e0291da6ffb0eb6b6@epcas3p3.samsung.com>
        <20171218124933.1803-1-simon@lineageos.org>
        <20171219062252.GC25647@gangnam.samsung>
        <20171219080409.GA27703@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <20171219080409.GA27703-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Simon,

> > >  #ifdef CONFIG_OF
> > >  static const struct of_device_id mms114_dt_match[] = {
> > > -	{ .compatible = "melfas,mms114" },
> > > +	{
> > > +		.compatible = "melfas,mms114",
> > > +		.data = (void *)TYPE_MMS114,
> > > +	}, {
> > > +		.compatible = "melfas,mms152",
> > > +		.data = (void *)TYPE_MMS152,
> > 
> > You are not documenting the new "melfas,mms152" compatible in
> > Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> 
> Yes I am - "melfas,mms152" is added to the documentation
> as part of this patch. Is there something wrong with what I've done
> there?

Oh yes, sorry! I missed it while snipping the code :)

Please ignore this comment, then.

Andi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
