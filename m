From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add Qualcomm PM8941 power key driver
Date: Mon, 6 Oct 2014 19:50:57 -0700
Message-ID: <20141007025057.GA26419@dtor-glaptop>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20141007013001.GD39707@dtor-ws>
 <20141007015141.GG28481@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52102 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaJGCvA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Oct 2014 22:51:00 -0400
Content-Disposition: inline
In-Reply-To: <20141007015141.GG28481@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>

On Mon, Oct 06, 2014 at 06:52:51PM -0700, Bjorn Andersson wrote:
> On Mon 06 Oct 18:30 PDT 2014, Dmitry Torokhov wrote:
> 
> > Hi Bjorn,
> > 
> 
> Hi,
> 
> > On Mon, Oct 06, 2014 at 06:12:00PM -0700, Bjorn Andersson wrote:
> > > +
> > > +	rc = devm_request_threaded_irq(&pdev->dev, pwrkey->irq,
> > > +				NULL, pm8941_pwrkey_irq,
> > > +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> > 
> > Do we need to hard-code IRQ flags like this? I'd rather we respect DT
> > data.
> > 
> 
> We could "move" it to DT but I don't think there's any other combination of
> these flags would make sense. If you insist I can remove it though.

No, that's fine if you are certain we want to react on both edges always.

Thanks.

-- 
Dmitry
