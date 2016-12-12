From: Jingkui Wang <jkwang@google.com>
Subject: Re: [PATCH v2] drivers: Update drv260x driver
Date: Mon, 12 Dec 2016 11:05:30 -0800
Message-ID: <CACMZmvVS-_VqRv-bzXj25igKOiG4qkDWq-__O4naex_srPUWaw@mail.gmail.com>
References: <1481319926-47706-1-git-send-email-jkwang@google.com>
 <20161211072250.GA39300@dtor-ws> <CACMZmvUfkt3Fv4Lr42-mnbzYsUdAuC98XUzz2kg4c9bRLX2rJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35329 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbcLLTFb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 14:05:31 -0500
Received: by mail-oi0-f49.google.com with SMTP id b126so98540470oia.2
        for <linux-input@vger.kernel.org>; Mon, 12 Dec 2016 11:05:31 -0800 (PST)
In-Reply-To: <CACMZmvUfkt3Fv4Lr42-mnbzYsUdAuC98XUzz2kg4c9bRLX2rJA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org

Opps, sorry for containing html.
Thanks again.
Jingkui

On Mon, Dec 12, 2016 at 11:02 AM, Jingkui Wang <jkwang@google.com> wrote:
> It looks great! Really appreciate your help.
>
> Thanks,
> Jingkui Wang
>
> On Sat, Dec 10, 2016 at 11:22 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> Hi Jingkui,
>>
>> On Fri, Dec 09, 2016 at 01:45:26PM -0800, Jingkui Wang wrote:
>> > Update driver drv260x to use generic device properties
>> > Remove platform data and corresponding header file
>>
>> Please next time come up with more descriptive subject than "drivers:
>> Update drv260x driver": when scanning commit messages person shoudl be
>> able to gauge whether the change is interesting or not.
>>
>> > -static int drv260x_parse_dt(struct device *dev,
>> > +static int drv260x_read_device_property(struct device *dev,
>> >                           struct drv260x_data *haptics)
>> >  {
>> > -     struct device_node *np = dev->of_node;
>> >       unsigned int voltage;
>> >       int error;
>> >
>> > -     error = of_property_read_u32(np, "mode", &haptics->mode);
>> > +     error = device_property_read_u32(dev, "mode", &haptics->mode);
>> >       if (error) {
>> >               dev_err(dev, "%s: No entry for mode\n", __func__);
>> >               return error;
>> >       }
>> >
>> > -     error = of_property_read_u32(np, "library-sel",
>> > &haptics->library);
>> > +     error = device_property_read_u32(dev, "library-sel",
>> > &haptics->library);
>> >       if (error) {
>> >               dev_err(dev, "%s: No entry for library selection\n",
>> >                       __func__);
>> >               return error;
>> >       }
>>
>> Now that platform code is gone there it makes no sense separating
>> reading properties from validating the settings. Does the following
>> version look OK to you (it needs a patch introducing temporary in
>> probe() function, you'll find it attached)?
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>>
>> Input: drv260x - use generic device properties
>>
>> From: Jingkui Wang <jkwang@google.com>
>>
>> Update driver drv260x to use generic device properties so that it can be
>> used on non-DT systems. We also remove platform data as generic device
>> properties work on static board code as well.
>>
>> Signed-off-by: Jingkui Wang <jkwang@google.com>
>> Patchwork-Id: 9469075
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/input/misc/drv260x.c                |   80
>> ++++++---------------------
>>  include/linux/platform_data/drv260x-pdata.h |   28 ---------
>>  2 files changed, 19 insertions(+), 89 deletions(-)
>>  delete mode 100644 include/linux/platform_data/drv260x-pdata.h
>>
>> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
>> index 18c266c..11664d7 100644
>> --- a/drivers/input/misc/drv260x.c
>> +++ b/drivers/input/misc/drv260x.c
>> @@ -18,8 +18,6 @@
>>  #include <linux/i2c.h>
>>  #include <linux/input.h>
>>  #include <linux/module.h>
>> -#include <linux/of_gpio.h>
>> -#include <linux/platform_device.h>
>>  #include <linux/regmap.h>
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>> @@ -27,7 +25,6 @@
>>  #include <linux/regulator/consumer.h>
>>
>>  #include <dt-bindings/input/ti-drv260x.h>
>> -#include <linux/platform_data/drv260x-pdata.h>
>>
>>  #define DRV260X_STATUS         0x0
>>  #define DRV260X_MODE           0x1
>> @@ -468,54 +465,12 @@ static const struct regmap_config
>> drv260x_regmap_config = {
>>         .cache_type = REGCACHE_NONE,
>>  };
>>
>> -#ifdef CONFIG_OF
>> -static int drv260x_parse_dt(struct device *dev,
>> -                           struct drv260x_data *haptics)
>> -{
>> -       struct device_node *np = dev->of_node;
>> -       unsigned int voltage;
>> -       int error;
>> -
>> -       error = of_property_read_u32(np, "mode", &haptics->mode);
>> -       if (error) {
>> -               dev_err(dev, "%s: No entry for mode\n", __func__);
>> -               return error;
>> -       }
>> -
>> -       error = of_property_read_u32(np, "library-sel",
>> &haptics->library);
>> -       if (error) {
>> -               dev_err(dev, "%s: No entry for library selection\n",
>> -                       __func__);
>> -               return error;
>> -       }
>> -
>> -       error = of_property_read_u32(np, "vib-rated-mv", &voltage);
>> -       if (!error)
>> -               haptics->rated_voltage =
>> drv260x_calculate_voltage(voltage);
>> -
>> -
>> -       error = of_property_read_u32(np, "vib-overdrive-mv", &voltage);
>> -       if (!error)
>> -               haptics->overdrive_voltage =
>> drv260x_calculate_voltage(voltage);
>> -
>> -       return 0;
>> -}
>> -#else
>> -static inline int drv260x_parse_dt(struct device *dev,
>> -                                  struct drv260x_data *haptics)
>> -{
>> -       dev_err(dev, "no platform data defined\n");
>> -
>> -       return -EINVAL;
>> -}
>> -#endif
>> -
>>  static int drv260x_probe(struct i2c_client *client,
>>                          const struct i2c_device_id *id)
>>  {
>> -       const struct drv260x_platform_data *pdata =
>> dev_get_platdata(&client->dev);
>>         struct device *dev = &client->dev;
>>         struct drv260x_data *haptics;
>> +       u32 voltage;
>>         int error;
>>
>>         haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
>> @@ -525,29 +480,24 @@ static int drv260x_probe(struct i2c_client *client,
>>         haptics->overdrive_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
>>         haptics->rated_voltage = DRV260X_DEF_RATED_VOLT;
>>
>> -       if (pdata) {
>> -               haptics->mode = pdata->mode;
>> -               haptics->library = pdata->library_selection;
>> -               if (pdata->vib_overdrive_voltage)
>> -                       haptics->overdrive_voltage =
>> drv260x_calculate_voltage(pdata->vib_overdrive_voltage);
>> -               if (pdata->vib_rated_voltage)
>> -                       haptics->rated_voltage =
>> drv260x_calculate_voltage(pdata->vib_rated_voltage);
>> -       } else if (client->dev.of_node) {
>> -               error = drv260x_parse_dt(&client->dev, haptics);
>> -               if (error)
>> -                       return error;
>> -       } else {
>> -               dev_err(dev, "Platform data not set\n");
>> -               return -ENODEV;
>> +       error = device_property_read_u32(dev, "mode", &haptics->mode);
>> +       if (error) {
>> +               dev_err(dev, "Can't fetch 'mode' property: %d\n", error);
>> +               return error;
>>         }
>>
>> -
>>         if (haptics->mode < DRV260X_LRA_MODE ||
>>             haptics->mode > DRV260X_ERM_MODE) {
>>                 dev_err(dev, "Vibrator mode is invalid: %i\n",
>> haptics->mode);
>>                 return -EINVAL;
>>         }
>>
>> +       error = device_property_read_u32(dev, "library-sel",
>> &haptics->library);
>> +       if (error) {
>> +               dev_err(dev, "Can't fetch 'library-sel' property: %d\n",
>> error);
>> +               return error;
>> +       }
>> +
>>         if (haptics->library < DRV260X_LIB_EMPTY ||
>>             haptics->library > DRV260X_ERM_LIB_F) {
>>                 dev_err(dev,
>> @@ -569,6 +519,14 @@ static int drv260x_probe(struct i2c_client *client,
>>                 return -EINVAL;
>>         }
>>
>> +       error = device_property_read_u32(dev, "vib-rated-mv", &voltage);
>> +       haptics->rated_voltage = error ? DRV260X_DEF_RATED_VOLT :
>> +
>> drv260x_calculate_voltage(voltage);
>> +
>> +       error = device_property_read_u32(dev, "vib-overdrive-mv",
>> &voltage);
>> +       haptics->overdrive_voltage = error ? DRV260X_DEF_OD_CLAMP_VOLT :
>> +
>> drv260x_calculate_voltage(voltage);
>> +
>>         haptics->regulator = devm_regulator_get(dev, "vbat");
>>         if (IS_ERR(haptics->regulator)) {
>>                 error = PTR_ERR(haptics->regulator);
>> diff --git a/include/linux/platform_data/drv260x-pdata.h
>> b/include/linux/platform_data/drv260x-pdata.h
>> deleted file mode 100644
>> index 0a03b09..0000000
>> --- a/include/linux/platform_data/drv260x-pdata.h
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
>> -/*
>> - * Platform data for DRV260X haptics driver family
>> - *
>> - * Author: Dan Murphy <dmurphy@ti.com>
>> - *
>> - * Copyright:   (C) 2014 Texas Instruments, Inc.
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - * General Public License for more details.
>> - */
>> -
>> -#ifndef _LINUX_DRV260X_PDATA_H
>> -#define _LINUX_DRV260X_PDATA_H
>> -
>> -struct drv260x_platform_data {
>> -       u32 library_selection;
>> -       u32 mode;
>> -       u32 vib_rated_voltage;
>> -       u32 vib_overdrive_voltage;
>> -};
>> -
>> -#endif
>
>
