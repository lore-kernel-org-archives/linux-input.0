From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/2] Cleanup and fix touch_down implementation
Date: Tue, 3 Mar 2015 00:28:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503030028270.9089@pobox.suse.cz>
References: <1424471119-4628-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50656 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944AbbCBX2g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2015 18:28:36 -0500
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
> 
>  drivers/hid/wacom_wac.c | 81 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 32 deletions(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
