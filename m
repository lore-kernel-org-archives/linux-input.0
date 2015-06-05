From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/9] input: goodix: write configuration data to device
Date: Fri, 5 Jun 2015 09:43:26 -0700
Message-ID: <20150605164326.GC26708@dtor-ws>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-7-git-send-email-irina.tirdea@intel.com>
 <20150528132133.GI23176@leverpostej>
 <1F3AC3675D538145B1661F571FE1805F19A773BB@irsmsx105.ger.corp.intel.com>
 <1433422507.5346.18.camel@hadess.net>
 <1F3AC3675D538145B1661F571FE1805F19A79DAD@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A79DAD@irsmsx105.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 05, 2015 at 04:36:24PM +0000, Tirdea, Irina wrote:
> 
> 
> > -----Original Message-----
> > From: Bastien Nocera [mailto:hadess@hadess.net]
> > Sent: 04 June, 2015 15:55
> > To: Tirdea, Irina
> > Cc: Mark Rutland; Dmitry Torokhov; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Purdila,
> > Octavian
> > Subject: Re: [PATCH 6/9] input: goodix: write configuration data to device
> > 
> > On Thu, 2015-05-28 at 13:51 +0000, Tirdea, Irina wrote:
> > >
> > > > -----Original Message-----
> > > > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > > > Sent: 28 May, 2015 16:22
> > > > To: Tirdea, Irina
> > > > Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > Purdila, Octavian
> > > > Subject: Re: [PATCH 6/9] input: goodix: write configuration data to
> > > > device
> > > >
> > > > On Thu, May 28, 2015 at 01:47:42PM +0100, Irina Tirdea wrote:
> > > > > Goodix devices can be configured by writing this information
> > > > > to the device at init. The configuration data can
> > > > > be provided through the ACPI/device tree property
> > > > > "device-config". If "device-config" is not set, the default
> > > > > device configuration will be used.
> > > > >
> > > > > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > > > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > > > ---
> > > > >  .../bindings/input/touchscreen/goodix.txt          |   5 +
> > > > >  drivers/input/touchscreen/goodix.c                 | 143
> > > > > +++++++++++++++++++++
> > > > >  2 files changed, 148 insertions(+)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > index 7137881..9e4ff69 100644
> > > > > ---
> > > > > a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > @@ -15,6 +15,11 @@ Required properties:
> > > > >   - irq-gpio              : GPIO pin used for IRQ
> > > > >   - reset-gpio            : GPIO pin used for reset
> > > > >
> > > > > +Optional properties:
> > > > > +
> > > > > + - device-config : device configuration information
> > > > > (specified as byte
> > > > > +                   array). Maximum size is 240 bytes.
> > > >
> > > > Generally we frown on passing opaque data.
> > > >
> > > > What exactly is encoded in device-config? The description is very
> > > > vague.
> > > >
> > > > Does this correspond to anything in a data sheet or manual?
> > >
> > > Yes, it is configuration data described in chapter 6.2. b of the
> > > datasheet:
> > > https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKN
> > > lktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing.
> > > This includes things like x/y resolution, maximum touch numbers
> > > supported,
> > > interrupt flags, various sensitivity factors.
> > >
> > > I should have included a link to the datasheet in the commit message
> > > - will do that in v2 for all patches.
> > >
> > > I did consider writing this as firmware, but it seems that some
> > > Goodix touchscreens have a
> > > real firmware they need to write in addition to this configuration
> > > data.
> > > If there is a better way to do this, please let me know and I will
> > > change it.
> > 
> > I would at least expect an excerpt from an ACPI DSDT that would make
> > use of that feature.
> 
> Ok, I will add this to the commit message.

No, it really shoudl be done via request_firmware() mechanism. There are
drivers in kernel that use request_firmware() for both firmware and
configuration data (see elan_i2c, elants_i2c, atmel_mxt_ts and I am sure
there are others).

Thanks.

-- 
Dmitry
