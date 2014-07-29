From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: huion: Fix sparse warnings
Date: Tue, 29 Jul 2014 15:06:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291504370.16390@pobox.suse.cz>
References: <alpine.LNX.2.00.1407291121530.16390@pobox.suse.cz> <1406638206-6108-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44489 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbaG2NGg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 09:06:36 -0400
In-Reply-To: <1406638206-6108-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, 29 Jul 2014, Nikolai Kondrashov wrote:

> Fix sparse warnings in hid-huion.c by using correct buffer type for
> retrieved string descriptor.
> 
> The warnings in question were:
> 
>     drivers/hid/hid-huion.c:144:44: sparse: cast to restricted __le16
>     drivers/hid/hid-huion.c:145:44: sparse: cast to restricted __le16
>     drivers/hid/hid-huion.c:146:51: sparse: cast to restricted __le16
>     drivers/hid/hid-huion.c:147:30: sparse: cast to restricted __le16

Interestingly enough, my sparse doesn't seem to report this problem 
(running sparse is part of my machinery before pushing anything out).

> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---
> 
> Hi Jiri, Benjamin,
> 
> Thanks for the review. There is one minor problem, though. I didn't run a
> sparse check and only just got a message with "sparse" warnings. This patch
> fixes them.
> 
> If you wouldn't like adding a tiny patch like this, I can send another version
> of the original patches. Otherwise, please feel free to just fixup my "Switch
> to generating report descriptor" commit with this one.

Yup, I'll be applying this on top of your previous one.

Thanks.

-- 
Jiri Kosina
SUSE Labs
