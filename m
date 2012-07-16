From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V9] input: add onkey support to 88PM80X PMIC
Date: Mon, 16 Jul 2012 09:17:32 -0700
Message-ID: <20120716161732.GA5112@core.coreip.homeip.net>
References: <1342168363-14299-1-git-send-email-zhouqiao@marvell.com>
 <1342168363-14299-2-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50946 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab2GPQRi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 12:17:38 -0400
Received: by gglu4 with SMTP id u4so5164516ggl.19
        for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 09:17:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1342168363-14299-2-git-send-email-zhouqiao@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: sameo@linux.intel.com, linux-input@vger.kernel.org

Hi Qiao,

On Fri, Jul 13, 2012 at 04:32:43PM +0800, Qiao Zhou wrote:
> +
> +	ret = regmap_read(info->map, PM800_STATUS_1, &val);
> +	if (ret < 0) {
> +		pr_err("%s: failed to read status: %d\n", __func__, ret);

Please change this to

		dev_err(input_dev->dev.parent, "...")

so that error messages are consistent throughout your driver.

> +
> +static int __devexit pm80x_onkey_remove(struct platform_device *pdev)
> +{
> +	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
> +
> +	pm80x_free_irq(info->pm80x, info->irq, info);
> +	input_unregister_device(info->idev);
> +	kfree(info);

And add

	device_init_wakeup(&pdev->dev, 0);

Otherwise feel free to add

	Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

and merge with the rest of the patches (I assume they went through MFD
tree?).

Thanks.

-- 
Dmitry
