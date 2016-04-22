From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFT V2 3/3] iio: mxs-lradc: implement suspend/resume support
Date: Fri, 22 Apr 2016 17:47:13 +0200
Message-ID: <571A4781.5020407@denx.de>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com> <1461269478-449-4-git-send-email-stefan.wahren@i2se.com> <57193C01.20709@denx.de> <571A2DB8.9050509@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59165 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbcDVQyX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2016 12:54:23 -0400
In-Reply-To: <571A2DB8.9050509@i2se.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Juergen Borleis <jbe@pengutronix.de>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/22/2016 03:57 PM, Stefan Wahren wrote:
> Hi Marek,
> 
> Am 21.04.2016 um 22:45 schrieb Marek Vasut:
>> On 04/21/2016 10:11 PM, Stefan Wahren wrote:
>>> This patch implements suspend/resume support for mxs-lradc.
>>> It's possible to use the touchscreen as wakeup source.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>  drivers/iio/adc/mxs-lradc.c |   61 +++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>>> index cfc558f..6bd387f 100644
>>> --- a/drivers/iio/adc/mxs-lradc.c
>>> +++ b/drivers/iio/adc/mxs-lradc.c
>>> @@ -29,6 +29,7 @@
>>>  #include <linux/of.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/pm.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/stmp_device.h>
>>>  #include <linux/sysfs.h>
>>> @@ -1745,10 +1746,70 @@ static int mxs_lradc_remove(struct platform_device *pdev)
>>>  	return 0;
>>>  }
>>>  
>>> +static int __maybe_unused mxs_lradc_suspend(struct device *dev)
>>> +{
>>> +	struct iio_dev *iio = dev_get_drvdata(dev);
>>> +	struct mxs_lradc *lradc = iio_priv(iio);
>>> +	struct input_dev *input = lradc->ts_input;
>> Can lradc->ts_input contain some non-valid pointer ? You should make
>> sure it's either inited to NULL or valid pointer, which I'm not sure
>> you do.
> 
> the whole content of lradc get initialized with zero by
> devm_iio_device_alloc.

Ah, good.

> Or do you mean the error case that input registration failed and a
> suspend occur (if it's possible)|?

No, you cannot get suspend call before you registered the device.

> Stefan
> 
> |
>>
>>> +	int ret = 0;
>>> +
>>> +	if (input) {
>>> +		mutex_lock(&input->mutex);
>>> +
>>> +		/* Enable touchscreen wakeup irq */
>>> +		if (input->users && device_may_wakeup(dev))
>>> +			ret = enable_irq_wake(lradc->irq[0]);
>>> +		else
>>> +			mxs_lradc_disable_ts(lradc);
>>> +
>>> +		mutex_unlock(&input->mutex);
>>> +	}
>>> +
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mxs_lradc_hw_stop(lradc);
>>> +
>>> +	clk_disable_unprepare(lradc->clk);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int __maybe_unused mxs_lradc_resume(struct device *dev)
>>> +{
>>> +	struct iio_dev *iio = dev_get_drvdata(dev);
>>> +	struct mxs_lradc *lradc = iio_priv(iio);
>>> +	struct input_dev *input = lradc->ts_input;
>>> +	int ret;
>>> +
>>> +	ret = clk_prepare_enable(lradc->clk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mxs_lradc_hw_init(lradc);
>>> +
>>> +	if (input) {
>>> +		mutex_lock(&input->mutex);
>>> +
>>> +		/* Disable touchscreen wakeup irq */
>>> +		if (input->users && device_may_wakeup(dev))
>>> +			ret = disable_irq_wake(lradc->irq[0]);
>>> +		else
>>> +			mxs_lradc_enable_touch_detection(lradc);
>>> +
>>> +		mutex_unlock(&input->mutex);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(mxs_lradc_pm_ops, mxs_lradc_suspend, mxs_lradc_resume);
>>> +
>>>  static struct platform_driver mxs_lradc_driver = {
>>>  	.driver	= {
>>>  		.name	= DRIVER_NAME,
>>>  		.of_match_table = mxs_lradc_dt_ids,
>>> +		.pm	= &mxs_lradc_pm_ops,
>>>  	},
>>>  	.probe	= mxs_lradc_probe,
>>>  	.remove	= mxs_lradc_remove,
>>>
>> Looks OK otherwise:
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
> 
> 


-- 
Best regards,
Marek Vasut
