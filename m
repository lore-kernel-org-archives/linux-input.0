From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/3] Input: zforce - use irq handler instead of gpio
 polling
Date: Tue, 14 Jul 2015 09:42:00 +0200
Message-ID: <55A4BD48.9000705@de.bosch.com>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
 <20150713170413.GB5039@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:45889 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbbGNHmE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 03:42:04 -0400
In-Reply-To: <20150713170413.GB5039@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

Hi Dmitry,

On 13.07.2015 19:04, Dmitry Torokhov wrote:
> On Mon, Jul 13, 2015 at 02:49:37PM +0200, Dirk Behme wrote:
>> From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
>>
>> Remove the IRQ GPIO polling and request. Existing DTS should not be affected
>> since the IRQ registration was and is based on "interrupts" descriptor of DTS.
>
> But this means that consecutive touchscreen readings will be delayed by
> the time it takes to schedule the thread.
>
> What is the motivation for this change?


This is the generic part we've done for a special hardware 
configuration: There is some hardware which uses an I2C Serializer / 
Deserializer (SerDes) to communicate with the zFroce touch driver. In 
this case the SerDes will be configured as an interrupt controller and 
the zForce driver will have no access to poll the GPIO line.

Best regards

Di
>>
>> Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>>
>> Note: All 3 patches in this series are against zforce in input next
>>        https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/log/?h=next
>>        to fit on top of the previous zforce gpiod change.
>>
>>   drivers/input/touchscreen/zforce_ts.c | 135 ++++++++++++++++------------------
>>   1 file changed, 62 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
>> index 32749db..19dc297 100644
>> --- a/drivers/input/touchscreen/zforce_ts.c
>> +++ b/drivers/input/touchscreen/zforce_ts.c
>> @@ -510,73 +510,71 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
>>   	if (!ts->suspending && device_may_wakeup(&client->dev))
>>   		pm_stay_awake(&client->dev);
>>
>> -	while (!gpiod_get_value_cansleep(ts->gpio_int)) {
>> -		ret = zforce_read_packet(ts, payload_buffer);
>> -		if (ret < 0) {
>> -			dev_err(&client->dev,
>> -				"could not read packet, ret: %d\n", ret);
>> -			break;
>> -		}
>> +	ret = zforce_read_packet(ts, payload_buffer);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev,
>> +			"could not read packet, ret: %d\n", ret);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	payload =  &payload_buffer[PAYLOAD_BODY];
>>
>> -		payload =  &payload_buffer[PAYLOAD_BODY];
>> -
>> -		switch (payload[RESPONSE_ID]) {
>> -		case NOTIFICATION_TOUCH:
>> -			/*
>> -			 * Always report touch-events received while
>> -			 * suspending, when being a wakeup source
>> -			 */
>> -			if (ts->suspending && device_may_wakeup(&client->dev))
>> -				pm_wakeup_event(&client->dev, 500);
>> -			zforce_touch_event(ts, &payload[RESPONSE_DATA]);
>> -			break;
>> -
>> -		case NOTIFICATION_BOOTCOMPLETE:
>> -			ts->boot_complete = payload[RESPONSE_DATA];
>> -			zforce_complete(ts, payload[RESPONSE_ID], 0);
>> -			break;
>> -
>> -		case RESPONSE_INITIALIZE:
>> -		case RESPONSE_DEACTIVATE:
>> -		case RESPONSE_SETCONFIG:
>> -		case RESPONSE_RESOLUTION:
>> -		case RESPONSE_SCANFREQ:
>> -			zforce_complete(ts, payload[RESPONSE_ID],
>> -					payload[RESPONSE_DATA]);
>> -			break;
>> -
>> -		case RESPONSE_STATUS:
>> -			/*
>> -			 * Version Payload Results
>> -			 * [2:major] [2:minor] [2:build] [2:rev]
>> -			 */
>> -			ts->version_major = (payload[RESPONSE_DATA + 1] << 8) |
>> -						payload[RESPONSE_DATA];
>> -			ts->version_minor = (payload[RESPONSE_DATA + 3] << 8) |
>> -						payload[RESPONSE_DATA + 2];
>> -			ts->version_build = (payload[RESPONSE_DATA + 5] << 8) |
>> -						payload[RESPONSE_DATA + 4];
>> -			ts->version_rev   = (payload[RESPONSE_DATA + 7] << 8) |
>> -						payload[RESPONSE_DATA + 6];
>> -			dev_dbg(&ts->client->dev,
>> -				"Firmware Version %04x:%04x %04x:%04x\n",
>> -				ts->version_major, ts->version_minor,
>> -				ts->version_build, ts->version_rev);
>> -
>> -			zforce_complete(ts, payload[RESPONSE_ID], 0);
>> -			break;
>> -
>> -		case NOTIFICATION_INVALID_COMMAND:
>> -			dev_err(&ts->client->dev, "invalid command: 0x%x\n",
>> +	switch (payload[RESPONSE_ID]) {
>> +	case NOTIFICATION_TOUCH:
>> +		/*
>> +		 * Always report touch-events received while
>> +		 * suspending, when being a wakeup source
>> +		 */
>> +		if (ts->suspending && device_may_wakeup(&client->dev))
>> +			pm_wakeup_event(&client->dev, 500);
>> +		zforce_touch_event(ts, &payload[RESPONSE_DATA]);
>> +		break;
>> +
>> +	case NOTIFICATION_BOOTCOMPLETE:
>> +		ts->boot_complete = payload[RESPONSE_DATA];
>> +		zforce_complete(ts, payload[RESPONSE_ID], 0);
>> +		break;
>> +
>> +	case RESPONSE_INITIALIZE:
>> +	case RESPONSE_DEACTIVATE:
>> +	case RESPONSE_SETCONFIG:
>> +	case RESPONSE_RESOLUTION:
>> +	case RESPONSE_SCANFREQ:
>> +		zforce_complete(ts, payload[RESPONSE_ID],
>>   				payload[RESPONSE_DATA]);
>> -			break;
>> +		break;
>>
>> -		default:
>> -			dev_err(&ts->client->dev,
>> -				"unrecognized response id: 0x%x\n",
>> -				payload[RESPONSE_ID]);
>> -			break;
>> -		}
>> +	case RESPONSE_STATUS:
>> +		/*
>> +		 * Version Payload Results
>> +		 * [2:major] [2:minor] [2:build] [2:rev]
>> +		 */
>> +		ts->version_major = (payload[RESPONSE_DATA + 1] << 8) |
>> +					payload[RESPONSE_DATA];
>> +		ts->version_minor = (payload[RESPONSE_DATA + 3] << 8) |
>> +					payload[RESPONSE_DATA + 2];
>> +		ts->version_build = (payload[RESPONSE_DATA + 5] << 8) |
>> +					payload[RESPONSE_DATA + 4];
>> +		ts->version_rev   = (payload[RESPONSE_DATA + 7] << 8) |
>> +					payload[RESPONSE_DATA + 6];
>> +		dev_dbg(&ts->client->dev,
>> +			"Firmware Version %04x:%04x %04x:%04x\n",
>> +			ts->version_major, ts->version_minor,
>> +			ts->version_build, ts->version_rev);
>> +
>> +		zforce_complete(ts, payload[RESPONSE_ID], 0);
>> +		break;
>> +
>> +	case NOTIFICATION_INVALID_COMMAND:
>> +		dev_err(&ts->client->dev, "invalid command: 0x%x\n",
>> +			payload[RESPONSE_DATA]);
>> +		break;
>> +
>> +	default:
>> +		dev_err(&ts->client->dev,
>> +			"unrecognized response id: 0x%x\n",
>> +			payload[RESPONSE_ID]);
>> +		break;
>>   	}
>>
>>   	if (!ts->suspending && device_may_wakeup(&client->dev))
>> @@ -754,15 +752,6 @@ static int zforce_probe(struct i2c_client *client,
>>   	if (!ts)
>>   		return -ENOMEM;
>>
>> -	/* INT GPIO */
>> -	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
>> -	if (IS_ERR(ts->gpio_int)) {
>> -		ret = PTR_ERR(ts->gpio_int);
>> -		dev_err(&client->dev,
>> -			"failed to request interrupt GPIO: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>>   	/* RST GPIO */
>>   	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
>>   					    GPIOD_OUT_HIGH);
>> --
>> 2.3.4
>>

