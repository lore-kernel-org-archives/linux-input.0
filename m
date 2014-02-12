From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Wed, 12 Feb 2014 15:11:31 -0800
Message-ID: <20140212231131.GA29769@core.coreip.homeip.net>
References: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56591 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbaBLXLf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 18:11:35 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so9928634pad.0
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 15:11:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi Barry,

On Mon, Feb 10, 2014 at 06:07:39PM +0800, Barry Song wrote:
>  
>  static int sirfsoc_pwrc_remove(struct platform_device *pdev)
>  {
> +	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(&pdev->dev);
> +
>  	device_init_wakeup(&pdev->dev, 0);
>  
> +	cancel_delayed_work_sync(&pwrcdrv->work);
> +

This is racy: interrupt is freed later and can schedule work again.

Thanks.

-- 
Dmitry
