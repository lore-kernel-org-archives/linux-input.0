From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/2] Cleanup and fix touch_down implementation
Date: Fri, 27 Feb 2015 08:38:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502270838120.19920@pobox.suse.cz>
References: <1424471119-4628-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38217 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbbB0HjB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 02:39:01 -0500
In-Reply-To: <1424471119-4628-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, 20 Feb 2015, Ping Cheng wrote:

> Hi Jiri,
> 
> This set is based on your for-3.20/upstream-fixes branch.
> 
> If pen comes in proximity while touch is down, we force touch up
> before sending pen events. This idea has been implemented for
> Tablet PCs. But other tablets that support both pen and touch are
> not fully considered.
> 
> Ping Cheng (2):
>   HID: wacom: do not send pen events before touch is up/forced out
>   HID: wacom: rely on actual touch down count to decide touch_down

Ping, looking at the code, I think this both should go into 4.0 still 
(i.e. not postponed for the next merge window), as it's purely fixes.

Could you please confirm that for me?

Thanks,

-- 
Jiri Kosina
SUSE Labs
