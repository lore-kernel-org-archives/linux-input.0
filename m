From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend v2] Input: goodix - Poll the 'buffer status' bit
 before reading data
Date: Fri, 13 Oct 2017 15:49:19 +0200
Message-ID: <56bc0128-3983-81f3-87b8-5dea3186891c@redhat.com>
References: <20171013111907.6913-1-hdegoede@redhat.com>
 <20171013111907.6913-2-hdegoede@redhat.com>
 <1507899456.5910.21.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753258AbdJMNtZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 09:49:25 -0400
In-Reply-To: <1507899456.5910.21.camel@hadess.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, russianneuromancer@ya.ru

Hi,

On 13-10-17 14:57, Bastien Nocera wrote:
> On Fri, 2017-10-13 at 13:19 +0200, Hans de Goede wrote:
>> From: Paul Cercueil <paul@crapouillou.net>
>>
>> The Goodix panel triggers an interrupt on touch events. However, its
>> registers will contain the valid values a short time after the
>> interrupt, and not when it's raised. At that moment, the 'buffer
>> status'
>> bit is set.
>>
>> Previously, if the 'buffer status' bit was not set when the registers
>> were read, the data was discarded and no input event was emitted,
>> causing "finger down" or "finger up" events to be missed sometimes.
>>
>> This went unnoticed until v4.9, as the DesignWare I2C driver commonly
>> used with this driver had enough latency for that bug to never
>> trigger.
> 
> Link to the bug fix?

There is this commit seems somewhat related:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-designware-core.c?id=2702ea7dbec55db62fa3016c7275fea7b508033f

But I think overall it might be best to just remove this paragraph
from the commit msg. The problem probably was there all along it
just was not noticed until around 4.9.

>> Now, in the IRQ handler we will poll (with a timeout) the 'buffer
>> status'
>> bit and process the data of the panel as soon as this bit gets set.
>>
>> Note that the Goodix panel will send a few spurious interrupts after
>> the
>> 'finger up' event, in which the 'buffer status' bit will never be
>> set.
>>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Cc: russianneuromancer@ya.ru
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> [hdegoede@redhat.com: Change poll loop to use jiffies,
>>                        add comment about typical poll time]
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/touchscreen/goodix.c | 36
>> ++++++++++++++++++++++++++++--------
>>   1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/goodix.c
>> b/drivers/input/touchscreen/goodix.c
>> index 32d2762448aa..a2071c132a2b 100644
>> --- a/drivers/input/touchscreen/goodix.c
>> +++ b/drivers/input/touchscreen/goodix.c
>> @@ -195,18 +195,38 @@ static int goodix_get_cfg_len(u16 id)
>>   
>>   static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8
>> *data)
>>   {
>> +	unsigned long timeout;
>>   	int touch_num;
>>   	int error;
>>   
>> -	error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR,
>> data,
>> -				GOODIX_CONTACT_SIZE + 1);
>> -	if (error) {
>> -		dev_err(&ts->client->dev, "I2C transfer error:
>> %d\n", error);
>> -		return error;
>> -	}
>> +	/*
>> +	 * The 'buffer status' bit, which indicates that the data is
>> valid, is
>> +	 * not set as soon as the interrupt is raised, but slightly
>> after.
>> +	 * This takes around 10 ms to happen, so we poll for 20 ms.
>> +	 */
>> +	timeout = jiffies + msecs_to_jiffies(20);
> 
> around 16msec is the time between 2 frames on a 60Hz display. Is 20msec
> what we want?

It is twice the time which people have observed on touchscreens
which need the poll, the idea is that since the normal time is
10ms, we wait somewhat more because of possible jitter in that
10 ms time observed.

> Does this looping block below any other parts of the
> kernel, or does it run in its own thread?

It is only called from goodix_ts_irq_handler which is
installed as a threaded interrupt handler, so it runs
from its own thread. Other wise we would be unable to do
i2c transfers since those can sleep too waiting for the
i2c controller to complete the transfer.

Regards,

Hans


> 
>> +	do {
>> +		error = goodix_i2c_read(ts->client,
>> GOODIX_READ_COOR_ADDR,
>> +					data, GOODIX_CONTACT_SIZE +
>> 1);
>> +		if (error) {
>> +			dev_err(&ts->client->dev, "I2C transfer
>> error: %d\n",
>> +					error);
>> +			return error;
>> +		}
>>   
>> -	if (!(data[0] & 0x80))
>> -		return -EAGAIN;
>> +		if (data[0] & 0x80)
>> +			break;
>> +
>> +		usleep_range(1000, 2000); /* Poll every 1 - 2 ms */
>> +	} while (time_before(jiffies, timeout));
>> +
>> +	if (!(data[0] & 0x80)) {
>> +		/*
>> +		 * The Goodix panel will send spurious interrupts
>> after a
>> +		 * 'finger up' event, which will always cause a
>> timeout.
>> +		 */
>> +		return 0;
>> +	}
>>   
>>   	touch_num = data[0] & 0x0f;
>>   	if (touch_num > ts->max_touch_num)
