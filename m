From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Wed, 03 Jun 2009 14:16:15 +0900
Message-ID: <4A26071F.6050906@samsung.com>
References: <4A0819EE.2050209@samsung.com>
 <20090512020921.GA1965@dtor-d630.eng.vmware.com>
 <4A0C1419.5070604@samsung.com>
 <20090514150947.GB30027@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41534 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbZFCFQP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 01:16:15 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KKN00MXPDB3YN@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 03 Jun 2009 14:16:15 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KKN00IO3DB37S@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 03 Jun 2009 14:16:15 +0900 (KST)
In-reply-to: <20090514150947.GB30027@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com

Hi, sorry for long time no reponse.

>>>> +	case INPUT_TYPE_SINGLE:
>>>> +		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
>>>> +		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
>>>> +
>>>> +		input_report_key(data->input_dev, BTN_TOUCH, 1);
>>>> +		input_report_abs(data->input_dev, ABS_X, x);
>>>> +		input_report_abs(data->input_dev, ABS_Y, y);
>>>> +		input_report_abs(data->input_dev, ABS_PRESSURE,
>>>> +				DEFAULT_PRESSURE);
>>> If the hardware does not support pressure reading don't fake it.
>>> BTN_TOUCH should be enough to signal touch.
>> MCS-5000 supports pressure reading, but the value of pressure is unstable in
>> my target, so i used the static value defined.
>> I will add pressure reading after more test.
> 
> OK. Alternatively you may indicate in the platform data if pressure
> reading is supported and set ABS_PRESSURE bit and report pressure only
> when you know it works well.

This is my mistake, the MCS-5000 does not support pressure. I confused pressure
and proximity.

>>>> +{
>>>> +	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
>>>> +
>>>> +	cancel_work_sync(&data->ts_event_work);
>>> There is a race here, IRQ handler may resubmit work after
>>> cancel_work_sync() returns. You need to  make sure that
>>> IRQ handler does not resubmit work while device is being shut down.
>> ok, how about doing free_irq() before cancel_work_sync() call?
>>
> 
> Then there is a risk that your work will try to enable_irq() on irq that
> was freed. I am not sure if IRQ core will be happy with it,
> 

It is no problem to try to enable_irq() on irq that was freed, but a new
problem is balance of disable_irq() and enable_irq().
I refered drivers/net/phy/phy.c file.

I will post patch v2.

thanks.
