From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Mon, 24 Sep 2018 11:45:43 -0700
Message-ID: <20180924184543.GB156847@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924132050.GK11965@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 24, 2018 at 04:20:50PM +0300, Heikki Krogerus wrote:
> Hi Dmitry,
> 
> On Fri, Sep 21, 2018 at 04:31:19PM -0700, Dmitry Torokhov wrote:
> > > > +	if (!parent_pset)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +
> > > > +	p = pset_create_set(properties);
> > > > +	if (IS_ERR(p))
> > > > +		return ERR_CAST(p);
> > > > +
> > > > +	p->dev = dev;
> > > 
> > > That looks wrong.
> > > 
> > > I'm guessing the assumption here is that the child nodes will never be
> > > assigned to their own devices, but you can't do that. It will limit
> > > the use of the child nodes to a very small number of cases, possibly
> > > only to gpios.
> > 
> > If I need to assign a node to a device I'll use device_add_properties()
> > API. device_add_child_properties() is for nodes living "below" the
> > device.
> 
> device_add_properties() is not available to us before we have the
> actual struct device meant for the properties. If the child device is
> populated outside of the "boardfiles" then we have to be able to link
> it to the child node afterwards.

I think we are talking about totally different use cases and that is why
we are having hard time coming to a mutually agreeable solution. Could
you please describe in more detail what you would like to achieve,
and preferably show how it is described now with DT and/or ACPI, so that
I have a better frame of reference.

Thanks.

-- 
Dmitry
