From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] HAPTIC: add HAPTIC class
Date: Tue, 8 Sep 2009 21:06:31 +0530
Message-ID: <5d5443650909080836j91f1d5cn3a7b32d41289c252@mail.gmail.com>
References: <4AA62BFF.2050703@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f190.google.com ([209.85.221.190]:53455 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZIHPo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 11:44:28 -0400
In-Reply-To: <4AA62BFF.2050703@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kmpark@infradead.org, dg77.kim@samsung.com

Hi Joonyoung Shim,

On Tue, Sep 8, 2009 at 3:33 PM, Joonyoung Shim<jy0922.shim@samsung.com>=
 wrote:
> This patch is for HAPTIC framework.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> ---
> I post this patch instead of Kyungmin Park.
> Maybe Kyungmin will make a description of the patch in the concrete.

Thanks for posting this patch, I can describe this code probably in
one word :) s/led_framework/haptics_framework :) I just hope it meets
most of the requirements of haptics devices.

Let's wait for Kyungmin Park to add some more text and hopefully not
so patents-breaking sample driver.

>
> =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/haptic/Kconfig =A0 =A0 =A0 =A0| =A0 14 ++++
> =A0drivers/haptic/Makefile =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/haptic/haptic-class.c | =A0165 +++++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/haptic/haptic.h =A0 =A0 =A0 | =A0 35 +++++++++
> =A0include/linux/haptic.h =A0 =A0 =A0 =A0| =A0 66 ++++++++++++++++
> =A08 files changed, 287 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/haptic/Kconfig
> =A0create mode 100644 drivers/haptic/Makefile
> =A0create mode 100644 drivers/haptic/haptic-class.c
> =A0create mode 100644 drivers/haptic/haptic.h
> =A0create mode 100644 include/linux/haptic.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aef63c8..86f0ef8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1463,6 +1463,8 @@ source "drivers/accessibility/Kconfig"
>
> =A0source "drivers/leds/Kconfig"
>
> +source "drivers/haptic/Kconfig"
> +
> =A0source "drivers/rtc/Kconfig"
>
> =A0source "drivers/dma/Kconfig"
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 48bbdbe..a44348e 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -90,6 +90,8 @@ source "drivers/memstick/Kconfig"
>
> =A0source "drivers/leds/Kconfig"
>
> +source "drivers/haptic/Kconfig"
> +
> =A0source "drivers/accessibility/Kconfig"
>
> =A0source "drivers/infiniband/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index bc4205d..29d3419 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -93,6 +93,7 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 +=3D idle/
> =A0obj-$(CONFIG_MMC) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D mmc/
> =A0obj-$(CONFIG_MEMSTICK) =A0 =A0 =A0 =A0 +=3D memstick/
> =A0obj-$(CONFIG_NEW_LEDS) =A0 =A0 =A0 =A0 +=3D leds/
> +obj-$(CONFIG_HAPTIC) =A0 =A0 =A0 =A0 =A0 +=3D haptic/
> =A0obj-$(CONFIG_INFINIBAND) =A0 =A0 =A0 +=3D infiniband/
> =A0obj-$(CONFIG_SGI_SN) =A0 =A0 =A0 =A0 =A0 +=3D sn/
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D firm=
ware/
> diff --git a/drivers/haptic/Kconfig b/drivers/haptic/Kconfig
> new file mode 100644
> index 0000000..fdbaa5c
> --- /dev/null
> +++ b/drivers/haptic/Kconfig
> @@ -0,0 +1,14 @@
> +menuconfig HAPTIC
> + =A0 =A0 =A0 bool "HAPTIC support"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y to enalbe haptic support. It enables the hapt=
ic and controlled
> + =A0 =A0 =A0 =A0 from both userspace and kernel
> +
> +if HAPTIC
> +
> +config HAPTIC_CLASS
> + =A0 =A0 =A0 tristate "Haptic Class Support"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option enables the haptic sysfs class in /sys/=
class/haptic.
> +
> +endif =A0# HAPTIC
> diff --git a/drivers/haptic/Makefile b/drivers/haptic/Makefile
> new file mode 100644
> index 0000000..d30f8cd
> --- /dev/null
> +++ b/drivers/haptic/Makefile
> @@ -0,0 +1,2 @@
> +# Haptic Core
> +obj-$(CONFIG_HAPTIC_CLASS) =A0 =A0 =A0 =A0 =A0 =A0 +=3D haptic-class=
=2Eo
> diff --git a/drivers/haptic/haptic-class.c b/drivers/haptic/haptic-cl=
ass.c
> new file mode 100644
> index 0000000..39a488f
> --- /dev/null
> +++ b/drivers/haptic/haptic-class.c
> @@ -0,0 +1,165 @@
> +/*
> + * =A0Haptic Class Core
> + *
> + * =A0Copyright (C) 2008 Samsung Electronics
> + * =A0Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/device.h>
> +#include <linux/rwsem.h>
> +#include <linux/sysdev.h>
> +#include <linux/timer.h>
> +#include <linux/err.h>
> +#include <linux/ctype.h>
> +#include <linux/haptic.h>
> +#include "haptic.h"
> +
> +static DECLARE_RWSEM(haptic_list_lock);
> +static LIST_HEAD(haptic_list);
> +static struct class *haptic_class;
> +
> +static void haptic_update_value(struct haptic_classdev *haptic_cdev)
> +{
> + =A0 =A0 =A0 if (haptic_cdev->get)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 haptic_cdev->value =3D haptic_cdev->get=
(haptic_cdev);
> +}
> +
> +static ssize_t haptic_value_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *bu=
f)
> +{
> + =A0 =A0 =A0 struct haptic_classdev *haptic_cdev =3D dev_get_drvdata=
(dev);
> + =A0 =A0 =A0 ssize_t ret =3D 0;
> +
> + =A0 =A0 =A0 /* no lock needed for this */
> + =A0 =A0 =A0 haptic_update_value(haptic_cdev);
> + =A0 =A0 =A0 sprintf(buf, "%u\n", haptic_get_value(haptic_cdev));
> + =A0 =A0 =A0 ret =3D strlen(buf) + 1;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static ssize_t haptic_value_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, const ch=
ar *buf, size_t size)
> +{
> + =A0 =A0 =A0 struct haptic_classdev *haptic_cdev =3D dev_get_drvdata=
(dev);
> + =A0 =A0 =A0 ssize_t ret =3D -EINVAL;
> + =A0 =A0 =A0 char *after;
> + =A0 =A0 =A0 unsigned long state =3D simple_strtoul(buf, &after, 10)=
;
> + =A0 =A0 =A0 size_t count =3D after - buf;
> +
> + =A0 =A0 =A0 if (*after && isspace(*after))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
> +
> + =A0 =A0 =A0 if (count =3D=3D size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 haptic_set_value(haptic_cdev, state);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static DEVICE_ATTR(value, 0644, haptic_value_show, haptic_value_stor=
e);
> +
> +/**
> + * haptic_classdev_suspend - suspend an haptic_classdev.
> + * @haptic_cdev: the haptic_classdev to suspend.
> + */
> +void haptic_classdev_suspend(struct haptic_classdev *haptic_cdev)
> +{
> + =A0 =A0 =A0 haptic_cdev->flags |=3D HAPTIC_SUSPENDED;
> + =A0 =A0 =A0 haptic_cdev->set(haptic_cdev, HAPTIC_OFF);
> +}
> +EXPORT_SYMBOL_GPL(haptic_classdev_suspend);
> +
> +/**
> + * haptic_classdev_resume - resume an haptic_classdev.
> + * @haptic_cdev: the haptic_classdev to resume.
> + */
> +void haptic_classdev_resume(struct haptic_classdev *haptic_cdev)
> +{
> + =A0 =A0 =A0 haptic_cdev->set(haptic_cdev, haptic_cdev->value);
> + =A0 =A0 =A0 haptic_cdev->flags &=3D ~HAPTIC_SUSPENDED;
> +}
> +EXPORT_SYMBOL_GPL(haptic_classdev_resume);
> +
> +/**
> + * haptic_classdev_register - register a new object of haptic_classd=
ev class.
> + * @dev: The device to register.
> + * @haptic_cdev: the haptic_classdev structure for this device.
> + */
> +int haptic_classdev_register(struct device *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
haptic_classdev *haptic_cdev)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 haptic_cdev->dev =3D device_create(haptic_class, parent=
, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 haptic_=
cdev, "%s", haptic_cdev->name);
> + =A0 =A0 =A0 if (IS_ERR(haptic_cdev->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(haptic_cdev->dev);
> +
> + =A0 =A0 =A0 /* register the attributes */
> + =A0 =A0 =A0 ret =3D device_create_file(haptic_cdev->dev, &dev_attr_=
value);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> +
> + =A0 =A0 =A0 /* add to the list of haptic */
> + =A0 =A0 =A0 down_write(&haptic_list_lock);
> + =A0 =A0 =A0 list_add_tail(&haptic_cdev->node, &haptic_list);
> + =A0 =A0 =A0 up_write(&haptic_list_lock);
> +
> + =A0 =A0 =A0 haptic_update_value(haptic_cdev);
> +
> + =A0 =A0 =A0 printk(KERN_INFO "Registered haptic device: %s\n", hapt=
ic_cdev->name);
> + =A0 =A0 =A0 return 0;
> +
> +err_out:
> + =A0 =A0 =A0 device_unregister(haptic_cdev->dev);
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL_GPL(haptic_classdev_register);
> +
> +/**
> + * haptic_classdev_unregister - unregisters a object of haptic_prope=
rties class.
> + * @haptic_cdev: the haptic device to unregister
> + *
> + * Unregisters a previously registered via haptic_classdev_register =
object.
> + */
> +void haptic_classdev_unregister(struct haptic_classdev *haptic_cdev)
> +{
> + =A0 =A0 =A0 device_remove_file(haptic_cdev->dev, &dev_attr_value);
> + =A0 =A0 =A0 device_unregister(haptic_cdev->dev);
> +
> + =A0 =A0 =A0 down_write(&haptic_list_lock);
> + =A0 =A0 =A0 list_del(&haptic_cdev->node);
> + =A0 =A0 =A0 up_write(&haptic_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(haptic_classdev_unregister);
> +
> +static int __init haptic_init(void)
> +{
> + =A0 =A0 =A0 haptic_class =3D class_create(THIS_MODULE, "haptic");
> + =A0 =A0 =A0 if (IS_ERR(haptic_class))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(haptic_class);
> + =A0 =A0 =A0 return 0;
> +}
> +subsys_initcall(haptic_init);
> +
> +static void __exit haptic_exit(void)
> +{
> + =A0 =A0 =A0 class_destroy(haptic_class);
> +}
> +module_exit(haptic_exit);
> +
> +MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Haptic Class Interface");
> diff --git a/drivers/haptic/haptic.h b/drivers/haptic/haptic.h
> new file mode 100644
> index 0000000..888aaa3
> --- /dev/null
> +++ b/drivers/haptic/haptic.h
> @@ -0,0 +1,35 @@
> +/*
> + * =A0Haptic Core
> + *
> + * =A0Copyright (C) 2008 Samsung Electronics
> + * =A0Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __HAPTIC_H_INCLUDED
> +#define __HAPTIC_H_INCLUDED
> +
> +#include <linux/device.h>
> +#include <linux/rwsem.h>
> +#include <linux/haptic.h>
> +
> +static inline void haptic_set_value(struct haptic_classdev *haptic_c=
dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 enum haptic_value value)
> +{
> + =A0 =A0 =A0 if (value > HAPTIC_FULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D HAPTIC_FULL;
> + =A0 =A0 =A0 haptic_cdev->value =3D value;
> + =A0 =A0 =A0 if (!(haptic_cdev->flags & HAPTIC_SUSPENDED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 haptic_cdev->set(haptic_cdev, value);
> +}
> +
> +static inline int haptic_get_value(struct haptic_classdev *haptic_cd=
ev)
> +{
> + =A0 =A0 =A0 return haptic_cdev->value;
> +}
> +
> +#endif /* __HAPTIC_H_INCLUDED */
> diff --git a/include/linux/haptic.h b/include/linux/haptic.h
> new file mode 100644
> index 0000000..34160fd
> --- /dev/null
> +++ b/include/linux/haptic.h
> @@ -0,0 +1,66 @@
> +/*
> + * =A0Driver model for haptic
> + *
> + * =A0Copyright (C) 2008 Samsung Electronics
> + * =A0Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __LINUX_HAPTIC_H_INCLUDED
> +#define __LINUX_HAPTIC_H_INCLUDED
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/rwsem.h>
> +
> +struct device;
> +/*
> + * Motor Core
> + */
> +
> +enum haptic_value {
> + =A0 =A0 =A0 HAPTIC_OFF =A0 =A0 =A0=3D 0,
> + =A0 =A0 =A0 HAPTIC_HALF =A0 =A0 =3D 127,
> + =A0 =A0 =A0 HAPTIC_FULL =A0 =A0 =3D 255,
> +};
> +
> +struct haptic_classdev {
> + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value;
> +#define HAPTIC_SUSPENDED =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0)
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags;
> +
> + =A0 =A0 =A0 /* Set haptic value */
> + =A0 =A0 =A0 /* Must not sleep, use a workqueue if needed */
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*set)(stru=
ct haptic_classdev *self,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 enum haptic_value value);
> + =A0 =A0 =A0 /* Get haptic value */
> + =A0 =A0 =A0 enum haptic_value =A0 =A0 =A0 (*get)(struct haptic_clas=
sdev *self);
> +
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0node; =A0 /* Motor Devi=
ce list */
> +};
> +
> +extern int haptic_classdev_register(struct device *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct haptic_classdev *haptic_cdev);
> +extern void haptic_classdev_unregister(struct haptic_classdev *lcd);
> +extern void haptic_classdev_suspend(struct haptic_classdev *haptic_c=
dev);
> +extern void haptic_classdev_resume(struct haptic_classdev *haptic_cd=
ev);
> +
> +/*
> + * Generic and gpio haptic platform data for describing haptic names=
=2E
> + */
> +struct haptic_platform_data {
> + =A0 =A0 =A0 const char =A0 =A0 =A0*name;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 pwm_timer;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 gpio;
> + =A0 =A0 =A0 void =A0 =A0(*setup_pin)(void);
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0active_low;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 ldo_level;
> +};
> +
> +#endif /* __LINUX_HAPTIC_H_INCLUDED */
> --
> 1.6.0.4
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
