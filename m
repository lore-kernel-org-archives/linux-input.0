From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 3/3] hid: intel-ish-hid: ipc: use msleep_interrupt() for
 wait
Date: Tue, 15 Nov 2016 14:27:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611151426300.29400@cbobk.fhfr.pm>
References: <1478828433-31779-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48719 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933311AbcKON1J (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 08:27:09 -0500
In-Reply-To: <1478828433-31779-1-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

On Fri, 11 Nov 2016, Even Xu wrote:

> set_current_task() must be called before schedule_timeout(), for this
> driver, in order to avoid incorrect usage, use msleep_interrupt()
> instead.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>

Is this fixing a bug that has been observed / reported in a real life, or 
has this been found purely via code inspection? (asking to schedule 
upstream merge properly).

Thanks,

-- 
Jiri Kosina
SUSE Labs

