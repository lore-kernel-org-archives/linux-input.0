From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Mon, 19 Oct 2015 14:32:24 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F101AC0@irsmsx105.ger.corp.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1444663477-30062-3-git-send-email-irina.tirdea@intel.com>
 <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
 <20151013100724.GG1492@lahna.fi.intel.com> <20151014062303.GC20406@dtor-ws>
 <20151014111820.GV1492@lahna.fi.intel.com>
 <20151014134403.GA25691@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38202 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbbJSOcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 10:32:32 -0400
In-Reply-To: <20151014134403.GA25691@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Dolca, Robert" <robert.dolca@intel.com>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of
> mika.westerberg@linux.intel.com
> Sent: 14 October, 2015 16:44
> To: Dmitry Torokhov
> Cc: Tirdea, Irina; Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
> 
> On Wed, Oct 14, 2015 at 02:18:20PM +0300, mika.westerberg@linux.intel.com wrote:
> > On Tue, Oct 13, 2015 at 11:23:03PM -0700, Dmitry Torokhov wrote:
> > > I understand why one might use acpi_dev_add_driver_gpios() to augment
> > > data in ACPI, however here we have completely different issue: driver
> > > that expects named gpios gets returned gpio that has nothing to do with
> > > what it requested, because gpiolib acpi code always falls back to
> > > unnamed gpio if it does not find named gpio. That can be acceptable if
> > > driver uses the same con_id for all requests to gpiolib, but is not
> > > working when driver supplies different con_ids.
> >
> > Right, the ACPI fallback ignores con_id completely and uses only the
> > index.
> >
> > AFAIK there is only one driver using ACPI _CRS index method:
> > sdhci-[acpi|pci].c. If we can convert that to use acpi_dev_add_driver_gpios()
> > to feed names for card detection GPIOs, I think we can remove the
> > fallback alltogether in favor of named GPIOs for ACPI.
> 
> Nah, there seems to be several drivers relying on this already :-/

Would it be possible to add an optional parameter to the GPIO API
to specify whether we want to fall back to indexed GPIOs for ACPI?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
