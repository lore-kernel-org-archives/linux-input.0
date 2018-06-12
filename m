From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Date: Tue, 12 Jun 2018 08:30:30 -0700
Message-ID: <634cd945beca786dc77876f71e39459cef6fbd75.camel@linux.intel.com>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
         <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2018-06-12 at 16:53 +0200, Jiri Kosina wrote:
> On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:
> 
> > From: Even Xu <even.xu@intel.com>
> > 
> > Current ish driver only register resume/suspend PM callbacks which
> > don't support hibernation (suspend to disk). Now use the
> > SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> > The suspend and resume functions will now be used for both suspend
> > to RAM and hibernation.
> > 
> > If power management is disable, SIMPLE_DEV_PM_OPS will do nothing,
> > the suspend and resume related functions won't be used, so mark
> > them
> > as __maybe_unused to clarify that this is intended behavior, and
> > remove #ifdefs for power management.
> 
> This describes details the patch does on code level, but what are the
> user 
> observable effects? Hibernation resume doesn't fail any more?
> Hibernation 
> is possible (and wasn't before)? Did kernel crash while trying to 
> hibernate and this is the fix? Or ... ?
Even,
Can you add more details and resubmit ASAP?

Basically after hiberation, the ISH can't resume properly and user may
not see sensor events (for example: screen rotation may not work).
User will not see a crash or panic or anything except the following
message in log:
hid-sensor-hub 001F:8086:22D8.0001: timeout waiting for response from 
ISHTP device 

So this is adding support for S4/hiberbation to ISH.



Thanks,
Srinivas

> 
> Thanks,
> 
