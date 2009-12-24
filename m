From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Subject: Re: Synaptics Multi touch capabilities
Date: Thu, 24 Dec 2009 11:54:27 +0100
Message-ID: <62e5edd40912240254w19b0b6c6ye43e2805055bb0e5@mail.gmail.com>
References: <62e5edd40912230313r65593b0cmea9541ea7a246cfc@mail.gmail.com>
	 <200912231032.32526.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:62066 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbZLXLBW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2009 06:01:22 -0500
Received: by fxm25 with SMTP id 25so2694959fxm.21
        for <linux-input@vger.kernel.org>; Thu, 24 Dec 2009 03:01:18 -0800 (PST)
In-Reply-To: <200912231032.32526.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

2009/12/23 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Wednesday 23 December 2009 03:13:04 am Erik Andr=E9n wrote:
>> Hi,
>> I have a ASUS 1005HA netbook equipped with a Synaptics touch pad:
>> [   18.341491] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1a0b1,
>> caps: 0xd04731/0xa40000
>>
>> In Linux, no multitouch capabilities are detected (Zoom, two and thr=
ee
>> finger button presses etc.).
>> This all works with the same hardware in windows 7.
>> Is there a bug in the linux driver preventing multitouch to work?
>>
>
> Linux Synaptics driver does not have full multitouch support (yet?). =
The 2-
> and 3- finger taps should work (provided that they are enabled in SYn=
aptics X
> driver) but there is no multiple finger tracking...
They don't. I've tried with the 1.1.2 and 1.2.0 version of the xorg
synaptics driver. But if this is the issue I guess I should take this
inquiry to the proper xorg mailing list.

>
> BTW, the capability 0xd04731 indicates that your hardware does not re=
port
> multi-finger taps.
>
I'm aware of that, but why does pinch and zoom then work in windows 7?
Is it possible to emulate this with a single touch touchpad?

Best regards,
Erik

> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
