From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V4 7/8] thermal: da9062/61: Thermal junction temperature
 monitoring driver
Date: Tue, 15 Nov 2016 09:46:51 +0000
Message-ID: <b2d2809e-b71e-5db0-2aeb-4773dc58960d@arm.com>
References: <cover.1479111766.git.stwiss.opensource@diasemi.com>
 <5d6cf6b51d71d2069db20ee427a92271015c337a.1479111766.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d6cf6b51d71d2069db20ee427a92271015c337a.1479111766.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

On 14/11/16 08:22, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
>
> Add junction temperature monitoring supervisor device driver, compatible
> with the DA9062 and DA9061 PMICs. A MODULE_DEVICE_TABLE() macro is added.
>
> If the PMIC's internal junction temperature rises above TEMP_WARN (125
> degC) an interrupt is issued. This TEMP_WARN level is defined as the
> THERMAL_TRIP_HOT trip-wire inside the device driver.
>
> The thermal triggering mechanism is interrupt based and happens when the
> temperature rises above a given threshold level. The component cannot
> return an exact temperature, it only has knowledge if the temperature is
> above or below a given threshold value. A status bit must be polled to
> detect when the temperature falls below that threshold level again. A
> kernel work queue is configured to repeatedly poll and detect when the
> temperature falls below this trip-wire, between 1 and 10 second intervals
> (defaulting at 3 seconds).
>
> This first level of temperature supervision is intended for non-invasive
> temperature control, where the necessary measures for cooling the system
> down are left to the host software.
>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>
Looks good to me.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
