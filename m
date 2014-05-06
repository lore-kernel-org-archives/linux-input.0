From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 6/7] Input: pixcir_i2c_ts: Implement wakeup from suspend
Date: Tue, 6 May 2014 11:33:24 +0300
Message-ID: <53689E54.5080705@ti.com>
References: <1399280678-23925-1-git-send-email-rogerq@ti.com> <1399280678-23925-7-git-send-email-rogerq@ti.com> <20140506052148.GB2608@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140506052148.GB2608-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, mugunthanvnm-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 05/06/2014 08:21 AM, Dmitry Torokhov wrote:
> On Mon, May 05, 2014 at 12:04:37PM +0300, Roger Quadros wrote:
>> Improve the suspend and resume handlers to allow the device
>> to wakeup the system from suspend.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/input/touchscreen/pixcir_i2c_ts.c | 53 ++++++++++++++++++++++++++++---
>>  1 file changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> index 927aed1..5f6a27e 100644
>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> @@ -348,21 +348,66 @@ static void pixcir_input_close(struct input_dev *dev)
>>  static int pixcir_i2c_ts_suspend(struct device *dev)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>> +	struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
>> +	struct input_dev *input = ts->input;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&input->mutex);
>> +
>> +	if (input->users) {
>> +		ret = pixcir_stop(ts);
>> +		if (ret)
>> +			goto unlock;
>> +	}
>> +
>> +	/*
>> +	 * If wakeup is enabled we need to enable interrupt generation
>> +	 * but don't need to process any reports i.e. ts->exiting must be true.
>> +	 */
>> +	if (device_may_wakeup(&client->dev)) {
>> +		/* enable wakeup interrupt generation */
>> +		ret = pixcir_int_enable(ts, 1);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable interrupt generation\n");
>> +			goto unlock;
>> +		}
> 
> I am not sure why we need to disable event processing here. Why not do
> 
> 	if (device_may_wakeup(&client->dev)) {
> 		enable_irq_wake(client->irq); 
> 		ret = pixcir_int_enable(ts, true);
> 		...
> 	} else if (input->users) {
> 		ret = pixcir_stop(ts);
> 	}
> 
> like many of the drivers do?

Seems to work without disabling event processing. I'll send a v5 with this
and patch 2 fixed as per your suggestion. Thanks.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
