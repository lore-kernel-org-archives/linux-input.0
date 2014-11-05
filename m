From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Wed, 05 Nov 2014 21:32:37 +0100
Message-ID: <545A8965.2010406@metafoo.de>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>	<CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>	<CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>	<CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
 <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Andrea Adami <andrea.adami@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Input <linux-input@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-input@vger.kernel.org

On 11/05/2014 09:02 PM, Dmitry Eremin-Solenikov wrote:
> 2014-11-03 16:41 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Fri, Oct 31, 2014 at 10:54 AM, Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com> wrote:
>>> 2014-10-31 10:42 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>>
>>>> It seems some DAC handling is part of the MFD driver, and we recently
>>>> discussed that MFD should not be doing misc stuff but mainly act as
>>>> arbiter and switching station.
>>>>
>>>> Can you please move the DAC parts of the driver to
>>>> drivers/iio/dac?
>>>>
>>>> The IIO DAC subsystem will likely add other goodies to
>>>> the driver for free and give a nice API to consumers.
>>>
>>> I wanted this part to be as simple as possible. I will look into IIO
>>> DAC subsystem.
>>> The DAC is as simple 2 channel 8-bit i2c device connected to a separate i2c bus
>>> controlled through a register in LoCoMo device. One channel is used
>>> for backlight,
>>> other will be used for volume control. So (in theory) I can add the
>>> following device
>>> chain:  locomo -> i2c-locomo -> m62332 -> IIO DAC client.  However isn't that
>>> quite an overkill for just backlight & volume control? Please advice me on this.
>>
>> The point is still the same: no unrelated code in drivers/mfd,
>> then either use IIO DAC as a middle layer or sink the DAC handling
>> into respective subdriver, i.e. push it into the backlight or
>> volume directly then.
>
> The problem is that the DAC is equally used by backlight and by sound
> device (WIP).

That shouldn't be a problem. The IIO API allows different consumers to 
request different channels of a converter. You can write a generic IIO based 
backlight driver and a generic IIO based volume control driver. This makes 
it possible to re-use them in other circuits with other DACs but the same 
application.

> What about true i2c device driver sitting in drivers/misc and exporting a regmap
> of 2 8-bit registers?

If it is a generic DAC it should go into drivers/iio/, this will allow code 
sharing and code re-usability. Given the simplicity of the DAC there might 
even be other existing drivers that can be used to control it.

- Lars
