From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH 8/9] input: goodix: add support for ESD
Date: Thu, 30 Jul 2015 12:06:08 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0AC11D@irsmsx105.ger.corp.intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-9-git-send-email-irina.tirdea@intel.com>
 <20150528132353.GJ23176@leverpostej>
 <1F3AC3675D538145B1661F571FE1805F19A77432@irsmsx105.ger.corp.intel.com>
 <1433422675.5346.21.camel@hadess.net>
 <1F3AC3675D538145B1661F571FE1805F19A79DF9@irsmsx105.ger.corp.intel.com>
 <20150605164602.GD26708@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F19A7A4F8@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A7A4F8@irsmsx105.ger.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Tirdea, Irina
> Sent: 08 June, 2015 17:29
> To: Dmitry Torokhov
> Cc: Bastien Nocera; Mark Rutland; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 8/9] input: goodix: add support for ESD
> 
> 
> 
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: 05 June, 2015 19:46
> > To: Tirdea, Irina
> > Cc: Bastien Nocera; Mark Rutland; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 8/9] input: goodix: add support for ESD
> >
> > On Fri, Jun 05, 2015 at 04:37:49PM +0000, Tirdea, Irina wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Bastien Nocera [mailto:hadess@hadess.net]
> > > > Sent: 04 June, 2015 15:58
> > > > To: Tirdea, Irina
> > > > Cc: Mark Rutland; Dmitry Torokhov; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 8/9] input: goodix: add support for ESD
> > > >
> > > > On Thu, 2015-05-28 at 14:26 +0000, Tirdea, Irina wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: linux-input-owner@vger.kernel.org [mailto:
> > > > > > linux-input-owner@vger.kernel.org] On Behalf Of Mark Rutland
> > > > > > Sent: 28 May, 2015 16:24
> > > > > > To: Tirdea, Irina
> > > > > > Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org;
> > > > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH 8/9] input: goodix: add support for ESD
> > > > > >
> > > > > > On Thu, May 28, 2015 at 01:47:44PM +0100, Irina Tirdea wrote:
> > > > > > > Add ESD (Electrostatic Discharge) protection mechanism.
> > > > > > >
> > > > > > > The driver enables ESD protection in HW and checks a register
> > > > > > > to determine if ESD occurred. If ESD is signalled by the HW,
> > > > > > > the driver will reset the device.
> > > > > > >
> > > > > > > The ESD poll time (in ms) can be set through
> > > > > > > esd-recovery-timeout-ms ACPI/DT property. If it is set to 0,
> > > > > > > ESD protection is disabled.
> > > > > > >
> > > > > > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > > > > > ---
> > > > > > >  .../bindings/input/touchscreen/goodix.txt          |   4 +
> > > > > > >  drivers/input/touchscreen/goodix.c                 | 106
> > > > > > > ++++++++++++++++++++-
> > > > > > >  2 files changed, 106 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > index 9e4ff69..9132ee0 100644
> > > > > > > ---
> > > > > > > a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > @@ -19,6 +19,10 @@ Optional properties:
> > > > > > >
> > > > > > >   - device-config : device configuration information
> > > > > > > (specified as byte
> > > > > > >                     array). Maximum size is 240 bytes.
> > > > > > > + - esd-recovery-timeout-ms : ESD poll time (in milli seconds)
> > > > > > > for the driver to
> > > > > > > +                      check if ESD occurred and in that
> > > > > > > case reset the
> > > > > > > +                      device. ESD is disabled if this
> > > > > > > property is not set
> > > > > > > +                      or is set to 0.
> > > > > >
> > > > > > This sounds like software configuration rather than HW description.
> > > > > > Is
> > > > > > there any reason this needs to be a DT property?
> > > > > >
> > > > >
> > > > > Although this enables a software feature, it depends on the platform
> > > > > if electrostatic discharge
> > > > > protection should be enabled or not. Some platform designs handle ESD
> > > > > better and do not need
> > > > > the SW mechanism, so the property can be used to disable it.
> >
> > Even though it depends on the platform it describes software function,
> > not hardware. Since it is not necessary for starting the device maybe we
> > should indeed export it through sysfs and userspace board code should
> > activate it as needed?
> 
> Sure, I can do it through sysfs.
> The only confusing part is that the tsc2005 touchscreen driver uses the
> device tree property esd-recovery-timeout-ms.
> 
> >
> > I'll leave the decision to DT folks here.
> >
> 
> OK. I will keep this version of the esd patch in v2 and wait for an answer
> from DT folks so I know exactly how to handle it.
> 

Hi Mark, Dmitry,

We have been experimenting with the ESD property exported through sysfs
and found it difficult to use. We are testing this on Android tablets which
do not provide userspace code customized for each subvariant of the same
platform. So the only way for us to set specific parameters for each subvariant
is to specify this in ACPI or DT. 

I could keep the sysfs interface that exports the esd_timeout attribute, but
initialize its value to what ACPI/DT provides. As I mentioned before, I could
separate the esd enabling from the actual timeout if that makes more sense.

What do you think?

Thanks,
Irina


> Thanks,
> Irina
> 
> > Thanks.
> >
> > --
> > Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
