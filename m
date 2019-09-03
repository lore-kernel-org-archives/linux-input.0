From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v2 29/49] Input: atmel_mxt_ts - implement debug output for
 messages
Date: Tue, 3 Sep 2019 16:39:32 +0900
Message-ID: <f0e8045a-e5d8-1fcf-268e-9a0ae6d9c0d4@mentor.com>
References: <20190827062943.20698-1-jiada_wang@mentor.com>
 <20190827062943.20698-5-jiada_wang@mentor.com>
 <20190829153124.cozqsegnmvxveecd@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829153124.cozqsegnmvxveecd@holly.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: nick@shmanahar.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

Hi Daniel

On 2019/08/30 0:31, Daniel Thompson wrote:
> On Tue, Aug 27, 2019 at 03:29:23PM +0900, Jiada Wang wrote:
>> From: Nick Dyer <nick.dyer@itdev.co.uk>
>>
>> Add a debug switch which causes all messages from the touch controller to
>> be dumped to the dmesg log with a set prefix "MXT MSG:". This is used by
>> Atmel user-space utilities to debug touch operation. Enabling this output
>> does impact touch performance.
>>
>> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
>> (cherry picked from ndyer/linux/for-upstream commit 3c3fcfdd4889dfeb1c80ae8cd94a622c6342b06a)
>> [gdavis: Forward port and fix conflicts.]
>> Signed-off-by: George G. Davis <george_davis@mentor.com>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/input/touchscreen/atmel_mxt_ts.c | 44 ++++++++++++++++++++++--
>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 2d2e8ea30547..941c6970cb70 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -335,6 +335,7 @@ struct mxt_data {
>>   	u8 t100_aux_ampl;
>>   	u8 t100_aux_area;
>>   	u8 t100_aux_vect;
>> +	bool debug_enabled;
>>   	u8 max_reportid;
>>   	u32 config_crc;
>>   	u32 info_crc;
>> @@ -460,8 +461,8 @@ static bool mxt_object_readable(unsigned int type)
>>   
>>   static void mxt_dump_message(struct mxt_data *data, u8 *message)
>>   {
>> -	dev_dbg(&data->client->dev, "message: %*ph\n",
>> -		data->T5_msg_size, message);
>> +	dev_dbg(&data->client->dev, "MXT MSG: %*ph\n",
>> +		       data->T5_msg_size, message);
> 
> I'm not 100% convinced that the kernel should change here (arguably the
> userspace utility should be modified instead) but if the messages are
> conforming to some sort of vendor specific protocol then some commenting
> is needed.
I will update with inline comment
> 
> 
>> @@ -3538,6 +3573,8 @@ static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);
>>   static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
>>   static DEVICE_ATTR(update_cfg, S_IWUSR, NULL, mxt_update_cfg_store);
>>   static DEVICE_ATTR(config_crc, S_IRUGO, mxt_config_crc_show, NULL);
>> +static DEVICE_ATTR(debug_enable, S_IWUSR | S_IRUSR, mxt_debug_enable_show,
>> +		   mxt_debug_enable_store);
> 
> Why isn't CONFIG_DYNAMIC_DEBUG sufficient to enable/disable the
> messages?
> 
thanks for the comment, I think the only difference is,
by only using CONFIG_DYNAMC_DEBUG, it's hard to differentiate
the messages between valid report_id and exceptional case
(explicitly set of "dump = true")


Thanks,
Jiada
> 
> Daniel.
> 
