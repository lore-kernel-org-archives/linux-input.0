From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH v4 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Mon, 2 Dec 2013 15:37:35 +0800
Message-ID: <CA+F6ckMRwq_1TbBvzQjqGFRBTdJxH74rUTuDUMmdL8c8Nda_Rw@mail.gmail.com>
References: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
	<20131202064121.GD21404@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:52854 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3LBHhg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 02:37:36 -0500
Received: by mail-wi0-f176.google.com with SMTP id hq4so4309320wib.15
        for <linux-input@vger.kernel.org>; Sun, 01 Dec 2013 23:37:35 -0800 (PST)
In-Reply-To: <20131202064121.GD21404@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>

Hi Dmitry,

Thanks for your review.

2013/12/2 Dmitry Torokhov <dmitry.torokhov@gmail.com>:

>> +     /* Ignore stick point data */
>> +     if (packet[0] == 0xD8)
>> +             return;

> Why are we ignoring trackstick data? If there Dolphin models with
> tracksticks that would basically "break" the device for users compared
> withe the emulated Explorer PS/2 mode.

I'm sorry, I think I used the wrong comment here...
Use comment /* Check if it's an valid touchpad packet */ would be better

>From the V5's spec, "0xC8" is the checkmask for 6byte Raw mode and
0x10 is the mask for trackpoint's / touchpad's packet.
So, 0xC8 means current packet is from touchpad and 0xD8 for trackpoint.
In current source code, what I wanted to do is just add a protection
logic to double check if it's a valid touchpad packet.

About your concern, I think there would be no problem because:
1) In initialization, we did not initialize trackpoint device as Raw
mode and it should always report 3Byte-packet. And in the first of
    alps_process_byte(), 3byte packet would be processed separately.
2) I checked with my Japanese colleague and in fact, there is no V5
device with trackpoint + touchpad in the world, although V5's spec
   designed the case of trackpoint's packet.

Thanks
-- 
Best Regards,
Tommy
