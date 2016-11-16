From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] Clean up ipc wait times
Date: Wed, 16 Nov 2016 11:44:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611161144220.29400@cbobk.fhfr.pm>
References: <1478828319-31590-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46849 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751335AbcKPKod (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 05:44:33 -0500
In-Reply-To: <1478828319-31590-1-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

On Fri, 11 Nov 2016, Even Xu wrote:

> This series addresses issue with schedule_timeout() calls and cleans
> up code around this.
> 
> Even Xu (3):
>   hid: intel-ish-hid: ipc: remove unused macro
>   hid: intel-ish-hid: ipc: change timed_wait_for_timeout() to be a
>     function
>   hid: intel-ish-hid: ipc: use msleep_interrupt() for wait
> 
>  drivers/hid/intel-ish-hid/ipc/ipc.c   | 66 +++++++++++++++++++++++++++++++----
>  drivers/hid/intel-ish-hid/ipc/utils.h | 64 ---------------------------------
>  2 files changed, 60 insertions(+), 70 deletions(-)
>  delete mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h

Applied to hid.git#for-4.10/intel-ish. Thanks,

-- 
Jiri Kosina
SUSE Labs

