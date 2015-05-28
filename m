From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH 6/9] input: goodix: write configuration data to device
Date: Thu, 28 May 2015 13:51:54 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A773BB@irsmsx105.ger.corp.intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-7-git-send-email-irina.tirdea@intel.com>
 <20150528132133.GI23176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62775 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbbE1NwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 09:52:01 -0400
In-Reply-To: <20150528132133.GI23176@leverpostej>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: 28 May, 2015 16:22
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> Purdila, Octavian
> Subject: Re: [PATCH 6/9] input: goodix: write configuration data to device
> 
> On Thu, May 28, 2015 at 01:47:42PM +0100, Irina Tirdea wrote:
> > Goodix devices can be configured by writing this information
> > to the device at init. The configuration data can
> > be provided through the ACPI/device tree property
> > "device-config". If "device-config" is not set, the default
> > device configuration will be used.
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  .../bindings/input/touchscreen/goodix.txt          |   5 +
> >  drivers/input/touchscreen/goodix.c                 | 143 +++++++++++++++++++++
> >  2 files changed, 148 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > index 7137881..9e4ff69 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > @@ -15,6 +15,11 @@ Required properties:
> >   - irq-gpio		: GPIO pin used for IRQ
> >   - reset-gpio		: GPIO pin used for reset
> >
> > +Optional properties:
> > +
> > + - device-config	: device configuration information (specified as byte
> > +			  array). Maximum size is 240 bytes.
> 
> Generally we frown on passing opaque data.
> 
> What exactly is encoded in device-config? The description is very vague.
> 
> Does this correspond to anything in a data sheet or manual?

Yes, it is configuration data described in chapter 6.2. b of the datasheet: 
https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing.
This includes things like x/y resolution, maximum touch numbers supported, 
interrupt flags, various sensitivity factors. 

I should have included a link to the datasheet in the commit message - will do that in v2 for all patches.

I did consider writing this as firmware, but it seems that some Goodix touchscreens have a
real firmware they need to write in addition to this configuration data.
If there is a better way to do this, please let me know and I will change it.

Thanks,
Irina

> 
> Mark.
