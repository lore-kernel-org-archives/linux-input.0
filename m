From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH] mc13xxx-ts: use zero as default value if no pdata was
 defined
Date: Wed, 14 Aug 2013 05:36:51 +0200
Message-ID: <20130814033651.GH9885@pengutronix.de>
References: <1376396070-24507-1-git-send-email-m.grzeschik@pengutronix.de>
 <20130813164609.GA21548@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130813164609.GA21548@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Dimitry,

On Tue, Aug 13, 2013 at 09:46:09AM -0700, Dmitry Torokhov wrote:
> Hi Michael,
> 
> On Tue, Aug 13, 2013 at 02:14:30PM +0200, Michael Grzeschik wrote:
> > In case of devicetree, we currently don't have a way to append pdata for
> > the touchscreen. The current approach is to bail out in that case.
> > This patch makes it possible to probe the touchscreen without pdata
> > and use zero as default values for the atox and ato adc conversion.
> 
> I'd rather you added the devicetree support to the driver.

I know that we will need real devictree glue that generates pdata in the
long run. I am working on that. Beside that, for now this patch makes
sense anyway.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
