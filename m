From: Hans Holmberg <hans-syntQev1tZzUyQxjFilb4QC/G2K4zDHf@public.gmane.org>
Subject: Re: [RFC PATCH v2] Input: gpio_keys - add dt abs/rel button support
Date: Thu, 2 Feb 2017 16:04:21 +0100
Message-ID: <20170202150254.GA3682@Gaia>
References: <20170131075516.GA4462@Gaia>
 <20170201172531.cdhjrl4rfidgouul@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170201172531.cdhjrl4rfidgouul@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 01, 2017 at 11:25:31AM -0600, Rob Herring wrote:
> On Tue, Jan 31, 2017 at 08:55:19AM +0100, Hans Holmberg wrote:
> > +
> > +	gpio-joystick: {
> 
> Why do we need a whole new example?

I found it motivated to describe a use case with the new property, since
it is very different from "normal" keys(and I think there are enough
tac 2's out there that are waiting to be hooked up :).

If you think the new example is surperflous, I'll chuck it out.

Thanks,
Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
