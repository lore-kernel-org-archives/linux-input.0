From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Fri, 8 May 2015 03:51:51 +0200
Message-ID: <201505080351.51784.marex@denx.de>
References: <1430869596-7044-1-git-send-email-marex@denx.de> <201505060236.14358.marex@denx.de> <20150506235928.GG5580@dtor-ws>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57394 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbEHByC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2015 21:54:02 -0400
In-Reply-To: <20150506235928.GG5580@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Thursday, May 07, 2015 at 01:59:28 AM, Dmitry Torokhov wrote:
[...]

Hi!

> > Maybe I'm fixing two bugs here ? The problem I really had is that with
> > kernel HZ set to 250 and the original code, the work was scheduled and
> > executed too quickly, so my touchscreen was bouncing between pendown and
> > penup events back and forth, without doing any usaful work.
> > 
> > I tried changing the code to HZ/5 instead of HZ/50 and that fixes my
> > issue as well.
> > 
> > My impression is that using msec_to_jiffies() is clearer especially
> > if the code is to represent a constant delay.
> 
> It is indeed clearer and I would not mind such conversion, we just need
> to adjust the comment why we do that.
> 
> > But maybe I should then
> > document why I changed the duration (because the original one was too
> > short) ?
> 
> Please make a separate patch for that with separate justification.
> 
> Thanks!

Roger, will do, thank you!

Best regards,
Marek Vasut
