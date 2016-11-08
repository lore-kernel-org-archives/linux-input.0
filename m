From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
Date: Tue, 08 Nov 2016 22:18:33 +0100
Message-ID: <87eg2ly8k6.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
 <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de> (Lars-Peter
 Clausen's message of "Tue, 8 Nov 2016 14:37:36 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

Lars-Peter Clausen <lars@metafoo.de> writes:

> On 10/26/2016 09:41 PM, Robert Jarzmik wrote:
>> +#define to_ac97_device(d) container_of(d, struct ac97_codec_device, dev)
>> +#define to_ac97_driver(d) container_of(d, struct ac97_codec_driver, driver)
>
> In my opinion these should be inline functions rather than macros as that
> generates much more legible compiler errors e.g. in case there is a type
> mismatch.
Sure, why not.

>> +struct ac97_codec_driver {
>> +	struct device_driver	driver;
>> +	int			(*probe)(struct ac97_codec_device *);
>> +	int			(*remove)(struct ac97_codec_device *);
>> +	int			(*suspend)(struct ac97_codec_device *);
>> +	int			(*resume)(struct ac97_codec_device *);
>> +	void			(*shutdown)(struct ac97_codec_device *);
>
> The suspend, resume and shutdown callbacks are never used. Which is good,
> since all new frameworks should use dev_pm_ops. Just drop the from the struct.
Ok.

>> +/**
>> + * struct ac97_controller - The AC97 controller of the AC-Link
>> + * @ops:		the AC97 operations.
>> + * @controllers:	linked list of all existing controllers.
>> + * @dev:		the device providing the AC97 controller.
>> + * @slots_available:	the mask of accessible/scanable codecs.
>> + * @codecs:		the 4 possible AC97 codecs (NULL if none found).
>> + * @codecs_pdata:	platform_data for each codec (NULL if no pdata).
>> + *
>> + * This structure is internal to AC97 bus, and should not be used by the
>> + * controllers themselves, excepting for using @dev.
>> + */
>> +struct ac97_controller {
>> +	const struct ac97_controller_ops *ops;
>> +	struct list_head controllers;
>> +	struct device *dev;
>
> I'd make the controller itself a struct dev, rather than just having the
> pointer to the parent. This is more idiomatic and matches what other
> subsystems do. It has several advantages, you get proper refcounting of your
> controller structure, the controller gets its own sysfs directory where the
> CODECs appear as children, you don't need the manual sysfs attribute
> creation and removal in ac97_controler_{un,}register().

If you mean having "struct device dev" instead of "struct device *dev", it has
also a drawback : all the legacy platforms have already a probing method, be
that platform data, device-tree or something else.

I'm a bit converned about the conversion toll. Maybe I've not understood your
point fully, so please feel free to explain, with an actual example even better.

>> +	void (*wait)(struct ac97_controller *adrv, int slot);
>> +	void (*init)(struct ac97_controller *adrv, int slot);
>
> Neither wait nor init are ever used.
This is because I've not begun to porting sound/pci/ac97_codec.c into
sound/ac97.

>> +	if ((codec_num < 0) || (codec_num >= AC97_BUS_MAX_CODECS))
>> +		return ERR_PTR(-ERANGE);
>
> I'd make this EINVAL.
Ok.

>> +	adev = container_of(dev, struct ac97_codec_device, dev);
>
> to_ac97_device()
Sure.

>> +	codec_name = kasprintf(GFP_KERNEL, "%s:%d", dev_name(ac97_ctrl->dev),
>> +			       idx);
>> +	codec->dev.init_name = codec_name;
>
> init_name is only for statically allocated devices. Use dev_set_name(dev,
> ...). No need for kasprintf() either as dev_set_name() takes a format string.
I'll try again, I seem to remember having tried that and it failed, but I can't
remember why.

> For this you need to split device_register into device_initialize() and
> device_add(). But usually that is what you want anyway.
Let me try again.

>> +	ret = sysfs_create_link(&codec->dev.kobj, &ac97_ctrl->dev->kobj,
>> +				"ac97_controller");
>
> Since the CODEC is a child of the controller this should not be necessary as
> this just points one directory up. It's like `ln -s .. parent`
This creates :
/sys/bus/ac97/devices/pxa2xx-ac97\:0/ac97_controller

Of course as you pointed out, it's a 'ln -s .. parent' like link, but it seems
to me very unfriendly to have :
 - /sys/bus/ac97/devices/pxa2xx-ac97\:0/../ac97_operations
 - while /sys/bus/ac97/devices/ac97_operations doesn't exist (obviously)

Mmm, I don't know for this one, my mind is not set, it's a bit hard to tell if
it's only an unecessary link bringing "comfort", or something usefull.

>
>> +	if (ret)
>> +		goto err_unregister_device;
>> +
>> +	return 0;
>> +err_unregister_device:
>> +	put_device(&codec->dev);
>> +err_free_codec:
>> +	kfree(codec);
>
> Since the struct is reference counted, the freeing is done in the release
> callback and this leads to a double free.
A yes in the "goto err_unregister_device" case right, while it's necessary in
the "goto err_free_codec" case ... I need to rework that a bit.

>> +int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
>> +{
>> +	int ret;
>> +
>> +	drv->driver.bus = &ac97_bus_type;
>> +
>> +	ret = driver_register(&drv->driver);
>> +	if (!ret)
>> +		ac97_rescan_all_controllers();
>
> Rescanning the bus when a new codec driver is registered should not be
> neccessary. The bus is scanned once when the controller is registered, this
> creates the device. The device driver core will take care of binding the
> device to the driver, if the driver is registered after thed evice.
That's because you suppose the initial scanning found all the ac97 codecs.
But that's an incomplete vision as a codec might be powered off at that time and
not seen by the first scanning, while the new scanning will discover it.

>> +static int ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
>> +		if (ac97_ctrl->codecs[i])
>> +			put_device(&ac97_ctrl->codecs[i]->dev);
>
> This should be device_unregister() to match the device_register() in
> ac97_codec_add().
Right.

>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t cold_reset_store(struct device *dev,
>> +				struct device_attribute *attr, const char *buf,
>> +				size_t len)
>> +{
>> +	struct ac97_controller *ac97_ctrl = ac97_ctrl_find(dev);
>> +
>> +	if (!dev)
>> +		return -ENODEV;
>
> dev is never NULL here.
Ok.

> And for the ac97_ctrl there is a race condition. It could be unregistered and
> freed after ac97_ctrl_find() returned sucessfully, but before ac97_ctrl->ops
> is used.
A good catch, the ac97_controllers_mutex is missing.

> Same here.
Indeed.

>> +
>> +	ac97_ctrl->ops->warm_reset(ac97_ctrl);
>> +	return len;
>> +}
>> +static DEVICE_ATTR_WO(warm_reset);
>> +
>> +static struct attribute *ac97_controller_device_attrs[] = {
>> +	&dev_attr_cold_reset.attr,
>> +	&dev_attr_warm_reset.attr,
>> +	NULL
>> +};
>
> This adds new userspace ABI that is not documented at the moment.
Very true. And as all userspace interface, it needs to be discussed. If nobody
complains, I'll add the documentation for next patch round.
>
>> +int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
>> +				 struct device *dev,
>> +				 unsigned short slots_available,
>> +				 void **codecs_pdata)
>
> In my opinion this should return a handle to a ac97 controller which can
> then be passed to snd_ac97_controller_unregister(). This is in my opinion
> the better approach rather than looking up the controller by parent device.
This is another "legacy drivers" issue.

The legacy driver (the one probed by platform_data or devicetree) doesn't
necessarily have a private structure to store this ac97_controller pointer. This
enables an "easier" porting of existing drivers.

>> +/**
>> + * snd_ac97_controller_unregister - unregister an ac97 controller
>> + * @dev: the device previously provided to ac97_controller_register()
>> + *
>> + * Returns 0 on success, negative upon error
>
> Unregister must not be able to fail. Hotunplug is one of the core concepts
> of the device driver model and there is really nothing that can be done to
> prevent a device from disappearing, so there is no sensible way of handling
> the error (and your pxa driver modifications simply ignore it as well).
>
> This also means the framework needs to cope with the case where the
> controller is removed and the CODEC devices are still present. All future
> operations should return -ENODEV in that case.
Ah ... that will require a serious modification, and I see your point, so I'll
prepare this for next patchset.
>> +static struct bus_type ac97_bus_type = {
>> +	.name		= "ac97",
>> +	.dev_attrs	= ac97_dev_attrs,
>
> dev_attrs is deprecated in favor of dev_groups (See commit 880ffb5c6).
Ok.

>> index 000000000000..a835f03744bf
>> --- /dev/null
>> +++ b/sound/ac97/codec.c
>> @@ -0,0 +1,15 @@
>> +/*
>> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <sound/ac97_codec.h>
>> +#include <sound/ac97/codec.h>
>> +#include <sound/ac97/controller.h>
>> +#include <linux/device.h>
>> +#include <linux/slab.h>
>> +#include <sound/soc.h>	/* For compat_ac97_* */
>> +
>
> I'm not sure I understand what this file does.
Ah yes, I'll remove it.
It's the future conversion of sound/pci/ac97_codec.c, but it's ... empty so far.

Thanks very much for the very detailed review.

-- 
Robert
