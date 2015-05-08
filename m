From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Fri, 8 May 2015 07:45:48 +0530
Message-ID: <CAKohpo=fr3tWEWwiMb25WQP6m=CpbdZCwRB3Zng5Q7tZ0RtPdw@mail.gmail.com>
References: <1431049991-30129-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34629 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbEHCPt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2015 22:15:49 -0400
Received: by obfe9 with SMTP id e9so45797897obf.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2015 19:15:49 -0700 (PDT)
In-Reply-To: <1431049991-30129-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 8 May 2015 at 07:23, Marek Vasut <marex@denx.de> wrote:
> Use msecs_to_jiffies(20) instead of plain (HZ / 50), as the
> former is much more explicit about it's behavior. We want
> to schedule the task 20 mS from now, so make it explicit in
> the code.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
