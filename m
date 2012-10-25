From: Sourav <sourav.poddar@ti.com>
Subject: Re: [RFT/PATCH] Input: omap4-keypad - switch to use managed resources
Date: Thu, 25 Oct 2012 18:31:32 +0530
Message-ID: <5089382C.2020202@ti.com>
References: <20121025074559.GA17710@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36137 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932770Ab2JYNBK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 09:01:10 -0400
In-Reply-To: <20121025074559.GA17710@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi Dmitry,
On Thursday 25 October 2012 01:16 PM, Dmitry Torokhov wrote:
> Now that input core supports devres-managed input devices we can clean
> up this driver a bit.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Just compiled, no hardware to test.
>
>   drivers/input/keyboard/omap4-keypad.c | 182 ++++++++++++++--------------------
>   1 file changed, 76 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index c05f98c..327388a 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -241,17 +241,60 @@ static inline int omap4_keypad_parse_dt(struct device *dev,
>   }
>   #endif
>   
> +static int __devinit omap4_keypad_setup_regs(struct device *dev,
> +					     struct omap4_keypad *keypad_data)
> +{
> +	unsigned int rev;
> +	int retval;
> +
> +	/*
> +	 * Enable clocks for the keypad module so that we can read
> +	 * revision register.
> +	 */
> +	pm_runtime_enable(dev);
> +
> +	retval = pm_runtime_get_sync(dev);
> +	if (retval) {
> +		dev_err(dev, "%s: pm_runtime_get_sync() failed: %d\n",
> +			__func__, retval);
> +		goto out;
> +	}
> +
> +	rev = __raw_readl(keypad_data->base + OMAP4_KBD_REVISION);
> +	rev &= 0x03 << 30;
> +	rev >>= 30;
> +	switch (rev) {
> +	case KBD_REVISION_OMAP4:
> +		keypad_data->reg_offset = 0x00;
> +		keypad_data->irqreg_offset = 0x00;
> +		break;
> +	case KBD_REVISION_OMAP5:
> +		keypad_data->reg_offset = 0x10;
> +		keypad_data->irqreg_offset = 0x0c;
> +		break;
> +	default:
> +		dev_err(dev, "Keypad reports unsupported revision %d", rev);
> +		retval = -EINVAL;
> +		break;
> +	}
> +
> +	pm_runtime_put_sync(dev);
> +
> +out:
> +	pm_runtime_disable(dev);
> +	return retval;
> +}
> +
>   static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>   {
> -	const struct omap4_keypad_platform_data *pdata =
> -				dev_get_platdata(&pdev->dev);
> +	struct device *dev = &pdev->dev;
> +	const struct omap4_keypad_platform_data *pdata = dev_get_platdata(dev);
>   	const struct matrix_keymap_data *keymap_data =
>   				pdata ? pdata->keymap_data : NULL;
>   	struct omap4_keypad *keypad_data;
>   	struct input_dev *input_dev;
>   	struct resource *res;
> -	unsigned int max_keys;
> -	int rev;
> +	size_t keymap_size;
>   	int irq;
>   	int error;
>   
> @@ -267,9 +310,10 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
> +	keypad_data = devm_kzalloc(dev, sizeof(struct omap4_keypad),
> +				   GFP_KERNEL);
>   	if (!keypad_data) {
> -		dev_err(&pdev->dev, "keypad_data memory allocation failed\n");
> +		dev_err(dev, "keypad_data memory allocation failed\n");
>   		return -ENOMEM;
>   	}
>   
> @@ -279,64 +323,25 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>   		keypad_data->rows = pdata->rows;
>   		keypad_data->cols = pdata->cols;
>   	} else {
> -		error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
> +		error = omap4_keypad_parse_dt(dev, keypad_data);
>   		if (error)
>   			return error;
>   	}
>   
> -	res = request_mem_region(res->start, resource_size(res), pdev->name);
> -	if (!res) {
> -		dev_err(&pdev->dev, "can't request mem region\n");
> -		error = -EBUSY;
> -		goto err_free_keypad;
> -	}
> -
> -	keypad_data->base = ioremap(res->start, resource_size(res));
> -	if (!keypad_data->base) {
> -		dev_err(&pdev->dev, "can't ioremap mem resource\n");
> -		error = -ENOMEM;
> -		goto err_release_mem;
> -	}
> +	keypad_data->base = devm_request_and_ioremap(dev, res);
> +	if (!keypad_data->base)
> +		return -EBUSY;
>   
> -
> -	/*
> -	 * Enable clocks for the keypad module so that we can read
> -	 * revision register.
> -	 */
> -	pm_runtime_enable(&pdev->dev);
> -	error = pm_runtime_get_sync(&pdev->dev);
> -	if (error) {
> -		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
> -		goto err_unmap;
> -	}
> -	rev = __raw_readl(keypad_data->base + OMAP4_KBD_REVISION);
> -	rev &= 0x03 << 30;
> -	rev >>= 30;
> -	switch (rev) {
> -	case KBD_REVISION_OMAP4:
> -		keypad_data->reg_offset = 0x00;
> -		keypad_data->irqreg_offset = 0x00;
> -		break;
> -	case KBD_REVISION_OMAP5:
> -		keypad_data->reg_offset = 0x10;
> -		keypad_data->irqreg_offset = 0x0c;
> -		break;
> -	default:
> -		dev_err(&pdev->dev,
> -			"Keypad reports unsupported revision %d", rev);
> -		error = -EINVAL;
> -		goto err_pm_put_sync;
> -	}
> +	error = omap4_keypad_setup_regs(dev, keypad_data);
> +	if (error)
> +		return error;
>   
>   	/* input device allocation */
> -	keypad_data->input = input_dev = input_allocate_device();
> -	if (!input_dev) {
> -		error = -ENOMEM;
> -		goto err_pm_put_sync;
> -	}
> +	keypad_data->input = input_dev = devm_input_allocate_device(dev);
> +	if (!input_dev)
> +		return -ENOMEM;
>   
>   	input_dev->name = pdev->name;
> -	input_dev->dev.parent = &pdev->dev;
>   	input_dev->id.bustype = BUS_HOST;
>   	input_dev->id.vendor = 0x0001;
>   	input_dev->id.product = 0x0001;
> @@ -352,81 +357,46 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>   	input_set_drvdata(input_dev, keypad_data);
>   
>   	keypad_data->row_shift = get_count_order(keypad_data->cols);
> -	max_keys = keypad_data->rows << keypad_data->row_shift;
> -	keypad_data->keymap = kzalloc(max_keys * sizeof(keypad_data->keymap[0]),
> -				      GFP_KERNEL);
> +	keymap_size = (keypad_data->rows << keypad_data->row_shift) *
> +			sizeof(keypad_data->keymap[0]);
> +	keypad_data->keymap = devm_kzalloc(dev, keymap_size, GFP_KERNEL);
>   	if (!keypad_data->keymap) {
> -		dev_err(&pdev->dev, "Not enough memory for keymap\n");
> -		error = -ENOMEM;
> -		goto err_free_input;
> +		dev_err(dev, "Not enough memory for keymap\n");
> +		return -ENOMEM;
>   	}
>   
>   	error = matrix_keypad_build_keymap(keymap_data, NULL,
>   					   keypad_data->rows, keypad_data->cols,
>   					   keypad_data->keymap, input_dev);
>   	if (error) {
> -		dev_err(&pdev->dev, "failed to build keymap\n");
> -		goto err_free_keymap;
> +		dev_err(dev, "failed to build keymap\n");
> +		return error;
>   	}
>   
> -	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
> -			     IRQF_TRIGGER_RISING,
> -			     "omap4-keypad", keypad_data);
> +	error = devm_request_irq(dev, keypad_data->irq, omap4_keypad_interrupt,
> +				 IRQF_TRIGGER_RISING,
> +				 "omap4-keypad", keypad_data);
>   	if (error) {
> -		dev_err(&pdev->dev, "failed to register interrupt\n");
> -		goto err_free_input;
> +		dev_err(dev, "failed to register interrupt\n");
> +		return error;
>   	}
>   
> -	pm_runtime_put_sync(&pdev->dev);
> -
>   	error = input_register_device(keypad_data->input);
>   	if (error < 0) {
> -		dev_err(&pdev->dev, "failed to register input device\n");
> -		goto err_pm_disable;
> +		dev_err(dev, "failed to register input device\n");
> +		return error;
>   	}
>   
>   	platform_set_drvdata(pdev, keypad_data);
> -	return 0;
> +	pm_runtime_enable(dev);
>   
> -err_pm_disable:
> -	pm_runtime_disable(&pdev->dev);
> -	free_irq(keypad_data->irq, keypad_data);
> -err_free_keymap:
> -	kfree(keypad_data->keymap);
> -err_free_input:
> -	input_free_device(input_dev);
> -err_pm_put_sync:
> -	pm_runtime_put_sync(&pdev->dev);
> -err_unmap:
> -	iounmap(keypad_data->base);
> -err_release_mem:
> -	release_mem_region(res->start, resource_size(res));
> -err_free_keypad:
> -	kfree(keypad_data);
> -	return error;
> +	return 0;
>   }
>   
>   static int __devexit omap4_keypad_remove(struct platform_device *pdev)
>   {
> -	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> -	struct resource *res;
> -
> -	free_irq(keypad_data->irq, keypad_data);
> -
>   	pm_runtime_disable(&pdev->dev);
>   
> -	input_unregister_device(keypad_data->input);
> -
> -	iounmap(keypad_data->base);
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -
> -	kfree(keypad_data->keymap);
> -	kfree(keypad_data);
> -
> -	platform_set_drvdata(pdev, NULL);
> -
>   	return 0;
>   }
>   
I tested this particular patch and found a warning during the bootup[1]. 
Even, the keypad functionality
was not intact and the interrupt was not coming.
[1]: Boot warning
[    1.738006] Initializing USB Mass Storage driver...
[    1.743377] usbcore: registered new interface driver usb-storage
[    1.749694] USB Mass Storage support registered.
[    1.754791] usbcore: registered new interface driver usbtest
[    1.761566] mousedev: PS/2 mouse device common for all mice
[    1.768890] input: 4a31c000.keypad as 
/devices/ocp.4/4a31c000.keypad/input/input0
[    1.776916] ------------[ cut here ]------------
[    1.781799] WARNING: at drivers/bus/omap_l3_noc.c:113 
l3_interrupt_handler+0x190/0x1c8()
[    1.790283] L3 custom error: MASTER:MPU TARGET:L4CFG
[    1.795471] Modules linked in:
[    1.798736] [<c001c848>] (unwind_backtrace+0x0/0xf4) from 
[<c0044794>] (warn_slowpath_common+0x4c/0x64)
[    1.808593] [<c0044794>] (warn_slowpath_common+0x4c/0x64) from 
[<c0044840>] (warn_slowpath_fmt+0x30/0x40)
[    1.818664] [<c0044840>] (warn_slowpath_fmt+0x30/0x40) from 
[<c02eceac>] (l3_interrupt_handler+0x190/0x1c8)
[    1.828887] [<c02eceac>] (l3_interrupt_handler+0x190/0x1c8) from 
[<c00a7ad8>] (handle_irq_event_percpu+0x64/0x244)
[    1.839782] [<c00a7ad8>] (handle_irq_event_percpu+0x64/0x244) from 
[<c00a7cf4>] (handle_irq_event+0x3c/0x5c)
[    1.850097] [<c00a7cf4>] (handle_irq_event+0x3c/0x5c) from 
[<c00aa8d0>] (handle_fasteoi_irq+0x98/0x13c)
[    1.859954] [<c00aa8d0>] (handle_fasteoi_irq+0x98/0x13c) from 
[<c00a7a64>] (generic_handle_irq+0x28/0x30)
[    1.870025] [<c00a7a64>] (generic_handle_irq+0x28/0x30) from 
[<c00154e0>] (handle_IRQ+0x4c/0xac)
[    1.879241] [<c00154e0>] (handle_IRQ+0x4c/0xac) from [<c00084c4>] 
(gic_handle_irq+0x2c/0x60)
[    1.888122] [<c00084c4>] (gic_handle_irq+0x2c/0x60) from [<c0514724>] 
(__irq_svc+0x44/0x5c)
[    1.896881] Exception stack(0xdc059d78 to 0xdc059dc0)
[    1.902191] 
9d60:                                                       dc00d9c0 
00000098
[    1.910766] 9d80: 00000000 00000001 fffffffa 00000001 da21c9bc 
00000001 da21c880 c07cbca0
[    1.919372] 9da0: da21c894 c0748ed8 00000018 dc059dc4 c00a78b0 
c02d2960 a0000113 ffffffff
[    1.927978] [<c0514724>] (__irq_svc+0x44/0x5c) from [<c02d2960>] 
(radix_tree_lookup+0x94/0xd4)
[    1.937011] [<c02d2960>] (radix_tree_lookup+0x94/0xd4) from 
[<00000001>] (0x1)
[    1.944641] ---[ end trace d7aa38c822c7e005 ]---
[    1.950256] omap4-keypad 4a31c000.keypad: input_register_device: 
registerign 4a31c000.keypad with devres.
[    1.962585] twl_rtc rtc.11: Power up reset detected.
[    1.968566] twl_rtc rtc.11: Enabling TWL-RTC
[    1.976409] twl_rtc rtc.11: rtc core: registered rtc.11 as rtc0
[    1.983123] i2c /dev entries driver

I did some hunk by hunk debugging of your patch and did a patch(inlined 
below) that helps us to get rid of this  issue:

From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] Input: omap4-keypad: Fix keypad functionality

Tested on omap4430 sdp with 3.7-rc1.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Index: linux-omap-storage/drivers/input/keyboard/omap4-keypad.c
===================================================================
--- linux-omap-storage.orig/drivers/input/keyboard/omap4-keypad.c 
2012-10-25 17:57:14.269204002 +0530
+++ linux-omap-storage/drivers/input/keyboard/omap4-keypad.c 2012-10-25 
17:57:58.905204001 +0530
@@ -278,8 +278,6 @@
                 break;
         }

-       pm_runtime_put_sync(dev);
-
  out:
         pm_runtime_disable(dev);
         return retval;
@@ -387,8 +385,9 @@
                 return error;
         }

+       pm_runtime_put_sync(dev);
+
         platform_set_drvdata(pdev, keypad_data);
-       pm_runtime_enable(dev);

         return 0;
  }

This patch seems to solve the warning and keypad functionality is restored.

