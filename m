From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook Airs
Date: Wed, 5 Oct 2011 11:48:51 +0200
Message-ID: <20111005094851.GA7261@polaris.bitmath.org>
References: <efc66984043a292faa31fee381945d18@jefferai.org>
 <20111005090735.GA6840@polaris.bitmath.org>
 <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:45432 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933732Ab1JEJm7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 05:42:59 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 88B13C046
	for <linux-input@vger.kernel.org>; Wed,  5 Oct 2011 11:42:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeff Mitchell <jeff@jefferai.org>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

> please check what is in my hid tree (included in linux-next as well) and 
> let me know whether there is anything that need to be applied on top of 
> that. I believe all the HID-related 4,1 and 4,2 bits are already in there.

Finding the right tree is the big challenge these days. ;-)

Looking at the twin.jikos.cz tree, the upstream and for-next branches
have the same content with regard to these devices. Both 4,1 and 4,2
are included in the special driver and mouse ignore lists. Whether the
keyboard handling is correct, I cannot say, but it looks consistent.

All good for now, it other words. Sorry about the fuzz.

Thanks,
Henrik
