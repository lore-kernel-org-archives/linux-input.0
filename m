From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] Input: smtpe-ts: Wait 50mS until polling for pen-up
Date: Fri, 8 May 2015 07:47:10 +0530
Message-ID: <CAKohpo=zJr3yE08_62GxjcSWwOBw9-FWthCX8uJh-Ehm9NDn6w@mail.gmail.com>
References: <1431049991-30129-1-git-send-email-marex@denx.de>
	<1431049991-30129-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35367 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbbEHCRK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2015 22:17:10 -0400
Received: by oign205 with SMTP id n205so48506788oig.2
        for <linux-input@vger.kernel.org>; Thu, 07 May 2015 19:17:10 -0700 (PDT)
In-Reply-To: <1431049991-30129-2-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 8 May 2015 at 07:23, Marek Vasut <marex@denx.de> wrote:
> Wait a little bit longer, 50mS instead of 20mS, until the driver
> starts polling for pen-up. The problematic behavior before this
> patch is applied is as follows. The behavior was observed on the
> STMPE610QTR controller.
>
> Upon a physical pen-down event, the touchscreen reports one set
> of x-y-p coordinates and a pen-down event. After that, the pen-up
> polling is triggered and since the controller is not ready yet,
> the polling mistakenly detects a pen-up event while the physical
> state is still such that the pen is down on the touch surface.
>
> The pen-up handling flushes the controller FIFO, so after that,
> all the samples in the controller are discarded. The controller
> becomes ready shortly after this bogus pen-up handling and does
> generate again a pen-down interrupt. This time, the controller
> contains x-y-p samples which all read as zero. Since pressure
> value is zero, this set of samples is effectively ignored by
> userland.
>
> In the end, the driver just bounces between pen-down and bogus
> pen-up handling, generating no useful results. Fix this by giving
> the controller a bit more time before polling it for pen-up.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
