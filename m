From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] Input: silead - Add OF device ID table
Date: Wed, 22 Feb 2017 15:23:22 +0100
Message-ID: <559a8956-0594-23e1-2437-8b595042cdaa@redhat.com>
References: <20170221181254.14748-1-javier@osg.samsung.com>
 <bfea9fbe-663a-69e4-29f1-5e90a8d9e475@redhat.com>
 <bc2fd608-e87d-41d3-65c2-9463c4a2ab2e@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <bc2fd608-e87d-41d3-65c2-9463c4a2ab2e@osg.samsung.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

HI,

On 22-02-17 13:45, Javier Martinez Canillas wrote:
> Hello Hans,
>
> Thanks for your feedback.
>
> On 02/22/2017 05:29 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 21-02-17 19:12, Javier Martinez Canillas wrote:
>>> The driver doesn't have a struct of_device_id table but supported devices
>>> are registered via Device Trees. This is working on the assumption that a
>>> I2C device registered via OF will always match a legacy I2C device ID and
>>> that the MODALIAS reported will always be of the form i2c:<device>.
>>>
>>> But this could change in the future so the correct approach is to have an
>>> OF device ID table if the devices are registered via OF.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> ---
>>>
>>>  drivers/input/touchscreen/silead.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
>>> index 404830a4a366..aae3ba1c3e02 100644
>>> --- a/drivers/input/touchscreen/silead.c
>>> +++ b/drivers/input/touchscreen/silead.c
>>> @@ -580,12 +580,26 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
>>>  MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
>>>  #endif
>>>
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id silead_ts_of_match[] = {
>>> +    { .compatible = "silead,gsl1680" },
>>> +    { .compatible = "silead,gsl1688" },
>>> +    { .compatible = "silead,gsl3670" },
>>> +    { .compatible = "silead,gsl3675" },
>>> +    { .compatible = "silead,gsl3692" },
>>> +    { .compatible = "silead,mssl1680" },
>>> +    { },
>>> +};
>>
>> Please drop the mssl1680 compatible, that id an ACPI ugliness
>
> Ok, I'll drop that compatible if isn't needed for Device Tree.
>
>> which we don't need for devicetree.
>>
>
> I'm not sure I understood your ACPI comment,

There is no silead chip named mssl1680, the mssl stands
for microsoft silead (or so I believe) and it is used
to identify the gsl1680 in some ACPI tables.

Regards,

Hans
