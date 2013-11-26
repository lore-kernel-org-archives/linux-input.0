From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio: remove unnecessary pci_set_drvdata()
Date: Mon, 25 Nov 2013 18:11:29 -0800
Message-ID: <20131126021128.GA31517@core.coreip.homeip.net>
References: <001b01cee983$f894c510$e9be4f30$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:57616 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3KZCLh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Nov 2013 21:11:37 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so6765072pdj.31
        for <linux-input@vger.kernel.org>; Mon, 25 Nov 2013 18:11:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <001b01cee983$f894c510$e9be4f30$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org

On Mon, Nov 25, 2013 at 11:13:46AM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied, thank you.

> ---
>  drivers/input/serio/pcips2.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
> index 76f8383..13062f6 100644
> --- a/drivers/input/serio/pcips2.c
> +++ b/drivers/input/serio/pcips2.c
> @@ -181,7 +181,6 @@ static void pcips2_remove(struct pci_dev *dev)
>  	struct pcips2_data *ps2if = pci_get_drvdata(dev);
>  
>  	serio_unregister_port(ps2if->io);
> -	pci_set_drvdata(dev, NULL);
>  	kfree(ps2if);
>  	pci_release_regions(dev);
>  	pci_disable_device(dev);
> -- 
> 1.7.10.4
> 
> 

-- 
Dmitry
