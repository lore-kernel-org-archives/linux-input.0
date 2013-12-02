From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH v4 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Mon, 2 Dec 2013 22:16:48 +0800
Message-ID: <CA+F6ckOSfTed-0cVYgNdv6k3=NuE1CQcwTHT51KM0p9Zd+0TKQ@mail.gmail.com>
References: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
	<20131202064121.GD21404@core.coreip.homeip.net>
	<CA+F6ckMRwq_1TbBvzQjqGFRBTdJxH74rUTuDUMmdL8c8Nda_Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:38465 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab3LBOQt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 09:16:49 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so11888837wes.41
        for <linux-input@vger.kernel.org>; Mon, 02 Dec 2013 06:16:48 -0800 (PST)
In-Reply-To: <CA+F6ckMRwq_1TbBvzQjqGFRBTdJxH74rUTuDUMmdL8c8Nda_Rw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>

Hi Dmitry,

I'm suddenly aware that change like below would be better.
Do you think so?

{ { 0x73, 0x03, 0x50 }, 0x0d, ALPS_PROTO_V5, 0xc8, 0xc8, 0 }
 => { { 0x73, 0x03, 0x50 }, 0x0d, ALPS_PROTO_V5, 0xc8, 0xd8, 0 }

Thanks
-- 
Best Regards,
Tommy


2013/12/2 Tommy Will <tommywill2011@gmail.com>:
> Hi Dmitry,
>
> Thanks for your review.
>
> 2013/12/2 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>
>>> +     /* Ignore stick point data */
>>> +     if (packet[0] == 0xD8)
>>> +             return;
>
>> Why are we ignoring trackstick data? If there Dolphin models with
>> tracksticks that would basically "break" the device for users compared
>> withe the emulated Explorer PS/2 mode.
>
> I'm sorry, I think I used the wrong comment here...
> Use comment /* Check if it's an valid touchpad packet */ would be better
>
> From the V5's spec, "0xC8" is the checkmask for 6byte Raw mode and
> 0x10 is the mask for trackpoint's / touchpad's packet.
> So, 0xC8 means current packet is from touchpad and 0xD8 for trackpoint.
> In current source code, what I wanted to do is just add a protection
> logic to double check if it's a valid touchpad packet.
>
> About your concern, I think there would be no problem because:
> 1) In initialization, we did not initialize trackpoint device as Raw
> mode and it should always report 3Byte-packet. And in the first of
>     alps_process_byte(), 3byte packet would be processed separately.
> 2) I checked with my Japanese colleague and in fact, there is no V5
> device with trackpoint + touchpad in the world, although V5's spec
>    designed the case of trackpoint's packet.
>
> Thanks
> --
> Best Regards,
> Tommy
