From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/4] ISH Fixes for module loading
Date: Sat, 5 Nov 2016 16:02:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611051602160.29400@cbobk.fhfr.pm>
References: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54459 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754771AbcKEPCv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 5 Nov 2016 11:02:51 -0400
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
> 
> 
> v2
>  -pci_set_power_state() used instead of changing directly CSR

Applied to hid.git#for-4.9/upstream-fixes

-- 
Jiri Kosina
SUSE Labs

