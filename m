From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Correct documentation
Date: Sat, 10 Jan 2015 22:25:30 +0000
Message-ID: <54B1A6DA.8080103@kernel.org>
References: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420654484-6410-2-git-send-email-srinivas.pandruvada@linux.intel.com> <54B1A5F0.9080904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54B1A5F0.9080904-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 10/01/15 22:21, Jonathan Cameron wrote:
> On 07/01/15 18:14, Srinivas Pandruvada wrote:
>> During changes to the interface, some documentation field comments
>> were missed. Added missing comments.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Applied to the togreg branch of iio.git as absence of docs is irritating
> rather than a bug ;)
Sorry, dopey evening.  This one is Jiri's area not mine so over to him and
backed out of the togreg branch of iio.git.

Sorry about that.

J


> 
> Thanks,
>> ---
>>  include/linux/hid-sensor-hub.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
>> index 51f7cca..4173a8f 100644
>> --- a/include/linux/hid-sensor-hub.h
>> +++ b/include/linux/hid-sensor-hub.h
>> @@ -33,6 +33,8 @@
>>   * @units:		Measurment unit for this attribute.
>>   * @unit_expo:		Exponent used in the data.
>>   * @size:		Size in bytes for data size.
>> + * @logical_minimum:	Logical minimum value for this attribute.
>> + * @logical_maximum:	Logical maximum value for this attribute.
>>   */
>>  struct hid_sensor_hub_attribute_info {
>>  	u32 usage_id;
>> @@ -146,6 +148,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
>>  
>>  /**
>>  * sensor_hub_input_attr_get_raw_value() - Synchronous read request
>> +* @hsdev:	Hub device instance.
>>  * @usage_id:	Attribute usage id of parent physical device as per spec
>>  * @attr_usage_id:	Attribute usage id as per spec
>>  * @report_id:	Report id to look for
>> @@ -160,6 +163,7 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
>>  			u32 attr_usage_id, u32 report_id);
>>  /**
>>  * sensor_hub_set_feature() - Feature set request
>> +* @hsdev:	Hub device instance.
>>  * @report_id:	Report id to look for
>>  * @field_index:	Field index inside a report
>>  * @value:	Value to set
>> @@ -172,6 +176,7 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>>  
>>  /**
>>  * sensor_hub_get_feature() - Feature get request
>> +* @hsdev:	Hub device instance.
>>  * @report_id:	Report id to look for
>>  * @field_index:	Field index inside a report
>>  * @value:	Place holder for return value
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
