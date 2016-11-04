From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 0/4] ISH Fixes for module loading
Date: Thu, 03 Nov 2016 19:39:47 -0700
Message-ID: <1478227187.26953.0.camel@linux.intel.com>
References: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <alpine.LNX.2.00.1611031204500.5061@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755455AbcKDCj4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Nov 2016 22:39:56 -0400
In-Reply-To: <alpine.LNX.2.00.1611031204500.5061@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org

On Thu, 2016-11-03 at 12:05 -0600, Jiri Kosina wrote:
> On Fri, 21 Oct 2016, Srinivas Pandruvada wrote:
> 
> > Two issues are reported related to loading of intel-ishtp-hid:
> > 
> > 1. Loading failure after rmmod and then modprobe
> > (Patch 1/4 to Patch 3/4) address this. Here first two patches are
> just
> > clean up patches which gets used in Patch 3/4 to fix the issue.
> > 
> > 2. Loading failure due to request_irq failure on some platforms
> > (Patch 4/4)
> 
> This actually looks like 4.9-rc material ... could you please confirm
> that 
> you agree with that, or you'd rather have this for the next merge
> window?
I am fine with 4.9-rc.

Thanks,
Srinivas

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
