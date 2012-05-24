From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v5] input: Add MELFAS mms114 touchscreen driver
Date: Thu, 24 May 2012 16:46:42 +0900
Message-ID: <4FBDE762.8020602@samsung.com>
References: <1337841467-20717-1-git-send-email-jy0922.shim@samsung.com>
 <20120524072108.GA3975@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:17550 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab2EXHqo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 03:46:44 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4I00FAUO9US320@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 24 May 2012 16:46:43 +0900 (KST)
Received: from [165.213.219.123] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M4I008ETO9UIVE1@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 24 May 2012 16:46:42 +0900 (KST)
In-reply-to: <20120524072108.GA3975@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

On 05/24/2012 04:21 PM, Henrik Rydberg wrote:
> Hi Joonyoung,
>
>> This is a initial driver for new touchscreen chip mms114 of MELFAS.
>> It uses I2C interface and supports 10 multi touch.
>>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> ---
>> This v5 patch was updated from Henrik review mainly.
> Looking neat now, thanks for making the changes. One comment and one question:
>
>> +#define MMS114_PACKET_NUM		8
> I would have dropped this in favor of sizeof(touch[0]) instead.

OK.

>> +static irqreturn_t mms114_interrupt(int irq, void *dev_id)
>> +{
>> +	struct mms114_data *data = dev_id;
>> +	struct mms114_touch touch[MMS114_MAX_TOUCH];
>> +	int packet_size;
>> +	int touch_size;
>> +	int index;
>> +	int error;
>> +
>> +	if (!data->enabled)
>> +		goto out;
>> +
>> +	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
>> +	if (packet_size<= 0)
>> +		goto out;
>> +
>> +	touch_size = packet_size / MMS114_PACKET_NUM;
> Since MMS114_PACKET_NUM changed, this calculation is no longer the
> same. Will you still get the correct number of touches for all
> firmware versions?

No, it is working only from firmware version 0x59 and i am using
firmware version 0x66. I don't know Melfas's firmware policy. Melfas
releases sometimes inconsistent updated firmware internally, so driver
needs to check firmware version later but currently this driver can't
get the correct number of touches on lower firmware version than 0x59.

>> +
>> +	error = __mms114_read_reg(data, MMS114_INFOMATION, packet_size,
>> +			(u8 *)touch);
>> +	if (error<  0)
>> +		goto out;
>> +
>> +	for (index = 0; index<  touch_size; index++)
>> +		mms114_proc_mt(data, touch + index);
>> +
>> +	input_mt_report_pointer_emulation(data->input_dev, true);
>> +	input_sync(data->input_dev);
>> +
>> +out:
>> +	return IRQ_HANDLED;
>> +}
> Thanks,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

