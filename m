From: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
Subject: Re: [PATCH 1/2] input: touchscreen: add driver for Zeitec ZET6223
Date: Wed, 18 Jan 2017 21:57:14 +0100
Message-ID: <20170118205712.GA5333@gmail.com>
References: <20161223163214.7716-1-jelle@vdwaa.nl>
 <20170114191425.GA31309@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170114191425.GA31309@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 01/14/17 at 11:14am, Dmitry Torokhov wrote:
> > +
> > +static const struct of_device_id zet6223_of_match[] = {
> > +	{ .compatible = "zeitec", "zet6223" },
> 
> The compatible should be "zeitec,zet6223", what you have here is
> equivalent of:
> 
> 	{ .compatible = "zeitec", .data = "zet6223" },

Ah that was silly, thanks :)

> I also have been looking at you previosu submission and had some draft
> changes. I reconciled them in the patch below, if it still works for you
> then I'll fold everything together and apply. Please let me know.

I'll find some time to test the patch below, I've one small suggestion
to the patch below.

> +	ts->fingernum = buf[15] & 0x7F;
> +	if (ts->fingernum > ZET6223_MAX_FINGERS) {
> +		dev_warn(&ts->client->dev,
> +			 "touchpanel reports %d fingers, limiting to %d\n",
> +			 ts->fingernum, ZET6223_MAX_FINGERS);
> +		ts->fingernum = 16;

Maybe use ZET6223_MAX_FINGERS?

-- 
Jelle van der Waa
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
