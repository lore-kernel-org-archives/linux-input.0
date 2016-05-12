From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 0/3] input: rmi4: Regulator supply support
Date: Wed, 11 May 2016 20:05:24 -0700
Message-ID: <20160512030524.GA1256@tuxbot>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
 <57312CFB.2040304@synaptics.com>
 <20160510154904.GI1256@tuxbot>
 <5733C088.1090700@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33174 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcELDF2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2016 23:05:28 -0400
Received: by mail-pa0-f47.google.com with SMTP id xk12so24495226pac.0
        for <linux-input@vger.kernel.org>; Wed, 11 May 2016 20:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5733C088.1090700@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Wed 11 May 16:30 PDT 2016, Andrew Duggan wrote:

> Hi Bjorn,
> 
> On 05/10/2016 08:49 AM, Bjorn Andersson wrote:
[..]
> >So either we duplicate the regulator support in spi/i2c or we make them
> >optional in the core driver. Sounds like you prefer the prior, i.e. v1
> >of my patch.
> 
> Yes, after all this I think it makes sense to put regulator support in the
> spi/i2c transports like in your v1 patch. I essentially duplicated the irq
> handling code in both transports so I would be ok with duplicating regulator
> support too. It doesn't seem like that much code. But, if this is too much
> duplication we could create some sort of common file and put the common irq
> and regulator support functions which could be called in the transports.
> Similar to how rmi_2d_sensor.c defines some common functions shared between
> rmi_f11 and rmi_f12.
> 

Sounds reasonable, I'm okay with this. Did you have any comments on the
implementation I had in v1?

@Dmitry, do you want me to resend v1?

Regards,
Bjorn
