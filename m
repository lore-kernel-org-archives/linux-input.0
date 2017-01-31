From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: touchscreen: add driver for Zeitec ZET6223
Date: Tue, 31 Jan 2017 00:19:42 -0800
Message-ID: <20170131081942.GC8311@dtor-ws>
References: <20161223163214.7716-1-jelle@vdwaa.nl>
 <20170114191425.GA31309@dtor-ws>
 <20170118205712.GA5333@gmail.com>
 <20170118224946.GC11881@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170118224946.GC11881@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jelle,

On Wed, Jan 18, 2017 at 02:49:46PM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 18, 2017 at 09:57:14PM +0100, Jelle van der Waa wrote:
> > On 01/14/17 at 11:14am, Dmitry Torokhov wrote:
> > > > +
> > > > +static const struct of_device_id zet6223_of_match[] = {
> > > > +	{ .compatible = "zeitec", "zet6223" },
> > > 
> > > The compatible should be "zeitec,zet6223", what you have here is
> > > equivalent of:
> > > 
> > > 	{ .compatible = "zeitec", .data = "zet6223" },
> > 
> > Ah that was silly, thanks :)
> > 
> > > I also have been looking at you previosu submission and had some draft
> > > changes. I reconciled them in the patch below, if it still works for you
> > > then I'll fold everything together and apply. Please let me know.
> > 
> > I'll find some time to test the patch below, I've one small suggestion
> > to the patch below.

It would be very helpful if you let me know if the patch actually works
on the hardware: the merge window for 4.11 will be opening fairly soon.

Thanks!

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
