From: "Jingoo Han" <jingoohan1@gmail.com>
Subject: Re: [PATCH v4 00/18] new MFD LoCoMo driver set
Date: Mon, 8 Jun 2015 23:48:39 +0900
Message-ID: <000001d0a1fa$39665c90$ac3315b0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Language: ko
Sender: linux-gpio-owner@vger.kernel.org
To: 'Dmitry Eremin-Solenikov' <dbaryshkov@gmail.com>
Cc: 'Lee Jones' <lee.jones@linaro.org>, 'Russell King' <linux@arm.linux.org.uk>, 'Daniel Mack' <zonque@gmail.com>, 'Robert Jarzmik' <robert.jarzmik@free.fr>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Alexandre Courbot' <acourbot@nvidia.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Samuel Ortiz' <sameo@linux.intel.com>, 'Mark Brown' <broonie@linaro.org>, 'Liam Girdwood' <liam.r.girdwood@linux.intel.com>, 'Andrea Adami' <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-spi@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

On Thu, 28 May 2015 22:07:40 +0300, Dmitry Eremin-Solenikov wrote:
>2015-05-28 14:58 GMT+03:00 Lee Jones wrote:
>> On Wed, 27 May 2015, Dmitry Eremin-Solenikov wrote:
>>
>>> 2015-05-27 13:27 GMT+03:00 Lee Jones <lee.jones@xxxxxxxxxx>:
>>> > On Mon, 25 May 2015, Dmitry Eremin-Solenikov wrote:
>>> >
>>> >> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
>>> >> several design issues (special bus instead of platform bus, doesn't use
>>> >> mfd-core, etc).
>>> >>
>>> >> Implement 'core' parts of locomo support as an mfd driver.
>>> >>
>>> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@xxxxxxxxx>
>>> >> ---
>>> >
>>> > These things are much easier to re-review if you keep a change-log
>>> > here.
>>> >
>>> >>  drivers/mfd/Kconfig        |  10 ++
>>> >>  drivers/mfd/Makefile       |   1 +
>>> >>  drivers/mfd/locomo.c       | 336 +++++++++++++++++++++++++++++++++++++++++++++
>>> >>  include/linux/mfd/locomo.h | 169 +++++++++++++++++++++++
>>> >>  4 files changed, 516 insertions(+)
>>> >>  create mode 100644 drivers/mfd/locomo.c
>>> >>  create mode 100644 include/linux/mfd/locomo.h
>>> >
>>> > Looks good now though:
>>> >   Acked-by: Lee Jones <lee.jones@xxxxxxxxxx>
>>> >
>>> > How do you plan for this to be merged?
>>>
>>> I'd like for this to be merged either through mfd tree or through the
>>> arm-soc (or rmk's ARM) tree.
>>> Some of the respective maintainers already gave their blessing for
>>> this patchset to be merged
>>> not through their subsystem trees.
>>
>> I can take it through MFD.  Once you have all the required Acks,
>> resubmit the set with them all applied with a note in the cover-letter
>> to that affect and I'll apply.
>
>Thank you. This is what I still miss:
>
>* Russell, could you please review sa1100 parts?
>* Jingoo, could you please review the backlight part?

For the following two patches,

  [PATCH v4 06/18] video: backlight: add new locomo backlight driver
  [PATCH v4 07/18] video: lcd: add LoCoMo LCD driver

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Pleased send the patches to 'jingoohan1@gmail.com', instead of
'jg1.han@samsung.com'.

Best regards,
Jingoo Han

>* Mark, same question for the updated SPI driver.
>* Linus, can I assume that yours 'Reviewed-by' mean
>  'Acked-by' for the GPIO-related parts?


