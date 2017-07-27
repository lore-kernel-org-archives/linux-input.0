From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 02/12] ALSA: ac97: add an ac97 bus
Date: Thu, 27 Jul 2017 22:59:39 +0200
Message-ID: <87a83pr3yc.fsf@belgarion.home>
References: <20170724204928.29505-1-robert.jarzmik@free.fr>
 <20170724204928.29505-3-robert.jarzmik@free.fr>
 <s5h60eg8a8d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h60eg8a8d.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
 25 Jul 2017 23:42:10 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> On Mon, 24 Jul 2017 22:49:18 +0200,
> Robert Jarzmik wrote:

...zip...
>> +#ifndef AC97_COMPAT_H
>> +#define AC97_COMPAT_H
>> +
>> +#include <sound/ac97_codec.h>
>> +#include <sound/soc.h>
>
> Is this inclusion needed?  The code here doesn't look ASoC-specific at
> all.
Mmm no, actually it's not, good point.

...zip...
>> +#ifndef AC97_CONTROLLER_H
>> +#define AC97_CONTROLLER_H
>> +
>> +#include <linux/list.h>
>> +
>> +#define AC97_BUS_MAX_CODECS 4
>> +#define AC97_SLOTS_AVAILABLE_ALL 0xf
>> +
>> +struct device;
>
> You need the definition struct device in below (it's no pointer), thus
> you have to include <linux/device.h> instead.
Fair enough, vor v5.
>> +struct ac97_controller {
>> +	const struct ac97_controller_ops *ops;
>
> The struct isn't declared beforehand?  GCC will warn.
Actually it doesn't.
It's interesting as ac97_controller depends on ac97_controller_ops, and
ac97_controller_ops depends on ac97_controller;

As for why it doesn't warn, every time I used controller.h, I also used
codec.h. And codec.h holds a :
struct ac97_controller;

So it's declared beforehand after all ...

But I will add before "struct ac97_controller" a :
struct ac97_controller_ops;

>> +	struct list_head controllers;
>> +	struct device adap;
>> +	int nr;
>> +	struct device *parent;
>> +	unsigned short slots_available;
>
> I'd move parent field below, so that 64bit pointer can be aligned
> better.
Okay, got it.

...zip...
>> +
>> +	device_initialize(&codec->dev);
>> +	dev_set_name(&codec->dev, "%s:%u", dev_name(ac97_ctrl->parent), idx);
>> +
>> +	ret = device_add(&codec->dev);
>> +	if (ret)
>> +		goto err_free_codec;
>> +
>> +	return 0;
>> +err_free_codec:
>> +	kfree(codec);
>
> This may leave the device name string.  You need to call
> put_device() even if device_add() returns an error.
You're right, I'll change that.

...zip...
>> +int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
>> +{
>> +	int ret;
>> +
>> +	drv->driver.bus = &ac97_bus_type;
>> +	ret = driver_register(&drv->driver);
>> +
>> +	return ret;
>
> This can be simplified.
Indeed.

>> +}
>> +EXPORT_SYMBOL(snd_ac97_codec_driver_register);
>
> No GPL?  (Ditto for other entries, too)
Euh yeah, GPL forever. I will change all the occurrences.

>> +int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
>> +	unsigned int id_mask)
>> +{
>> +	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
>> +	struct ac97_controller *actrl = adev->ac97_ctrl;
>> +
>> +	if (try_warm) {
>> +		compat_ac97_warm_reset(ac97);
>> +		if (snd_ac97_bus_scan_one(actrl, adev->num) == adev->vendor_id)
>
> Can we ignore id_mask here?  I'm not quite sure whether it's fixed...
Probably not, but I will take a bit more time to cross-check that one.

Thanks for the review, I'll follow up on that last question when I'll have
settled on the correct answer.

Cheers.

-- 
Robert
