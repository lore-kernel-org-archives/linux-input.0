From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio: hid-sensor-trigger: Change get poll value function
 order to avoid sensor properties losing after resume from S3
Date: Sat, 25 Feb 2017 16:51:33 +0000
Message-ID: <1f73506c-2bdd-c527-cd13-76594a1a7375@kernel.org>
References: <1487755058-31310-1-git-send-email-hongyan.song@intel.com>
 <1487741996.19408.0.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487741996.19408.0.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Song, Hongyan" <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 22/02/17 05:40, Pandruvada, Srinivas wrote:
> On Wed, 2017-02-22 at 17:17 +0800, Song Hongyan wrote:
>> In function _hid_sensor_power_state(), when
>> hid_sensor_read_poll_value()
>> is called, sensor's all properties will be updated by the value from
>> sensor hardware/firmware.
>> In some implementation, sensor hardware/firmware will do a power
>> cycle
>> during S3. In this case, after resume, once
>> hid_sensor_read_poll_value()
>> is called, sensor's all properties which are kept by driver during S3
>> will be changed to default value.
>> But instead, if a set feature function is called first, sensor
>> hardware/firmware will be recovered to the last status. So change the
>> sensor_hub_set_feature() calling order to behind of set feature
>> function
>> to avoid sensor properties lose.
>>
>> Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Hi Song,

The patch message, whilst excellent on the technical detail, gives me
no sense of urgency on this. Is this a fix we want to have heading for
stable ASAP or are we looking at something seen in some developmental
hardware for example?
Links to bug reports, or examples of hardware suffering from the issue
are always helpful as well.

Also for something like this a 'fixes' tag is very helpful when people
are looking to back port it.

Anyhow, I'm going to hold off on taking this one until I have more
information. Right now it makes little difference as the next fixes
pull request from me will probably not be until next weekend.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> index a3cce3a..ecf592d 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> @@ -51,8 +51,6 @@ static int _hid_sensor_power_state(struct
>> hid_sensor_common *st, bool state)
>>  			st->report_state.report_id,
>>  			st->report_state.index,
>>  			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EV
>> ENTS_ENUM);
>> -
>> -		poll_value = hid_sensor_read_poll_value(st);
>>  	} else {
>>  		int val;
>>  
>> @@ -89,7 +87,9 @@ static int _hid_sensor_power_state(struct
>> hid_sensor_common *st, bool state)
>>  	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
>>  			       st->power_state.index,
>>  			       sizeof(state_val), &state_val);
>> -	if (state && poll_value)
>> +	if (state)
>> +		poll_value = hid_sensor_read_poll_value(st);
>> +	if (poll_value > 0)
>>  		msleep_interruptible(poll_value * 2);
>>  
>>  	return 0;N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
