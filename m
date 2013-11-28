From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: pcips2 - use DEFINE_PCI_DEVICE_TABLE macro
Date: Wed, 27 Nov 2013 19:56:37 -0800
Message-ID: <20131128035637.GA11139@core.coreip.homeip.net>
References: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
 <001b01ceebe0$82141940$863c4bc0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48317 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab3K1D4k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 22:56:40 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so11189586pdj.22
        for <linux-input@vger.kernel.org>; Wed, 27 Nov 2013 19:56:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <001b01ceebe0$82141940$863c4bc0$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org

On Thu, Nov 28, 2013 at 11:21:12AM +0900, Jingoo Han wrote:
> This macro is used to create a struct pci_device_id array.

Applied all 3, thank you.

> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/input/serio/pcips2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
> index 13062f6..2fff5d4 100644
> --- a/drivers/input/serio/pcips2.c
> +++ b/drivers/input/serio/pcips2.c
> @@ -186,7 +186,7 @@ static void pcips2_remove(struct pci_dev *dev)
>  	pci_disable_device(dev);
>  }
>  
> -static const struct pci_device_id pcips2_ids[] = {
> +static DEFINE_PCI_DEVICE_TABLE(pcips2_ids) = {
>  	{
>  		.vendor		= 0x14f2,	/* MOBILITY */
>  		.device		= 0x0123,	/* Keyboard */
> -- 
> 1.7.10.4
> 
> 

-- 
Dmitry
