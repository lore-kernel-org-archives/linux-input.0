From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v11 3/8] Input: goodix - write configuration data to
 device
Date: Fri, 20 Nov 2015 13:13:03 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F12029F@irsmsx105.ger.corp.intel.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
 <1447936001-21420-4-git-send-email-irina.tirdea@intel.com>
 <20151119182038.GA24773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151119182038.GA24773@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 19 November, 2015 20:21
> To: Tirdea, Irina
> Cc: Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Rob Herring; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v11 3/8] Input: goodix - write configuration data to device
> 
> On Thu, Nov 19, 2015 at 02:26:36PM +0200, Irina Tirdea wrote:
> > +	if (ts->gpiod_int && ts->gpiod_rst) {
> > +		/* update device config */
> > +		ts->cfg_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin",
> > +					 ts->id);
> 
> devm_kasprintf maybe (don't resubmit)?
> 

Yes, using devm_kasprintf would be better.

Thanks,
Irina

> Thanks.
> 
> --
> Dmitry
