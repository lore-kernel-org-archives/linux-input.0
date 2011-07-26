From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Tue, 26 Jul 2011 09:54:36 +0100
Message-ID: <20110726085435.GB7285@opensource.wolfsonmicro.com>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <20110725182628.GA1175@sirena.org.uk>
 <20110725232533.GA25994@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37811 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751145Ab1GZIyi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 04:54:38 -0400
Content-Disposition: inline
In-Reply-To: <20110725232533.GA25994@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 04:25:33PM -0700, Greg KH wrote:
> On Mon, Jul 25, 2011 at 07:26:28PM +0100, Mark Brown wrote:

> > They're asking if drivers should set driver_data to NULL while
> > unbinding, which always struck me as a waste of time given that
> > nothing except a currently bound driver should be using driver_data.

> Yeah, it's not needed, as nothing should rely on that.  However it's
> also not hurting anything either.

Every time I see it it always sets off a red flag, partly because we
shouldn't need to bother at all and partly because to the extent it's
valuable it's not something we should be doing on a driver by driver or
even subsystem by subsystem basis.
