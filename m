From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Fri, 22 May 2015 02:05:52 +0200
Message-ID: <201505220205.52913.marex@denx.de>
References: <1431049991-30129-1-git-send-email-marex@denx.de> <201505220158.34136.marex@denx.de> <20150522000121.GB39517@dtor-ws>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36715 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbbEVAF5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 20:05:57 -0400
In-Reply-To: <20150522000121.GB39517@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipul Kumar Samar <vipulkumar.samar@st.com>

On Friday, May 22, 2015 at 02:01:21 AM, Dmitry Torokhov wrote:
> On Fri, May 22, 2015 at 01:58:34AM +0200, Marek Vasut wrote:
> > On Friday, May 08, 2015 at 07:22:28 PM, Dmitry Torokhov wrote:
> > > On Fri, May 08, 2015 at 11:47:39AM +0200, Marek Vasut wrote:
> > > > On Friday, May 08, 2015 at 07:28:20 AM, Dmitry Torokhov wrote:
> > > > > On Fri, May 08, 2015 at 07:45:48AM +0530, Viresh Kumar wrote:
> > > > > > On 8 May 2015 at 07:23, Marek Vasut <marex@denx.de> wrote:
> > > > > > > Use msecs_to_jiffies(20) instead of plain (HZ / 50), as the
> > > > > > > former is much more explicit about it's behavior. We want
> > > > > > > to schedule the task 20 mS from now, so make it explicit in
> > > > > > > the code.
> > > > > > > 
> > > > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > > > > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > > > > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > > ---
> > > > > > > 
> > > > > > >  drivers/input/touchscreen/stmpe-ts.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > 
> > > > > Applied both, thank you.
> > > > 
> > > > Thank you! Shall I submit them for -stable as well please ?
> > > 
> > > Please.
> > 
> > Hi,
> > 
> > these patches still didn't make it for Linus's tree. I cannot submit
> > to -stable unless they hit Linus's tree to my knowledge. Shall I wait
> > some more please ?
> 
> They are in -next. I guess I could get them in 4.1...

In case it's not much of a hassle for everyone involved, it would be nice.
Otherwise, I will just wait for 4.2 merge window to open and submit for
stable after that. Just let me know what you prefer and I will do so.

Best regards,
Marek Vasut
