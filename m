From: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Subject: RE: The way of touch finger and pen stylus report
Date: Mon, 8 May 2017 10:42:32 +0800
Message-ID: <000301d2c7a4$be30f850$3a92e8f0$@emc.com.tw>
References: <001701d2c56e$9c5227f0$d4f677d0$@emc.com.tw> <CAN+gG=HJf6H_04Og+a=kfvfq9TzqZVwgvZfa-g15h96t=rc=CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:9890 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdEHCmF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 7 May 2017 22:42:05 -0400
In-Reply-To: <CAN+gG=HJf6H_04Og+a=kfvfq9TzqZVwgvZfa-g15h96t=rc=CQ@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>
Cc: 'linux-input' <linux-input@vger.kernel.org>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>

Hi Benjamin,
	I appreciate your quick response.
	I referred to Wacom_i2c.c which is an example about how does pen stylus report.
	My firmware are listed following hid usage as MS' specification : 
			Barrel, Invert, Erase
	And I think the those hid usage is mapping to below event code:
	
	HID usage	:	linux-input EV_* code
	Eraser 		:	BTN_TOOL_RUBBER	(button1 with pen contact on touch surface)
	Invert 		:	?? 					(button1 with pen hover)
	Barrel 		:	BTN_STYLUS 			(button2)

	Can you tell me what event code is mapped to hid usage "Invert"?

	My device is hid-i2c and what else I need to do after I built hid-i2c module into kernel?
	Like, do I need add my device information to whitelist.

	Thanks!!

BR,
Scott 
-----Original Message-----
From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com] 
Sent: Friday, May 05, 2017 3:33 PM
To: 劉嘉駿
Cc: linux-input; Dmitry Torokhov
Subject: Re: The way of touch finger and pen stylus report

Hi Scott,

On Fri, May 5, 2017 at 9:10 AM, 劉嘉駿 <scott.liu@emc.com.tw> wrote:
> I would like to write a touch driver for finger touch and pen stylus.
>
> They have different definition on maximum range of X, Y, Pressure,
>
> additionally, pen have two buttons functionality that need to be reported.
>
>
>
> So can driver register two input device to corresponding finger touch 
> and pen stylus?

Yes, and that's the only way you can achieve that. Each (touch and
pen) should have their own input node.

>
> Otherwise how single input device can map two different X, Y, Pressure 
> range.

That's not possible. There use to be something roughly like that in the wacom.ko driver in the past, but this wasn't compatible with wayland. So now every driver reports 2 input nodes in such cases.

>
>
>
> Another thing is that pen stylus has two buttons which enumerate to 
> Eraser/Invert and Barrel as MS spec said.
>
> Please refer to
> https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design
> /component-guidelines/required-hid-top-level-collections
>
> My question is that how do buttons represents to key bit event? Any example?

HID should handle it properly. You should map it to BTN_TOOL_RUBBER in case you are not using a HID device.
There is not much to do with this bit: if button is depressed, set the tool to BTN_TOOL_RUBBER, and when released, switch back to BTN_TOOL_PEN.

Cheers,
Benjamin

>
>
>
> Thanks.
>
>
>
> BR,
>
> Scott
>
>

