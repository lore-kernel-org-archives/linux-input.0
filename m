From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Mon, 18 Oct 2010 09:12:10 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713094520E36@LIMKCMBX1.ad.analog.com>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
 <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
 <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
 <20101018040810.GB7782@core.coreip.homeip.net>
 <20101018042428.GA23778@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:8710 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab0JRIMP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 04:12:15 -0400
In-Reply-To: <20101018042428.GA23778@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier.adi@gmail.com>
Cc: Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry Torokhov wrote on 2010-10-18:
> On Sun, Oct 17, 2010 at 09:08:10PM -0700, Dmitry Torokhov wrote:
>> On Fri, Oct 15, 2010 at 09:51:12PM -0400, Mike Frysinger wrote:
>>> On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com>
> wrote:
>>>> Suppress events where pressure > pressure_max.
>>>> These events come typically along with inaccurate X and Y
> samples.
>>>
>>> were you going to commit to the blackfin tree ?
>>>
>>>> --- a/drivers/input/touchscreen/ad7877.c
>>>> +++ b/drivers/input/touchscreen/ad7877.c
>>>> @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
>>>>                Rt /= z1;
>>>>                Rt = (Rt + 2047) >> 12;
>>>>
>>>> +               /*
>>>> +                * Sample found inconsistent, pressure is beyond
>>>> +                * the maximum. Don't report it to user space.
>>>> +                */
>>>> +               if (Rt > ts->pressure_max)
>>>> +                       return -EINVAL;
>>>
>>> this has spaces in the middle of your tab indents ...
>>
>> I took care of that on my side...
>>
>
> BTW, I have a couple more small patches to the driver... Here is the
> first:
>
> Input: ad7877 - use attribute group to control visibility of attributes
>
> Instead of manually creating one set of attributes or another set up
> is_visible method in attribute group structure to control whether
> aux3 or gpio3 attribute is oresented to userspace.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>
>  drivers/input/touchscreen/ad7877.c |   49 +++++++++++++++++++++-------
>  -------- 1 files changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7877.c
> b/drivers/input/touchscreen/ad7877.c index b7de78e..326d733 100644 ---
> a/drivers/input/touchscreen/ad7877.c +++
> b/drivers/input/touchscreen/ad7877.c @@ -206,8 +206,8 @@ struct ad7877 {
>       u16 conversion_data[AD7877_NR_SENSE] ____cacheline_aligned;  };
> -static int gpio3;
> -module_param(gpio3, int, 0);
> +static bool gpio3;
> +module_param(gpio3, bool, 0);
>  MODULE_PARM_DESC(gpio3, "If gpio3 is set to 1 AUX3 acts as GPIO3");
>
>  /*
> @@ -471,7 +471,7 @@ static void ad7877_enable(struct ad7877 *ts)
> #define SHOW(name) static ssize_t \  name ## _show(struct device *dev,
> struct device_attribute *attr, char *buf) \  { \
> -     struct ad7877   *ts = dev_get_drvdata(dev); \
> +     struct ad7877 *ts = dev_get_drvdata(dev); \
>       ssize_t v = ad7877_read_adc(ts->spi, \                  AD7877_READ_CHAN(name)); \
>       if (v < 0) \ @@ -491,7 +491,7 @@ SHOW(temp2) static ssize_t
>  ad7877_disable_show(struct device *dev,                                   struct
>  device_attribute *attr, char *buf) {
> -     struct ad7877   *ts = dev_get_drvdata(dev);
> +     struct ad7877 *ts = dev_get_drvdata(dev);
>
>       return sprintf(buf, "%u\n", ts->disabled);  } @@ -521,7 +521,7 @@
> static DEVICE_ATTR(disable, 0664, ad7877_disable_show,
> ad7877_disable_store);  static ssize_t ad7877_dac_show(struct device
> *dev,
>                                    struct device_attribute *attr, char *buf) {
> -     struct ad7877   *ts = dev_get_drvdata(dev);
> +     struct ad7877 *ts = dev_get_drvdata(dev);
>
>       return sprintf(buf, "%u\n", ts->dac);  } @@ -551,7 +551,7 @@ static
> DEVICE_ATTR(dac, 0664, ad7877_dac_show, ad7877_dac_store);  static
> ssize_t ad7877_gpio3_show(struct device *dev,
>                                    struct device_attribute *attr, char *buf) {
> -     struct ad7877   *ts = dev_get_drvdata(dev);
> +     struct ad7877 *ts = dev_get_drvdata(dev);
>
>       return sprintf(buf, "%u\n", ts->gpio3);  } @@ -582,7 +582,7 @@
> static DEVICE_ATTR(gpio3, 0664, ad7877_gpio3_show,
> ad7877_gpio3_store); static ssize_t ad7877_gpio4_show(struct device *dev,
>                                    struct device_attribute *attr, char *buf) {
> -     struct ad7877   *ts = dev_get_drvdata(dev);
> +     struct ad7877 *ts = dev_get_drvdata(dev);
>
>       return sprintf(buf, "%u\n", ts->gpio4);  } @@ -615,16 +615,35 @@
>  static struct attribute *ad7877_attributes[] = {     &dev_attr_temp2.attr,
>       &dev_attr_aux1.attr,    &dev_attr_aux2.attr, +  &dev_attr_aux3.attr,
>       &dev_attr_bat1.attr,    &dev_attr_bat2.attr,    &dev_attr_disable.attr,
>       &dev_attr_dac.attr, +   &dev_attr_gpio3.attr,   &dev_attr_gpio4.attr,
>       NULL };
> +static mode_t ad7877_attr_is_visible(struct kobject *kobj,
> +                                  struct attribute *attr, int n) {
> +     mode_t mode = attr->mode;
> +
> +     if (attr == &dev_attr_aux3.attr) {
> +             if (gpio3)
> +                     mode = 0;
> +     } else if (attr == &dev_attr_gpio3.attr) {
> +             if (!gpio3)
> +                     mode = 0;
> +     }
> +
> +     return mode;
> +}
> +
>  static const struct attribute_group ad7877_attr_group = {
> -     .attrs = ad7877_attributes,
> +     .is_visible     = ad7877_attr_is_visible,
> +     .attrs          = ad7877_attributes,
>  };
>
>  static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct
> ad7877 *ts) @@ -787,20 +806,12 @@ static int __devinit
> ad7877_probe(struct spi_device *spi)
>       if (err)
>               goto err_free_irq;
> -     err = device_create_file(&spi->dev,
> -                              gpio3 ? &dev_attr_gpio3 : &dev_attr_aux3);
> -     if (err)
> -             goto err_remove_attr_group;
> -
>       err = input_register_device(input_dev);
>       if (err)
> -             goto err_remove_attr;
> +             goto err_remove_attr_group;
>
>       return 0;
> -err_remove_attr:
> -     device_remove_file(&spi->dev,
> -                        gpio3 ? &dev_attr_gpio3 : &dev_attr_aux3);
>  err_remove_attr_group:
>       sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
>  err_free_irq:
> @@ -814,11 +825,9 @@ err_free_mem:
>
>  static int __devexit ad7877_remove(struct spi_device *spi)  {
> -     struct ad7877           *ts = dev_get_drvdata(&spi->dev);
> +     struct ad7877 *ts = dev_get_drvdata(&spi->dev);
>
>       sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
> -     device_remove_file(&spi->dev,
> -                        gpio3 ? &dev_attr_gpio3 : &dev_attr_aux3);
>
>       ad7877_disable(ts);
>       free_irq(ts->spi->irq, ts);

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif

