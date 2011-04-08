From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 2/2 v3] Input: atmel_mxt_ts - Make CHG line high after
 the interrupts are enabled
Date: Fri, 08 Apr 2011 15:58:34 +0300
Message-ID: <4D9F067A.8070204@atmel.com>
References: <4D821E00.5060104@atmel.com>	<AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>	<4D95DB70.2090604@atmel.com> <BANLkTi=PRjx3nN0LQs9Asdj0PHj-ripv4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:10423 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab1DHNAM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2011 09:00:12 -0400
In-Reply-To: <BANLkTi=PRjx3nN0LQs9Asdj0PHj-ripv4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello,

On 04/08/2011 07:56 AM, Joonyoung Shim wrote:
> Hi,
> 
> 2011/4/1 Iiro Valkonen <iiro.valkonen@atmel.com>:
>> This is version 2 of the patch, where sysfs group is correctly removed in case of error, and the firmware update is also considered (mxt_make_highchg is also called from mxt_initialize).
>>
>> Original description:
>>
>> Make the CHG line (interrupt line) go high after the interrupts have been enabled to make sure we don't miss the falling edge.
>>
>> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
>> ---
>>  drivers/input/touchscreen/atmel_mxt_ts.c |   14 ++++++++++----
>>  1 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 4012436..08ea846 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -804,10 +804,6 @@ static int mxt_initialize(struct mxt_data *data)
>>        if (error)
>>                return error;
>>
>> -       error = mxt_make_highchg(data);
>> -       if (error)
>> -               return error;
>> -
>>        mxt_handle_pdata(data);
>>
>>        /* Backup to memory */
>> @@ -832,6 +828,10 @@ static int mxt_initialize(struct mxt_data *data)
>>                return error;
>>        info->matrix_ysize = val;
>>
>> +       error = mxt_make_highchg(data);
>> +       if (error)
>> +               return error;
>> +
> 
> This is unnecessary patch. If you add this for firmware update part,
> how about move to mxt_update_fw_store()?
> 

Good call.

>>        dev_info(&client->dev,
>>                        "Family ID: %d Variant ID: %d Version: %d Build: %d\n",
>>                        info->family_id, info->variant_id, info->version,
>> @@ -1098,8 +1098,14 @@ static int __devinit mxt_probe(struct i2c_client *client,
>>        if (error)
>>                goto err_unregister_device;
>>
>> +       error = mxt_make_highchg(data);
>> +       if (error)
>> +               goto err_remove_sysfs_group;
>> +
> 
> This is ok, but how about move this to the below request_threaded_irq()
> instead of adding error handling?
> 

Makes sense, will move it.

Thanks for the feedback.

BR,

-- 
Iiro
