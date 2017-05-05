From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: The way of touch finger and pen stylus report
Date: Fri, 5 May 2017 09:32:53 +0200
Message-ID: <CAN+gG=HJf6H_04Og+a=kfvfq9TzqZVwgvZfa-g15h96t=rc=CQ@mail.gmail.com>
References: <001701d2c56e$9c5227f0$d4f677d0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34775 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755842AbdEEHcz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 03:32:55 -0400
Received: by mail-wr0-f169.google.com with SMTP id l9so18940219wre.1
        for <linux-input@vger.kernel.org>; Fri, 05 May 2017 00:32:54 -0700 (PDT)
In-Reply-To: <001701d2c56e$9c5227f0$d4f677d0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Scott,

On Fri, May 5, 2017 at 9:10 AM, =E5=8A=89=E5=98=89=E9=A7=BF <scott.liu@emc.=
com.tw> wrote:
> I would like to write a touch driver for finger touch and pen stylus.
>
> They have different definition on maximum range of X, Y, Pressure,
>
> additionally, pen have two buttons functionality that need to be reported=
.
>
>
>
> So can driver register two input device to corresponding finger touch and
> pen stylus?

Yes, and that's the only way you can achieve that. Each (touch and
pen) should have their own input node.

>
> Otherwise how single input device can map two different X, Y, Pressure
> range.

That's not possible. There use to be something roughly like that in
the wacom.ko driver in the past, but this wasn't compatible with
wayland. So now every driver reports 2 input nodes in such cases.

>
>
>
> Another thing is that pen stylus has two buttons which enumerate to
> Eraser/Invert and Barrel as MS spec said.
>
> Please refer to
> https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design/co=
mponent-guidelines/required-hid-top-level-collections
>
> My question is that how do buttons represents to key bit event? Any examp=
le?

HID should handle it properly. You should map it to BTN_TOOL_RUBBER in
case you are not using a HID device.
There is not much to do with this bit: if button is depressed, set the
tool to BTN_TOOL_RUBBER, and when released, switch back to
BTN_TOOL_PEN.

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
