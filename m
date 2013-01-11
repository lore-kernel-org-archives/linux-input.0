From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/4] Input: twl6040-vibra: Code cleanup in probe with
 devm_* conversion
Date: Fri, 11 Jan 2013 09:04:53 -0800
Message-ID: <20130111170453.GB11224@core.coreip.homeip.net>
References: <1357896483-20764-1-git-send-email-peter.ujfalusi@ti.com>
 <1357896483-20764-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357896483-20764-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Peter,

On Fri, Jan 11, 2013 at 10:28:02AM +0100, Peter Ujfalusi wrote:
> @@ -422,11 +413,8 @@ static int twl6040_vibra_remove(struct platform_device *pdev)
>  {
>  	struct vibra_info *info = platform_get_drvdata(pdev);
>  
> -	input_unregister_device(info->input_dev);
> -	free_irq(info->irq, info);
>  	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
>  	destroy_workqueue(info->workqueue);
> -	kfree(info);
>  


I do not think we can switch to managed resources while using
non-managed version of regulator_bulk_get, because with this patch you
shutting down regulators (presumably making device inoperable) while
the input device and interrupt are alive and kicking. BTW, the wq patch
should have been before this one in the queue as again you can't
destroy work queue while input device is active.

I see 3 ways here:

1. Change regulator core to allow separate owner device from the device
the resource is attached to.

2. Create custom version of devm_regulator_bulk_get() and use it in
twl6040.

3. Keep the resources unmanaged.

Unless there are many drivers like twl6040 to justify 1 I'd go with 3.

Thanks.

-- 
Dmitry
