From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
Date: Tue, 8 Nov 2016 14:37:36 +0100
Message-ID: <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:53042 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcKHNiH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 08:38:07 -0500
In-Reply-To: <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/26/2016 09:41 PM, Robert Jarzmik wrote:
> AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link one
> controller to 0 to 4 AC97 codecs.
> 
> The goal of this new implementation is to implement a device/driver
> model for AC97, with an automatic scan of the bus and automatic
> discovery of AC97 codec devices.
> 

Good work, a couple of comments inline.

[...]
> diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
> new file mode 100644
> index 000000000000..8901c1200522
> --- /dev/null
> +++ b/include/sound/ac97/codec.h
> @@ -0,0 +1,115 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __SOUND_AC97_CODEC2_H
> +#define __SOUND_AC97_CODEC2_H
> +
> +#include <linux/device.h>
> +
> +#define AC97_ID(vendor_id1, vendor_id2) \
> +	((((vendor_id1) & 0xffff) << 16) | ((vendor_id2) & 0xffff))
> +#define AC97_DRIVER_ID(vendor_id1, vendor_id2, mask_id1, mask_id2, _data) \
> +	{ .id = (((vendor_id1) & 0xffff) << 16) | ((vendor_id2) & 0xffff), \
> +	  .mask = (((mask_id1) & 0xffff) << 16) | ((mask_id2) & 0xffff), \
> +	  .data = (_data) }
> +
> +#define to_ac97_device(d) container_of(d, struct ac97_codec_device, dev)
> +#define to_ac97_driver(d) container_of(d, struct ac97_codec_driver, driver)

In my opinion these should be inline functions rather than macros as that
generates much more legible compiler errors e.g. in case there is a type
mismatch.

[...]
> +struct ac97_codec_driver {
> +	struct device_driver	driver;
> +	int			(*probe)(struct ac97_codec_device *);
> +	int			(*remove)(struct ac97_codec_device *);
> +	int			(*suspend)(struct ac97_codec_device *);
> +	int			(*resume)(struct ac97_codec_device *);
> +	void			(*shutdown)(struct ac97_codec_device *);

The suspend, resume and shutdown callbacks are never used. Which is good,
since all new frameworks should use dev_pm_ops. Just drop the from the struct.

> +	const struct ac97_id	*id_table;
> +};
[...]
> diff --git a/include/sound/ac97/controller.h b/include/sound/ac97/controller.h
> new file mode 100644
> index 000000000000..5ff59bd7e324
> --- /dev/null
> +++ b/include/sound/ac97/controller.h
> @@ -0,0 +1,85 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef AC97_CONTROLLER_H
> +#define AC97_CONTROLLER_H
> +
> +#include <linux/list.h>
> +
> +#define AC97_BUS_MAX_CODECS 4
> +#define AC97_SLOTS_AVAILABLE_ALL 0xf
> +
> +struct device;
> +
> +/**
> + * struct ac97_controller - The AC97 controller of the AC-Link
> + * @ops:		the AC97 operations.
> + * @controllers:	linked list of all existing controllers.
> + * @dev:		the device providing the AC97 controller.
> + * @slots_available:	the mask of accessible/scanable codecs.
> + * @codecs:		the 4 possible AC97 codecs (NULL if none found).
> + * @codecs_pdata:	platform_data for each codec (NULL if no pdata).
> + *
> + * This structure is internal to AC97 bus, and should not be used by the
> + * controllers themselves, excepting for using @dev.
> + */
> +struct ac97_controller {
> +	const struct ac97_controller_ops *ops;
> +	struct list_head controllers;
> +	struct device *dev;

I'd make the controller itself a struct dev, rather than just having the
pointer to the parent. This is more idiomatic and matches what other
subsystems do. It has several advantages, you get proper refcounting of your
controller structure, the controller gets its own sysfs directory where the
CODECs appear as children, you don't need the manual sysfs attribute
creation and removal in ac97_controler_{un,}register().

> +	unsigned short slots_available;
> +	struct ac97_codec_device *codecs[AC97_BUS_MAX_CODECS];

If you make the controller a struct dev you can also remove this, since the
device driver core tracks the children of a device.

> +	void *codecs_pdata[AC97_BUS_MAX_CODECS];
> +};
> +
> +/**
> + * struct ac97_controller_ops - The AC97 operations
> + * @reset:	Cold reset of the AC97 AC-Link.
> + * @warm_reset:	Warm reset of the AC97 AC-Link.
> + * @read:	Read of a single AC97 register.
> + *		Returns the register value or a negative error code.
> + * @write:	Write of a single AC97 register.
> + * @wait:	Wait for the current AC97 operation to finish (might be NULL).
> + * @init:	Initialization of the AC97 AC-Link (might be NULL).
> + *
> + * These are the basic operation an AC97 controller must provide for an AC97
> + * access functions. Amongst these, all but the last 2 are mandatory.
> + * The slot number is also known as the AC97 codec number, between 0 and 3.
> + */
> +struct ac97_controller_ops {
> +	void (*reset)(struct ac97_controller *adrv);
> +	void (*warm_reset)(struct ac97_controller *adrv);
> +	int (*write)(struct ac97_controller *adrv, int slot,
> +		     unsigned short reg, unsigned short val);
> +	int (*read)(struct ac97_controller *adrv, int slot, unsigned short reg);
> +	void (*wait)(struct ac97_controller *adrv, int slot);
> +	void (*init)(struct ac97_controller *adrv, int slot);

Neither wait nor init are ever used.

> +};
> +
[...]
> +/*
> + * Protects ac97_controllers and each ac97_controller structure.
> + */
> +static DEFINE_MUTEX(ac97_controllers_mutex);
> +static LIST_HEAD(ac97_controllers);
> +
> +static struct bus_type ac97_bus_type;
> +
> +static struct ac97_codec_device *
> +ac97_codec_find(struct ac97_controller *ac97_ctrl, int codec_num)

