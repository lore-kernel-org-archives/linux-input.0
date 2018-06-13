From: "Xu, Even" <even.xu@intel.com>
Subject: RE: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Date: Wed, 13 Jun 2018 00:04:08 +0000
Message-ID: <9577C59DB499174B9340876B077C2E9569DF11D7@SHSMSX101.ccr.corp.intel.com>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
 <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi, Jiri Kosina,

If without this patch, the platform with ISH, its hibernation resume will take more than 10s because of ISH resume failure, it will also cause ISH not functional.
With this patch, everything will go will.

Best Regards,
Even Xu


-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Tuesday, June 12, 2018 10:53 PM
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Xu, Even <even.xu@intel.com>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to support hibernation

On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:

> From: Even Xu <even.xu@intel.com>
> 
> Current ish driver only register resume/suspend PM callbacks which 
> don't support hibernation (suspend to disk). Now use the
> SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> The suspend and resume functions will now be used for both suspend to 
> RAM and hibernation.
> 
> If power management is disable, SIMPLE_DEV_PM_OPS will do nothing, the 
> suspend and resume related functions won't be used, so mark them as 
> __maybe_unused to clarify that this is intended behavior, and remove 
> #ifdefs for power management.

This describes details the patch does on code level, but what are the user observable effects? Hibernation resume doesn't fail any more? Hibernation is possible (and wasn't before)? Did kernel crash while trying to hibernate and this is the fix? Or ... ?

Thanks,

--
Jiri Kosina
SUSE Labs
