From: Olivier Goffart <olivier@woboq.com>
Subject: Re: [PATCH] Fix sentelic multi-touch driver
Date: Fri, 29 Jun 2012 17:00:39 +0200
Message-ID: <2421405.kgV4JOQPin@gargamel>
References: <1340829375-4995-1-git-send-email-ogoffart@woboq.com> <10241529.n8evo9c2RU@gargamel> <12062922475617.19930@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01.worldserver.net ([217.13.200.41]:45676 "EHLO
	mail01.worldserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab2F2PBH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jun 2012 11:01:07 -0400
In-Reply-To: <12062922475617.19930@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: linux-input@vger.kernel.org

On Friday 29 June 2012 22:51:16 Tai-hwa Liang wrote:
> On Fri, 29 Jun 2012, Olivier Goffart wrote:
> > On Friday 29 June 2012 11:03:12 Tai-hwa Liang wrote:
> [...]
> 
> >>    With the correct flag(FSP_BIT_SWC1_EN_GID) being set, the hardware
> >> 
> >> clears MFMC bit during 2 -> 1 finger transition.  The attached patch is
> >> an aggregated version against Dmitry's master branch, which supposes to
> >> fix
> >> the testing case listed above.
> > 
> > I am testing against the stable 3.4.y branch.
> > With that patch, scrolling is very slow, and it emits middle click
> > sometimes while I want to scroll fast.
> > 
> > Looking at the debug output, i see a lot of NOTIFY packets, for the same
> > number of packets/seconds (77). So then there is 5 times less multi touch
> > events. Maybe that's why.
> 
>    I see. It appears to me that we'd better to revert back to the
> last_mt_fgr workaround to avoid such delay.

That last patch seems to work perfectly.

Thanks
-- 
Olivier