unsigned int codec_num

> +{
> +	if ((codec_num < 0) || (codec_num >= AC97_BUS_MAX_CODECS))
> +		return ERR_PTR(-ERANGE);

I'd make this EINVAL.

> +
> +	return ac97_ctrl->codecs[codec_num];
> +}
> +
> +static void ac97_codec_release(struct device *dev)
> +{
> +	struct ac97_codec_device *adev;
> +	struct ac97_controller *ac97_ctrl;
> +
> +	adev = container_of(dev, struct ac97_codec_device, dev);

to_ac97_device()

> +	ac97_ctrl = adev->ac97_ctrl;
> +	ac97_ctrl->codecs[adev->num] = NULL;
> +	sysfs_remove_link(&dev->kobj, "ac97_controller");
> +	kfree(adev);
> +}
> +
> +static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
> +		   unsigned int vendor_id)
> +{
> +	struct ac97_codec_device *codec;
> +	char *codec_name;
> +	int ret;
> +
> +	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
> +	if (!codec)
> +		return -ENOMEM;
> +	ac97_ctrl->codecs[idx] = codec;
> +	codec->vendor_id = vendor_id;
> +	codec->dev.release = ac97_codec_release;
> +	codec->dev.bus = &ac97_bus_type;
> +	codec->dev.parent = ac97_ctrl->dev;
> +	codec->num = idx;
> +	codec->ac97_ctrl = ac97_ctrl;
> +
> +	codec_name = kasprintf(GFP_KERNEL, "%s:%d", dev_name(ac97_ctrl->dev),
> +			       idx);
> +	codec->dev.init_name = codec_name;

init_name is only for statically allocated devices. Use dev_set_name(dev,
...). No need for kasprintf() either as dev_set_name() takes a format string.

For this you need to split device_register into device_initialize() and
device_add(). But usually that is what you want anyway.

> +
> +	ret = device_register(&codec->dev);
> +	kfree(codec_name);
> +	if (ret)
> +		goto err_free_codec;
> +
> +	ret = sysfs_create_link(&codec->dev.kobj, &ac97_ctrl->dev->kobj,
> +				"ac97_controller");

Since the CODEC is a child of the controller this should not be necessary as
this just points one directory up. It's like `ln -s .. parent`

> +	if (ret)
> +		goto err_unregister_device;
> +
> +	return 0;
> +err_unregister_device:
> +	put_device(&codec->dev);
> +err_free_codec:
> +	kfree(codec);

Since the struct is reference counted, the freeing is done in the release
callback and this leads to a double free.

> +	ac97_ctrl->codecs[idx] = NULL;
> +
> +	return ret;
> +}
[...]
> +/**
> + * snd_ac97_codec_driver_register - register an AC97 codec driver
> + * @dev: AC97 driver codec to register
> + *
> + * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
> + * controller.
> + *
> + * Returns 0 on success or error code
> + */
> +int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
> +{
> +	int ret;
> +
> +	drv->driver.bus = &ac97_bus_type;
> +
> +	ret = driver_register(&drv->driver);
> +	if (!ret)
> +		ac97_rescan_all_controllers();

Rescanning the bus when a new codec driver is registered should not be
neccessary. The bus is scanned once when the controller is registered, this
creates the device. The device driver core will take care of binding the
device to the driver, if the driver is registered after thed evice.

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(snd_ac97_codec_driver_register);
> +
[...]
> +static int ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
> +{
> +	int i;
> +
> +	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
> +		if (ac97_ctrl->codecs[i])
> +			put_device(&ac97_ctrl->codecs[i]->dev);

This should be device_unregister() to match the device_register() in
ac97_codec_add().

> +
> +	return 0;
> +}
> +
> +static ssize_t cold_reset_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len)
> +{
> +	struct ac97_controller *ac97_ctrl = ac97_ctrl_find(dev);
> +
> +	if (!dev)
> +		return -ENODEV;

dev is never NULL here. And for the ac97_ctrl there is a race condition. It
could be unregistered and freed after ac97_ctrl_find() returned sucessfully,
but before ac97_ctrl->ops is used.

> +
> +	ac97_ctrl->ops->reset(ac97_ctrl);
> +	return len;
> +}
> +static DEVICE_ATTR_WO(cold_reset);
> +
> +static ssize_t warm_reset_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len)
> +{
> +	struct ac97_controller *ac97_ctrl = ac97_ctrl_find(dev);
> +
> +	if (!dev)
> +		return -ENODEV;

Same here.

> +
> +	ac97_ctrl->ops->warm_reset(ac97_ctrl);
> +	return len;
> +}
> +static DEVICE_ATTR_WO(warm_reset);
> +
> +static struct attribute *ac97_controller_device_attrs[] = {
> +	&dev_attr_cold_reset.attr,
> +	&dev_attr_warm_reset.attr,
> +	NULL
> +};

