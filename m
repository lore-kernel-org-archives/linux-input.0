From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/17] Merging of TSC2005 driver
Date: Wed, 16 Mar 2011 09:40:20 -0700
Message-ID: <20110316164019.GA6974@core.coreip.homeip.net>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
 <alpine.DEB.1.10.1103161737540.2634@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56883 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab1CPQk0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 12:40:26 -0400
Received: by iyb26 with SMTP id 26so1846449iyb.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 09:40:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1103161737540.2634@esdhcp041196.research.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

On Wed, Mar 16, 2011 at 05:44:23PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, 16 Mar 2011, Dmitry Torokhov wrote:
> >So I guess the common core for tsc2005/2007 will not materialize anytime
> >soon and I should finally merge the standalone version of driver... Still
> >there were a few issues with it and I would appreciate if you take a look
> >at the following patches and let me know if the driver still works if
> >you apply them.
> 
> Thanks, I think those are good changes. There are two bugs (about which
> I already sent mails) but with those fixed it appeared to work fine
> with RX-51 (Nokia N900) based on a brief sanity check. I tested with
> mainline v2.6.38.

Excellent, then I'll tag the patches as "Tested-by" you (after fixing up
the 2 issues you noticed).

Thanks.

-- 
Dmitry
