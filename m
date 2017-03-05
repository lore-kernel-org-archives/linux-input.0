From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: hid-sensor-trigger: Change get poll value function
 order to avoid sensor properties losing after resume from S3
Date: Sun, 5 Mar 2017 10:29:38 +0000
Message-ID: <0145ac74-b788-e8d1-1bcc-2385f7c6b68e@kernel.org>
References: <1487755058-31310-1-git-send-email-hongyan.song@intel.com>
 <1487741996.19408.0.camel@intel.com>
 <1f73506c-2bdd-c527-cd13-76594a1a7375@kernel.org>
 <AE3E3DFA698D6144A7445C92D1D41E2F10BE0440@SHSMSX103.ccr.corp.intel.com>
 <1488159432.3489.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59415 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdCEKcC (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 5 Mar 2017 05:32:02 -0500
In-Reply-To: <1488159432.3489.1.camel@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Song, Hongyan" <hongyan.song@intel.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "jikos@kernel.org" <jikos@kernel.org>

On 27/02/17 01:37, Pandruvada, Srinivas wrote:
> On Mon, 2017-02-27 at 01:00 +0000, Song, Hongyan wrote:
>> Hi Jonathan,
>> 	I add more information about the patch:
>> 	
>> Bug found: 
>> When we cat sensor incli sensor data with hysteresis value is 0,
>> there always have streamed sensor data output,
>> But when system enter S3 and resume back, the streaming thread is
>> still on but there is not streaming sensor data output.
>> Test data as below:
>> 279: 2017-01-24 01:16:00.279385 *5* incli_3d: Min Delta: 99.779ms,
>> Max Delta: 100.316ms, Received: 10/s, Overall: 170/16s; Sample values
>> ,0.010546,-0.006712,2.797579
>> 280: 2017-01-24 01:16:41.211385 *5* incli_3d: Min Delta: 100.16ms,
>> Max Delta: 40924.6ms, Received: 2/s, Overall: 172/19s; Sample values
>> ,0.010546,-0.006712,2.797579
>> 281: 2017-01-24 01:16:42.219892 *5* incli_3d: Min Delta: 0.023ms, Max
>> Delta: 543.28ms, Received: 2/s, Overall: 174/20s; Sample values
>> ,0.010546,-0.006712,2.797579
>> 282: 2017-01-24 01:16:42.755548 *4*
>> CIIOSensorInform::sensor_wait_event poll timeout
>> 283: 2017-01-24 01:16:43.223062 *5* incli_3d: Min Delta: --, Max
>> Delta: --, Received: 0/s, Overall: 174/21s
>> 284: 2017-01-24 01:16:43.756980 *4*
>> CIIOSensorInform::sensor_wait_event poll timeout
>> 285: 2017-01-24 01:16:44.225527 *5* incli_3d: Min Delta: --, Max
>> Delta: --, Received: 0/s, Overall: 174/22s
>> 286: 2017-01-24 01:16:44.758467 *4*
>> CIIOSensorInform::sensor_wait_event poll timeout
>> 287: 2017-01-24 01:16:45.228082 *5* incli_3d: Min Delta: --, Max
>> Delta: --, Received: 0/s, Overall: 174/23s
>> 288: 2017-01-24 01:16:45.759958 *4*
>> CIIOSensorInform::sensor_wait_event poll timeout
>>
>> Root cause: 
>> when sensor resume back from S3, the sensor property user set is
>> lost.
>> For example, if we set sensor hysteresis value to be 0, then let
>> system enter S3, when resume back, the hysteresis value will be not 0
>> but the default value 1.
>>
>> this is not what we want, resume back from S3 should not lose the
>> properties which is set before S3, just because the property setting
>> sequence lead to this lose.
>>
>> This is patch is a fix patch and needed for stable.
> But not urgent.
Thanks for the info.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> Thanks,
> Srinivas
> 
>>
>> Thanks a lot!
>>
>> BR
>> Song Hongyan
>>
>>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org] 
>> Sent: Sunday, February 26, 2017 12:52 AM
>> To: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; linux-input
>> @vger.kernel.org; Song, Hongyan <hongyan.song@intel.com>; linux-iio@v
>> ger.kernel.org
>> Cc: jikos@kernel.org
>> Subject: Re: [PATCH] iio: hid-sensor-trigger: Change get poll value
>> function order to avoid sensor properties losing after resume from S3
>>
>> On 22/02/17 05:40, Pandruvada, Srinivas wrote:
>>> On Wed, 2017-02-22 at 17:17 +0800, Song Hongyan wrote:
>>>> In function _hid_sensor_power_state(), when
>>>> hid_sensor_read_poll_value()
>>>> is called, sensor's all properties will be updated by the value
>>>> from 
>>>> sensor hardware/firmware.
>>>> In some implementation, sensor hardware/firmware will do a power 
>>>> cycle during S3. In this case, after resume, once
>>>> hid_sensor_read_poll_value()
>>>> is called, sensor's all properties which are kept by driver
>>>> during S3 
>>>> will be changed to default value.
>>>> But instead, if a set feature function is called first, sensor 
>>>> hardware/firmware will be recovered to the last status. So change
>>>> the
>>>> sensor_hub_set_feature() calling order to behind of set feature 
>>>> function to avoid sensor properties lose.
>>>>
>>>> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
>>>
>>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> Hi Song,
>>
>> The patch message, whilst excellent on the technical detail, gives me
>> no sense of urgency on this. Is this a fix we want to have heading
>> for stable ASAP or are we looking at something seen in some
>> developmental hardware for example?
>> Links to bug reports, or examples of hardware suffering from the
>> issue are always helpful as well.
>>
>> Also for something like this a 'fixes' tag is very helpful when
>> people are looking to back port it.
>>
>> Anyhow, I'm going to hold off on taking this one until I have more
>> information. Right now it makes little difference as the next fixes
>> pull request from me will probably not be until next weekend.
>>
>> Thanks,
>>
>> Jonathan
>>>
>>>> ---
>>>>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> index a3cce3a..ecf592d 100644
>>>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>> @@ -51,8 +51,6 @@ static int _hid_sensor_power_state(struct 
>>>> hid_sensor_common *st, bool state)
>>>>  			st->report_state.report_id,
>>>>  			st->report_state.index,
>>>>  			HID_USAGE_SENSOR_PROP_REPORTING_STATE_AL
>>>> L_EV
>>>> ENTS_ENUM);
>>>> -
>>>> -		poll_value = hid_sensor_read_poll_value(st);
>>>>  	} else {
>>>>  		int val;
>>>>  
>>>> @@ -89,7 +87,9 @@ static int _hid_sensor_power_state(struct 
>>>> hid_sensor_common *st, bool state)
>>>>  	sensor_hub_get_feature(st->hsdev, st-
>>>>> power_state.report_id,
>>>>  			       st->power_state.index,
>>>>  			       sizeof(state_val), &state_val);
>>>> -	if (state && poll_value)
>>>> +	if (state)
>>>> +		poll_value = hid_sensor_read_poll_value(st);
>>>> +	if (poll_value > 0)
>>>>  		msleep_interruptible(poll_value * 2);
>>>>  
>>>>  	return 
>>>> 0;N     r  y   b X  ǧv ^ )޺{.n +    {  *"  ^n r   z   h    &  
>>>> G   
>>>> h ( 階 ݢj"   m     z ޖ   f   h   ~ mml==
>>
>> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==

