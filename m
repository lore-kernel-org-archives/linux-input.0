Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1230DEB7;
	Mon, 26 Jan 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422983; cv=none; b=QlkOysxT+qQPevC9W1Nt6qGSbZ1ySmRqmUVDXv3jtAUNfdQoAuTx60P1EXHCf8UTzve7asOCISAgOX3t6/ienygex95nwSqPje9pe61k7W5Udc2t5vSUsF2YHF+Pt87XK3Ff6lWc9RHnkSxC5XHdD55o+rU4Dub8tOB2dJLbwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422983; c=relaxed/simple;
	bh=ygc1uKlv7zYU9xhmwD0ebXu1vNWoTlsNh0eS/OtRKHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NRwM2qC9OvYTd/6/PNoz0iJH3qUuWQEtdMR5/bZuwwnA++amIbOsaXn4SwMfRh3RPLxpN+xLH4DVotM8iXLDBffCYywIIDiqOxEJxN8S5vEAR7Kvh5Euf13Tfjrxv/59s9F60oR4exqDUQX/Rc6uVCzvmzjaW8jTYgtKr497M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=JqpC2c5n; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="JqpC2c5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1769422658;
	bh=y+mQBNXab2dHTLXM3X9Jfe1Jx0dpgMkQIwlVu5i+C8c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=JqpC2c5nYpHw5JLsTYrsCcENcu1k3EBw8VAhBLyMh5pUJ3xP1svCMe/bf1wf864GI
	 jJsmwSaUNk1smplJIJmnthrNLjdLbGCNIkKKHgst4wQsaTePlVQN/oVCuXodOMPECE
	 ql6Ji0JTjGqQDDoP9VT8QRDRyY2oDGZZBt94eHt4=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 90EECA0518;
	Mon, 26 Jan 2026 11:17:38 +0100 (CET)
Message-ID: <07b84348-edb1-442f-822a-2e2c6275a8ad@ysoft.com>
Date: Mon, 26 Jan 2026 11:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: pixcir_i2c_ts - add support for one-time total
 calibration
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>
References: <20251119175113.39216-1-michal.vokac@ysoft.com>
 <894b86b6-8b80-4ad1-942c-0e1120c0a4ae@ysoft.com>
Content-Language: en-US
In-Reply-To: <894b86b6-8b80-4ad1-942c-0e1120c0a4ae@ysoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

second polite ping. Is this falling through the cracks or did I miss to answer/resolve
some of your comments to v1?

On 18. 12. 25 11:22, Michal Vokáč wrote:
> Hi Dmitry,
> 
> gentle ping on this.
> 
> On 19. 11. 25 18:51, Michal Vokáč wrote:
>> The Pixcir Tango controller has support for a one-time total calibration
>> (manual calibration) procedure. Its purpose is to measure the capacitance
>> offsets of the electrode system and to store these values into EEPROM.
>>
>> During normal operation this calibration data is subtracted from the values
>> measured. This calibration should be necessary only once in the product
>> lifetime. It should be performed as part of the final adjustment after
>> the panel is mounted in the product.
>>
>> Add support for the calibration with sysfs interface.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> changes in v2:
>>   - Removed redundant lock from calibrate_store().
>>
>>   drivers/input/touchscreen/pixcir_i2c_ts.c | 26 +++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> index dad5786e82a4..e52ec8d8e392 100644
>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> @@ -24,6 +24,7 @@
>>    */
>>   #define PIXCIR_REG_POWER_MODE    51
>>   #define PIXCIR_REG_INT_MODE    52
>> +#define PIXCIR_REG_SPECOP    58
>>   /*
>>    * Power modes:
>> @@ -462,6 +463,30 @@ static int pixcir_i2c_ts_resume(struct device *dev)
>>   static DEFINE_SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
>>                   pixcir_i2c_ts_suspend, pixcir_i2c_ts_resume);
>> +static ssize_t calibrate_store(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   const char *buf, size_t count)
>> +{
>> +    struct i2c_client *client = to_i2c_client(dev);
>> +    struct pixcir_i2c_ts_data *ts = i2c_get_clientdata(client);
>> +    static const u8 cmd = 0x03;
>> +    int error;
>> +
>> +    error = i2c_smbus_write_byte_data(ts->client, PIXCIR_REG_SPECOP, cmd);
>> +    if (error)
>> +        dev_err(dev, "calibrate command failed: %d\n", error);
>> +
>> +    return error ?: count;
>> +}
>> +
>> +static DEVICE_ATTR_WO(calibrate);
>> +
>> +static struct attribute *pixcir_i2c_ts_attrs[] = {
>> +    &dev_attr_calibrate.attr,
>> +    NULL,
>> +};
>> +ATTRIBUTE_GROUPS(pixcir_i2c_ts);
>> +
>>   static int pixcir_i2c_ts_probe(struct i2c_client *client)
>>   {
>>       const struct i2c_device_id *id = i2c_client_get_device_id(client);
>> @@ -600,6 +625,7 @@ MODULE_DEVICE_TABLE(of, pixcir_of_match);
>>   static struct i2c_driver pixcir_i2c_ts_driver = {
>>       .driver = {
>>           .name    = "pixcir_ts",
>> +        .dev_groups = pixcir_i2c_ts_groups,
>>           .pm    = pm_sleep_ptr(&pixcir_dev_pm_ops),
>>           .of_match_table = of_match_ptr(pixcir_of_match),
>>       },

Best regards,
Michal
