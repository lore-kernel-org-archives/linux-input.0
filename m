From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 16:25:33 -0700
Message-ID: <20110725232533.GA25994@suse.de>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <20110725182628.GA1175@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54515 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960Ab1GYX03 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 19:26:29 -0400
Content-Disposition: inline
In-Reply-To: <20110725182628.GA1175@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 07:26:28PM +0100, Mark Brown wrote:
> On Mon, Jul 25, 2011 at 08:21:06AM -0700, Greg KH wrote:
> > On Mon, Jul 25, 2011 at 05:14:11PM +0800, Wanlong Gao wrote:
> > > On 07/25/2011 04:30 PM, Dmitry Torokhov wrote:
> 
> > > >I'd rather have platform devices core clean up this pointer, then we
> > > >could stop caring about it in all drivers...
> 
> > > But the platform devices core just call the method of each own.
> > > And don't care about the details like pdata, etc.
> 
> > > Meanwhile, I think the platform core need not care about these details.
> 
> > > and Greg, what do you think about this?
> 
> > I don't understand what you are asking me.
> 
> They're asking if drivers should set driver_data to NULL while
> unbinding, which always struck me as a waste of time given that
> nothing except a currently bound driver should be using driver_data.

Yeah, it's not needed, as nothing should rely on that.  However it's
also not hurting anything either.

greg k-h