This adds new userspace ABI that is not documented at the moment.

> +
> +static const struct attribute_group ac97_controller_attr_group = {
> +	.name	= "ac97_operations",
> +	.attrs	= ac97_controller_device_attrs,
> +};
> +
> +/**
> + * snd_ac97_controller_register - register an ac97 controller
> + * @ops: the ac97 bus operations
> + * @dev: the device providing the ac97 DC function
> + * @slots_available: mask of the ac97 codecs that can be scanned and probed
> + *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
> + *
> + * Register a digital controller which can control up to 4 ac97 codecs. This is
> + * the controller side of the AC97 AC-link, while the slave side are the codecs.
> + *
> + * Returns 0 upon success, negative value upon error
> + */
> +int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
> +				 struct device *dev,
> +				 unsigned short slots_available,
> +				 void **codecs_pdata)

In my opinion this should return a handle to a ac97 controller which can
then be passed to snd_ac97_controller_unregister(). This is in my opinion
the better approach rather than looking up the controller by parent device.

> +{
> +	struct ac97_controller *ac97_ctrl;
> +	int ret, i;
> +
> +	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
> +	if (!ac97_ctrl)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < AC97_BUS_MAX_CODECS && codecs_pdata; i++)
> +		ac97_ctrl->codecs_pdata[i] = codecs_pdata[i];
> +
> +	ret = sysfs_create_group(&dev->kobj, &ac97_controller_attr_group);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&ac97_controllers_mutex);
> +	ac97_ctrl->ops = ops;
> +	ac97_ctrl->slots_available = slots_available;
> +	ac97_ctrl->dev = dev;
> +	list_add(&ac97_ctrl->controllers, &ac97_controllers);

Stricly speeaking only the list_add needs to be protected.

> +	mutex_unlock(&ac97_controllers_mutex);
> +
> +	ac97_bus_reset(ac97_ctrl);
> +	ac97_bus_scan(ac97_ctrl);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(snd_ac97_controller_register);
> +
> +/**
> + * snd_ac97_controller_unregister - unregister an ac97 controller
> + * @dev: the device previously provided to ac97_controller_register()
> + *
> + * Returns 0 on success, negative upon error

Unregister must not be able to fail. Hotunplug is one of the core concepts
of the device driver model and there is really nothing that can be done to
prevent a device from disappearing, so there is no sensible way of handling
the error (and your pxa driver modifications simply ignore it as well).

This also means the framework needs to cope with the case where the
controller is removed and the CODEC devices are still present. All future
operations should return -ENODEV in that case.

> + */
> +int snd_ac97_controller_unregister(struct device *dev)
> +{
> +	struct ac97_controller *ac97_ctrl;
> +	int ret = -ENODEV, i;
> +
> +	mutex_lock(&ac97_controllers_mutex);
> +	ac97_ctrl = ac97_ctrl_find(dev);
> +	if (ac97_ctrl) {
> +		ret = 0;
> +		for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
> +			if (ac97_ctrl->codecs[i] &&
> +			    device_is_registered(&ac97_ctrl->codecs[i]->dev))
> +				ret = -EBUSY;
> +		if (!ret)
> +			ret = ac97_ctrl_codecs_unregister(ac97_ctrl);
> +		if (!ret) {
> +			list_del(&ac97_ctrl->controllers);
> +			sysfs_remove_group(&dev->kobj,
> +					   &ac97_controller_attr_group);
> +		}
> +	}
> +	mutex_unlock(&ac97_controllers_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(snd_ac97_controller_unregister);
[...]
> +static struct bus_type ac97_bus_type = {
> +	.name		= "ac97",
> +	.dev_attrs	= ac97_dev_attrs,

dev_attrs is deprecated in favor of dev_groups (See commit 880ffb5c6).

> +	.match		= ac97_bus_match,
> +	.pm		= &ac97_pm,
> +	.probe		= ac97_bus_probe,
> +	.remove		= ac97_bus_remove,
> +};
> +
> +static int __init ac97_bus_init(void)
> +{
> +	return bus_register(&ac97_bus_type);
> +}
> +subsys_initcall(ac97_bus_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
> diff --git a/sound/ac97/codec.c b/sound/ac97/codec.c
> new file mode 100644
> index 000000000000..a835f03744bf
> --- /dev/null
> +++ b/sound/ac97/codec.c
> @@ -0,0 +1,15 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <sound/ac97_codec.h>
> +#include <sound/ac97/codec.h>
> +#include <sound/ac97/controller.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <sound/soc.h>	/* For compat_ac97_* */
> +

I'm not sure I understand what this file does.

[...]

