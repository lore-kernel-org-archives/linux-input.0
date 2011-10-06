From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/16] input: ambakmi: Enable module alias autogeneration
 for AMBA drivers
Date: Wed, 5 Oct 2011 20:37:03 -0700
Message-ID: <20111006033702.GB20217@core.coreip.homeip.net>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
 <1317830707-17517-8-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48121 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab1JFDhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 23:37:11 -0400
Received: by iakk32 with SMTP id k32so2496894iak.19
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 20:37:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317830707-17517-8-git-send-email-dave.martin@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, =?utf-8?B?UGF3ZcWC?= Moll <Pawel.Moll@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-input@vger.kernel.org

On Wed, Oct 05, 2011 at 05:04:58PM +0100, Dave Martin wrote:
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Dmitry Torokhov <dtor@mail.ru>

> ---
>  drivers/input/serio/ambakmi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
> index 12abc50..8407d5b 100644
> --- a/drivers/input/serio/ambakmi.c
> +++ b/drivers/input/serio/ambakmi.c
> @@ -195,6 +195,8 @@ static struct amba_id amba_kmi_idtable[] = {
>  	{ 0, 0 }
>  };
>  
> +MODULE_DEVICE_TABLE(amba, amba_kmi_idtable);
> +
>  static struct amba_driver ambakmi_driver = {
>  	.drv		= {
>  		.name	= "kmi-pl050",
> -- 
> 1.7.4.1
> 

-- 
Dmitry
