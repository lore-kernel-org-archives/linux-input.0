From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Thu, 7 May 2015 22:28:20 -0700
Message-ID: <20150508052820.GC18159@dtor-ws>
References: <1431049991-30129-1-git-send-email-marex@denx.de>
 <CAKohpo=fr3tWEWwiMb25WQP6m=CpbdZCwRB3Zng5Q7tZ0RtPdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36011 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbEHF2Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 01:28:25 -0400
Received: by iecnq11 with SMTP id nq11so56057394iec.3
        for <linux-input@vger.kernel.org>; Thu, 07 May 2015 22:28:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohpo=fr3tWEWwiMb25WQP6m=CpbdZCwRB3Zng5Q7tZ0RtPdw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Marek Vasut <marex@denx.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipul Kumar Samar <vipulkumar.samar@st.com>

On Fri, May 08, 2015 at 07:45:48AM +0530, Viresh Kumar wrote:
> On 8 May 2015 at 07:23, Marek Vasut <marex@denx.de> wrote:
> > Use msecs_to_jiffies(20) instead of plain (HZ / 50), as the
> > former is much more explicit about it's behavior. We want
> > to schedule the task 20 mS from now, so make it explicit in
> > the code.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/touchscreen/stmpe-ts.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied both, thank you.

-- 
Dmitry
