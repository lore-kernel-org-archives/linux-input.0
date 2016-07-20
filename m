From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Fix maximum size check for F12
 control register 8
Date: Tue, 19 Jul 2016 17:02:46 -0700
Message-ID: <62ae487a-f927-22a2-e8bb-be2927393551@synaptics.com>
References: <1468971821-16982-1-git-send-email-aduggan@synaptics.com>
 <20160720000005.GE19250@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160720000005.GE19250@dtor-ws>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>, Nitin Chaudhary <nitinchaudhary1289@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/19/2016 05:00 PM, Dmitry Torokhov wrote:
> On Tue, Jul 19, 2016 at 04:43:41PM -0700, Andrew Duggan wrote:
>> According to the RMI4 spec the maximum size of F12 control register 8 is
>> 15 bytes. The current code incorrectly reports an error if control 8 is
>> greater then 14. Making sensors with a control register 8 with 15 bytes
>> unusable.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Reported-by: Chris Healy <cphealy@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/input/rmi4/rmi_f12.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
>> index c30fd86..9b0d9f7 100644
>> --- a/drivers/input/rmi4/rmi_f12.c
>> +++ b/drivers/input/rmi4/rmi_f12.c
>> @@ -68,7 +68,7 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
>>   	struct rmi_device *rmi_dev = fn->rmi_dev;
>>   	int ret;
>>   	int offset;
>> -	u8 buf[14];
>> +	u8 buf[15];
>>   	int pitch_x = 0;
>>   	int pitch_y = 0;
>>   	int clip_x_low = 0;
>> @@ -88,8 +88,9 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
>>   
>>   	offset = rmi_register_desc_calc_reg_offset(&f12->control_reg_desc, 8);
>>   
>> -	if (item->reg_size > 14) {
>> -		dev_err(&fn->dev, "F12 control8 should be 14 bytes, not: %ld\n",
>> +	if (item->reg_size > 15) {
> Do you mind if I change this to sizeof(buf)?

Nope, that is fine with me.

Thanks,
Andrew

>
>> +		dev_err(&fn->dev,
>> +			"F12 control8 should be a maximum of 15 bytes, not: %ld\n",
>>   			item->reg_size);
>>   		return -ENODEV;
>>   	}
>> -- 
>> 2.7.4
>>
