From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 2/2] mfd: axp20x: use correct platform device id for many
 PEK
Date: Tue, 18 Jul 2017 12:04:32 +0200
Message-ID: <77d54c56-81ee-4c18-991c-2db68f048e15@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-3-quentin.schulz@free-electrons.com>
 <20170718071936.llnpgwqmgzt2axea@dell>
 <2ea34792-3775-7534-3c06-5bf7ca8211c6@free-electrons.com>
 <20170718094911.2brtyp2skney72l4@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718094911.2brtyp2skney72l4@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

Hi Lee,

On 18/07/2017 11:49, Lee Jones wrote:
> On Tue, 18 Jul 2017, Quentin Schulz wrote:
> 
>> Hi Lee,
>>
>> On 18/07/2017 09:19, Lee Jones wrote:
>>> On Mon, 17 Jul 2017, Quentin Schulz wrote:
>>>
>>>> According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
>>>> AXP809 and AXP813 PEK have different values for startup time bits from
>>>> the AXP20X, let's use the platform device id with the correct values.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>> ---
>>>>  drivers/mfd/axp20x.c | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> Patch is find, but are these names reference from platform data
>>> anywhere i.e. are we going to break anything by applying it?
>>>
>>
>> I don't really understand what you're asking.
> 
> Yes, I guess that was a little Fringlish, apologies for my haste.
> 
>> We need the first patch of this patch series to be applied before the
>> second patch or axp20x-pek driver wouldn't be probed anymore.
>>
>> There is no Device Tree declaring axp20x-pek and there is no support for
>> Device Tree probing in the driver.
>>
>> I don't see how I could break anything with these patches. Could you
>> explain with an abstract example, please? I might not break anything
>> here but it's better to know now what I could have broken in another
>> situation/with another patch series so I won't make that mistake in the
>> future.
>>
>> Oh, but this patch series would change the name of the directory exposed
>> in sysfs (/sys/bus/platform/devices/axp221-pek/*). Is that what you were
>> afraid of?
> 
> I'm worried about any breakage in terms of name referencing.
> 
> If this driver is DT only, then the concern is less, but in the olden
> days, we used to conduct device/driver binding using the name.  Ergo,
> if you change the name in the driver without updating the device
> registration, we would not bind and .probe() would not be called.
> 

Previous to this patch set, the axp20x-pek driver would have no
platform_device_id table set. The name attribute in the
platform_driver.driver was (and still is): "axp20x-pek". As I
understand, the MFD subsystem would use the name of the driver to make
the connection between the name defined in the mfd cell and the one in
the driver.

Now I've a platform device id table that, if I understood correctly,
would be used by the MFD subsystem to make the connection between the
name defined in the mfd cell and the platform device id table.

My platform device id table is as following:

static const struct platform_device_id axp_pek_id_match[] = {

        {

                .name = "axp20x-pek",

                .driver_data = (kernel_ulong_t)&axp20x_attribute_group,

        }, {

                .name = "axp221-pek",

                .driver_data = (kernel_ulong_t)&axp221_attribute_group,

        },

};


Thus, by keeping axp20x-pek as one of the platform device id, we do not
break anything since everything that makes the connection with the
driver name would also make the connection with the platform device id.
Right?

Basically without this patch, axp20x-pek still probes (I've just tested
to make sure), with "axp20x-pek" platform device id, as it does today
with except with "axp20x-pek" driver name.

Does it make sense? Do I answer your worries?

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
