From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable() conditions
Date: Thu, 16 Sep 2010 23:39:05 -0700
Message-ID: <201009162339.06395.dmitry.torokhov@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com> <1284634286-8871-4-git-send-email-jason77.wang@gmail.com> <1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44279 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab0IQGjN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Sep 2010 02:39:13 -0400
Received: by pwi3 with SMTP id 3so601358pwi.19
        for <linux-input@vger.kernel.org>; Thu, 16 Sep 2010 23:39:12 -0700 (PDT)
In-Reply-To: <1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

Hi Jason,

On Thursday, September 16, 2010 03:51:26 am Jason Wang wrote:
> The design like that, we can stop or disable ADC, one difference is
> the disable not only stop the ADC but also close the power regulator.
> So we change the condition flag to stopped in the _stop() function.
> 
> Because we call __ads7846_disable() in the suspend/resume process, so
> move disabled flag modification from ads7846_disable() to the
> __ads7846_disable(), otherwise when we call _disable() in the suspend,
> and the ADC is really suspended but the flag shows that it isn't.

I disagree with the patch. "Disable" knob is separate from PM knobs 
(suspend/resume); and thus that attribute should only read "1" when
user forcibly disabled the device via sysfs. Same goes for open/close.

Thanks.

-- 
Dmitry
