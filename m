From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
Date: Wed, 9 Nov 2016 14:11:50 +0100
Message-ID: <5ae15e01-eaaf-4996-27ec-1179041c0268@metafoo.de>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
 <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
 <87eg2ly8k6.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87eg2ly8k6.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 11/08/2016 10:18 PM, Robert Jarzmik wrote:
[...]
>>> +/**
>>> + * struct ac97_controller - The AC97 controller of the AC-Link
>>> + * @ops:		the AC97 operations.
>>> + * @controllers:	linked list of all existing controllers.
>>> + * @dev:		the device providing the AC97 controller.
>>> + * @slots_available:	the mask of accessible/scanable codecs.
>>> + * @codecs:		the 4 possible AC97 codecs (NULL if none found).
>>> + * @codecs_pdata:	platform_data for each codec (NULL if no pdata).
>>> + *
>>> + * This structure is internal to AC97 bus, and should not be used by the
>>> + * controllers themselves, excepting for using @dev.
>>> + */
>>> +struct ac97_controller {
>>> +	const struct ac97_controller_ops *ops;
>>> +	struct list_head controllers;
>>> +	struct device *dev;
>>
>> I'd make the controller itself a struct dev, rather than just having the
>> pointer to the parent. This is more idiomatic and matches what other
>> subsystems do. It has several advantages, you get proper refcounting of your
>> controller structure, the controller gets its own sysfs directory where the
>> CODECs appear as children, you don't need the manual sysfs attribute
>> creation and removal in ac97_controler_{un,}register().
> 
> If you mean having "struct device dev" instead of "struct device *dev", it has
> also a drawback : all the legacy platforms have already a probing method, be
> that platform data, device-tree or something else.
> 
> I'm a bit converned about the conversion toll. Maybe I've not understood your
> point fully, so please feel free to explain, with an actual example even better.

This would be a struct device that is not bound to a driver, but just acts
as a shell for the controller and places it inside the device hierarchy. You
get reference counting and other management functions as well as a
consistent naming scheme. E.g. you can call the devices ac97c%d (or
something similar) and then call the CODEC ac97c%d.%d.

This is how most frameworks implementing some kind of control bus are
structured in the Linux kernel. E.g. take a look at I2C or SPI.

Your controller driver itself is unaffected by this, you still call
snd_ac97_controller_register() from the probe function and so on.

> 
>>> +	void (*wait)(struct ac97_controller *adrv, int slot);
>>> +	void (*init)(struct ac97_controller *adrv, int slot);
>>
>> Neither wait nor init are ever used.
> This is because I've not begun to porting sound/pci/ac97_codec.c into
> sound/ac97.

Ok, makes sense. But maybe just leave them out for now and add them when
they are used.

[...]
>>> +	ret = sysfs_create_link(&codec->dev.kobj, &ac97_ctrl->dev->kobj,
>>> +				"ac97_controller");
>>
>> Since the CODEC is a child of the controller this should not be necessary as
>> this just points one directory up. It's like `ln -s .. parent`
> This creates :
> /sys/bus/ac97/devices/pxa2xx-ac97\:0/ac97_controller
> 
> Of course as you pointed out, it's a 'ln -s .. parent' like link, but it seems
> to me very unfriendly to have :
>  - /sys/bus/ac97/devices/pxa2xx-ac97\:0/../ac97_operations
>  - while /sys/bus/ac97/devices/ac97_operations doesn't exist (obviously)
> 
> Mmm, I don't know for this one, my mind is not set, it's a bit hard to tell if
> it's only an unecessary link bringing "comfort", or something usefull.

It is additional ABI and we do not have this for any other bus either (e.g.
you don't see a backlink for a I2C or SPI device to the parent). In my
opinion for the sake of keeping things consistent and simple we should not
add this.

>>
>>> +	if (ret)
>>> +		goto err_unregister_device;
>>> +
>>> +	return 0;
>>> +err_unregister_device:
>>> +	put_device(&codec->dev);
>>> +err_free_codec:
>>> +	kfree(codec);
>>
>> Since the struct is reference counted, the freeing is done in the release
>> callback and this leads to a double free.
> A yes in the "goto err_unregister_device" case right, while it's necessary in
> the "goto err_free_codec" case ... I need to rework that a bit.

It should use put_device() in both cases, check the the device_register()
documentation. It says that put_device() must be used, even if
device_register() fails.

> 
>>> +int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
>>> +{
>>> +	int ret;
>>> +
>>> +	drv->driver.bus = &ac97_bus_type;
>>> +
>>> +	ret = driver_register(&drv->driver);
>>> +	if (!ret)
>>> +		ac97_rescan_all_controllers();
>>
>> Rescanning the bus when a new codec driver is registered should not be
>> neccessary. The bus is scanned once when the controller is registered, this
>> creates the device. The device driver core will take care of binding the
>> device to the driver, if the driver is registered after thed evice.
> That's because you suppose the initial scanning found all the ac97 codecs.
> But that's an incomplete vision as a codec might be powered off at that time and
> not seen by the first scanning, while the new scanning will discover it.

But why would the device become suddenly visible when the driver is
registered. This seems to be an as arbitrary point in time as any other.

Also consider that when you build a driver as a module, the module will
typically only be auto-loaded after the device has been detected, based on
the device ID. On the other hand, if the driver is built-in driver
registration will happen either before or shortly after the controller
registration.

If there is the expectation that the AC97 CODEC might randomly appear on the
bus, the core should periodically scan the bus.

[...]
>>> +	ac97_ctrl->ops->warm_reset(ac97_ctrl);
>>> +	return len;
>>> +}
>>> +static DEVICE_ATTR_WO(warm_reset);
>>> +
>>> +static struct attribute *ac97_controller_device_attrs[] = {
>>> +	&dev_attr_cold_reset.attr,
>>> +	&dev_attr_warm_reset.attr,
>>> +	NULL
>>> +};
>>
>> This adds new userspace ABI that is not documented at the moment.
> Very true. And as all userspace interface, it needs to be discussed. If nobody
> complains, I'll add the documentation for next patch round.
>>
>>> +int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
>>> +				 struct device *dev,
>>> +				 unsigned short slots_available,
>>> +				 void **codecs_pdata)
>>
>> In my opinion this should return a handle to a ac97 controller which can
>> then be passed to snd_ac97_controller_unregister(). This is in my opinion
>> the better approach rather than looking up the controller by parent device.
> This is another "legacy drivers" issue.
> 
> The legacy driver (the one probed by platform_data or devicetree) doesn't
> necessarily have a private structure to store this ac97_controller pointer.

I might be missing something, but I'm not convinced by this. Can you point
me to such a legacy driver where you think this would not work?
