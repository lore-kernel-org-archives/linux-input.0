From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Fri, 10 Feb 2017 15:02:35 +0200
Message-ID: <20170210130235.GH19313@lahna.fi.intel.com>
References: <20170122222015.GA31009@dtor-ws>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
 <20170201174257.GE40045@dtor-ws>
 <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
 <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com>
 <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
 <20170202131251.GQ2053@lahna.fi.intel.com>
 <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59551 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdBJNWH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Feb 2017 08:22:07 -0500
Content-Disposition: inline
In-Reply-To: <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Fri, Feb 10, 2017 at 12:52:41PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-02-17 14:12, Mika Westerberg wrote:
> > On Thu, Feb 02, 2017 at 01:50:58PM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 02-02-17 13:32, Mika Westerberg wrote:
> > > > On Thu, Feb 02, 2017 at 02:10:18PM +0200, Mika Westerberg wrote:
> > > > > I do not have a copy of the patch in this thread but sounds like
> > > > > something that might work.
> > > > 
> > > > Actually, I seem have a copy of that patch.
> > > > 
> > > > So you are saying that the device has a power GPIO in ACPI _CRS but it
> > > > should not be used for some reason?
> > > 
> > >                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Setti
> > >                 {
> > >                     Name (WBUF, ResourceTemplate ()
> > >                     {
> > >                         I2cSerialBusV2 (0x0040, ControllerInitiated, 0x00061A80,
> > >                             AddressingMode7Bit, "\\_SB.PCI0.I2C6",
> > >                             0x00, ResourceConsumer, , Exclusive,
> > >                             )
> > >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestri
> > >                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
> > >                             )
> > >                             {   // Pin list
> > >                                 0x0019
> > >                             }
> > >                         GpioInt (Edge, ActiveHigh, Shared, PullDefault, 0x0000,
> > >                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
> > >                             )
> > >                             {   // Pin list
> > >                                 0x0013
> > >                             }
> > >                     })
> > >                     Return (WBUF) /* \_SB_.PCI0.I2C6.TCS4._CRS.WBUF */
> > >                 }
> > > 
> > > The setting of the special bit in the gpio control register leads to
> > > drivers/pinctrl/intel/pinctrl-cherryview.c chv_gpio_request_enable()
> > > returning -EBUSY, which in return makes gpiod_get_optional
> > > return -EBUSY for this pin, rather then NULL (as we would like).
> > 
> > Actually what is wrong here is that your gpiod_get(dev, "power") falls
> > back to use plain indexes and returns the first GPIO even though it
> > should not as the driver specifically requests GPIO with name "power"
> > and there is no _DSD.
> > 
> > Andy (Cc'd) has a patch that tries to make the fallback mechanism more
> > stricter which should in theory fix the problem as well. The patch
> > series is here:
> > 
> > https://bitbucket.org/andy-shev/linux/commits/338c0226b631b8b497d143070a301d8b8883c349?at=master
> 
> Ok, that patches fixes the issues I was seeing with the silead driver
> on my cube iwork8 air cherrytrail tablet.

OK, good to hear. I suppose Andy can start cleaning up that branch and
send them for review then ;-)

> As discussed we might need some extra handling to fallback to actually
> get a gpio by index on some tablets which don't control the gpio from
> ACPI AML code, but lets cross that bridge when we get there.

Agreed.
