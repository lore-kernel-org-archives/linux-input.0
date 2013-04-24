From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH] input: egalax_ts: remove bogus OF dependency
Date: Wed, 24 Apr 2013 08:58:27 +0300
Message-ID: <1366783107.21369.0.camel@sauron.fi.intel.com>
References: <1366708088.9823.16.camel@sauron.fi.intel.com>
	 <1366715357-9392-1-git-send-email-artem.bityutskiy@linux.intel.com>
	 <20130423153754.GA4104@core.coreip.homeip.net>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20297 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab3DXF4a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Apr 2013 01:56:30 -0400
In-Reply-To: <20130423153754.GA4104@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Maling List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Ulf Hofemeier <ulf.hofemeier@intel.com>, Hui Wang <jason77.wang@gmail.com>

On Tue, 2013-04-23 at 08:37 -0700, Dmitry Torokhov wrote:
> On Tue, Apr 23, 2013 at 02:09:17PM +0300, Artem Bityutskiy wrote:
> > There are platforms using this driver which do not have OF. However, commit
> > ae495e844a77344fdaedbb2ad97d925d096e9f0d added a Kconfig dependency on OF and
> > broke OF-less setups.
> > 
> > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > Cc: stable@vger.kernel.org [v3.7+]
> > ---
> >  drivers/input/touchscreen/Kconfig     |    2 +-
> >  drivers/input/touchscreen/egalax_ts.c |    2 ++
> >  2 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index 515cfe7..d53b0d6 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -227,7 +227,7 @@ config TOUCHSCREEN_EETI
> >  
> >  config TOUCHSCREEN_EGALAX
> >  	tristate "EETI eGalax multi-touch panel support"
> > -	depends on I2C && OF
> > +	depends on I2C
> 
> No, because egalax_wake_up_device() needs OF data and with !CONFIG_OF
> you'll end up using stubs, the wakeup will fail and the touchscreen will
> fail probe.
> 
> It wasn't tested, was it?

Not tested. But Ulf (the reporter of the issue) confirms it does not
solve the issue.

-- 
Best Regards,
Artem Bityutskiy

