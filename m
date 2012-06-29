From: Olivier Goffart <olivier@woboq.com>
Subject: Re: [PATCH] Fix sentelic multi-touch driver
Date: Fri, 29 Jun 2012 09:52:12 +0200
Message-ID: <10241529.n8evo9c2RU@gargamel>
References: <1340829375-4995-1-git-send-email-ogoffart@woboq.com> <1523768.XhBRLqFZzh@gargamel> <1206291029033.19930@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01.worldserver.net ([217.13.200.41]:36148 "EHLO
	mail01.worldserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2F2Hwj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jun 2012 03:52:39 -0400
In-Reply-To: <1206291029033.19930@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: linux-input@vger.kernel.org

On Friday 29 June 2012 11:03:12 Tai-hwa Liang wrote:
> On Thu, 28 Jun 2012, Olivier Goffart wrote:
> [...]
> 
> > - Touch the touchpad with one finger and move it: this moves the cursor
> > - Place a second finger: this allows you to scoll
> > - Release a finger: you should now be able to move the cursor again.  This
> > is the part that does not work in one of the patch
> 
>    Sorry, I didn't realise that one of my patch submitted a few months ago
> (namely, http://www.spinics.net/lists/linux-input/msg19443.html) isn't
> in the master tree, which is different from my local working copy.
> 
>    With the correct flag(FSP_BIT_SWC1_EN_GID) being set, the hardware
> clears MFMC bit during 2 -> 1 finger transition.  The attached patch is
> an aggregated version against Dmitry's master branch, which supposes to fix
> the testing case listed above.
> 
> Thanks,
> 
> Tai-hwa Liang

I am testing against the stable 3.4.y branch.
With that patch, scrolling is very slow, and it emits middle click sometimes 
while I want to scroll fast. 

Looking at the debug output, i see a lot of NOTIFY packets, for the same  
number of packets/seconds (77). So then there is 5 times less multi touch 
events. Maybe that's why.

Regards
-- 
Olivier
