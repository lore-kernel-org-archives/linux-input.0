From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V3 8/9] thermal: da9062/61: Thermal junction temperature
 monitoring driver
Date: Fri, 11 Nov 2016 09:57:39 +0000
Message-ID: <9a7876db-4d89-c883-9ddd-83cd5535370e@arm.com>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <52d74c72cc445d2bc911014f38b79c1f10426878.1477929725.git.stwiss.opensource@diasemi.com>
 <b5789f09-0053-f0fc-ee35-c8c32969852b@arm.com>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE91AE@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CCE91AE@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

Hi Steve,

On 09/11/16 18:20, Steve Twiss wrote:
> On 02 November 2016 13:29, Lukasz Luba wrote:
> [...]
>
>> Apart from these 2 comments, 10sec is not to long
>> (waiting for the temperature change)?
>
> Hi Lukasz,
>
> Are you saying the maximum polling time is too long or too short if it
> is fixed in the driver at 10 seconds?
In my opinion 10s is too long.
>
> Certainly 10 seconds can be seen as either too long or too short a time
> when waiting for the temperature to fall-back below a threshold.
> But, this maximum polling time will be application dependent I think.
>
> However, this is a repeated polling event notifying of a warning
> over-temperature condition, so, it is already known that the
> temperature is above the threshold and action should already be
> in progress to reduce the temperature.
In this case we have precise start time when we should e.g. throttle
the CPU, because this interrupt will be fired by the hardware just
after the real temperature change. We do not have precise end time
for the throttling process, though. The function .get_temp
may return stale data which was read out some time ago
(< 3s or max 10s).
The hole system performance may suffer for too long (because the
temperature could drop to i.e. 100degC).

On the other hand, when we consider that this is just a binary flag
reacting on 125degC threshold then maybe there is a point of cooling
down the PMIC for longer time.
You are right it is application and system specific (i.e. how many
other temperature sensors is registered in the system and what
decisions we can make based on them i.e. in IPA).
>
> #define DA9062_DEFAULT_POLLING_MS_PERIOD	3000
> #define DA9062_MAX_POLLING_MS_PERIOD		10000
> #define DA9062_MIN_POLLING_MS_PERIOD		1000
>
> The TEMP_WARN first level temperature supervision is intended for
> non-invasive temperature controlling measures for cooling the system
> and are left to the host software. This first level temperature
> TEMP_WARN (125 degC) is only +15degC off the next TEMP_CRIT
> (140 degC) temperature threshold. And this TEMP_CRIT is where
> the hardware will automatically shutdown.
>
> I suppose it all depends on how fast the temperature is expected to
> rise and fall.
>
> In any case, this 10 second polling maximum value was provided as part
> of guidance from a specific solution with this hardware. It would be expected
> that any final implementation will also include a notify() function and any
> of these settings could be altered to match the application where
> appropriate.
>
> I've added a comment above these defined variables for the next code
> patch.
Fair enough. You can mention about the throttling side effect so that
engineers working on bring-up will be aware of this particular knob
during the experiments.

Best Regards,
Lukasz


>
>> On 31/10/16 16:02, Steve Twiss wrote:
>>> From: Steve Twiss <stwiss.opensource@diasemi.com>
>>>
>>> +static int da9062_thermal_probe(struct platform_device *pdev)
>>> +{
>>> +	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
>>> +	struct da9062_thermal *thermal;
>>> +	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
>>> +	const struct of_device_id *match;
>>> +	int ret = 0;
>>> +
>>> +	match = of_match_node(da9062_compatible_reg_id_table,
>>> +			      pdev->dev.of_node);
>>> +	if (!match)
>>> +		return -ENXIO;
>>> +
>>> +	if (pdev->dev.of_node) {
>>> +		if (!of_property_read_u32(pdev->dev.of_node,
>>> +					"dlg,tjunc-temp-polling-period-ms",
>>> +					&pp_tmp)) {
>>> +			if (pp_tmp < DA9062_MIN_POLLING_MS_PERIOD ||
>>> +				pp_tmp > DA9062_MAX_POLLING_MS_PERIOD)
>>> +				pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
>>
>> Maybe it's worth to add some print here just to mention about
>> the DT value out of range. When you saw a dmesg with
>> this print on some bug report, you would know about wrong DT entry
>> (even if debug was not set).
>
> I can add a dev_warn() here explaining the invalid configuration.
>
> [...]
>
>>> +static int da9062_thermal_remove(struct platform_device *pdev)
>>> +{
>>> +	struct	da9062_thermal *thermal = platform_get_drvdata(pdev);
>>> +
>>> +	free_irq(thermal->irq, thermal);
>>> +	thermal_zone_device_unregister(thermal->zone);
>>> +	cancel_delayed_work_sync(&thermal->work);
>>
>> You should change the order for these two functions
>> and cancel the work before unregistering thermal zone device.
>
> ok
>
> Regards,
> Steve
>
