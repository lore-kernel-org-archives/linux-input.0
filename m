From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] hid-hyperv: Do not use hid_parse_report() directly
Date: Fri, 27 Apr 2012 10:53:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204271052330.1856@pobox.suse.cz>
References: <1335097300-11881-1-git-send-email-rydberg@euromail.se> <1335097300-11881-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37523 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757634Ab2D0IxJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Apr 2012 04:53:09 -0400
In-Reply-To: <1335097300-11881-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>

On Sun, 22 Apr 2012, Henrik Rydberg wrote:

> Upcoming changes will split the semantics of hid_parse_report()
> and hid_parse(), so make sure drivers use hid_parse() in probe().
> 
> Compiled, not tested.
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

KY, could I please get your Ack/Tested-by for this patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs
