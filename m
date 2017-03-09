From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend 3/4] Input: axp20x-pek - Do not register input
 device on some systems
Date: Thu, 9 Mar 2017 08:56:28 +0100
Message-ID: <c127b27b-534f-27e0-9835-e7bf276c951a@redhat.com>
References: <20170308085413.5185-1-hdegoede@redhat.com>
 <20170308085413.5185-4-hdegoede@redhat.com> <20170308171612.GA20567@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbdCIH4j (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 02:56:39 -0500
In-Reply-To: <20170308171612.GA20567@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On 08-03-17 18:16, Dmitry Torokhov wrote:
> On Wed, Mar 08, 2017 at 09:54:12AM +0100, Hans de Goede wrote:
>> On some systems (Intel tablets with axp288 pmic) the powerbutton is
>> also connected to a gpio pin of the SoC, advertised through the
>> "INTCFD9" / "PNP0C40" acpi device. This leads to double reporting
>> of powerbutton events, which is undesirable, so one driver needs
>> to not report input events in this case.
>>
>> Since the soc_button_array driver for the "PNP0C40" acpi device
>> also handles wake from suspend on these tablets and since the
>> axp20x-pel driver requires relative expensive i2c accrsses,
>> it is best for the axp20x-pek driver to not register an input device
>> in this case.
>>
>> Note that this commit leaves the axp20x-driver bound to the
>> device, rather then returning -ENODEV, this is done so that the
>> sysfs attributes it offers are kept around.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/input/misc/axp20x-pek.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
>> index b7258ec..dbd2c89 100644
>> --- a/drivers/input/misc/axp20x-pek.c
>> +++ b/drivers/input/misc/axp20x-pek.c
>> @@ -13,6 +13,7 @@
>>   * GNU General Public License for more details.
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/errno.h>
>>  #include <linux/irq.h>
>>  #include <linux/init.h>
>> @@ -267,9 +268,16 @@ static int axp20x_pek_probe(struct platform_device *pdev)
>>
>>  	axp20x_pek->axp20x = dev_get_drvdata(pdev->dev.parent);
>>
>> -	error = axp20x_pek_probe_input_device(axp20x_pek, pdev);
>> -	if (error)
>> -		return error;
>> +	/*
>> +	 * Do not register the input device if there is an "INTCFD9"
>> +	 * gpio button ACPI device, that handles the power button too,
>> +	 * and otherwise we end up reporting all presses twice.
>> +	 */
>> +	if (!acpi_dev_found("INTCFD9")) {
>
> Should we also add "|| !IS_ENABLED(CONFIG_INPUT_SOC_BUTTON_ARRAY)"?

That would be a bit of a broken kernel config for the devices in
question, but yeah probably a good idea to add that.

Regards,

Hans


>
> No need to resend, just shout if you agree/disagree.
>
>> +		error = axp20x_pek_probe_input_device(axp20x_pek, pdev);
>> +		if (error)
>> +			return error;
>> +	}
>>
>>  	error = sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
>>  	if (error) {
>> --
>> 2.9.3
>>
>
