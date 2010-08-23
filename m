From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Mon, 23 Aug 2010 10:02:12 -0700
Message-ID: <AANLkTi=sSbhcDO=1k-qa1YE7tK7VmVTiveoP=q_PNQE-@mail.gmail.com>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
	<AANLkTinvcUJPgSeLcc-rDF97g_QxZe_W53tCMNGT9wAd@mail.gmail.com>
	<4C7285F9.6050804@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55887 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab0HWRCN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Aug 2010 13:02:13 -0400
Received: by vws3 with SMTP id 3so5385016vws.19
        for <linux-input@vger.kernel.org>; Mon, 23 Aug 2010 10:02:12 -0700 (PDT)
In-Reply-To: <4C7285F9.6050804@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Aug 23, 2010 at 7:30 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Ping,
> [...]
>>> 1) It uses the MT slot protocol
>
>>> 2) It creates two input devices, but only one is useful
>>
>> I would like to keep the same wacom_features and usb_device_id
>> wacom_ids structures for Bamboo as we did for all the other models,
>> i.e., we define one entry for Bamboo although there could be more than
>> one logical devices (touch and pen) associated with it.
>>
>> This may not make a difference for your Bamboo (a touch only device).
>> It would make the code easy to maintain for the other Bamboos (Product
>> ID: 0xd1, 0xd2, 0xd3, and 0xd4).
>>
>> If you are not sure what I am talking about, please let me know.
>
>
> The problem I had with this is how that additional input device is presented
> in  userland.

Pen and touch data are reported to the user space by different logical
ports. So, there is no confusion among the data between the ports. MT
X driver only needs to talk to the touch port.

> As long as the capabilities are set properly for each input device, I
> have no problem using one catch-all match in the device id list.

I think we are safe here. It has been working like this for sometime...

Ping
