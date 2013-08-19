From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/4] hid-sensor-hub: fix style of comments
Date: Mon, 19 Aug 2013 08:26:39 -0700
Message-ID: <5212392F.8090204@linux.intel.com>
References: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com> <1376902117.403.151.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54772 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab3HSPTb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Aug 2013 11:19:31 -0400
In-Reply-To: <1376902117.403.151.camel@smile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On 08/19/2013 01:48 AM, Andy Shevchenko wrote:
> On Wed, 2013-08-14 at 11:07 +0300, Andy Shevchenko wrote:
>> This patch fixes the style of the comments to be like following
>> 	/* The commentary */
>>
>> There is no functional change.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Jiri, Srinivas, any comments on this?
Agreed.
>> ---
>>   drivers/hid/hid-sensor-hub.c   | 2 +-
>>   include/linux/hid-sensor-hub.h | 2 +-
>>   include/linux/hid-sensor-ids.h | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
>> index ca749810..ffc80cf 100644
>> --- a/drivers/hid/hid-sensor-hub.c
>> +++ b/drivers/hid/hid-sensor-hub.c
>> @@ -416,7 +416,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>>   		return 1;
>>   
>>   	ptr = raw_data;
>> -	ptr++; /*Skip report id*/
>> +	ptr++; /* Skip report id */
>>   
>>   	spin_lock_irqsave(&pdata->lock, flags);
>>   
>> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
>> index ecefb73..32ba451 100644
>> --- a/include/linux/hid-sensor-hub.h
>> +++ b/include/linux/hid-sensor-hub.h
>> @@ -172,7 +172,7 @@ struct hid_sensor_common {
>>   	struct hid_sensor_hub_attribute_info sensitivity;
>>   };
>>   
>> -/*Convert from hid unit expo to regular exponent*/
>> +/* Convert from hid unit expo to regular exponent */
>>   static inline int hid_sensor_convert_exponent(int unit_expo)
>>   {
>>   	if (unit_expo < 0x08)
>> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
>> index 6f24446..4f945d3 100644
>> --- a/include/linux/hid-sensor-ids.h
>> +++ b/include/linux/hid-sensor-ids.h
>> @@ -37,7 +37,7 @@
>>   #define HID_USAGE_SENSOR_ANGL_VELOCITY_Y_AXIS			0x200458
>>   #define HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS			0x200459
>>   
>> -/*ORIENTATION: Compass 3D: (200083) */
>> +/* ORIENTATION: Compass 3D: (200083) */
>>   #define HID_USAGE_SENSOR_COMPASS_3D				0x200083
>>   #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING			0x200471
>>   #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING_X			0x200472
Thanks,
Srinivas
