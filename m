From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 19:26:28 +0100
Message-ID: <20110725182628.GA1175@sirena.org.uk>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46061 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab1GYS0e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 14:26:34 -0400
Content-Disposition: inline
In-Reply-To: <20110725152106.GB23356@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 08:21:06AM -0700, Greg KH wrote:
> On Mon, Jul 25, 2011 at 05:14:11PM +0800, Wanlong Gao wrote:
> > On 07/25/2011 04:30 PM, Dmitry Torokhov wrote:

> > >I'd rather have platform devices core clean up this pointer, then we
> > >could stop caring about it in all drivers...

> > But the platform devices core just call the method of each own.
> > And don't care about the details like pdata, etc.

> > Meanwhile, I think the platform core need not care about these details.

> > and Greg, what do you think about this?

> I don't understand what you are asking me.

They're asking if drivers should set driver_data to NULL while
unbinding, which always struck me as a waste of time given that
nothing except a currently bound driver should be using driver_data.
