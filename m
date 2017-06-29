From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCHv3 4/4] hwmon: da9052: add support for TSI channel
Date: Thu, 29 Jun 2017 15:44:57 -0700
Message-ID: <20170629224457.GA4360@roeck-us.net>
References: <20170629124346.22325-1-sebastian.reichel@collabora.co.uk>
 <20170629124346.22325-5-sebastian.reichel@collabora.co.uk>
 <20170629184521.GA38388@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43252 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdF2WpB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 18:45:01 -0400
Content-Disposition: inline
In-Reply-To: <20170629184521.GA38388@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 29, 2017 at 11:45:21AM -0700, Dmitry Torokhov wrote:
> Hi Sebastian,
> 
> On Thu, Jun 29, 2017 at 02:43:46PM +0200, Sebastian Reichel wrote:
> > @@ -238,6 +239,14 @@ static int da9052_ts_probe(struct platform_device *pdev)
> >  	if (!da9052)
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * Check if touchscreen pins are used are analogue input instead
> > +	 * of having a touchscreen connected to them. The analogue input
> > +	 * functionality will be provided by hwmon driver (if enabled).
> > +	 */
> > +	if (device_property_read_bool(pdev->dev.parent, "dlg,tsi-as-adc"))
> > +		return -ENODEV;
> > +
> 
> I believe this is not the right way of doing this. da9052-core should
> simply forgo creating da9052-tsi platform device when this property is
> present.
> 
Agreed.

Guenter
