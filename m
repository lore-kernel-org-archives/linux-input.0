From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
Date: Wed, 09 Nov 2016 22:27:37 +0100
Message-ID: <87mvh8uywm.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
        <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
        <87eg2ly8k6.fsf@belgarion.home>
        <5ae15e01-eaaf-4996-27ec-1179041c0268@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <5ae15e01-eaaf-4996-27ec-1179041c0268@metafoo.de> (Lars-Peter
        Clausen's message of "Wed, 9 Nov 2016 14:11:50 +0100")
Sender: linux-pm-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Lars-Peter Clausen <lars@metafoo.de> writes:

> On 11/08/2016 10:18 PM, Robert Jarzmik wrote:
>>> I'd make the controller itself a struct dev, rather than just having the
>>> pointer to the parent. This is more idiomatic and matches what other
>>> subsystems do. It has several advantages, you get proper refcounting of your
>>> controller structure, the controller gets its own sysfs directory where the
>>> CODECs appear as children, you don't need the manual sysfs attribute
>>> creation and removal in ac97_controler_{un,}register().
>> 
>> If you mean having "struct device dev" instead of "struct device *dev", it has
>> also a drawback : all the legacy platforms have already a probing method, be
>> that platform data, device-tree or something else.
>> 
>> I'm a bit converned about the conversion toll. Maybe I've not understood your
>> point fully, so please feel free to explain, with an actual example even better.
>
> This would be a struct device that is not bound to a driver, but just acts
> as a shell for the controller and places it inside the device hierarchy. You
> get reference counting and other management functions as well as a
> consistent naming scheme. E.g. you can call the devices ac97c%d (or
> something similar) and then call the CODEC ac97c%d.%d.
Let me think about it.
If I get you right, the device model would be, from a parenthood point of view:
             pxa2xx_ac97 (platform_device)
                  ^
                  |
             ac97_controller.dev (device, son of pxa2xx_ac97)
                 / \
                /   \
               /     \
              /       \
             /         \
         wm97xx-core  codec2     (sons ac97_controller.dev)

I have already the device hierarchy AFAIK, created in ac97_codec_add(). I'm
still failing to see the difference, as the refcounting is already used. The
only additional thing I see is the introduction of an intermediate
ac97_controller.dev which is refcounted.

In current model, pxa2xx_ac97 refcount is incremented for each codec device. In
the one you propose, pxa2xx_ac97 will be 1 refcounted (maybe 2 actually), and
ac97_controller.dev will be refcounted for each codec. This ac97_controller.dev
will be a spiritual twin of spi_master/i2c_adapter.

As I said, I must think about it and find which value is brought by this
additionnal layer.

As for the name change, I must check if this breaks the sound machine files, and
their dai_link structures (ex: mioa701_wm9713.c, structure mioa701_dai). In a
former state of this patchset I had changed the device names, ie. wm9713-codec
became pxa2xx-ac97.0, and the my machine file became broken.

> This is how most frameworks implementing some kind of control bus are
> structured in the Linux kernel. E.g. take a look at I2C or SPI.
I will.

>>>> +	ret = sysfs_create_link(&codec->dev.kobj, &ac97_ctrl->dev->kobj,
>>>> +				"ac97_controller");
>>>
>>> Since the CODEC is a child of the controller this should not be necessary as
>>> this just points one directory up. It's like `ln -s .. parent`
>> This creates :
>> /sys/bus/ac97/devices/pxa2xx-ac97\:0/ac97_controller
>> 
>> Of course as you pointed out, it's a 'ln -s .. parent' like link, but it seems
>> to me very unfriendly to have :
>>  - /sys/bus/ac97/devices/pxa2xx-ac97\:0/../ac97_operations
>>  - while /sys/bus/ac97/devices/ac97_operations doesn't exist (obviously)
>> 
>> Mmm, I don't know for this one, my mind is not set, it's a bit hard to tell if
>> it's only an unecessary link bringing "comfort", or something usefull.
>
> It is additional ABI and we do not have this for any other bus either (e.g.
> you don't see a backlink for a I2C or SPI device to the parent). In my
> opinion for the sake of keeping things consistent and simple we should not
> add this.
Fair enough.

>>>> +int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	drv->driver.bus = &ac97_bus_type;
>>>> +
>>>> +	ret = driver_register(&drv->driver);
>>>> +	if (!ret)
>>>> +		ac97_rescan_all_controllers();
>>>
>>> Rescanning the bus when a new codec driver is registered should not be
>>> neccessary. The bus is scanned once when the controller is registered, this
>>> creates the device. The device driver core will take care of binding the
>>> device to the driver, if the driver is registered after thed evice.
>> That's because you suppose the initial scanning found all the ac97 codecs.
>> But that's an incomplete vision as a codec might be powered off at that time and
>> not seen by the first scanning, while the new scanning will discover it.
>
> But why would the device become suddenly visible when the driver is
> registered. This seems to be an as arbitrary point in time as any other.
Because in the meantime, a regulator or something else provided power to the
AC97 IP, or a clock, and it can answer to requests after that.

And another point if that the clock of controller might be provided by the AC97
codec, and the scan will only succeed once the codec is actually providing this
clock, which it might do only once the module_init() is done.

> Also consider that when you build a driver as a module, the module will
> typically only be auto-loaded after the device has been detected, based on
> the device ID. On the other hand, if the driver is built-in driver
> registration will happen either before or shortly after the controller
> registration.
> If there is the expectation that the AC97 CODEC might randomly appear on the
> bus, the core should periodically scan the bus.
Power wise a periodical scan doesn't look good, at all.

More globally, I don't see if there is an actual issue we're trying to address
here, ie. that the rescan is a bug, or if it's more an "Occam's razor"
discussion ?

>>> In my opinion this should return a handle to a ac97 controller which can
>>> then be passed to snd_ac97_controller_unregister(). This is in my opinion
>>> the better approach rather than looking up the controller by parent device.
>> This is another "legacy drivers" issue.
>> 
>> The legacy driver (the one probed by platform_data or devicetree) doesn't
>> necessarily have a private structure to store this ac97_controller pointer.
>
> I might be missing something, but I'm not convinced by this. Can you point
> me to such a legacy driver where you think this would not work?
The first one that popped out:
 - hac_soc_platform_probe()

Cheers.

-- 
Robert
