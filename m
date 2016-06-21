From: ghzhong <ghzhong@yifangdigital.com>
Subject: Re: [PATCH] HID: i2c-hid: set power sleep before shutdown
Date: Tue, 21 Jun 2016 15:37:17 +0800
Message-ID: <5768EEAD.10004@yifangdigital.com>
References: <1466247030-23047-1-git-send-email-ghzhong@yifangdigital.com>
 <20160620103954.GG1739@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.yifangdigital.com ([121.15.200.100]:4839 "EHLO
	yifangdigital.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752265AbcFUHk6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 03:40:58 -0400
In-Reply-To: <20160620103954.GG1739@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/20/2016 06:39 PM, Mika Westerberg wrote:
> On Sat, Jun 18, 2016 at 06:50:30PM +0800, Guohua Zhong wrote:
>> Add i2c_hid_shutdown for i2c-hid driver to send suspend cmd &
>> disable irq before device shutdown.
>>
>> Some HW design is that the power to i2c hid device won't down
>> after device shutdown. Also the i2c-hid driver do not send suspend
>> cmd to the hid i2c device and disable its irq before shutdown.So
>> if We touch the touchscreen or some other i2c hid device ,the power
>> consumtion will be go up even when the device is in shutdown state.
>>
>> Though the root cause maybe a HW issue. But it seems that it is a
>> good pratice to set power sleep for i2c-hid device before shutdown.
>>
>> Signed-off-by: Guohua Zhong <ghzhong@yifangdigital.com>
>> ---
>>   drivers/hid/i2c-hid/i2c-hid.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index 2e021ba..d6ea97b 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -1106,6 +1106,12 @@ static int i2c_hid_remove(struct i2c_client *client)
>>   	return 0;
>>   }
>>   
>> +static void i2c_hid_shutdown(struct i2c_client *client)
>> +{
>> +	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
>> +	disable_irq(client->irq);
> Why not free_irq() instead?
Oh, you are right, the free_irq is better.
>
>> +}
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   static int i2c_hid_suspend(struct device *dev)
>>   {
>> @@ -1230,7 +1236,7 @@ static struct i2c_driver i2c_hid_driver = {
>>   
>>   	.probe		= i2c_hid_probe,
>>   	.remove		= i2c_hid_remove,
>> -
>> +	.shutdown	= i2c_hid_shutdown,
>>   	.id_table	= i2c_hid_id_table,
>>   };
>>   
>> -- 
>> 1.9.1
>>
>


