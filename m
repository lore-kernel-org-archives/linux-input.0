From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: add NULL check on devm_kmemdup()
 return value
Date: Mon, 17 Jul 2017 00:00:49 -0500
Message-ID: <6913c916-93f7-4b25-8183-676a7cd009b0@embeddedor.com>
References: <20170707051213.GA6074@embeddedgus>
 <20170712074035.GF22282@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712074035.GF22282@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 07/12/2017 02:40 AM, Benjamin Tissoires wrote:
> On Jul 07 2017 or thereabouts, Gustavo A. R. Silva wrote:
>> Check return value from call to devm_kmemdup()
>> in order to prevent a NULL pointer dereference.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>

Thank you, Benjamin.

>>  drivers/hid/hid-logitech-hidpp.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>> index 41b3946..501e16a 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -2732,6 +2732,9 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
>>  				     hidpp_battery_props,
>>  				     sizeof(hidpp_battery_props),
>>  				     GFP_KERNEL);
>> +	if (!battery_props)
>> +		return -ENOMEM;
>> +
>>  	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 2;
>>
>>  	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
>> --
>> 2.5.0
>>

-- 
Gustavo A. R. Silva
