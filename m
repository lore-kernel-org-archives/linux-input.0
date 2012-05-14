From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] input: Add MELFAS mms114 touchscreen driver
Date: Mon, 14 May 2012 16:34:05 +0900
Message-ID: <4FB0B56D.9010209@samsung.com>
References: <1336100056-19884-1-git-send-email-jy0922.shim@samsung.com>
 <20120504094308.GA7124@polaris.bitmath.org> <4FB091D3.1070400@samsung.com>
 <20120514065634.GA18514@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29951 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab2ENHd5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 03:33:57 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M40002EB50J7BI0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 14 May 2012 16:33:56 +0900 (KST)
Received: from [165.213.219.123] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M4000K6950JKLN1@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 14 May 2012 16:33:55 +0900 (KST)
In-reply-to: <20120514065634.GA18514@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

On 05/14/2012 03:56 PM, Henrik Rydberg wrote:
>>>> +struct mms114_data {
>>>> +	struct i2c_client	*client;
>>>> +	struct input_dev	*input_dev;
>>>> +	struct mutex		mutex;
>>> Other similar drivers seem to get by with the input mutex.
>> This is the mutex for i2c synchronization, not for input.
> Yes, but you have disable_irq()/enable_irq() for that.
>
>>>> +static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
>>>> +			     unsigned int len, u8 *val)
>>>> +{
>>>> +	struct i2c_client *client = data->client;
>>>> +	struct i2c_msg xfer;
>>>> +	u8 buf = reg&   0xff;
>>>> +	int ret;
>>>> +
>>>> +	if (reg == MMS114_MODE_CONTROL) {
>>>> +		dev_err(&client->dev, "No support to read mode control reg\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	mutex_lock(&data->mutex);
>>> Looks like this mutex is malplaced. The function is called both from
>>> interrupt context and from user-driven context.
>> This driver uses threaded irq, it is not interrupt context.
> Interrupt-driven context, I meant to say. Technically, your code
> works, but the pattern is unusual. The serialization is needed to
> remove the race between a call initiated by the interrupt and a call
> initiated by the user, coming in through suspend/resume. The standard
> pattern for the latter is to turn interrupts off and wait for
> interrupt completion, which you already do, then continue
> execution. The effect is the same, without the mutex.
>

I just thought, if i don't have any locking here, there is no guarantee
that another i2c access won't happen between i2c_transfer() and
i2c_master_recv(). But this can be replaced to one i2c_transfer().

>>>> +	touchdata->strength = buf[5];
>>> Does not seem to be used anywhere.
>> It seems to be used for pressure.
> It is assigned a variable, but it is not reported to userland.

Right, I should add it.

>>>> +static int mms114_suspend(struct device *dev)
>>>> +{
>>>> +	struct i2c_client *client = to_i2c_client(dev);
>>>> +	struct mms114_data *data = i2c_get_clientdata(client);
>>>> +	struct mms114_touchdata *touchdata = data->touchdata;
>>>> +	int id;
>>>> +	int ret;
>>>> +
>>> It would seem the mutex should be here instead.
>> Any reasons? I did not feel the mutex needs here.
> Oh well, as long as suspend/resume is the only user intervention, and
> because those are already serialized, then maybe so. Something to
> revisit in the next patch version, I presume.
>
> Thanks,
> Henrik
>

Thanks.
