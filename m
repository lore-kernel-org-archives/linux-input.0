From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: intel-ish-hid: Fix potential race condition
Date: Tue, 29 Nov 2016 15:28:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611291528070.29400@cbobk.fhfr.pm>
References: <1480361015-8148-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757498AbcK2O2U (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 09:28:20 -0500
In-Reply-To: <1480361015-8148-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Mon, 28 Nov 2016, Srinivas Pandruvada wrote:

> Although unlikely but it is possible that when a connect or disconnect
> request is issued to the firmware, before the response comes, user
> terminates the client session. In this case when the response is arrived
> there is no matching client instance in the list of currently active
> clients. In this case, don't issue call to wake up a waiting client.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> 
> This issue is not reported. This was found during code reviews for fault
> tolerance.
> So not a fix for 4.9.rc release.

Applied to for-4.10/intel-ish.

-- 
Jiri Kosina
SUSE Labs

