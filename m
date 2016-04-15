From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2 v2] device-tree: nexus7-flo: Remove power gpio key
 entry and use pmic8xxx-pwrkey
Date: Fri, 15 Apr 2016 14:58:26 -0700
Message-ID: <CALAqxLVjULOD8SyhJkV7zREFqJA0w6LyU4udXEsXKqtXqbHPUg@mail.gmail.com>
References: <1460668031-12384-1-git-send-email-john.stultz@linaro.org>
	<20160415172212.GW391@tuxbot>
	<20160415185927.GN14441@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36016 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbcDOV61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Apr 2016 17:58:27 -0400
Received: by mail-oi0-f41.google.com with SMTP id y204so137190874oie.3
        for <linux-input@vger.kernel.org>; Fri, 15 Apr 2016 14:58:27 -0700 (PDT)
In-Reply-To: <20160415185927.GN14441@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Boyd <stephen.boyd@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Vinay Simha BN <simhavcs@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Apr 15, 2016 at 11:59 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] Input: pmic8xxx-pwrkey: Fix algorithm for converting trigger
>  delay
>
> The trigger delay algorithm that converts from microseconds to
> the register value looks incorrect. According to most of the PMIC
> documentation, the equation is
>
>         delay (Seconds) = (1 / 1024) * 2 ^ (x + 4)
>
> except for one case where the documentation looks to have a
> formatting issue and the equation looks like
>
>         delay (Seconds) = (1 / 1024) * 2 x + 4
>
> Most likely this driver was written with the improper
> documentation to begin with. According to the downstream sources
> the valid delays are from 2 seconds to 1/64 second, and the
> latter equation just doesn't make sense for that. Let's fix the
> algorithm and the range check to match the documentation and the
> downstream sources.
>
> Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Fixes: 92d57a73e410 ("input: Add support for Qualcomm PMIC8XXX power key")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This works great for me, and lets me zap the pwrkey node in my dts.

Tested-by: John Stultz <john.stultz@linaro.org>

I'll also send an updated variant of my patch that only removes the gpio key.

thanks!
-john
