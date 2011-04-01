From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 2/4] Input: atmel_mxt_ts - Support 12bit resolution
Date: Fri, 01 Apr 2011 12:58:23 +0300
Message-ID: <4D95A1BF.6070100@atmel.com>
References: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com> <1299487335-24139-2-git-send-email-jy0922.shim@samsung.com> <4D94850C.1020301@atmel.com> <4D956C64.6000906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:37100 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab1DAJ6r (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2011 05:58:47 -0400
In-Reply-To: <4D956C64.6000906@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi,

On 04/01/2011 09:10 AM, Joonyoung Shim wrote:
>>> @@ -837,6 +847,17 @@ static int mxt_initialize(struct mxt_data *data)
>>>          return 0;
>>>   }
>>>
>>> +static void mxt_calc_resolution(struct mxt_data *data)
>>> +{
>>> +       if (data->pdata->orient&  MXT_XY_SWITCH) {
>>> +               data->x_size = data->pdata->y_size;
>>> +               data->y_size = data->pdata->x_size;
>>> +       } else {
>>> +               data->x_size = data->pdata->x_size;
>>> +               data->y_size = data->pdata->y_size;
>>> +       }
>>> +}
>>> +
>>
>> What's the reason for this? If we have set the x/y switch in the config, then
>> we probably want to swap the axes. Or is this axis swap something that should be
>> done on upper layers? Even so, then we shouldn't have the MXT_XY_SWITCH bit set
>> in the config, and we could just say "data->x_max_value = data->pdata->xsize - 1"
>> (and same for y) in the probe function. We wouldn't need Touch orient bit defines
>> either.
>>
> 
> If we set XY_SWITCH for special purpose then the axis is swapped and
> driver will report also coordinates out of max value.
> 

Right, of course.

Regards,

-- 
Iiro
