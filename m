From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable()
 conditions
Date: Fri, 17 Sep 2010 09:07:10 -0700
Message-ID: <20100917160709.GC14186@core.coreip.homeip.net>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
 <201009162339.06395.dmitry.torokhov@gmail.com>
 <4C9332CE.6040905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43625 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab0IQQHR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Sep 2010 12:07:17 -0400
Received: by pzk34 with SMTP id 34so637143pzk.19
        for <linux-input@vger.kernel.org>; Fri, 17 Sep 2010 09:07:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C9332CE.6040905@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

On Fri, Sep 17, 2010 at 05:20:14PM +0800, Jason Wang wrote:
> Dmitry Torokhov wrote:
> >Hi Jason,
> >
> >On Thursday, September 16, 2010 03:51:26 am Jason Wang wrote:
> >>The design like that, we can stop or disable ADC, one difference is
> >>the disable not only stop the ADC but also close the power regulator.
> >>So we change the condition flag to stopped in the _stop() function.
> >>
> >>Because we call __ads7846_disable() in the suspend/resume process, so
> >>move disabled flag modification from ads7846_disable() to the
> >>__ads7846_disable(), otherwise when we call _disable() in the suspend,
> >>and the ADC is really suspended but the flag shows that it isn't.
> >
> >I disagree with the patch. "Disable" knob is separate from PM
> >knobs (suspend/resume); and thus that attribute should only read
> >"1" when
> >user forcibly disabled the device via sysfs. Same goes for open/close.
> >
> >Thanks.
> >
> OK, i will fix this patch.
> 

Hmm, I am not sure what there is to fix... Maybe I misunderstood your
description. Could you please try again to explain what you are trying
to achieve?

Thanks!

-- 
Dmitry
