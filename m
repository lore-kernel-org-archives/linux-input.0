From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v4] Input: add touchscreen driver for MELFAS MCS-5000
 controller
Date: Wed, 16 Sep 2009 15:19:47 +0900
Message-ID: <4AB08383.9080107@samsung.com>
References: <4AB07B5E.7040501@samsung.com>
 <20090916060017.GG2756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37035 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZIPGTp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 02:19:45 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KQ1004BNW8YWQ@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Sep 2009 15:19:47 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KQ100B3VW8Y4S@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Sep 2009 15:19:46 +0900 (KST)
In-reply-to: <20090916060017.GG2756@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

On 9/16/2009 3:00 PM, Dmitry Torokhov wrote:
> Hi Joonyoung,
> 
> On Wed, Sep 16, 2009 at 02:45:02PM +0900, Joonyoung Shim wrote:
>> +
>> +static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
>> +{
>> +	struct mcs5000_ts_data *data = dev_id;
>> +	struct i2c_client *client = data->client;
>> +	u8 buffer[READ_BLOCK_SIZE];
>> +	int err;
>> +	int x;
>> +	int y;
>> +
>> +	disable_irq_nosync(irq);
>> +
> 
> I don't think we need to disable IRQ in the threaded handler - it should
> be masked off until we return...
> 

Yor're right. It is unnecessary.

>> +
>> +static irqreturn_t mcs5000_ts_hardirq(int irq, void *dev_id)
>> +{
>> +	return IRQ_WAKE_THREAD;
>> +}
> 
> This is not needed, just pass NULL to request_threaded_irq().
> 

OK, this is unnecessary too.

I will resend the patch after fix.
Thanks.
