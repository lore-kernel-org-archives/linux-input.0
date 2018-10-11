From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Thu, 11 Oct 2018 11:18:19 +0300
Message-ID: <20181011081819.GB24771@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
 <20180924184543.GB156847@dtor-ws>
 <20180925121927.GL11965@kuha.fi.intel.com>
 <20181005214734.GC215120@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005214734.GC215120@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Sorry for the late reply. I decided to give this a try myself, and
I've now prepared something (not for the gpio stuff!). I'll do a quick
internal review round, and send it to you guys as RFC after that..

On Fri, Oct 05, 2018 at 02:47:34PM -0700, Dmitry Torokhov wrote:
> Hi Heikki,
> 
> On Tue, Sep 25, 2018 at 03:19:27PM +0300, Heikki Krogerus wrote:
> > On Mon, Sep 24, 2018 at 11:45:43AM -0700, Dmitry Torokhov wrote:
> > > I think we are talking about totally different use cases and that is why
> > > we are having hard time coming to a mutually agreeable solution. Could
> > > you please describe in more detail what you would like to achieve,
> > > and preferably show how it is described now with DT and/or ACPI, so that
> > > I have a better frame of reference.
> > 
> > Yes, of course. Sorry.
> > 
> > USB ports are devices that usually the USB controller drivers register
> > (or actually the USB core code). They are represented in both ACPI and
> > DT as child nodes of the controller device node. The USB connector OF
> > node is defined in file
> > Documentation/devicetree/bindings/connector/usb-connector.txt
> > 
> > In short, the controller drivers will request handle to a child node
> > that represents a port, and only after that register the actual port
> > device.
> > 
> > The drivers I'm looking at currently are the USB Type-C port
> > controller drivers and the port manager (in Greg's usb-next or
> > linux-next):
> > 
> >         drivers/usb/typec/tcpm/tcpci.c
> >         drivers/usb/typec/tcpm/fusb302.c
> >         drivers/usb/typec/tcpm/tcpm.c
> > 
> > The goal is simply to get rid of the platform data as usual, and
> > ideally so that we don't need any extra code in order to support the
> > "legacy" platforms.
> 
> Are these actually used on any of the "legacy" platforms? I fetched
> linux-next today, but I do not actually see anything in
> drivers/usb/typec touching platform data...

It's not touching any platform data, and I would like to keep it that
way :-). The device for fusb302 is created for example in
drivers/platform/x86/intel_cht_int33fe.c.

The fusb302.c driver already tries to find that child node named
"connector" (and so do the other port drivers). I'm trying to supply
the driver that node here somehow so I can avoid quirks.

> In the context of the connector, even before we descend to child nodes
> details, how do you propose implementing references between fwnodes?
> Especially since the other node (in case you complementing existing
> topology) may be ACPI or DT instance?

The different fwnode types (ACPI, OF, etc.) must live in parallel,
i.e. you can not have something like ACPI parent node with
property_set children if that's what you mean. The "secondary" member
will link the different types of fwnodes together, but they will live
their separate lives. I'm not planning on changing that.

I'm just looking for a smooth way of describing the devices in
software when the firmware is not supplying the hardware description,
just like you. What I really need is separation of the fwnode
registration from device registration in those cases. For that I now
have a proposal, and I believe my proposal will work for you as a
baseline as well.


Thanks,

-- 
heikki
