From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 0/3] input: rmi4: Regulator supply support
Date: Fri, 13 May 2016 15:29:48 -0700
Message-ID: <20160513222948.GD1256@tuxbot>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
 <57312CFB.2040304@synaptics.com>
 <20160510154904.GI1256@tuxbot>
 <5733C088.1090700@synaptics.com>
 <20160512030524.GA1256@tuxbot>
 <57352536.7040909@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34592 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbcEMW3x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 18:29:53 -0400
Received: by mail-pf0-f170.google.com with SMTP id y69so46239599pfb.1
        for <linux-input@vger.kernel.org>; Fri, 13 May 2016 15:29:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57352536.7040909@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu 12 May 17:52 PDT 2016, Andrew Duggan wrote:

> On 05/11/2016 08:05 PM, Bjorn Andersson wrote:
> >On Wed 11 May 16:30 PDT 2016, Andrew Duggan wrote:
> >
> >>Hi Bjorn,
> >>
> >>On 05/10/2016 08:49 AM, Bjorn Andersson wrote:
> >[..]
> >>>So either we duplicate the regulator support in spi/i2c or we make them
> >>>optional in the core driver. Sounds like you prefer the prior, i.e. v1
> >>>of my patch.
> >>Yes, after all this I think it makes sense to put regulator support in the
> >>spi/i2c transports like in your v1 patch. I essentially duplicated the irq
> >>handling code in both transports so I would be ok with duplicating regulator
> >>support too. It doesn't seem like that much code. But, if this is too much
> >>duplication we could create some sort of common file and put the common irq
> >>and regulator support functions which could be called in the transports.
> >>Similar to how rmi_2d_sensor.c defines some common functions shared between
> >>rmi_f11 and rmi_f12.
> >>
> >Sounds reasonable, I'm okay with this. Did you have any comments on the
> >implementation I had in v1?
> 
> I tested on a device which has an always on regulators so I didn't add
> anything to device tree for the device. But, it returned 0 when it didn't
> find anything which seems to be the correct behavior. Is there an easy way
> to avoid sleeping for 10ms when there are no regulators? Maybe check if both
> the supplies .consumer pointer is null?
> 

I did look at this as well, but unfortunately the regulators does not
come back as NULL, but rather as dummy regulators.

The delay matches Tpowerup (iirc) from the data sheet, which I assume is
firmware/hardware dependant. Should we provide a knob for that and
default the sleep to 0ms?

Regards,
Bjorn
