From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sensor-hub: Add quirk for Lenovo Yoga 900 with ITE
 Chips
Date: Tue, 22 Dec 2015 14:27:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512221427230.9922@cbobk.fhfr.pm>
References: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33956 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbbLVN2B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2015 08:28:01 -0500
In-Reply-To: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, nish.aravamudan@gmail.com, linux-input@vger.kernel.org

On Fri, 18 Dec 2015, Srinivas Pandruvada wrote:

> This needs same quirk as applied to other YOGA sensor hubs.
> Refer to
> 47eeca8a48 (" HID: sensor-hub: Add in quirk for Lenovo Yogas with ITE")
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Tested-by: Nishanth Aravamudan <nish.aravamudan@gmail.com>

I got a bit lost here ... what's the status of this patch? Nishanth later 
reported that the patch actually doesn't fix the issue for him, so?

Thanks,

-- 
Jiri Kosina
SUSE Labs

