From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 23:02:48 -0700
Message-ID: <20110726060248.GA3868@suse.de>
References: <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <1311608069.3262.8.camel@Allen>
 <20110725181916.GB6876@core.coreip.homeip.net>
 <20110725182928.GB1175@sirena.org.uk>
 <20110725183746.GD6876@core.coreip.homeip.net>
 <4E2E1897.9020808@cn.fujitsu.com>
 <20110726043949.GA27720@suse.de>
 <4E2E5240.4060309@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37392 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab1GZGT1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 02:19:27 -0400
Content-Disposition: inline
In-Reply-To: <4E2E5240.4060309@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Tue, Jul 26, 2011 at 01:36:00PM +0800, Wanlong Gao wrote:
> On 07/26/2011 12:39 PM, Greg KH wrote:
> 
> >>+
> >>+	if (drv->remove) {
> >>+		dev_dbg(_dev, "remove\n");
> >>+		status = drv->remove(dev);
> >>+	} else {
> >>+		status = 0;
> >>+	}
> >
> >Again, why would remove ever be NULL?
> >
> >This whole thing isn't needed at all.
> >
> >greg k-h
> Yeah, I see.
> 
> But Greg, why does i2c-core do this?
> like:drivers/i2c/i2c-core.c:

The i2c core has different requirements than the driver core does,
right?  They are two totally different things, please don't assume that
the rules for one are the same for the other.

greg k-h
