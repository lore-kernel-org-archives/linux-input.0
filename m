From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute
 read
Date: Sun, 11 Jan 2015 15:08:54 -0800
Message-ID: <54B30286.7090106@linux.intel.com>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com> <54B1AAD6.6070303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7330 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbbAKXIz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2015 18:08:55 -0500
In-Reply-To: <54B1AAD6.6070303@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, jkosina@suse.cz, a.zummo@towertech.it
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, holler@ahsoftware.de, rtc-linux@googlegroups.com


On 01/10/2015 02:42 PM, Jonathan Cameron wrote:
> On 07/01/15 18:47, Srinivas Pandruvada wrote:
>> The new API added a flag for sync/async mode. Added sync mode flag.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Again, please don't break the build between patches like this.
As we did in the past, the hid sensor hub patches involving hid sensor 
and IIO part goes through one tree, either via IIO or HID.
So once acked this needs to go through a single tree, as done in the past.
So the patches submitted in a series to avoid breaking build.

Thanks,
Srinivas
>
> If you want to do things in steps, you'll have to carry to versions of
> the function during the conversion and drop the unwanted one at the end.
>
>> ---
>>   drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
>> index d5d9531..0085c2f 100644
>> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
>> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
>> @@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>>   			*val = sensor_hub_input_attr_get_raw_value(
>>   					accel_state->common_attributes.hsdev,
>>   					HID_USAGE_SENSOR_ACCEL_3D, address,
>> -					report_id);
>> +					report_id,
>> +					SENSOR_HUB_SYNC);
>>   		else {
>>   			*val = 0;
>>   			hid_sensor_power_state(&accel_state->common_attributes,
>>
>

