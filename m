From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH] Input: goodix - use generic touchscreen_properties
Date: Thu, 26 Oct 2017 15:50:07 +0200
Message-ID: <9e258fde-ea61-0bfe-ed5f-4b3212fc64e2@grinn-global.com>
References: <20171025113217.7814-1-m.niestroj@grinn-global.com>
 <1508960523.28409.31.camel@hadess.net>
 <5ac10de2-9838-0adc-27ea-28b781c3092a@grinn-global.com>
 <1509022932.28409.38.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:49853 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932481AbdJZNuK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Oct 2017 09:50:10 -0400
In-Reply-To: <1509022932.28409.38.camel@hadess.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org

On 26.10.2017 15:02, Bastien Nocera wrote:
> On Thu, 2017-10-26 at 10:14 +0200, Marcin Niestroj wrote:
>> Hi Bastien,
>>
>> On 25.10.2017 21:42, Bastien Nocera wrote:
>>> Hey Marcin,
>>>
>>> On Wed, 2017-10-25 at 13:32 +0200, Marcin Niestroj wrote:
>>>> Use touchscreen_properties structure instead of implementing all
>>>> properties by our own. It allows to reuse generic code for
>>>> parsing
>>>> device-tree properties (which was implemented manually in the
>>>> driver
>>>> for now). Additionally, it allows us to report events using
>>>> generic
>>>> touchscreen_report_pos(), which automatically handles inverted
>>>> and
>>>> swapped axes.
>>>>
>>>> There was also bug in driver in touch position calculation, when
>>>> axes
>>>> were configured as inverted and swapped in the same time. This is
>>>> however fixed now, by using touchscreen_report_pos() function,
>>>> which
>>>> handles inversion+swapping correctly.
>>>
>>> <snip>
>>>> @@ -579,6 +568,7 @@ static int goodix_get_gpio_config(struct
>>>> goodix_ts_data *ts)
>>>>    static void goodix_read_config(struct goodix_ts_data *ts)
>>>>    {
>>>>    	u8 config[GOODIX_CONFIG_MAX_LENGTH];
>>>> +	int x_max, y_max;
>>>>    	int error;
>>>>    
>>>>    	error = goodix_i2c_read(ts->client, ts->chip-
>>>>> config_addr,
>>>> @@ -587,37 +577,34 @@ static void goodix_read_config(struct
>>>> goodix_ts_data *ts)
>>>>    		dev_warn(&ts->client->dev,
>>>>    			 "Error reading config (%d), using
>>>> defaults\n",
>>>>    			 error);
>>>> -		ts->abs_x_max = GOODIX_MAX_WIDTH;
>>>> -		ts->abs_y_max = GOODIX_MAX_HEIGHT;
>>>> -		if (ts->swapped_x_y)
>>>> -			swap(ts->abs_x_max, ts->abs_y_max);
>>>> +		x_max = GOODIX_MAX_WIDTH;
>>>> +		y_max = GOODIX_MAX_HEIGHT;
>>>
>>> When do you swap those out if necessary?
>>
>> Swapping axes is implemented in of_touchscreen.c. This includes
>> swapping
>> during event reporting, as well as during touchscreen width and
>> height
>> reporting during initialization.
> 
> But this isn't swapped or rotated when the device's range is set, is
> it?
> +       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +                       0, x_max - 1, 0, 0);
> +       input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +                       0, y_max - 1, 0, 0);
> 

Not sure I understand your question. You mean at this specific point
in code? No it is not. But this is how it should be done I think.
Swapping range (x_max, y_max) occurs at the end of
touchscreen_parse_properties().

> <snip>
>>>
>> You are right, I should mention this. I've searched through several
>> touchscreen drivers and I think this is how it should be. Am I right?
>> If you confirm, I will split it off in next patch version.
>>
>> Should we split fixing inverted+swapped axes as well? This is fixed
>> by
>> this patch right now, by reusing code in of_touchscreen.c. Below is a
>> patch, that fixes inversion+swapping, by not using of_touchscreen.c.
>> Should I add that to the patch set, so it could be backported to
>> stable
>> releases?
> 
> That would be great, though I'm not sure whether the gt1151 support
> would get backported.
> 

gt1151 patch should not be needed for that fix to apply cleanly.

>>> Looks good overall, but was this tested, and if so, on which
>>> device?
>>> Could you add a reference to the hardware used for testing in the
>>> commit log?
>>
>> I just have a custom hardware (prototype) with gt1151. Should I
>> mention
>> this in commit log as well?
> 
> That would be useful, yes. The fact that it's a device-tree based
> device would also be good to mention.
> 

Will do so.

-- 
Marcin Niestroj
