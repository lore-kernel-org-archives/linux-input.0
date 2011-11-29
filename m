From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 22:16:29 +0100
Message-ID: <201111292216.30826.heiko@sntech.de>
References: <201111291324.34045.heiko@sntech.de> <20111129185623.GJ4241@core.coreip.homeip.net> <20111129190602.GA30946@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:46428 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756501Ab1K2VQf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 16:16:35 -0500
In-Reply-To: <20111129190602.GA30946@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

Am Dienstag 29 November 2011, 20:06:02 schrieb Dmitry Torokhov:
> On Tue, Nov 29, 2011 at 10:56:23AM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 29, 2011 at 06:42:03PM +0000, Mark Brown wrote:
> > > On Tue, Nov 29, 2011 at 10:23:26AM -0800, Dmitry Torokhov wrote:
> > > > Could you please separate this change? I applied previous version to
> > > > my tree and I am not sure when module_driver changes will hit
> > > > mainline...
> > > 
> > > module_platform_driver is in Linus' tree already.
> > 
> > Ah, indeed, its the rest of the buses that are missing. Anyway, could I
> > still get a separate patch, please?
> 
> Ah, never mind, I haven't pushed it out yet so I'll take the latest
> version.
very cool :-)

Thanks
Heiko
