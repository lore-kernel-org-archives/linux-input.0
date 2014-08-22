From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [RESEND PATCH 5/7] mfd: cros_ec: wait for completion of commands
 that return IN_PROGRESS
Date: Fri, 22 Aug 2014 13:24:52 +0200
Message-ID: <53F72884.20801@collabora.co.uk>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk> <1408536812-7836-6-git-send-email-javier.martinez@collabora.co.uk> <20140821142100.GM4266@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140821142100.GM4266@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello Lee,

Thanks a lot for your feedback.

On 08/21/2014 04:21 PM, Lee Jones wrote:
> On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:
> 
>> From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> 
>> When an EC command returns EC_RES_IN_PROGRESS, we need to query
>> the state of the EC until it indicates that it is no longer busy.
>> Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
>> commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
>> it is working on the in-progress command.
>> 
>> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>> ---
>>  drivers/mfd/cros_ec.c | 35 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 34 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index c53804a..634c434 100644
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
>>  
>>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>>  		       struct cros_ec_command *msg)
>> @@ -65,10 +69,39 @@ EXPORT_SYMBOL(cros_ec_check_result);
>>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>>  		     struct cros_ec_command *msg)
>>  {
>> -	int ret;
>> +	int ret, i;
>>  
>>  	mutex_lock(&ec_dev->lock);
>>  	ret = ec_dev->cmd_xfer(ec_dev, msg);
>> +	if (ret == -EAGAIN && msg->result == EC_RES_IN_PROGRESS) {
>> +		/*
>> +		 * Query the EC's status until it's no longer busy or
>> +		 * we encounter an error.
>> +		 */
>> +		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
>> +			struct cros_ec_command status_msg;
>> +			struct ec_response_get_comms_status status;
>> +
>> +			msleep(EC_RETRY_DELAY_MS);
>> +
>> +			status_msg.version = 0;
>> +			status_msg.command = EC_CMD_GET_COMMS_STATUS;
>> +			status_msg.outdata = NULL;
>> +			status_msg.outsize = 0;
>> +			status_msg.indata = (uint8_t *)&status;
>> +			status_msg.insize = sizeof(status);
>> +
>> +			ret = ec_dev->cmd_xfer(ec_dev, &status_msg);
>> +			if (ret < 0)
>> +				break;
>> +
>> +			msg->result = status_msg.result;
>> +			if (status_msg.result != EC_RES_SUCCESS)
>> +				break;
>> +			if (!(status.flags & EC_COMMS_STATUS_PROCESSING))
>> +				break;
>> +		}
>> +	}
> 
> Wow!  Things just got ugly real fast.
> 
> Do the *xfer() calls fiddle with msg passed into cros_ec_cmd_xfer()?
> If not, why is it necessary to keep populating it?
> 

Not really, I see that only struct cros_ec_command .result and .indata
fields are modified by the cmd_xfer() function handlers so I agree with
you that these variables can be defined outside of the for loop and
reused. I think that even zero'ing indata is not needed between calls
since on success the full sizeof(status) is copied and on failure it
doesn't matter what is there.

Will change this when doing the re-spin.

> If all this stuff is necessary (and I really hope that it's not) I
> think it would be better to have the for() loop as the outer layer.
> Then we only have one instance of cmd_xfer() invocation and we save a
> layer of tabbing. 
> 

Most of this doesn't need to be inside the for loop as you said but there
is a need for two struct cros_ec_command *msg though, one for the actual
command made by the caller and other to query the EC if it already
finished processing the first command.

>>  	mutex_unlock(&ec_dev->lock);
>>  
>>  	return ret;
> 

Best regards,
Javier
