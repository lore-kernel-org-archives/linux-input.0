From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/5] input/cma3000_d0x: Check silicon version
Date: Tue, 18 Oct 2011 09:34:21 +0100
Message-ID: <4E9D3A0D.9070108@cam.ac.uk>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com> <1318926486-10330-3-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318926486-10330-3-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/18/11 09:28, Ricardo Ribalda Delgado wrote:
> Improve probing of the cma3000 chip, by checking the revision of the
> device.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/input/misc/cma3000_d0x.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
> index 2f993d5..9899742 100644
> --- a/drivers/input/misc/cma3000_d0x.c
> +++ b/drivers/input/misc/cma3000_d0x.c
> @@ -26,6 +26,8 @@
>  
>  #include "cma3000_d0x.h"
>  
> +#define CMA3000_REV         0x10
> +
>  #define CMA3000_WHOAMI      0x00
>  #define CMA3000_REVID       0x01
>  #define CMA3000_CTRL        0x02
> @@ -373,9 +375,20 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
>  		error = rev;
>  		goto err_free_mem;
>  	}
> -
> +	if (rev != CMA3000_REV) {
> +		error = -EINVAL;
> +		pr_err("CMA3000 Accelerometer: Unknown Revision %x\n", rev);
warning perhaps rather than error?
> +		goto err_free_mem;
> +	}
>  	pr_info("CMA3000 Accelerometer: Revision %x\n", rev);
>  
> +	rev = CMA3000_READ(data, CMA3000_WHOAMI, "WhoamI");
> +	if (rev < 0) {
> +		error = rev;
> +		goto err_free_mem;
> +	}
> +	pr_info("CMA3000 Accelerometer: WhoamI %x\n", rev);
> +
Patch could do with a statement of why anyone would care about this.
>  	error = request_threaded_irq(irq, NULL, cma3000_thread_irq,
>  				     pdata->irqflags | IRQF_ONESHOT,
>  				     "cma3000_d0x", data);
