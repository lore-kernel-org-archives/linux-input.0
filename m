From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/3] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Fri, 29 Apr 2016 16:12:52 +0200
Message-ID: <57236BE4.908@denx.de>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>	<a93050366ed452b147652abfad21a87f4af87bfb.1461930102.git.ksenija.stanojevic@gmail.com>	<57235E75.9060409@denx.de> <CAL7P5j+E1WzC9AsS=ge4oHVTwq7Tov=kGbfJSKGyRzjg6Arg5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55058 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbcD2OM7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Apr 2016 10:12:59 -0400
In-Reply-To: <CAL7P5j+E1WzC9AsS=ge4oHVTwq7Tov=kGbfJSKGyRzjg6Arg5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?S3NlbmlqYSBTdGFub2pldmnEhw==?= <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>

On 04/29/2016 03:43 PM, Ksenija Stanojevi=C4=87 wrote:
> On Fri, Apr 29, 2016 at 3:15 PM, Marek Vasut <marex@denx.de> wrote:
>> On 04/29/2016 01:47 PM, Ksenija Stanojevic wrote:
>>> Add core files for mxs-lradc MFD driver.
>>>
>>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>>> ---
>>>  drivers/mfd/Kconfig           |  33 +++++--
>>>  drivers/mfd/Makefile          |   1 +
>>>  drivers/mfd/mxs-lradc.c       | 213 ++++++++++++++++++++++++++++++=
++++++++++++
>>>  include/linux/mfd/mxs-lradc.h | 210 ++++++++++++++++++++++++++++++=
+++++++++++
>>>  4 files changed, 449 insertions(+), 8 deletions(-)
>>>  create mode 100644 drivers/mfd/mxs-lradc.c
>>>  create mode 100644 include/linux/mfd/mxs-lradc.h
>>
>> Is there any chance you can also remove the same code from lradc ?
>=20
> You mean drivers/iio/adc/mxs-lradc.c. I thought to remove it once thi=
s
> patch set was accepted,
> but I can include that in patch set.

I'd much rather see one driver mutate into another than having two
drivers in the tree. If that's possible without crazy amount of effort
that is.

>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index eea61e3..fff44d6 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -16,7 +16,7 @@ config MFD_CS5535
>>>       depends on PCI && (X86_32 || (X86 && COMPILE_TEST))
>>>       ---help---
>>>         This is the core driver for CS5535/CS5536 MFD functions.  T=
his is
>>> -          necessary for using the board's GPIO and MFGPT functiona=
lity.
>>> +       necessary for using the board's GPIO and MFGPT functionalit=
y.
>>
>> Probably shouldn't be part of the patch ?
>=20
> Yeah, sorry about that.

:)

>>>  config MFD_ACT8945A
>>>       tristate "Active-semi ACT8945A"
>>> @@ -319,6 +319,23 @@ config MFD_HI6421_PMIC
>>>         menus in order to enable them.
>>>         We communicate with the Hi6421 via memory-mapped I/O.
>>>
>>> +config MFD_MXS_LRADC
>>> +     tristate "Freescale i.MX23/i.MX28 LRADC"
>>> +     depends on ARCH_MXS || COMPILE_TEST
>>> +     select MFD_CORE
>>> +     select STMP_DEVICE
>>> +     help
>>> +       Say yes here to build support for the low-resolution
>>> +       analog-to-digital converter (LRADC) found on the i.MX23 and=
 i.MX28
>>> +       processors. This driver provides common support for accessi=
ng the
>>> +       device, additional drivers must be enabled in order to use =
the
>>> +       functionality of the device:
>>> +             mxs-lradc-adc for ADC readings
>>> +             mxs-lradc-ts  for touchscreen support
>>> +
>>> +       This driver can also be built as a module. If so, the modul=
e will be
>>> +       called mxs-lradc.
>>> +
>>>  config HTC_EGPIO
>>>       bool "HTC EGPIO support"
>>>       depends on GPIOLIB && ARM
>>> @@ -650,7 +667,7 @@ config EZX_PCAP
>>>         needed for MMC, TouchScreen, Sound, USB, etc..
>>>
>>>  config MFD_VIPERBOARD
>>> -        tristate "Nano River Technologies Viperboard"
>>> +     tristate "Nano River Technologies Viperboard"
>>
>> Shouldn't be part of this patch
>=20
> No, I should have check it twice.

Yeah, but that's what the patch review process is for.

[...]

>>> +     ret =3D mfd_add_devices(&pdev->dev, -1, &lradc_ts_dev, 1, NUL=
L, 0, NULL);
>>
>> devm_mfd_add_devices()?
>>
>> You might want to split registration of each MFD subdev into separat=
e
>> function.
>=20
> Ok, I will fix it in v2

Just be careful not to introduce a race with enabling/disabling the
clock. That's something I am not sure about and something which might
bite you.

>>> +     if (ret) {
>>> +             dev_err(&pdev->dev,
>>> +                     "Failed to add the touchscreen subdevice\n");
>>> +             goto err_remove_adc;
>>> +     }
>>> +
>>> +     return 0;
>>> +
>>> +err_remove_adc:
>>> +     mfd_remove_devices(&pdev->dev);
>>> +err_clk:
>>> +     clk_disable_unprepare(lradc->clk);
>>> +     return ret;
>>> +}
>>> +
>>> +static int mxs_lradc_remove(struct platform_device *pdev)
>>> +{
>>> +     struct mxs_lradc *lradc =3D platform_get_drvdata(pdev);
>>> +
>>> +     mfd_remove_devices(&pdev->dev);
>>> +     clk_disable_unprepare(lradc->clk);
>>> +     return 0;
>>> +}
>>> +
>>> +static struct platform_driver mxs_lradc_driver =3D {
>>> +     .driver =3D {
>>> +             .name =3D "mxs-lradc",
>>> +             .of_match_table =3D mxs_lradc_dt_ids,
>>> +     },
>>> +     .probe =3D mxs_lradc_probe,
>>> +     .remove =3D mxs_lradc_remove,
>>> +};
>>> +
>>> +module_platform_driver(mxs_lradc_driver);
>>> +
>>> +MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:mxs-lradc");
>>
>> [...]
>>
>>
>> --
>> Best regards,
>> Marek Vasut


--=20
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
