From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Date: Sun, 29 May 2016 20:53:01 +0100
Message-ID: <509a10d9-fe46-b159-86be-12de0ccf5a5a@kernel.org>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
 <61fe1da2e8d82921f3222ec939047b6823f695e1.1461930102.git.ksenija.stanojevic@gmail.com>
 <bad220c7-7f72-55e8-fe41-e3a6ae7d7d2f@kernel.org>
 <CAL7P5jKukmxbK92oei+hOtsqcHjiBjKs2g7d7B7JsjgUxKRYAA@mail.gmail.com>
 <e2e0aa2d-dc26-cd23-1d45-837456104286@kernel.org>
 <CAL7P5jJYptf4OQE+d1AFLy92uajDTUD-B5Qsk-noBx36k3rGsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL7P5jJYptf4OQE+d1AFLy92uajDTUD-B5Qsk-noBx36k3rGsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Ksenija_Stanojevi=c4=87?= <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>, linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>
List-Id: linux-input@vger.kernel.org

<snip>
>>>>> +     if (of_property_read_u32(node, "fsl,settling", &adapt)) {
>>>>> +             ts->settling_delay = 10;
>>>>> +     } else {
>>>>> +             if (adapt < 1 || adapt > LRADC_DELAY_DELAY_MASK) {
>>>>> +                     dev_err(ts->dev, "Invalid settling delay (%u)\n",
>>>>> +                             adapt);
>>>>> +                     touch_ret = -EINVAL;
>>>>> +             } else {
>>>>> +                     ts->settling_delay = adapt;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     mxs_lradc_ts_hw_init(ts);
>>>>> +     for (i = 0; i < lradc->irq_count; i++) {
>>>>> +             ret = devm_request_irq(dev, lradc->irq[i],
>>>>> +                                    mxs_lradc_ts_handle_irq,
>>>>> +                                    IRQF_SHARED, lradc->irq_name[i], ts);
>>>> As with the adc driver, are we actually using all of these?  I'd prefer we
>>>> only grab the ones that are actually relevant.
>>>
>>> Only irq lines relevant for touchscreen are:
>>> mxs-lradc-touchscreen, mxs-lradc-channel6 and mxs-lradc-channel7
>>> But not all interrupts are beiing used even when I enabled all remaining
>>> channels (not used by touchscreen) for bufferd capture via
>>> echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltagexx_en
>>>
>>> So I don't know if it's supposed to work like this...
>>> (It works the same on the original code)
>> Certainly should only grab the relevant ones to touch screen use in here..
>> Original code probably being overly enthusiastic and we never noticed ;)
> 
> Sorry for being unclear...
> The point I was trying to make was that even though touchscreen and
> adc don't share irq lines, irqs mxs-lradc-channel(2,3,4,5,6) are never
> being used.
> So touchscreen is only use 2 out of 3 irqs assigned to it:
> mxs-lradc-touchscreen and mxs-lradc-channel7  . And adc
> is only using 2 irq lines mxs-lradc-channel(0,1) during buffered
> capture, even when all virtal channels are enabled.
> I found that odd...
odd indeed. It's odd hardware ;)

>From what I recall this hardware is capable of scheduling things in really
complex ways, but the driver elects not to use that, basically because it became
unmanageably complex and KISS was applied....

If there is an application needing that complexity we can revisit.

Of course there may be a better explanation ;)

Jonathan
> 
>>> root@cfa100xx:~# cat /proc/interrupts
>>>            CPU0
>>>  16:      13108         -  48 Edge      MXS Timer Tick
>>>  17:       4240         -  82 Edge      mxs-dma
>>>  25:          6         -  96 Edge      80010000.ssp
>>> 196:          0         -  68 Edge      mxs-dma
>>> 210:         13         -  10 Edge      mxs-lradc-touchscreen
>>> 211:          0         -  14 Edge      mxs-lradc-thresh0
>>> 212:          0         -  15 Edge      mxs-lradc-thresh1
>>> 213:         10         -  16 Edge      mxs-lradc-channel0
>>> 214:         10         -  17 Edge      mxs-lradc-channel1
>>> 215:          0         -  18 Edge      mxs-lradc-channel2
>>> 216:          0         -  19 Edge      mxs-lradc-channel3
>>> 217:          0         -  20 Edge      mxs-lradc-channel4
>>> 218:          0         -  21 Edge      mxs-lradc-channel5
>>> 219:          0         -  22 Edge      mxs-lradc-channel6
>>> 220:        412         -  23 Edge      mxs-lradc-channel7
>>> 221:          0         -  24 Edge      mxs-lradc-button0
>>> 222:          0         -  25 Edge      mxs-lradc-button1
>>> 223:          0         -  29 Edge      RTC alarm
>>> 224:          0         - 111 Edge      80058000.i2c
>>> 228:        174         -  47 Edge      uart-pl011
>>> 229:        439         -  93 Edge      80080000.usb
>>> 230:          0         -  92 Edge      80090000.usb
>>> 231:       3610         - 101 Edge      800f0000.ethernet
>>> 232:         10  80050000.lradc-dev0 Edge
>>> Err:          0
>>>
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +     }
>>>>> +
>>>>> +     if (!touch_ret) {
>>>>> +             ret = mxs_lradc_ts_register(ts);
>>>>> +             if (!ret)
>>>>> +                     goto err_ts_register;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +err_ts_register:
>>>>> +     mxs_lradc_ts_hw_stop(ts);
>>>>> +     return ret;
>>>>> +}
>>>>> +
>>>>> +static int mxs_lradc_ts_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +     struct mxs_lradc_ts *ts = platform_get_drvdata(pdev);
>>>>> +
>>>>> +     mxs_lradc_ts_hw_stop(ts);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static struct platform_driver mxs_lradc_ts_driver = {
>>>>> +     .driver = {
>>>>> +             .name = DRIVER_NAME_TS,
>>>>> +     },
>>>>> +     .probe  = mxs_lradc_ts_probe,
>>>>> +     .remove = mxs_lradc_ts_remove,
>>>>> +};
>>>>> +module_platform_driver(mxs_lradc_ts_driver);
>>>>> +
>>>>> +MODULE_LICENSE("GPL v2");
>>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 
