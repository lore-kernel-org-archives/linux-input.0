From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: sirfsoc-onkey - use dev_get_drvdata instead
 of platform_get_drvdata
Date: Thu, 13 Feb 2014 08:39:23 -0800
Message-ID: <20140213163923.GA26175@core.coreip.homeip.net>
References: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
 <1392273624-22920-4-git-send-email-21cnbao@gmail.com>
 <20140213072459.GB23392@core.coreip.homeip.net>
 <CAGsJ_4ze3k2_ZQxkrRNiptqMVMm5taRTbFr0wmO9q5Q0kJLoNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35062 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaBMQj2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 11:39:28 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so10779789pdj.33
        for <linux-input@vger.kernel.org>; Thu, 13 Feb 2014 08:39:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ze3k2_ZQxkrRNiptqMVMm5taRTbFr0wmO9q5Q0kJLoNw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

On Thu, Feb 13, 2014 at 03:47:33PM +0800, Barry Song wrote:
> 2014-02-13 15:24 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Thu, Feb 13, 2014 at 02:40:23PM +0800, Barry Song wrote:
> >> From: Xianglong Du <Xianglong.Du@csr.com>
> >>
> >> In resume entry, use dev_get_drvdata() instead of to_platform_device(dev) +
> >> platform_get_drvdata(pdev).
> >>
> >> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> >> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> >> ---
> >>  drivers/input/misc/sirfsoc-onkey.c |    3 +--
> >>  1 files changed, 1 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> >> index 097c10a..8e45bf11 100644
> >> --- a/drivers/input/misc/sirfsoc-onkey.c
> >> +++ b/drivers/input/misc/sirfsoc-onkey.c
> >> @@ -157,8 +157,7 @@ static int sirfsoc_pwrc_remove(struct platform_device *pdev)
> >>  #ifdef CONFIG_PM_SLEEP
> >>  static int sirfsoc_pwrc_resume(struct device *dev)
> >>  {
> >> -     struct platform_device *pdev = to_platform_device(dev);
> >> -     struct sirfsoc_pwrc_drvdata *pwrcdrv = platform_get_drvdata(pdev);
> >> +     struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
> >
> > I believe we should use accessors matching the object type. Currently
> > dev_get_drvdata and platform_get_drvdata return the same object, but
> > they do not have to.
> >
> > IOW I prefer the original code.
> 
> i did see many commits in kernel which did same jobs with this one. e.g:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a1216394e620d0dfbb03c712ae3210e7b77c9e11
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bab8b563ef08455440badca7fe79b2c700bd1b75
> ...
> 
> in my understand, the changed context is a general pm_ops to general
> "driver" and not a legacy suspend/resume in "platform_driver" bound
> with pdev, so in the context, we are caring about "device" more than
> "pdev".

It is more about who owns the data - generic device or platform device?

> 
> how do you think if i do a more change in probe() with this by:
> 
> - platform_set_drvdata(pdev, pwrcdrv);
> + dev_set_drvdata(&pdev->dev, pwrcdrv);
> 
> would this make everything look fine?

Yes, it would, since we would now know that it is generic driver layer
that has ownership of this data item.

Thanks.

-- 
Dmitry
