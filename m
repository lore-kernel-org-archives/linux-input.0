From: Anirudh Ghayal <aghayal@codeaurora.org>
Subject: Re: [RFC v1 PATCH 5/6] input: pmic8058-othc: Add support for PM8058
 based OTHC
Date: Wed, 01 Dec 2010 11:04:57 +0530
Message-ID: <4CF5DE81.1090803@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-6-git-send-email-tsoni@codeaurora.org> <0680EC522D0CC943BC586913CF3768C003FF9009B6@dbde02.ent.ti.com> <4CE22665.50209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:55121 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0LAFfD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 00:35:03 -0500
In-Reply-To: <4CE22665.50209@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Dimitry,

Please me know your comments this patch.

Thank you,
Anirudh

On 11/16/2010 12:06 PM, Trilok Soni wrote:
>
> Hi Shubhrajyoti,
>
> On 11/16/2010 11:06 AM, Datta, Shubhrajyoti wrote:
>> Hi Anirudh,
>>
>>> -----Original Message-----
>>> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
>>> owner@vger.kernel.org] On Behalf Of Trilok Soni
>>> Sent: Wednesday, November 10, 2010 6:18 PM
>>> To: linux-kernel@vger.kernel.org
>>> Cc: linux-input@vger.kernel.org; rtc-linux@googlegroups.com; linux-arm-
>>> msm@vger.kernel.org; Anirudh Ghayal; Dmitry Torokhov
>>> Subject: [RFC v1 PATCH 5/6] input: pmic8058-othc: Add support for PM8058
>>> based OTHC
>>>
>>> From: Anirudh Ghayal<aghayal@codeaurora.org>
>>>
>>> One-touch headset controller is a hardware module in Qualcomm's PMIC8058.
>>> It supports headset insert/remove and switch press/release detection
>>> events
>>> over 3 MIC BIAS lines. The MIC BIAS lines can be configured to support
>>> headset detection or act as regular BIAS lines.
>> Could  you help with the datasheet link if it is free.
>>
>
> datasheets are not available for open access.
>
>>> +
>>> +static int
>> If this is called only at init it can also be a devinit ?
>
> Ok.
>
>>> +     if (rc) {
>>> +             dev_dbg(&pd->dev, "Headset inserted during boot up!\n");
>>> +             dd->othc_ir_state = true;
>>> +             input_report_switch(dd->othc_ipd, SW_HEADPHONE_INSERT, 1);
>>> +             input_sync(dd->othc_ipd);
>>> +     }
>> Not a comment. However I did not understand why the status at boot is required here.
>
> We need to report right status when the system boots up with headset inserted.
>
>>> +
>>> +fail_sw_irq:
>>> +     free_irq(dd->othc_irq_ir, dd);
>>> +fail_ir_irq:
>>> +     input_unregister_device(ipd);
>> Unregister and then falling back to free may not be what you intended.
>>
>
> Nope. Please see we are making othc_ipd = NULL, so everything should be fine.
>
> Thanks for the review comments.
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
