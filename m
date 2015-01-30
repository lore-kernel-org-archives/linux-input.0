From: Bryan Wu <cooloney@gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: add parameter to allow the use named gpios
Date: Fri, 30 Jan 2015 11:12:53 -0800
Message-ID: <CAK5ve-KqC2gojeFx_hSwR6Riv1YPkhO49eqaa2bOxVhChLDtXw@mail.gmail.com>
References: <1421876028-22799-1-git-send-email-o.schinagl@ultimaker.com>
 <1421876028-22799-3-git-send-email-o.schinagl@ultimaker.com> <CACRpkdbywy3Nrg+d8YAGTYH_Z-AB=UDB7zyq85rD8WoCwAk5eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbywy3Nrg+d8YAGTYH_Z-AB=UDB7zyq85rD8WoCwAk5eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Olliver Schinagl <o.schinagl@ultimaker.com>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 30, 2015 at 5:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jan 21, 2015 at 10:33 PM, Olliver Schinagl
> <o.schinagl@ultimaker.com> wrote:
>
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> The gpio binding document says that new code should always use named
>> gpios. Patch 40b73183 added support to parse a list of gpios from child
>> nodes, but does not make it possible to use named gpios. This patch adds
>> the con_id property and implements it is done in gpiolib.c, where the
>> old-style of using unnamed gpios still works.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>  drivers/gpio/devres.c                     | 18 +++++++++++++++++-
>>  drivers/input/keyboard/gpio_keys_polled.c |  2 +-
>>  drivers/leds/leds-gpio.c                  |  2 +-
>>  include/linux/gpio/consumer.h             |  1 +
>
> Alexandre: does this match your vision of how it should work, i.e. ACK?
>
> Bryan/Dmitry: can you ACK the oneliners in your subsystems?

Sure, please take my Ack
Acked-by: Bryan Wu <cooloney@gmail.com>

>
> Yours,
> Linus Walleij
