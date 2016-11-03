From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/4] ISH Fixes for module loading
Date: Thu, 3 Nov 2016 12:05:33 -0600 (MDT)
Message-ID: <alpine.LNX.2.00.1611031204500.5061@cbobk.fhfr.pm>
References: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36433 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759250AbcKCSFp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Nov 2016 14:05:45 -0400
In-Reply-To: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, 21 Oct 2016, Srinivas Pandruvada wrote:

> Two issues are reported related to loading of intel-ishtp-hid:
> 
> 1. Loading failure after rmmod and then modprobe
> (Patch 1/4 to Patch 3/4) address this. Here first two patches are just
> clean up patches which gets used in Patch 3/4 to fix the issue.
> 
> 2. Loading failure due to request_irq failure on some platforms
> (Patch 4/4)

This actually looks like 4.9-rc material ... could you please confirm that 
you agree with that, or you'd rather have this for the next merge window?

Thanks,

-- 
Jiri Kosina
SUSE Labs

