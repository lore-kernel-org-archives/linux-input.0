From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 1/3] Input: silead - Add OF device ID table
Date: Wed, 22 Feb 2017 09:45:29 -0300
Message-ID: <bc2fd608-e87d-41d3-65c2-9463c4a2ab2e@osg.samsung.com>
References: <20170221181254.14748-1-javier@osg.samsung.com>
 <bfea9fbe-663a-69e4-29f1-5e90a8d9e475@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44212
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752397AbdBVMpp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 07:45:45 -0500
In-Reply-To: <bfea9fbe-663a-69e4-29f1-5e90a8d9e475@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello Hans,

Thanks for your feedback.

On 02/22/2017 05:29 AM, Hans de Goede wrote:
> Hi,
> 
> On 21-02-17 19:12, Javier Martinez Canillas wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>  drivers/input/touchscreen/silead.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
>> index 404830a4a366..aae3ba1c3e02 100644
>> --- a/drivers/input/touchscreen/silead.c
>> +++ b/drivers/input/touchscreen/silead.c
>> @@ -580,12 +580,26 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
>>  MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
>>  #endif
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id silead_ts_of_match[] = {
>> +    { .compatible = "silead,gsl1680" },
>> +    { .compatible = "silead,gsl1688" },
>> +    { .compatible = "silead,gsl3670" },
>> +    { .compatible = "silead,gsl3675" },
>> +    { .compatible = "silead,gsl3692" },
>> +    { .compatible = "silead,mssl1680" },
>> +    { },
>> +};
> 
> Please drop the mssl1680 compatible, that id an ACPI ugliness

Ok, I'll drop that compatible if isn't needed for Device Tree.

> which we don't need for devicetree.
>

I'm not sure I understood your ACPI comment, 
 
> Otherwise looks good to me.
> 
> Regards,
> 
> Hans
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
