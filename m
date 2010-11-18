From: Chris Leech <christopher.leech@linux.intel.com>
Subject: Re: [PATCH 4/5] qt602240_ts: add optional hooks for board specific
	reset logic
Date: Thu, 18 Nov 2010 11:46:28 -0800
Message-ID: <20101118194628.GG1273@cleech-lnx.jf.intel.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6> <20101116204206.28796.34520.stgit@localhost6.localdomain6> <4CE50ED7.8000802@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49772 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498Ab0KRTq2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 14:46:28 -0500
Content-Disposition: inline
In-Reply-To: <4CE50ED7.8000802@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

On Thu, Nov 18, 2010 at 08:32:39PM +0900, Joonyoung Shim wrote:
> Hi, Chris.
>
> On 2010-11-17 =EC=98=A4=EC=A0=84 5:42, Chris Leech wrote:
>> Hooks for board specific setup and tear-down, to be used if the cont=
rollers
>> reset is wired to a GPIO pin.
>>
>> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>
>> ---
>>   drivers/input/touchscreen/qt602240_ts.c |    7 +++++++
>>   include/linux/i2c/qt602240_ts.h         |    4 ++++
>>   2 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input=
/touchscreen/qt602240_ts.c
>> index 11055ec..efe975e 100644
>> --- a/drivers/input/touchscreen/qt602240_ts.c
>> +++ b/drivers/input/touchscreen/qt602240_ts.c
>> @@ -1307,6 +1307,11 @@ static int __devinit qt602240_probe(struct i2=
c_client *client,
>>
>>   	i2c_set_clientdata(client, data);
>>
>> +	if (data->pdata->hw_setup) {
>> +		error =3D data->pdata->hw_setup(client);
>> +		if (error)
>> +			goto err_free_object;
>> +	}
>>   	error =3D qt602240_initialize(data);
>>   	if (error)
>>   		goto err_free_object;
>> @@ -1376,6 +1381,8 @@ static int __devexit qt602240_remove(struct i2=
c_client *client)
>>   	sysfs_remove_group(&client->dev.kobj,&qt602240_attr_group);
>>   	free_irq(data->irq, data);
>>   	input_unregister_device(data->input_dev);
>> +	if (data->pdata->hw_teardown)
>> +		data->pdata->hw_teardown(client);
>>   	kfree(data->object_table);
>>   	kfree(data);
>>
>> diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt6=
02240_ts.h
>> index d2aa1b6..764dd45 100644
>> --- a/include/linux/i2c/qt602240_ts.h
>> +++ b/include/linux/i2c/qt602240_ts.h
>> @@ -41,6 +41,10 @@ struct qt602240_platform_data {
>>   	 * platform_data).
>>   	 */
>>   	unsigned char trust_nvm;
>> +
>> +	/* Board-specific HW hooks; NULL if not needed */
>> +	int (*hw_setup) (struct i2c_client *client);
>> +	void (*hw_teardown) (struct i2c_client *client);
>
> Why does client need?

I'm not sure I understand your question.

If it's why are these hooks needed, I want to make sure that if the
reset pin is hooked up to a gpio the device is taken out of reset
properly.

If it's why the client argument is passed, it seemed like there should
be some way to identify the device.  You could have a platform with
multiple touchscreens.

- Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
