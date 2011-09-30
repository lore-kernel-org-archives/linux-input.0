From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/imx_keypad: add pm suspend and resume functions
Date: Fri, 30 Sep 2011 02:12:29 -0700
Message-ID: <20110930091229.GA21336@core.coreip.homeip.net>
References: <1317369254-31146-1-git-send-email-jason77.wang@gmail.com>
 <4E857E25.4040503@cn.fujitsu.com>
 <4E858509.80303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45764 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757614Ab1I3JMe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Sep 2011 05:12:34 -0400
Received: by iaqq3 with SMTP id q3so1629313iaq.19
        for <linux-input@vger.kernel.org>; Fri, 30 Sep 2011 02:12:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E858509.80303@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: gaowanlong@cn.fujitsu.com, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org

On Fri, Sep 30, 2011 at 04:59:53PM +0800, Hui Wang wrote:
> Wanlong Gao wrote:
> >On 09/30/2011 03:54 PM, Hui Wang wrote:
> >>+
> >>+static int imx_kbd_resume(struct device *dev)
> >>+{
> >>+	struct platform_device *pdev = to_platform_device(dev);
> >>+	struct imx_keypad *kbd = platform_get_drvdata(pdev);
> >>+	struct input_dev *input_dev = kbd->input_dev;
> >>+
> >>+	mutex_lock(&input_dev->mutex);
> >>+
> >>+	if (device_may_wakeup(&pdev->dev))
> >>+		disable_irq_wake(kbd->irq);
> >>+
> >>+	if (input_dev->users)
> >>+		clk_enable(kbd->clk);
> >>+
> >>+	mutex_unlock(&input_dev->mutex);
> >>+
> >>+	return 0;
> >>+}
> >
> >	struct input_dev *input_dev = kbd->input_dev;
> >	if (device_may_wakeup(dev)) {
> >		disable_irq_wake(kdb->irq);
> >	} else {
> >		mutex_lock(&input_dev->mutex);
> >
> >		if (input_dev->users)
> >			clk_enable(kbd->clk);
> >
> >		mutex_unlock(&input_dev->mutex);
> >	}
> >
> So, if we unconditionally disable kpp clock in the suspend, we don't
> need above logic as well in the resume.

We should not unconditionally disable clock in suspend, you need to check
if there are any users (or drop check in resume), otherwise you'll get
unbalanced count in clk (suspend - decrement, resume - not enabling clk
if device is not being used).

Also locking is needed in suspend.

Thanks.

-- 
Dmitry
