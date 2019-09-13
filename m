From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: Re: [PATCH v5] hid-logitech-hidpp: read battery voltage from newer
 devices
Date: Fri, 13 Sep 2019 17:45:45 -0400
Message-ID: <cb3e7c8f-b8f9-7a59-d358-8682625e4adf@pedrovanzella.com>
References: <20190831175659.7404-1-pedro@pedrovanzella.com>
 <80785df1c804796a01bbfbae4b2aeda66f30d7c5.camel@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80785df1c804796a01bbfbae4b2aeda66f30d7c5.camel@archlinux.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>, linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 9/9/19 8:00 AM, Filipe Laíns wrote:
> On Sat, 2019-08-31 at 13:56 -0400, Pedro Vanzella wrote:
>> +static int hidpp20_battery_map_status_voltage(u8 data[3], int
>> *voltage)
>> +{
>> +	int status;
>> +
>> +	switch (data[2]) {
>> +	case 0x00: /* discharging */
>> +		status = POWER_SUPPLY_STATUS_DISCHARGING;
>> +		break;
>> +	case 0x10: /* wireless charging */
>> +	case 0x80: /* charging */
>> +		status = POWER_SUPPLY_STATUS_CHARGING;
>> +		break;
>> +	case 0x81: /* fully charged */
>> +		status = POWER_SUPPLY_STATUS_FULL;
>> +		break;
>> +	default:
>> +		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +	}
>> +
>> +	*voltage = get_unaligned_be16(data);
>> +
>> +	return status;
>> +}
> 
> Here's the missing specification:
> 
> +--------+-------------------------------------------------------------------------+
> |  byte  |                                    2                                    |
> +--------+--------------+------------+------------+----------+----------+----------+
> |   bit  |     0..2     |      3     |      4     |     5    |     6    |     7    |
> +--------+--------------+------------+------------+----------+----------+----------+
> | buffer | chargeStatus | fastCharge | slowCharge | critical | (unused) | extPower |
> +--------+--------------+------------+------------+----------+----------+----------+
> Table 1 - battery voltage (0x1001), getBatteryInfo() (ASE 0), 3rd byte
> 
> +-------+--------------------------------------+
> | value |                meaning               |
> +-------+--------------------------------------+
> |   0   | Charging                             |
> +-------+--------------------------------------+
> |   1   | End of charge (100% charged)         |
> +-------+--------------------------------------+
> |   2   | Charge stopped (any "normal" reason) |
> +-------+--------------------------------------+
> |   7   | Hardware error                       |
> +-------+--------------------------------------+
> Table 2 - chargeStatus value
> 
> I know this is already on the 5th revision but could you please change
> hidpp20_battery_map_status_voltage() to properly handle the 3rd byte?
> Also, if you could make sure those values are properly exported via
> sysfs it would be great! We will need them for proper upower support.

Sure thing. I'll have a new patch in a few days.

Thanks for figuring that stuff out, by the way.

> 
> Sorry for not saying this in my first review. Since then I have done
> some testing and I discovered that if we want to get accurate upower
> support we will need the values exposed by the 3rd byte to be
> exported properly.
> 
> I am not sure about the endianness of chargeStatus but you can find
> that easily.
> 
> Thank you!
> Filipe Laíns
> 
