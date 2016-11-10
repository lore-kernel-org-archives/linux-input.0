From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
Date: Thu, 10 Nov 2016 12:38:40 +0100
Message-ID: <6b97a129-bd10-b9be-616d-a3ea3b91b103@metafoo.de>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
 <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
 <87eg2ly8k6.fsf@belgarion.home>
 <5ae15e01-eaaf-4996-27ec-1179041c0268@metafoo.de>
 <87mvh8uywm.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:51603 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754806AbcKJLjc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 06:39:32 -0500
In-Reply-To: <87mvh8uywm.fsf@belgarion.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/09/2016 10:27 PM, Robert Jarzmik wrote:
[...]
>>>>> +int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	drv->driver.bus = &ac97_bus_type;
>>>>> +
>>>>> +	ret = driver_register(&drv->driver);
>>>>> +	if (!ret)
>>>>> +		ac97_rescan_all_controllers();
>>>>
>>>> Rescanning the bus when a new codec driver is registered should not be
>>>> neccessary. The bus is scanned once when the controller is registered, this
>>>> creates the device. The device driver core will take care of binding the
>>>> device to the driver, if the driver is registered after thed evice.
>>> That's because you suppose the initial scanning found all the ac97 codecs.
>>> But that's an incomplete vision as a codec might be powered off at that time and
>>> not seen by the first scanning, while the new scanning will discover it.
>>
>> But why would the device become suddenly visible when the driver is
>> registered. This seems to be an as arbitrary point in time as any other.
> Because in the meantime, a regulator or something else provided power to the
> AC97 IP, or a clock, and it can answer to requests after that.
> 
> And another point if that the clock of controller might be provided by the AC97
> codec, and the scan will only succeed once the codec is actually providing this
> clock, which it might do only once the module_init() is done.
> 
>> Also consider that when you build a driver as a module, the module will
>> typically only be auto-loaded after the device has been detected, based on
>> the device ID. On the other hand, if the driver is built-in driver
>> registration will happen either before or shortly after the controller
>> registration.
>> If there is the expectation that the AC97 CODEC might randomly appear on the
>> bus, the core should periodically scan the bus.
> Power wise a periodical scan doesn't look good, at all.
> 
> More globally, I don't see if there is an actual issue we're trying to address
> here, ie. that the rescan is a bug, or if it's more an "Occam's razor"
> discussion ?

It's a framework design discussion. In my opinion the driver being
registered and the device becoming visible on the physical bus are two
completely unrelated operations. Especially in the Linux device driver model.

You have a generic driver that calls ac97_codec_driver_register() in its
module_init() section. This generic driver does (at module_init() time) not
know anything about a device instance specific clocks, regulators or other
resources. Resources are handled on a per device instance basis, and you
won't have a device instance until the device has been detected, which
happens in ac97_bus_scan(). So you have a cyclic dependency loop here.

Maybe we can just leave the rescanning out for now and think about how to
best handle it when the need arises.

> 
>>>> In my opinion this should return a handle to a ac97 controller which can
>>>> then be passed to snd_ac97_controller_unregister(). This is in my opinion
>>>> the better approach rather than looking up the controller by parent device.
>>> This is another "legacy drivers" issue.
>>>
>>> The legacy driver (the one probed by platform_data or devicetree) doesn't
>>> necessarily have a private structure to store this ac97_controller pointer.
>>
>> I might be missing something, but I'm not convinced by this. Can you point
>> me to such a legacy driver where you think this would not work?
> The first one that popped out:
>  - hac_soc_platform_probe()

I think that driver should be able to use platform_set_drvdata() to store
the pointer.

