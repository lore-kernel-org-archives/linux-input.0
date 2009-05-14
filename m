From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] input: add synaptics_i2c driver
Date: Thu, 14 May 2009 14:29:03 +0300
Message-ID: <4A0C007F.7090207@compulab.co.il>
References: <1242225003-8049-1-git-send-email-mike@compulab.co.il>	<20090514025030.GB9461@dtor-d630.eng.vmware.com>	<20090514092818.39a83282@hyperion.delvare>	<4A0BDE82.5070006@compulab.co.il> <20090514130034.2119c883@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:46971 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbZENL3H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 07:29:07 -0400
In-Reply-To: <20090514130034.2119c883@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, grinberg@compulab.co.il, linux-input@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Hi Mike,
> 
> On Thu, 14 May 2009 12:04:02 +0300, Mike Rapoport wrote:
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  drivers/input/mouse/Kconfig         |    9 +
>>  drivers/input/mouse/Makefile        |    1 +
>>  drivers/input/mouse/synaptics_i2c.c |  793 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 803 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/input/mouse/synaptics_i2c.c
> 
> I think you introduced a new bug in this version:
> 
>> (...)
>> +static s32 synaptics_i2c_block_get(struct i2c_client *client,
>> +				    u16 reg, u8 length, u8 *values)
>> +{
>> +	struct synaptics_i2c *touch = i2c_get_clientdata(client);
>> +	int ret;
>> +
>> +	mutex_lock(&touch->mutex);
>> +
>> +	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
>> +	if (!ret)
>> +		ret = i2c_smbus_read_i2c_block_data(client, reg & 0xff,
>> +						    length, values);
>> +
>> +	mutex_unlock(&touch->mutex);
>> +
>> +	return ret < 0 ? : 0;
>> +}
> 
> Here you return 0 on success...
> 
>> +
>> +static int synaptics_i2c_query(struct i2c_client *client)
>> +{
>> +	u8 data[7];
>> +	char id[PRODUCT_ID_LENGTH + 1];
>> +	int ret, retry_count, control, status, sens;
>> +
>> +	/* DEV_QUERY_REG0 is the Function Query area for 2D devices. */
>> +	/* We're only interested in entries DEV_QUERY_REG2 */
>> +	/* and following registers right now. */
>> +	for (retry_count = 0; retry_count < 3; retry_count++) {
>> +		ret = synaptics_i2c_block_get(client, DEV_QUERY_REG2,
>> +					       sizeof(data), data);
>> +		if (ret == sizeof(data))
> 
> ... but here you expect the number of read values.

I think I'd just drop the entire _query think although original driver author
really wanted to have it. It does not add anything except the head ache.

> 
>> +			break;
>> +	}
>> +
>> +	if (ret == sizeof(data)) {
>> +		dev_warn(&client->dev,
>> +			  "Query command failed: block read failed\n");
>> +	} else {
> 
>> (...)
>> +static struct i2c_driver synaptics_i2c_driver = {
>> +	.driver = {
>> +		.name	= DRIVER_NAME,
>> +		.owner	= THIS_MODULE,
>> +	},
>> +
>> +	.probe		= synaptics_i2c_probe,
>> +	.remove		= synaptics_i2c_remove,
> 
> Still missing __devexit_p() as Dmitry wrote.

I somehow missed all the points Dmitry had. :( So I'm going to another round
now. Sorry for the noise.

>> +
>> +	.suspend	= synaptics_i2c_suspend,
>> +	.resume		= synaptics_i2c_resume,
>> +	.id_table	= synaptics_i2c_id_table,
>> +};
> 
> The rest looks OK to me. After fixing the 2 errors above, you can add
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 

-- 
Sincerely yours,
Mike.

