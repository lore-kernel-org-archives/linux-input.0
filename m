From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2 5/7] mfd: cros_ec: wait for completion of commands
 that return IN_PROGRESS
Date: Mon, 08 Sep 2014 13:39:35 +0200
Message-ID: <540D9577.9000702@collabora.co.uk>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk> <1408974008-17184-6-git-send-email-javier.martinez@collabora.co.uk> <20140904083426.GD8257@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:33612 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbaIHLjk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Sep 2014 07:39:40 -0400
In-Reply-To: <20140904083426.GD8257@lee--X1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hello Lee,

On 09/04/2014 10:34 AM, Lee Jones wrote:
> On Mon, 25 Aug 2014, Javier Martinez Canillas wrote:
>> From: Andrew Bresticker <abrestic@chromium.org>
>> 
>> When an EC command returns EC_RES_IN_PROGRESS, we need to query
>> the state of the EC until it indicates that it is no longer busy.
>> Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
>> commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
>> it is working on the in-progress command.
>> 
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> 
>> Changes since v1:
>>  - The *xfer() calls don't modify the passed cros_ec_command so there is
>>    no need to populate it inside the for loop. Suggested by Lee Jones.
>> ---
>>  drivers/mfd/cros_ec.c | 34 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index c53804a..cd0c93c 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -23,6 +23,10 @@
>>  #include <linux/mfd/core.h>
>>  #include <linux/mfd/cros_ec.h>
>>  #include <linux/mfd/cros_ec_commands.h>
>> +#include <linux/delay.h>
>> +
>> +#define EC_COMMAND_RETRIES	50
>> +#define EC_RETRY_DELAY_MS	10
> 
> Where did these values come from?
> 

These patches were taken from the ChromeOS 3.8 kernel so I don't really know
why these values were chosen. I'll let Andrew or one of the ChromiumOS folks
to answer this question.

>>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>>  		       struct cros_ec_command *msg)
>> @@ -65,10 +69,38 @@ EXPORT_SYMBOL(cros_ec_check_result);
>>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>>  		     struct cros_ec_command *msg)
>>  {
>> -	int ret;
>> +	int ret, i;
>> +	struct cros_ec_command status_msg;
>> +	struct ec_response_get_comms_status status;
> 
> Please put these inside the if().
> 

Ok.

>>  	mutex_lock(&ec_dev->lock);
>>  	ret = ec_dev->cmd_xfer(ec_dev, msg);
>> +	if (ret == -EAGAIN && msg->result == EC_RES_IN_PROGRESS) {
> 
> Is there ever a time where (ret == -EAGAIN) but (msg->result !=
> EC_RES_IN_PROGRESS) [note the !=].  And/or is there ever a time where
> (msg->result == EC_RES_IN_PROGRESS) but (ret != -EAGAIN) [again, not
> the !=].
> 
> Another way of explaining it.  Can ret be anything other than -EAGAIN
> when the result is EC_RES_IN_PROGRESS.  And can the result be anything
> other than EC_RES_IN_PROGRESS when ret is -EAGAIN?
>

For the first question, no. ret is always -EAGAIN when result is
EC_RES_IN_PROGRESS.

All the cros_ec transport drivers (cros_ec_{i2c,spi,lpc}) have the following
code block:

	switch (msg->result) {
	...
	case EC_RES_IN_PROGRESS:
		ret = -EAGAIN;
	...
	};

For the second question, yes AFAICT. Some transports transfer function return
-EAGAIN and that error is propagated. As an example i2c_transfer() returns
-EAGAIN if the struct i2c_adapter bus_lock mutex is tried to be acquired.

But after looking at all the cros_ec transport drivers it seems to be safe to
just check if result is EC_RES_IN_PROGRESS instead of checking also if ret is
-EAGAIN since (at least on all the current transport drivers) the former
implies the later.

>> +		/*
>> +		 * Query the EC's status until it's no longer busy or
>> +		 * we encounter an error.
>> +		 */
>> +		status_msg.version = 0;
>> +		status_msg.command = EC_CMD_GET_COMMS_STATUS;
>> +		status_msg.outdata = NULL;
>> +		status_msg.outsize = 0;
>> +		status_msg.indata = (uint8_t *)&status;
>> +		status_msg.insize = sizeof(status);
>> +
>> +		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
>> +			msleep(EC_RETRY_DELAY_MS);
> 
> msleep() doesn't handle any time below 20ms well, use usleep() or even
> better usleep_range() instead.
> 

Ok.

>> +			ret = ec_dev->cmd_xfer(ec_dev, &status_msg);
>> +			if (ret < 0)
>> +				break;
> 
> What does a ret of >0 mean?
> 

When ret > 0, it means the actual amount of data received in the transfer.

>> +			msg->result = status_msg.result;
>> +			if (status_msg.result != EC_RES_SUCCESS)
>> +				break;
>> +			if (!(status.flags & EC_COMMS_STATUS_PROCESSING))
>> +				break;
>> +		}
>> +	}
>>  	mutex_unlock(&ec_dev->lock);
>>  
>>  	return ret;
> 

Best regards,
Javier
