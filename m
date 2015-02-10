From: Lauri Kasanen <cand@gmx.com>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers, v2
Date: Tue, 10 Feb 2015 14:43:18 +0200
Message-ID: <20150210144318.f167f52d.cand@gmx.com>
References: <20150208111138.6f562d6c.cand@gmx.com>
	<20150210121948.a74fb71f5f3a8fc0a9504f68@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:65291 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbBJMlK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 07:41:10 -0500
In-Reply-To: <20150210121948.a74fb71f5f3a8fc0a9504f68@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com, AndrewD207@aol.com

Hi Antonio,

> These annotations about the history of a patch are usually added
> after the '---' marker right before sending the patch, not in the commit
> message.
> 
> They are useful for reviewers, but not really interesting anymore after
> the code is validated and merged.
> 
> In the subject you can mark a v2 like [PATCHv2], the prefix will be
> stripped by git am, do not put the version of the patch in the short
> commit message itself.

Thanks, communities differ wrt these, I'm not often around the kernel.

> Moreover, a following cleanup patch could make this __u8 *buf which
> would be the correct type.
> 
> Another follow-up patch could indeed use SIXAXIS_REPORT_0xF2_SIZE and
> also define SIXAXIS_REPORT_0xF5_SIZE.
> 
> I can do these latter if you want.

Yes, please do. You have more experience around these parts and can
get it done faster.

> Maybe you can add a "goto out" here and skip the other steps if a
> previous one fails. Or is some slack actually required to support
> compatible controllers?

They all succeed on mine, so will add the goto.

- Lauri
