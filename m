From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Date: Tue, 12 Jun 2018 16:53:12 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:

> From: Even Xu <even.xu@intel.com>
> 
> Current ish driver only register resume/suspend PM callbacks which
> don't support hibernation (suspend to disk). Now use the
> SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> The suspend and resume functions will now be used for both suspend
> to RAM and hibernation.
> 
> If power management is disable, SIMPLE_DEV_PM_OPS will do nothing,
> the suspend and resume related functions won't be used, so mark them
> as __maybe_unused to clarify that this is intended behavior, and
> remove #ifdefs for power management.

This describes details the patch does on code level, but what are the user 
observable effects? Hibernation resume doesn't fail any more? Hibernation 
is possible (and wasn't before)? Did kernel crash while trying to 
hibernate and this is the fix? Or ... ?

Thanks,

-- 
Jiri Kosina
SUSE Labs
