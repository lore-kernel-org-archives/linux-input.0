From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 03/17] Input: sun4i-ts: Add thermal zone sensor support
Date: Thu, 8 Jan 2015 21:33:54 +0800
Message-ID: <CAGb2v64F8mQRka=L1qWKe=WNOUYtiC5RSZUDORr3Ynd3Djf20g@mail.gmail.com>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-4-git-send-email-wens@csie.org> <20150106152425.GA6276@developer>
 <CAGb2v66L-ZD1Ep-rnKXKP7PuJH+dA=26tV35KyKCNnKHgM4Hmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56628 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbbAHNeP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 08:34:15 -0500
In-Reply-To: <CAGb2v66L-ZD1Ep-rnKXKP7PuJH+dA=26tV35KyKCNnKHgM4Hmg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Thu, Jan 8, 2015 at 12:24 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> On Tue, Jan 6, 2015 at 11:24 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
>> Hello Chen-Yu,
>>
>>
>> On Tue, Jan 06, 2015 at 10:35:13AM +0800, Chen-Yu Tsai wrote:
>>> The touchscreen controller has a temperature sensor embedded in the SoC,
>>> which already has hwmon support in the driver.
>>>
>>> Add DT thermal zone support so we can use it with cpufreq for thermal
>>> throttling.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  .../bindings/input/touchscreen/sun4i.txt           |  1 +
>>>  drivers/input/touchscreen/sun4i-ts.c               | 27 ++++++++++++++++++++++
>>>  2 files changed, 28 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
>>> index aef57791f40b..7f1110adbd24 100644
>>> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
>>> @@ -5,6 +5,7 @@ Required properties:
>>>   - compatible: "allwinner,sun4i-a10-ts"
>>>   - reg: mmio address range of the chip
>>>   - interrupts: interrupt to which the chip is connected
>>> + - #thermal-sensor-cells: shall be 0
>>>
>>
>> You may want to update your Example section too, below.
>> Example:
>>
>>         rtp: rtp@01c25000 {
>>                 compatible = "allwinner,sun4i-a10-ts";
>>                 reg = <0x01c25000 0x100>;
>>                 interrupts = <29>;
>>                 allwinner,ts-attached;
>>                 #thermal-sensor-cells = <0>;
>>         };
>
> Ok.
>
>>
>>
>>>  Optional properties:
>>>   - allwinner,ts-attached: boolean indicating that an actual touchscreen is
>>> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
>>> index 28a06749ae42..b6e9043446d6 100644
>>> --- a/drivers/input/touchscreen/sun4i-ts.c
>>> +++ b/drivers/input/touchscreen/sun4i-ts.c
>>> @@ -34,6 +34,7 @@
>>>
>>>  #include <linux/err.h>
>>>  #include <linux/hwmon.h>
>>> +#include <linux/thermal.h>
>>>  #include <linux/init.h>
>>>  #include <linux/input.h>
>>>  #include <linux/interrupt.h>
>>> @@ -107,6 +108,7 @@
>>>  struct sun4i_ts_data {
>>>       struct device *dev;
>>>       struct input_dev *input;
>>> +     struct thermal_zone_device *tz;
>>>       void __iomem *base;
>>>       unsigned int irq;
>>>       bool ignore_fifo_data;
>>> @@ -180,6 +182,23 @@ static void sun4i_ts_close(struct input_dev *dev)
>>>       writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>>>  }
>>>
>>> +static int get_temp(void *data, long *temp)
>>> +{
>>> +     struct sun4i_ts_data *ts = data;
>>> +
>>> +     /* No temp_data until the first irq */
>>> +     if (ts->temp_data == -1)
>>> +             return -EAGAIN;
>>> +
>>> +     *temp = (ts->temp_data - 1447) * 100;
>>> +
>>
>> Care to explain the formula in a simple comment?
>
> This was just copied from the hwmon section. AFAIK there is no documentation
> for the formula. It was probably copied from Allwinner's SDK code.
>
> Hans? Do you remember where you got this?

So this is from the AXP209 datasheet. The Allwinner SoC datasheets don't
mention the formula to calculate the temperature. But since Allwinner
and X-powers are affiliated, it's possible they use the same formula.

http://comments.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/3838

>>> +     return 0;
>>> +}
>>> +
>>> +static struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
>>> +     .get_temp = get_temp,
>>> +};
>>> +
>>>  static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
>>>                        char *buf)
>>>  {
>>> @@ -288,6 +307,11 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>>>       if (IS_ERR(hwmon))
>>>               return PTR_ERR(hwmon);
>>>
>>> +     ts->tz = thermal_zone_of_sensor_register(ts->dev, 0, ts,
>>> +                                              &sun4i_ts_tz_ops);
>>> +     if (IS_ERR(ts->tz))
>>> +             ts->tz = NULL;
>>> +
>>>       writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>>>
>>>       if (ts_attached) {
>>
>> here.. if input_register_device fails, you will keep an orphan thermal zone
>> registered in your system:
>>
>>                 error = input_register_device(ts->input);
>>                 if (error) {
>>                         writel(0, ts->base + TP_INT_FIFOC);
>
> Will add an unregister call here.
>
>
> Thanks for the review.
>
> ChenYu
>
>>                         return error;
>>                 }
>>                 ...
>>
>>
>>> @@ -310,6 +334,9 @@ static int sun4i_ts_remove(struct platform_device *pdev)
>>>       if (ts->input)
>>>               input_unregister_device(ts->input);
>>>
>>> +     if (ts->tz)
>>> +             thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
>>> +
>>>       /* Deactivate all IRQs */
>>>       writel(0, ts->base + TP_INT_FIFOC);
>>>
>>> --
>>> 2.1.4
>>>
