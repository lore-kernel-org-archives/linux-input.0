From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCHv3 2/7] input/cma3000_d0x: Check silicon version
Date: Tue, 18 Oct 2011 17:01:22 +0100
Message-ID: <4E9DA2D2.20800@cam.ac.uk>
References: <1318952886-835-1-git-send-email-ricardo.ribalda@gmail.com> <1318952886-835-3-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41114 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab1JRQBU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 12:01:20 -0400
In-Reply-To: <1318952886-835-3-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/18/11 16:48, Ricardo Ribalda Delgado wrote:
> Improve probing of the cma3000 chip, by checking the revision of the
> device.
Please carry acks forward with new versions if the patch hasn't changed
significantly.
> 
> ---
> 
> v2: Fixes suggested by Jonathan Cameron
> 	-Remove WhoamI pr_info
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/input/misc/cma3000_d0x.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
> index 604a32f..18ac912 100644
> --- a/drivers/input/misc/cma3000_d0x.c
> +++ b/drivers/input/misc/cma3000_d0x.c
> @@ -27,6 +27,8 @@
>  
>  #include "cma3000_d0x.h"
>  
> +#define CMA3000_REV         0x10
> +
>  #define CMA3000_WHOAMI      0x00
>  #define CMA3000_REVID       0x01
>  #define CMA3000_CTRL        0x02
> @@ -418,7 +420,11 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
>  		error = rev;
>  		goto err_free_mem;
>  	}
> -
> +	if (rev != CMA3000_REV) {
> +		error = -EINVAL;
> +		pr_err("CMA3000 Accelerometer: Unknown Revision %x\n", rev);
> +		goto err_free_mem;
> +	}
>  	pr_info("CMA3000 Accelerometer: Revision %x\n", rev);
>  
>  	error = request_threaded_irq(irq, NULL, cma3000_thread_irq,

