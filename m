From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Tue, 26 Jul 2011 10:26:50 -0700
Message-ID: <20110726172650.GA9179@core.coreip.homeip.net>
References: <20110725181916.GB6876@core.coreip.homeip.net>
 <20110725182928.GB1175@sirena.org.uk>
 <20110725183746.GD6876@core.coreip.homeip.net>
 <4E2E1897.9020808@cn.fujitsu.com>
 <20110726043949.GA27720@suse.de>
 <4E2E5240.4060309@cn.fujitsu.com>
 <20110726060248.GA3868@suse.de>
 <4E2E5DEC.60208@cn.fujitsu.com>
 <20110726064519.GA4520@core.coreip.homeip.net>
 <20110726164106.GA7941@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56071 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1GZR06 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 13:26:58 -0400
Received: by qyk9 with SMTP id 9so378560qyk.19
        for <linux-input@vger.kernel.org>; Tue, 26 Jul 2011 10:26:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110726164106.GA7941@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Tue, Jul 26, 2011 at 09:41:06AM -0700, Greg KH wrote:
> On Mon, Jul 25, 2011 at 11:45:20PM -0700, Dmitry Torokhov wrote:
> > On Tue, Jul 26, 2011 at 02:25:48PM +0800, Wanlong Gao wrote:
> > > On 07/26/2011 02:02 PM, Greg KH wrote:
> > > >On Tue, Jul 26, 2011 at 01:36:00PM +0800, Wanlong Gao wrote:
> > > >>On 07/26/2011 12:39 PM, Greg KH wrote:
> > > >>
> > > >>>>+
> > > >>>>+	if (drv->remove) {
> > > >>>>+		dev_dbg(_dev, "remove\n");
> > > >>>>+		status = drv->remove(dev);
> > > >>>>+	} else {
> > > >>>>+		status = 0;
> > > >>>>+	}
> > > >>>
> > > >>>Again, why would remove ever be NULL?
> > > >>>
> > > >>>This whole thing isn't needed at all.
> > > >>>
> > > >>>greg k-h
> > > >>Yeah, I see.
> > > >>
> > > >>But Greg, why does i2c-core do this?
> > > >>like:drivers/i2c/i2c-core.c:
> > > >
> > > >The i2c core has different requirements than the driver core does,
> > > >right?  They are two totally different things, please don't assume that
> > > >the rules for one are the same for the other.
> > > >
> > > >greg k-h
> > > >
> > > Hmm...They are totally different things, maybe I see..
> > 
> > Still, it would make sense to clean up platform device's drvdata
> > pointer, so that every platform driver out there does not have to do it
> > on its own.
> 
> Again, it shouldn't need to be "cleaned" up, as no one relies on it
> being there.

No one should rely on it being there however I came across quite a few
MFD patches that tried passing parent's data in that pointer. Hopefully
they are all cleaned now but we getting new drivers all the time...

If we had it in the platform bus code such uses would break even before
we get such drivers and we won't have to deal with them.

Thanks.

-- 
Dmitry
