From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid_parse failure
Date: Mon, 14 May 2012 15:04:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205141503510.15448@pobox.suse.cz>
References: <1336693531-13613-1-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56599 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756477Ab2ENNE2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 09:04:28 -0400
In-Reply-To: <1336693531-13613-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-input@vger.kernel.org

On Thu, 10 May 2012, srinivas pandruvada wrote:

> When logical maximum is 0xffffffff, the parser fails even if
> logical minimum is more than 0.
> By HID specification this is a valid combination.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>

I have made the subject line a little bit more verbose, added a bit of 
explanatory comment before the condition, and applied.

Thanks,

-- 
Jiri Kosina
SUSE Labs
