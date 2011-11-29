From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 11:06:02 -0800
Message-ID: <20111129190602.GA30946@core.coreip.homeip.net>
References: <201111291324.34045.heiko@sntech.de>
 <20111129182326.GF4241@core.coreip.homeip.net>
 <20111129184203.GE12111@sirena.org.uk>
 <20111129185623.GJ4241@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40852 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab1K2TGI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 14:06:08 -0500
Received: by iage36 with SMTP id e36so11008092iag.19
        for <linux-input@vger.kernel.org>; Tue, 29 Nov 2011 11:06:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111129185623.GJ4241@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Heiko St?bner <heiko@sntech.de>, linux-input@vger.kernel.org

On Tue, Nov 29, 2011 at 10:56:23AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 29, 2011 at 06:42:03PM +0000, Mark Brown wrote:
> > On Tue, Nov 29, 2011 at 10:23:26AM -0800, Dmitry Torokhov wrote:
> > 
> > > Could you please separate this change? I applied previous version to my
> > > tree and I am not sure when module_driver changes will hit mainline...
> > 
> > module_platform_driver is in Linus' tree already.
> 
> Ah, indeed, its the rest of the buses that are missing. Anyway, could I
> still get a separate patch, please?
> 

Ah, never mind, I haven't pushed it out yet so I'll take the latest
version.

-- 
Dmitry

