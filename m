From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: The way of touch finger and pen stylus report
Date: Tue, 9 May 2017 10:30:16 +0200
Message-ID: <CAN+gG=ETLG_GokivuKLmrUsQqgJhoPL7d6Y2kgSVEQwLXj9BJg@mail.gmail.com>
References: <001701d2c56e$9c5227f0$d4f677d0$@emc.com.tw> <CAN+gG=HJf6H_04Og+a=kfvfq9TzqZVwgvZfa-g15h96t=rc=CQ@mail.gmail.com>
 <000301d2c7a4$be30f850$3a92e8f0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35871 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbdEIIaY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 04:30:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id u65so2521009wmu.1
        for <linux-input@vger.kernel.org>; Tue, 09 May 2017 01:30:18 -0700 (PDT)
In-Reply-To: <000301d2c7a4$be30f850$3a92e8f0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, May 8, 2017 at 4:42 AM, =E5=8A=89=E5=98=89=E9=A7=BF <scott.liu@emc.=
com.tw> wrote:
> Hi Benjamin,
>         I appreciate your quick response.
>         I referred to Wacom_i2c.c which is an example about how does pen =
stylus report.
>         My firmware are listed following hid usage as MS' specification :
>                         Barrel, Invert, Erase
>         And I think the those hid usage is mapping to below event code:
>
>         HID usage       :       linux-input EV_* code
>         Eraser          :       BTN_TOOL_RUBBER (button1 with pen contact=
 on touch surface)
>         Invert          :       ??                                      (=
button1 with pen hover)
>         Barrel          :       BTN_STYLUS                      (button2)

IIRC, you should have:

Invert: BTN_TOOL_RUBBER (button 1 pressed, hover or touching)
Eraser: BTN_TOUCH (button1 with pen contact on touch surface)
Barrel: BTN_STYLUS                      (button2)

Note that as long as button 1 is pressed, your firmware should send
invert to 1 (independently of the tip touching the surface).

That's how the wacom driver works, and how hid-input should be working
(I haven't seen the eraser part in hid-input, so there might be a bug
here). hid-input handles the pressure as tip switch too, so it should
eb working fine if you report pressure.

>
>         Can you tell me what event code is mapped to hid usage "Invert"?
>
>         My device is hid-i2c and what else I need to do after I built hid=
-i2c module into kernel?
>         Like, do I need add my device information to whitelist.

You should only build i2c-hid and hid-multitouch. Nothing else, no whitelis=
t.

Cheers,
Benjamin

>
>         Thanks!!
>
> BR,
> Scott
> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
> Sent: Friday, May 05, 2017 3:33 PM
> To: =E5=8A=89=E5=98=89=E9=A7=BF
> Cc: linux-input; Dmitry Torokhov
> Subject: Re: The way of touch finger and pen stylus report
>
> Hi Scott,
>
> On Fri, May 5, 2017 at 9:10 AM, =E5=8A=89=E5=98=89=E9=A7=BF <scott.liu@em=
c.com.tw> wrote:
>> I would like to write a touch driver for finger touch and pen stylus.
>>
>> They have different definition on maximum range of X, Y, Pressure,
>>
>> additionally, pen have two buttons functionality that need to be reporte=
d.
>>
>>
>>
>> So can driver register two input device to corresponding finger touch
>> and pen stylus?
>
> Yes, and that's the only way you can achieve that. Each (touch and
> pen) should have their own input node.
>
>>
>> Otherwise how single input device can map two different X, Y, Pressure
>> range.
>
> That's not possible. There use to be something roughly like that in the w=
acom.ko driver in the past, but this wasn't compatible with wayland. So now=
 every driver reports 2 input nodes in such cases.
>
>>
>>
>>
>> Another thing is that pen stylus has two buttons which enumerate to
>> Eraser/Invert and Barrel as MS spec said.
>>
>> Please refer to
>> https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design
>> /component-guidelines/required-hid-top-level-collections
>>
>> My question is that how do buttons represents to key bit event? Any exam=
ple?
>
> HID should handle it properly. You should map it to BTN_TOOL_RUBBER in ca=
se you are not using a HID device.
> There is not much to do with this bit: if button is depressed, set the to=
ol to BTN_TOOL_RUBBER, and when released, switch back to BTN_TOOL_PEN.
>
> Cheers,
> Benjamin
>
>>
>>
>>
>> Thanks.
>>
>>
>>
>> BR,
>>
>> Scott
>>
>>
>
