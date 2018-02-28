From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [RFC 2/4] mfd: add Gateworks System Controller core driver
Date: Wed, 28 Feb 2018 13:14:00 -0800
Message-ID: <CAJ+vNU0uRdG2vJWLc5ohBLNuzkKNQdH9-rSQxPAVW92f72yOPA@mail.gmail.com>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-3-git-send-email-tharvey@gateworks.com> <170c83e1-8a34-5103-3767-139b22081cf9@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <170c83e1-8a34-5103-3767-139b22081cf9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 27, 2018 at 6:00 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 02/27/2018 05:21 PM, Tim Harvey wrote:
>> The Gateworks System Controller (GSC) is an I2C slave controller
>> implemented with an MSP430 micro-controller whose firmware embeds the
>> following features:
>>  - I/O expander (16 GPIO's) using PCA955x protocol
>>  - Real Time Clock using DS1672 protocol
>>  - User EEPROM using AT24 protocol
>>  - HWMON using custom protocol
>>  - Interrupt controller with tamper detect, user pushbotton
>>  - Watchdog controller capable of full board power-cycle
>>  - Power Control capable of full board power-cycle
>>
>> see http://trac.gateworks.com/wiki/gsc for more details
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  drivers/mfd/Kconfig     |  10 ++
>>  drivers/mfd/Makefile    |   1 +
>>  drivers/mfd/gsc.c       | 330 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/gsc.h |  79 ++++++++++++
>>  4 files changed, 420 insertions(+)
>>  create mode 100644 drivers/mfd/gsc.c
>>  create mode 100644 include/linux/mfd/gsc.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 1d20a80..16dd486 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -341,6 +341,16 @@ config MFD_EXYNOS_LPASS
>>         Select this option to enable support for Samsung Exynos Low Power
>>         Audio Subsystem.
>>
>> +config MFD_GSC
>> +     tristate "Gateworks System Controller"
>> +     depends on (I2C && OF) || COMPILE_TEST
>
> Do both I2C and OF have stubs so that a driver will build when they are
> both disabled?  I.e., only COMPILE_TEST is enabled?

Randy,

No, at this point it requires both I2C and OF. I may add platform data
to support an older non-device-tree family of boards but it still
would require I2C.

I will remove the || COMPILE_TEST

Thanks for catching that.

Tim
