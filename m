From: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
Subject: RE: [PATCH] Input: Introduce the use of managed version of kzalloc
Date: Fri, 9 May 2014 09:40:50 +0000
Message-ID: <24DF37198A1E704D9811D8F72B87EB51D98DF9EB@NB-EX-MBX02.diasemi.com>
References: <20140508040002.GA3307@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.118]:12001 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012AbaEIJrO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 May 2014 05:47:14 -0400
In-Reply-To: <20140508040002.GA3307@himangi-Dell>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>, Support Opensource <Support.Opensource@diasemi.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>

> -----Original Message-----
> From: Himangi Saraogi [mailto:himangi774@gmail.com]
> Sent: 08 May 2014 05:00
> To: Support Opensource; dmitry.torokhov@gmail.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: julia.lawall@lip6.fr
> Subject: [PATCH] Input: Introduce the use of managed version of kzalloc
> This patch moves data allocated using kzalloc to managed data allocated
> using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> functions. This data is the third argument to da9052_request_irq in the two
> cases below.

The remainder of the description .....

> The following Coccinelle semantic patch was used for making the change:
> @platform@
> identifier p, probefn, removefn;
> @@
> struct platform_driver p = {
>   .probe = probefn,
>   .remove = removefn,
> };
> @prb@
> identifier platform.probefn, pdev;
> expression e, e1, e2;
> @@
> probefn(struct platform_device *pdev, ...) {
>   <+...
> - e = kzalloc(e1, e2)
> + e = devm_kzalloc(&pdev->dev, e1, e2)
>   ...
> ?-kfree(e);
>   ...+>
> }
> @rem depends on prb@
> identifier platform.removefn;
> expression e;
> @@
> removefn(...) {
>   <...
> - kfree(e);
>   ...>
> }

.... does not seems appropriate for the commit message, it should IMHO go in the following section

> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
> As a follow up patch I would like to know if it would be desirable to modify
> request_threaded_irq to devm_request_threaded_irq in the helper function
> da9052_request_irq :
> int da9052_request_irq(struct da9052 *da9052, int irq, char *name,
> 			   irq_handler_t handler, void *data) {
> 	irq = da9052_map_irq(da9052, irq);
> 	if (irq < 0)
> 		return irq;
> 	return request_threaded_irq(irq, NULL, handler,
> 				     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> 				     name, data);
> }

The problem here is that there is no way back to the 'dev' associated with the irq.
To solve this requires a change to the function, or even better, just placing the function's
code inline, in which case a two stage approach is required:- first 'inline' the function
(from the common header file) to each of the PMIC's component drivers and second
raise a patch for each component driver do the change as you suggest which will
work because the correct 'dev' is available. Not that the second stage will have to
wait until the first statge is actually in main-line.

>  drivers/input/misc/da9052_onkey.c      | 4 +---
>  drivers/input/touchscreen/da9052_tsi.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> diff --git a/drivers/input/misc/da9052_onkey.c
> b/drivers/input/misc/da9052_onkey.c
> index 184c8f2..6fc8243 100644
> --- a/drivers/input/misc/da9052_onkey.c
> +++ b/drivers/input/misc/da9052_onkey.c
> @@ -84,7 +84,7 @@ static int da9052_onkey_probe(struct platform_device
> *pdev)
>  		return -EINVAL;
>  	}
> 
> -	onkey = kzalloc(sizeof(*onkey), GFP_KERNEL);
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!onkey || !input_dev) {
>  		dev_err(&pdev->dev, "Failed to allocate memory\n"); @@ -
> 126,7 +126,6 @@ err_free_irq:
>  	cancel_delayed_work_sync(&onkey->work);
>  err_free_mem:
>  	input_free_device(input_dev);
> -	kfree(onkey);
> 
>  	return error;
>  }
> @@ -139,7 +138,6 @@ static int da9052_onkey_remove(struct
> platform_device *pdev)
>  	cancel_delayed_work_sync(&onkey->work);
> 
>  	input_unregister_device(onkey->input);
> -	kfree(onkey);
> 
>  	return 0;
>  }
> diff --git a/drivers/input/touchscreen/da9052_tsi.c
> b/drivers/input/touchscreen/da9052_tsi.c
> index ab64d58..dff6a2e 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -238,7 +238,7 @@ static int da9052_ts_probe(struct platform_device
> *pdev)
>  	if (!da9052)
>  		return -EINVAL;
> 
> -	tsi = kzalloc(sizeof(struct da9052_tsi), GFP_KERNEL);
> +	tsi = devm_kzalloc(&pdev->dev, sizeof(struct da9052_tsi),
> GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!tsi || !input_dev) {
>  		error = -ENOMEM;
> @@ -311,7 +311,6 @@ err_free_datardy_irq:
>  err_free_pendwn_irq:
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
>  err_free_mem:
> -	kfree(tsi);
>  	input_free_device(input_dev);
> 
>  	return error;
> @@ -327,7 +326,6 @@ static int  da9052_ts_remove(struct platform_device
> *pdev)
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> 
>  	input_unregister_device(tsi->dev);
> -	kfree(tsi);
> 
>  	return 0;
>  }
> --
> 1.9.1

for the content of this patch:

Acked-by: Opensource [Anthony Olech] <anthony.olech.opensource@diasemi.com>

