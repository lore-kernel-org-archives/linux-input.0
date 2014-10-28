From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Tue, 28 Oct 2014 09:02:44 +0900
Message-ID: <000001cff242$80476680$80d63380$%han@samsung.com>
References: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com>
 <20141027233744.GC7594@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44005 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbaJ1AC2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 20:02:28 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE40090GO412GA0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Tue, 28 Oct 2014 09:02:26 +0900 (KST)
In-reply-to: <20141027233744.GC7594@dtor-ws>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, October 28, 2014 8:38 AM, Dmitry Torokhov wrote:
> On Mon, Oct 27, 2014 at 09:32:58PM +0900, Jingoo Han wrote:
> > Add CONFIG_PM_SLEEP to suspend/resume functions
> >
> > Add CONFIG_PM_SLEEP to suspend/resume functions instead of
> > CONFIG_PM to fix the following build warning when CONFIG_PM_SLEEP
> > is not selected and CONFIG_PM is selected. This is because sleep
> > PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when the
> > CONFIG_PM_SLEEP is enabled.
> 
> Recently I've become a fan of __maybe_unused markings as they insulate
> us from various CONFIG changes in unrelated subsystems, I'll transform
> this patch to use them instead.

OK, I see. I have no objection.
Then, how about changing other usages of CONFIG_PM_SLEEP/CONFIG_PM
to __maybe_unused annotation? Personally, I prefer to increase build
coverage than using #ifdef guards. Someone, however, argued that #ifdef
guards should be used in this case because the size of binary can be
reduced. How about your opinion?
Thank you.

Best regards,
Jingoo Han

> 
> Thanks.
> 
> >
> > drivers/input/keyboard/spear-keyboard.c:292:12: warning: 'spear_kbd_suspend' defined but not used [-
> Wunused-function]
> > drivers/input/keyboard/spear-keyboard.c:345:12: warning: 'spear_kbd_resume' defined but not used [-
> Wunused-function]
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/input/keyboard/spear-keyboard.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> > index 258af10..fc93e79 100644
> > --- a/drivers/input/keyboard/spear-keyboard.c
> > +++ b/drivers/input/keyboard/spear-keyboard.c
> > @@ -288,7 +288,7 @@ static int spear_kbd_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >
> > -#ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> >  static int spear_kbd_suspend(struct device *dev)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> > --
> > 1.7.9.5
> >
> >
> 
> --
> Dmitry

