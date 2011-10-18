From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCHv2 6/7] input/cma3000_d0x: Unwind reverse order of init
Date: Tue, 18 Oct 2011 14:15:56 +0100
Message-ID: <4E9D7C0C.5090805@cam.ac.uk>
References: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com> <1318939596-27330-7-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:59608 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab1JRNPx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 09:15:53 -0400
In-Reply-To: <1318939596-27330-7-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/18/11 13:06, Ricardo Ribalda Delgado 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/input/misc/cma3000_d0x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
> index e1d27d0..9836264 100644
> --- a/drivers/input/misc/cma3000_d0x.c
> +++ b/drivers/input/misc/cma3000_d0x.c
> @@ -407,8 +407,8 @@ EXPORT_SYMBOL(cma3000_init);
>  
>  void cma3000_exit(struct cma3000_accl_data *data)
>  {
> -	free_irq(data->irq, data);
>  	input_unregister_device(data->input_dev);
> +	free_irq(data->irq, data);
>  	kfree(data);
>  }
>  EXPORT_SYMBOL(cma3000_exit);

