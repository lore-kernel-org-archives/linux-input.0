From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] hwmod: sensors: mma845x gravity sensor chips
Date: Thu, 14 Apr 2011 11:10:12 +0800
Message-ID: <BANLkTimxuG+H5YGdiNZx58PBQPO18xWy1A@mail.gmail.com>
References: <1302695813-9606-1-git-send-email-jiejing.zhang@freescale.com>
 <20110413143324.3fae2a75@endymion.delvare> <4DA5A0EE.7040505@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58548 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758639Ab1DNDKd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 23:10:33 -0400
Received: by pzk9 with SMTP id 9so432601pzk.19
        for <linux-input@vger.kernel.org>; Wed, 13 Apr 2011 20:10:33 -0700 (PDT)
In-Reply-To: <4DA5A0EE.7040505@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org

Hi Jonathan,

2011/4/13 Jonathan Cameron <jic23@cam.ac.uk>:
> On 04/13/11 13:33, Jean Delvare wrote:
>> On Wed, 13 Apr 2011 19:56:53 +0800, Zhang Jiejing wrote:
>>> This patch add basic support for mma8450 mma8451 gravity
>>> sensor chips, and will support mma8452, mma8453 in same
>>> driver file.
>>>
>>> They are i2c controller and support 3-axis gravity accelerator
>>> sensor.
>>>
>>> mma8450 have some different from mma845[1,2,3] in register map, so
>>> there are some switch case between mma8450 and others.
>>>
>>> Product Information can be found here:
>>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMM=
A8450Q
>>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMM=
A8451Q
>>>
>>> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
>>> ---
>>> =A0drivers/hwmon/Kconfig =A0 | =A0 10 +
>>> =A0drivers/hwmon/Makefile =A0| =A0 =A01 +
>>> =A0drivers/hwmon/mma845x.c | =A0568 +++++++++++++++++++++++++++++++=
++++++++++++++++
>>> =A03 files changed, 579 insertions(+), 0 deletions(-)
>>> =A0create mode 100644 drivers/hwmon/mma845x.c
>>
>> Nack. Accelerometers don't belong to hwmon. Several such drivers wer=
e
>> kicked out of drivers/hwmon recently, and we won't accept any such
>> driver in the future. Push this to drivers/misc, drivers/input or
>> drivers/staging/iio, whichever your prefer, but not drivers/hwmon.
> Taking a quick look, you already have a polled input device in here
> and it makes no use of hwmon interfaces whatsoever so input is the
> obvious target.
>
> Couple of quick things I noticed whilst scan reading...
>
> id table contains only 8451 and 8450, get_mmax845x_name contains
> 8452 and 8453.
>
> Use the names in the id table to provide you with the names rather th=
an
> an additional function.
>
> Take a look at how other drivers handle subtly different parts. There
> are much neater ways of doing it than things like get_ctrl_register.
Could you give a filename or example driver name ? I can use them as an=
 example.


since mma845[1-3] have same operation flow, and data byte order, but
mma8450 is different on both register address and data byte order.

Do you think split mma8450 and mma845x (8451, 8452, 8453) into two
file is better?


>
> Shift it over to input and I'll do a full review.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
