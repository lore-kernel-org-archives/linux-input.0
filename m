From: Florian Ragwitz <rafl@debian.org>
Subject: Re: Getting recent elantech touchpads to work with synaptics
Date: Tue, 27 Apr 2010 16:58:46 +0200
Message-ID: <1272380327-7921-1-git-send-email-rafl@debian.org>
References: <20100427073654.GC29797@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:52322 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab0D0PAK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 11:00:10 -0400
Received: from p4fd76bae.dip.t-dialin.net ([79.215.107.174]:55374 helo=tardis.perldition.org)
	by weedy.perldition.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <rafl@tardis.perldition.org>)
	id 1O6mGe-00036D-Hg
	for linux-input@vger.kernel.org; Tue, 27 Apr 2010 17:00:08 +0200
Received: from rafl by tardis.perldition.org with local (Exim 4.71)
	(envelope-from <rafl@tardis.perldition.org>)
	id 1O6mFp-00024e-2H
	for linux-input@vger.kernel.org; Tue, 27 Apr 2010 16:59:17 +0200
In-Reply-To: <20100427073654.GC29797@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Tue, 27 Apr 2010 00:36:54 -0700, Dmitry Torokhov wrote:
> Florian, great work. I will queue the patches for .34, I think is not
> too late.

Great news. Thank you!

I also just noticed my initial patch updated the comments about the packet
structure in the source code, but failed to update the relevant docs in
Documentation/.

The following patch does just that.

  [PATCH] Update elantech documentation


-- 
BOFH excuse #390:
Increased sunspot activity.
