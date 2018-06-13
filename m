From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Date: Wed, 13 Jun 2018 13:34:12 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806131333500.6203@cbobk.fhfr.pm>
References: <1455221494-2915-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455221494-2915-1-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 12 Feb 2016, Even Xu wrote:

> Current ISH driver only registers suspend/resume PM callbacks which don't
> support hibernation (suspend to disk). Basically after hiberation, the ISH
> can't resume properly and user may not see sensor events
> (for example: screen rotation may not work).
> 
> User will not see a crash or panic or anything except the following message
> in log:
> hid-sensor-hub 001F:8086:22D8.0001: timeout waiting for response from ISHTP device
> 
> So this patch adds support for S4/hiberbation to ISH by using the
> SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly. The suspend
> and resume functions will now be used for both suspend to RAM and hibernation.
> 
> If power management is disabled, SIMPLE_DEV_PM_OPS will do nothing, the suspend
> and resume related functions won't be used, so mark them as __maybe_unused to
> clarify that this is the intended behavior, and remove #ifdefs for power
> management.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Even Xu <even.xu@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to hid.git#for-4.18/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
