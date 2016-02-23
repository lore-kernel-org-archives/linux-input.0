From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Tue, 23 Feb 2016 09:54:14 -0800
Message-ID: <20160223175414.GA30638@dtor-ws>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
 <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
 <20160222195815.GB28343@dtor-ws>
 <20160223072950.GJ1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34950 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbcBWRyS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 12:54:18 -0500
Content-Disposition: inline
In-Reply-To: <20160223072950.GJ1770@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

On Tue, Feb 23, 2016 at 09:29:50AM +0200, Mika Westerberg wrote:
> On Mon, Feb 22, 2016 at 11:58:15AM -0800, Dmitry Torokhov wrote:
> > On Fri, Feb 19, 2016 at 11:16:22AM +0100, Geert Uytterhoeven wrote:
> > > @@ -887,7 +870,7 @@ static struct platform_driver gpio_keys_device_driver = {
> > >  	.driver		= {
> > >  		.name	= "gpio-keys",
> > >  		.pm	= &gpio_keys_pm_ops,
> > > -		.of_match_table = of_match_ptr(gpio_keys_of_match),
> > > +		.of_match_table = gpio_keys_of_match,
> > 
> > Why are we changing this? I think match table should still be guarded
> > by #ifdef CONFIG_OF.
> 
> This allows ACPI "PRP0001" ID to match DT .compatible strings in the
> gpio_keys_of_match[] table.

Ah, I see.

-- 
Dmitry
