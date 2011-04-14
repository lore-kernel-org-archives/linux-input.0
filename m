From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] hwmod: sensors: mma845x gravity sensor chips
Date: Thu, 14 Apr 2011 12:50:07 +0100
Message-ID: <4DA6DF6F.30000@cam.ac.uk>
References: <1302695813-9606-1-git-send-email-jiejing.zhang@freescale.com> <20110413143324.3fae2a75@endymion.delvare> <4DA5A0EE.7040505@cam.ac.uk> <BANLkTimxuG+H5YGdiNZx58PBQPO18xWy1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57436 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab1DNLsS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Apr 2011 07:48:18 -0400
In-Reply-To: <BANLkTimxuG+H5YGdiNZx58PBQPO18xWy1A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jiejing.Zhang" <kzjeef@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org

On 04/14/11 04:10, Jiejing.Zhang wrote:
> Hi Jonathan,
> 
> 2011/4/13 Jonathan Cameron <jic23@cam.ac.uk>:
>> On 04/13/11 13:33, Jean Delvare wrote:
>>> On Wed, 13 Apr 2011 19:56:53 +0800, Zhang Jiejing wrote:
>>>> This patch add basic support for mma8450 mma8451 gravity
>>>> sensor chips, and will support mma8452, mma8453 in same
>>>> driver file.
>>>>
>>>> They are i2c controller and support 3-axis gravity accelerator
>>>> sensor.
>>>>
>>>> mma8450 have some different from mma845[1,2,3] in register map, so
>>>> there are some switch case between mma8450 and others.
>>>>
>>>> Product Information can be found here:
>>>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8450Q
>>>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8451Q
>>>>
>>>> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
>>>> ---
>>>>  drivers/hwmon/Kconfig   |   10 +
>>>>  drivers/hwmon/Makefile  |    1 +
>>>>  drivers/hwmon/mma845x.c |  568 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 579 insertions(+), 0 deletions(-)
>>>>  create mode 100644 drivers/hwmon/mma845x.c
>>>
>>> Nack. Accelerometers don't belong to hwmon. Several such drivers were
>>> kicked out of drivers/hwmon recently, and we won't accept any such
>>> driver in the future. Push this to drivers/misc, drivers/input or
>>> drivers/staging/iio, whichever your prefer, but not drivers/hwmon.
>> Taking a quick look, you already have a polled input device in here
>> and it makes no use of hwmon interfaces whatsoever so input is the
>> obvious target.
>>
>> Couple of quick things I noticed whilst scan reading...
>>
>> id table contains only 8451 and 8450, get_mmax845x_name contains
>> 8452 and 8453.
>>
>> Use the names in the id table to provide you with the names rather than
>> an additional function.
>>
>> Take a look at how other drivers handle subtly different parts. There
>> are much neater ways of doing it than things like get_ctrl_register.
> Could you give a filename or example driver name ? I can use them as an example.
> 
> 
> since mma845[1-3] have same operation flow, and data byte order, but
> mma8450 is different on both register address and data byte order.
> 
> Do you think split mma8450 and mma845x (8451, 8452, 8453) into two
> file is better?
Difficult to know without analysing full code.  Right now you are only
supporting a small corner of what the chips supply, so probably depends
more on what features get added to the drivers in future..
> 
> 
>>
>> Shift it over to input and I'll do a full review.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

