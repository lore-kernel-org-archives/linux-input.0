From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 21:39:49 -0700
Message-ID: <20110726043949.GA27720@suse.de>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <1311608069.3262.8.camel@Allen>
 <20110725181916.GB6876@core.coreip.homeip.net>
 <20110725182928.GB1175@sirena.org.uk>
 <20110725183746.GD6876@core.coreip.homeip.net>
 <4E2E1897.9020808@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35209 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab1GZEoV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 00:44:21 -0400
Content-Disposition: inline
In-Reply-To: <4E2E1897.9020808@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Tue, Jul 26, 2011 at 09:29:59AM +0800, Wanlong Gao wrote:
> On 07/26/2011 02:37 AM, Dmitry Torokhov wrote:
> >On Mon, Jul 25, 2011 at 07:29:28PM +0100, Mark Brown wrote:
> >>On Mon, Jul 25, 2011 at 11:19:16AM -0700, Dmitry Torokhov wrote:
> >>
> >>>Right, like i2c bus we could just have platform core clean up platform
> >>>drvdata pointer after calling ->remove() and also if ->probe() errors
> >>>out.
> >>
> >>I2C doesn't do this (at least not any more).
> >>
> >
> >Sure does. See drivers/i2c/i2c-core.c::i2c_device_probe() and
> >i2c_device_remove().
> Yeah, I see it. Sure i2c does.
> Let the Core to do the pointer's clean up is very good idea.

No it isn't.

> So, Dmitry, do you means this ?
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  drivers/base/platform.c |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6040717..349e71b 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -405,8 +405,21 @@ static int platform_drv_probe(struct device *_dev)
>  {
>  	struct platform_driver *drv = to_platform_driver(_dev->driver);
>  	struct platform_device *dev = to_platform_device(_dev);
> +	int status;
> 
> -	return drv->probe(dev);
> +	if (!dev)
> +		return 0;

When would dev ever be NULL?  Wouldn't that be an error?

> +
> +	if (!drv->probe)
> +		return -ENODEV;

That's not a valid error for this.  And when would probe ever be NULL?

> +
> +	dev_dbg(_dev, "probe\n");

Why add this noise?

> +
> +	status = drv->probe(dev);
> +	if (status)
> +		platform_set_drvdata(dev, NULL);

No, not ok.

> +
> +	return status;
>  }
> 
>  static int platform_drv_probe_fail(struct device *_dev)
> @@ -418,8 +431,21 @@ static int platform_drv_remove(struct device *_dev)
>  {
>  	struct platform_driver *drv = to_platform_driver(_dev->driver);
>  	struct platform_device *dev = to_platform_device(_dev);
> +	int status;
> +
> +	if (!dev)
> +		return 0;

Again, when would that ever happen?

> +
> +	if (drv->remove) {
> +		dev_dbg(_dev, "remove\n");
> +		status = drv->remove(dev);
> +	} else {
> +		status = 0;
> +	}

Again, why would remove ever be NULL?

This whole thing isn't needed at all.

greg k-h
