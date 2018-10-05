From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Fri, 5 Oct 2018 14:47:34 -0700
Message-ID: <20181005214734.GC215120@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
 <20180924184543.GB156847@dtor-ws>
 <20180925121927.GL11965@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925121927.GL11965@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Heikki,

On Tue, Sep 25, 2018 at 03:19:27PM +0300, Heikki Krogerus wrote:
> On Mon, Sep 24, 2018 at 11:45:43AM -0700, Dmitry Torokhov wrote:
> > I think we are talking about totally different use cases and that is why
> > we are having hard time coming to a mutually agreeable solution. Could
> > you please describe in more detail what you would like to achieve,
> > and preferably show how it is described now with DT and/or ACPI, so that
> > I have a better frame of reference.
> 
> Yes, of course. Sorry.
> 
> USB ports are devices that usually the USB controller drivers register
> (or actually the USB core code). They are represented in both ACPI and
> DT as child nodes of the controller device node. The USB connector OF
> node is defined in file
> Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> In short, the controller drivers will request handle to a child node
> that represents a port, and only after that register the actual port
> device.
> 
> The drivers I'm looking at currently are the USB Type-C port
> controller drivers and the port manager (in Greg's usb-next or
> linux-next):
> 
>         drivers/usb/typec/tcpm/tcpci.c
>         drivers/usb/typec/tcpm/fusb302.c
>         drivers/usb/typec/tcpm/tcpm.c
> 
> The goal is simply to get rid of the platform data as usual, and
> ideally so that we don't need any extra code in order to support the
> "legacy" platforms.

Are these actually used on any of the "legacy" platforms? I fetched
linux-next today, but I do not actually see anything in
drivers/usb/typec touching platform data...

In the context of the connector, even before we descend to child nodes
details, how do you propose implementing references between fwnodes?
Especially since the other node (in case you complementing existing
topology) may be ACPI or DT instance?

I want to say that "You aren't gonna need it" for what you are asking
here and we can actually split it apart if and when we actually want to
separate creation of pset-backed device nodes and instantiating
corresponding device structures.

Thanks.

-- 
Dmitry
