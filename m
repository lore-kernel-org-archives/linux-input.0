From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Adding graceful shutdown to sysrq key reset
Date: Tue, 23 Apr 2013 17:42:31 -0700
Message-ID: <20130424004231.GA22911@core.coreip.homeip.net>
References: <1365169112-7999-1-git-send-email-mathieu.poirier@linaro.org>
 <20130415204535.GB4374@core.coreip.homeip.net>
 <516D6420.4070406@linaro.org>
 <51771E48.40600@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:55550 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab3DXAmg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Apr 2013 20:42:36 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so292261pbb.27
        for <linux-input@vger.kernel.org>; Tue, 23 Apr 2013 17:42:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51771E48.40600@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-input@vger.kernel.org, arve@android.com, kernel-team@android.com, john.stultz@linaro.org

On Tue, Apr 23, 2013 at 05:50:32PM -0600, Mathieu Poirier wrote:
> On 13-04-16 08:45 AM, Mathieu Poirier wrote:
> > On 13-04-15 02:45 PM, Dmitry Torokhov wrote:
> >> Hi Mathieu,
> >>
> >> On Fri, Apr 05, 2013 at 07:38:32AM -0600, mathieu.poirier@linaro.org wrote:
> >>> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> >>>
> >>> Attempt to reboot the system gracefully when a key combo
> >>> is detected.  The system is force to go down if the first
> >>> attempt failed and the key combo is pressed a second time.
> >>>
> >>
> >> If system can gracefully shutdown can;t we request it through normal
> >> means?
> >>
> >> Thanks.
> >>
> > 
> > Can you provide more details on how you'd like to see this done please ?
> >  Since 'kernel_restart' is found in 'linux/reboot.h' I was under the
> > impression that it is fairly mainstream.
> > 
> > Thanks,
> > Mathieu.
> > 
> 
> I haven't hard back from my last question so I'll try to interpret your
> original answer differently.
> 
> The proposed functionality is a last effort at rebooting the system when
> the UI is hung.  In such case the rest of the system could still be
> alive and as such should be given a chance to reboot more gracefully
> than when using emergency_reset().

OK, fair enough.

-- 
Dmitry
