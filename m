From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook
 Airs
Date: Wed, 5 Oct 2011 12:13:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz>
References: <efc66984043a292faa31fee381945d18@jefferai.org> <20111005090735.GA6840@polaris.bitmath.org> <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz> <20111005094851.GA7261@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34855 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933122Ab1JEKNa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Oct 2011 06:13:30 -0400
In-Reply-To: <20111005094851.GA7261@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jeff Mitchell <jeff@jefferai.org>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On Wed, 5 Oct 2011, Henrik Rydberg wrote:

> > please check what is in my hid tree (included in linux-next as well) and 
> > let me know whether there is anything that need to be applied on top of 
> > that. I believe all the HID-related 4,1 and 4,2 bits are already in there.
> 
> Finding the right tree is the big challenge these days. ;-)

Indeed :)

I will be moving my trees back to kernel.org as soon as it is possible.

> Looking at the twin.jikos.cz tree, the upstream and for-next branches 
> have the same content with regard to these devices. Both 4,1 and 4,2 are 
> included in the special driver and mouse ignore lists. Whether the 
> keyboard handling is correct, I cannot say, but it looks consistent.

Perfect, thanks for verification.

> All good for now, it other words. Sorry about the fuzz.

No problem at all, the situation with the trees is now simply too 
confusing. Thanks a lot for checking.

-- 
Jiri Kosina
SUSE Labs
