From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support
Date: Sat, 18 Jan 2014 10:30:09 +0800
Message-ID: <CA+F6ckPDkigiy1qKPTXE7Ec1xgj3Jk-fXa-vrpjwd_vJmzU2Yg@mail.gmail.com>
References: <52D6B45A.4050202@gmail.com>
	<CA+F6ckMgiF-TrCf1rxNGvGrPHubxdVCtTBsLOKHpg=StRt8BvA@mail.gmail.com>
	<52D955A3.9040802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:37313 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbaARCaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 21:30:11 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so3545612lbj.17
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 18:30:10 -0800 (PST)
In-Reply-To: <52D955A3.9040802@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AJ Guillon <aj.guillon@gmail.com>
Cc: linux-input@vger.kernel.org

Hi AJ,

> Here is the touchpad I bought:
> http://www.cirque.com/desktoptouchpad/productsandorders/smartcatpro.aspx
> (the black USB one).

Thanks for your info.

> It works somewhat as a mouse, but isn't recognized as a touchpad.
>
> If there is no chance for Linux support, I'll just return it and
> exchange for a brand that does support Linux.  If there is something I
> can do to help it be supported, I'm happy to do so.
>

First, so thanks for you'll be happy to try the patch if we can
provide. However, I'm not
the manager of Cirque who can decide if we'll support the device.
I have sent the request mail to my Cirque's colleague and please wait
my feedback until
next week. Sorry for the inconvenience!

Thanks
-- 
Best Regards,
Tommy

> AJ
>
> On 14-01-17 11:01 AM, Tommy Will wrote:
>> Hi AJ,
>>
>> This is Tommy from ALPS. From the PCI ID you attached, it looks like
>> an external USB touchpad (?)
>> If so, modify alps.c may not let touchpad work since its only for PS/2 device.
>>
>> I'm sorry although I work in ALPS, I'm not so familar with the
>> products made by Cirque.
>> However, I'll try to ask our Cirque's colleagues if they have schedule
>> to support their products for Linux mainstring.
>> Thanks !
>>
