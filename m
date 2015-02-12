From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: sun4i-ts: add thermal driver dependency
Date: Thu, 12 Feb 2015 08:01:40 +0100
Message-ID: <54DC4FD4.4060503@redhat.com>
References: <2265502.1m7jYBaqyh@wuerfel> <54C9E63A.6020806@redhat.com> <20150129185151.GA33547@dtor-ws> <20150211182403.GE29440@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150211182403.GE29440@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi,

On 11-02-15 19:24, Dmitry Torokhov wrote:
> On Thu, Jan 29, 2015 at 10:51:51AM -0800, Dmitry Torokhov wrote:
>> On Thu, Jan 29, 2015 at 08:50:18AM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 28-01-15 16:17, Arnd Bergmann wrote:
>>>> The sun4i-ts driver has had a dependency on the thermal code
>>>> since it was first merged,
>>>
>>> The "since it was first merged bit" is not true, this is caused
>>> by recent changes by ChenYu.
>>>
>>> Other then that no objections from me against the proposed fix.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>   but this is not currently enforced
>>>> in Kconfig, so in some randconfig builds we get
>>>>
>>>> drivers/built-in.o: In function `sun4i_ts_remove':
>>>> :(.text+0x2376f4): undefined reference to `thermal_zone_of_sensor_unregister'
>>>> drivers/built-in.o: In function `sun4i_ts_probe':
>>>> :(.text+0x237a94): undefined reference to `thermal_zone_of_sensor_register'
>>>> :(.text+0x237c00): undefined reference to `thermal_zone_of_sensor_unregister'
>>>>
>>>> We need the dependency on THERMAL in order to ensure that this
>>>> driver becomes a loadable module if the thermal support itself
>>>> is modular, while the dependency on THERMAL_OF is a runtime dependency
>>>> and the driver will still build but not work if it is missing.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Fixes: 6decea7c5438e2 ("Input: add driver for Allwinner sunxi SoC's rtp controller")
>>>>
>>>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>>>> index 58917525126e..e2447f0063b7 100644
>>>> --- a/drivers/input/touchscreen/Kconfig
>>>> +++ b/drivers/input/touchscreen/Kconfig
>>>> @@ -943,6 +943,8 @@ config TOUCHSCREEN_SUN4I
>>>>   	tristate "Allwinner sun4i resistive touchscreen controller support"
>>>>   	depends on ARCH_SUNXI || COMPILE_TEST
>>>>   	depends on HWMON
>>>> +	depends on THERMAL
>>>> +	depends on THERMAL_OF || COMPILE_TEST
>>
>> THERMAL_OF does have proper stubs and I do not see why we need to force
>> having TERMAL even if we don't do compile test. Should the dependency be:
>>
>> 	depends on !THERMAL_OF || TERMAL
>
> *ping*

ChenYu, since your patch causes this problem I'm assuming that you will come
up with a fix, is that correct ?

Regards,

Hans
