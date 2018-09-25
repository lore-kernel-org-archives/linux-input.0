From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Tue, 25 Sep 2018 15:19:27 +0300
Message-ID: <20180925121927.GL11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
 <20180924184543.GB156847@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924184543.GB156847@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 24, 2018 at 11:45:43AM -0700, Dmitry Torokhov wrote:
> I think we are talking about totally different use cases and that is why
> we are having hard time coming to a mutually agreeable solution. Could
> you please describe in more detail what you would like to achieve,
> and preferably show how it is described now with DT and/or ACPI, so that
> I have a better frame of reference.

Yes, of course. Sorry.

USB ports are devices that usually the USB controller drivers register
(or actually the USB core code). They are represented in both ACPI and
DT as child nodes of the controller device node. The USB connector OF
node is defined in file
Documentation/devicetree/bindings/connector/usb-connector.txt

In short, the controller drivers will request handle to a child node
that represents a port, and only after that register the actual port
device.

The drivers I'm looking at currently are the USB Type-C port
controller drivers and the port manager (in Greg's usb-next or
linux-next):

        drivers/usb/typec/tcpm/tcpci.c
        drivers/usb/typec/tcpm/fusb302.c
        drivers/usb/typec/tcpm/tcpm.c

The goal is simply to get rid of the platform data as usual, and
ideally so that we don't need any extra code in order to support the
"legacy" platforms.


Thanks,

-- 
heikki
