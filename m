From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Date: Tue, 12 Jun 2018 17:14:59 -0700
Message-ID: <e40e926c35ae036c4b6f9ebc33223a2dc5c3eff2.camel@linux.intel.com>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
         <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
         <634cd945beca786dc77876f71e39459cef6fbd75.camel@linux.intel.com>
         <9577C59DB499174B9340876B077C2E9569DF11EC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9577C59DB499174B9340876B077C2E9569DF11EC@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Xu, Even" <even.xu@intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2018-06-13 at 00:05 +0000, Xu, Even wrote:
> Ok, sure, I will update patch comments and resubmit.
Can you also add in the sign-off area


Cc: stable@vger.kernel.org

Thanks,
Srinivas

> Thanks Srinivas!
> 
> Best Regards,
> Even Xu
> 
> 
> 
> -----Original Message-----
> From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com
> ] 
> Sent: Tuesday, June 12, 2018 11:31 PM
> To: Jiri Kosina <jikos@kernel.org>; Xu, Even <even.xu@intel.com>
> Cc: benjamin.tissoires@redhat.com; linux-input@vger.kernel.org; linux
> -kernel@vger.kernel.org; Xu, Even <even.xu@intel.com>
> Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm
> callbacks to support hibernation
> 
> On Tue, 2018-06-12 at 16:53 +0200, Jiri Kosina wrote:
> > On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:
> > 
> > > From: Even Xu <even.xu@intel.com>
> > > 
> > > Current ish driver only register resume/suspend PM callbacks
> > > which 
> > > don't support hibernation (suspend to disk). Now use the
> > > SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> > > The suspend and resume functions will now be used for both
> > > suspend 
> > > to RAM and hibernation.
> > > 
> > > If power management is disable, SIMPLE_DEV_PM_OPS will do
> > > nothing, 
> > > the suspend and resume related functions won't be used, so mark
> > > them 
> > > as __maybe_unused to clarify that this is intended behavior, and 
> > > remove #ifdefs for power management.
> > 
> > This describes details the patch does on code level, but what are
> > the 
> > user observable effects? Hibernation resume doesn't fail any more?
> > Hibernation
> > is possible (and wasn't before)? Did kernel crash while trying to 
> > hibernate and this is the fix? Or ... ?
> 
> Even,
> Can you add more details and resubmit ASAP?
> 
> Basically after hiberation, the ISH can't resume properly and user
> may not see sensor events (for example: screen rotation may not
> work).
> User will not see a crash or panic or anything except the following
> message in log:
> hid-sensor-hub 001F:8086:22D8.0001: timeout waiting for response from
> ISHTP device 
> 
> So this is adding support for S4/hiberbation to ISH.
> 
> 
> 
> Thanks,
> Srinivas
> 
> > 
> > Thanks,
> > 
