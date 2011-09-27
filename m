From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v3 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD
 config option
Date: Tue, 27 Sep 2011 13:58:20 +0530
Message-ID: <CAJuYYwT0wDiWNR38iH84W9S3M78iYa_+j5dTNLxC4no2k0zDzw@mail.gmail.com>
References: <1316427553-5033-1-git-send-email-thomas.abraham@linaro.org>
	<1316427553-5033-2-git-send-email-thomas.abraham@linaro.org>
	<20110922173507.GN17168@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110922173507.GN17168@ponder.secretlab.ca>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Grant,

On 22 September 2011 23:05, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Mon, Sep 19, 2011 at 03:49:12PM +0530, Thomas Abraham wrote:
>> For platforms using device tree, the static keypad device instances
>> are not required and SAMSUNG_DEV_KEYPAD is not selected. Since,
>> samsung keypad driver has dependency on SAMSUNG_DEV_KEYPAD config
>> option, the driver is left out of the compilation for dt enabled
>> platforms.
>>
>> An additional config option 'HAVE_SAMSUNG_KEYPAD' is added
>> which the device tree based platforms can select. This config
>> option is added as an alternative dependency for keypad driver.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0drivers/input/keyboard/Kconfig | =A0 =A09 ++++++++-
>> =A01 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard=
/Kconfig
>> index b4dee9d..7c322a3 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -423,9 +423,16 @@ config KEYBOARD_PMIC8XXX
>> =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: t=
he module will
>> =A0 =A0 =A0 =A0 be called pmic8xxx-keypad.
>>
>> +config HAVE_SAMSUNG_KEYPAD
>> + =A0 =A0 bool
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This will include Samsung Keypad controller driver sup=
port. If you
>> + =A0 =A0 =A0 want to include Samsung Keypad support for any machine=
, kindly
>> + =A0 =A0 =A0 select this in the respective mach-xxxx/Kconfig file.
>> +
>> =A0config KEYBOARD_SAMSUNG
>> =A0 =A0 =A0 tristate "Samsung keypad support"
>> - =A0 =A0 depends on SAMSUNG_DEV_KEYPAD
>> + =A0 =A0 depends on SAMSUNG_DEV_KEYPAD || HAVE_SAMSUNG_KEYPAD
>
> It would be better to modify SAMSUNG_DEV_KEYPAD to select
> HAVE_SAMSUNG_KEYPAD and then make KEYBOARD_SAMSUNG only depend on
> HAVE_SAMSUNG_KEYPAD instead of both.

The SAMSUNG_DEV_KEYPAD is not selected for device tree enabled
machine. For instance, the Kconfig section for Exynos4 dt-enabled
machine file is as below.

config MACH_EXYNOS4_DT
        bool "Samsung Exynos4 Machine using device tree"
        select CPU_EXYNOS4210
        select USE_OF
        select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
        help
          Machine support for Samsung Exynos4 machine with device tree =
enabled.

SAMSUNG_DEV_KEYPAD (that selects the static platform device for
keypad) should not be selected for MACH_EXYNOS4_DT config option. So
selecting HAVE_SAMSUNG_KEYPAD in SAMSUNG_DEV_KEYPAD config option
would not help in this case. So for now, this is kept unchanged.
Please let me know if you think this needs to be changed.

Thanks for your review. I am sorry for delayed reply to your email.

Regards,
Thomas.

>
> g.
>
>
