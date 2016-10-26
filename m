From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: da9063 - fix module autoload when registered
 via OF
Date: Wed, 26 Oct 2016 16:46:57 -0700
Message-ID: <20161026234657.GH27930@dtor-ws>
References: <1476460819-12809-1-git-send-email-javier@osg.samsung.com>
 <1476460819-12809-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35519 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcJZXrA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 19:47:00 -0400
Content-Disposition: inline
In-Reply-To: <1476460819-12809-2-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org

On Fri, Oct 14, 2016 at 01:00:19PM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/input/misc/da9063_onkey.ko | grep alias
> alias:          platform:da9063-onkey
> 
> After this patch:
> 
> $ modinfo drivers/input/misc/da9063_onkey.ko | grep alias
> alias:          platform:da9063-onkey
> alias:          of:N*T*Cdlg,da9062-onkeyC*
> alias:          of:N*T*Cdlg,da9062-onkey
> alias:          of:N*T*Cdlg,da9063-onkeyC*
> alias:          of:N*T*Cdlg,da9063-onkey
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> ---
> 
>  drivers/input/misc/da9063_onkey.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index bb863e062b03..f0d0543562df 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -87,6 +87,7 @@ static const struct of_device_id da9063_compatible_reg_id_table[] = {
>  	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, da9063_compatible_reg_id_table);
>  
>  static void da9063_poll_on(struct work_struct *work)
>  {
> -- 
> 2.7.4
> 

-- 
Dmitry
