From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] Input: goodix - Tweak configuration to use passed in
 touchscreen resolution
Date: Thu, 27 Oct 2016 12:03:10 -0500
Message-ID: <650a47a2-d854-f846-082b-acf5b2497cf5@ti.com>
References: <20161020195917.20051-1-fcooper@ti.com>
 <20161020195917.20051-4-fcooper@ti.com> <1477564458.2458.10.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477564458.2458.10.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org



On 10/27/2016 05:34 AM, Bastien Nocera wrote:
> On Thu, 2016-10-20 at 14:59 -0500, Franklin S Cooper Jr wrote:
>> Some goodix touchscreen controllers aren't programed properly to
>> match the
>> display panel it is used on. Although the defaults may largely work
>> it is
>> also likely that the screen resolution will be incorrect. Therefore,
>> add support to allow via DT for the touchscreen resolution to be set
>> and
>> reprogram the controller to use this updated resolution.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../bindings/input/touchscreen/goodix.txt          |  2 ++
>>  drivers/input/touchscreen/goodix.c                 | 26
>> +++++++++++++++++++++-
>>  2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> index c98757a..ebc7cb7 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> @@ -19,6 +19,8 @@ Optional properties:
>>  			  interrupt gpio pin as output to reset the
>> device.
>>   - reset-gpios		: GPIO pin used for reset
>>  
>> + - touchscreen-size-x      : horizontal resolution of touchscreen
>> (in pixels)
>> + - touchscreen-size-y      : vertical resolution of touchscreen (in
>> pixels)
>>   - touchscreen-inverted-x  : X axis is inverted (boolean)
>>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>> diff --git a/drivers/input/touchscreen/goodix.c
>> b/drivers/input/touchscreen/goodix.c
>> index 01e12f8..c2428e1 100644
>> --- a/drivers/input/touchscreen/goodix.c
>> +++ b/drivers/input/touchscreen/goodix.c
>> @@ -496,6 +496,10 @@ static void goodix_tweak_config(struct
>> goodix_ts_data *ts)
>>  		return;
>>  	}
>>  
>> +	/* Setting X and Y Resolution */
>> +	put_unaligned_le16(ts->abs_x_max, &config[RESOLUTION_LOC]);
>> +	put_unaligned_le16(ts->abs_y_max, &config[RESOLUTION_LOC +
>> 2]);
>> +
>>  	check_sum = goodix_calculate_checksum(ts->cfg_len, config);
>>  
>>  	config[raw_cfg_len] = check_sum;
>> @@ -669,6 +673,8 @@ static int goodix_request_input_dev(struct
>> goodix_ts_data *ts)
>>  static int goodix_configure_dev(struct goodix_ts_data *ts)
>>  {
>>  	int error;
>> +	bool alter_config = false;
>> +	u32 max_x, max_y;
>>  
>>  	ts->swapped_x_y = device_property_read_bool(&ts->client-
>>> dev,
>>  						    "touchscreen-
>> swapped-x-y");
>> @@ -676,9 +682,27 @@ static int goodix_configure_dev(struct
>> goodix_ts_data *ts)
>>  						   "touchscreen-
>> inverted-x");
>>  	ts->inverted_y = device_property_read_bool(&ts->client->dev,
>>  						   "touchscreen-
>> inverted-y");
>> -
> 
> No need for that linefeed removal.
> 
>>  	goodix_read_config(ts);
>>  
>> +	if (device_property_present(&ts->client->dev, "touchscreen-
>> size-x") &&
> 
> Is it expected that incomplete or invalid arguments do not generate
> errors? I'd expect that the presence of just one of those properties,
> or...

Looking back at this there is technically nothing wrong with only
wanting to set 1 property. So I will update this to decouple these two
properties.
> 
>> +	    device_property_present(&ts->client->dev, "touchscreen-
>> size-y")) {
>> +
>> +		device_property_read_u32(&ts->client->dev,
>> "touchscreen-size-x",
>> +				&max_x);
>> +
>> +		device_property_read_u32(&ts->client->dev,
>> "touchscreen-size-y",
>> +				&max_y);
>> +
>> +		if (max_x > 0 && max_y > 0) {
> 
> ... invalid values for those properties would throw errors (either
> warnings, or lower severity messages).

I'll add a warning here indicating that the passed in value with be ignored.
> 
>> +			ts->abs_x_max = max_x;
>> +			ts->abs_y_max = max_y;
>> +			alter_config = true;
>> +		}
>> +	}
>> +
>> +	if (alter_config)
>> +		goodix_tweak_config(ts);
>> +
>>  	error = goodix_request_input_dev(ts);
>>  	if (error)
>>  		return error;
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
