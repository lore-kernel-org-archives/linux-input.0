From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to suspend/resume functions
Date: Mon, 27 Oct 2014 17:35:57 -0700
Message-ID: <2274989.iT8abOtjsb@dtor-glaptop>
References: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com> <20141028001100.GF7594@dtor-ws> <000601cff246$e192a3b0$a4b7eb10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35875 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaJ1AgB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 20:36:01 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so4851701pad.11
        for <linux-input@vger.kernel.org>; Mon, 27 Oct 2014 17:36:00 -0700 (PDT)
In-Reply-To: <000601cff246$e192a3b0$a4b7eb10$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>

On Tuesday, October 28, 2014 09:34:06 AM Jingoo Han wrote:
> On Tuesday, October 28, 2014 9:11 AM, Dmitry Torokhov wrote:
> > On Tue, Oct 28, 2014 at 09:02:44AM +0900, Jingoo Han wrote:
> > > On Tuesday, October 28, 2014 8:38 AM, Dmitry Torokhov wrote:
> > > > On Mon, Oct 27, 2014 at 09:32:58PM +0900, Jingoo Han wrote:
> > > > > Add CONFIG_PM_SLEEP to suspend/resume functions
> > > > > 
> > > > > Add CONFIG_PM_SLEEP to suspend/resume functions instead of
> > > > > CONFIG_PM to fix the following build warning when CONFIG_PM_SLEEP
> > > > > is not selected and CONFIG_PM is selected. This is because sleep
> > > > > PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when the
> > > > > CONFIG_PM_SLEEP is enabled.
> > > > 
> > > > Recently I've become a fan of __maybe_unused markings as they insulate
> > > > us from various CONFIG changes in unrelated subsystems, I'll transform
> > > > this patch to use them instead.
> > > 
> > > OK, I see. I have no objection.
> > > Then, how about changing other usages of CONFIG_PM_SLEEP/CONFIG_PM
> > > to __maybe_unused annotation? Personally, I prefer to increase build
> > > coverage than using #ifdef guards. Someone, however, argued that #ifdef
> > > guards should be used in this case because the size of binary can be
> > > reduced. How about your opinion?
> > 
> > The optimizer is supposed to drop functions marked as '__maybe_unused'
> > if they are indeed unused so size of the binary should not change.
> 
> Oh, I really appreciate your reply. :-)
> Then, how about changing other usages of CONFIG_PM_SLEEP/CONFIG_PM
> to __maybe_unused annotation? If you don't have any objection, I will
> send one single patch for this.

That will work.

Thanks.

-- 
Dmitry
