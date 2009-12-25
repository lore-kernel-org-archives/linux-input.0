From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Subject: Re: Synaptics Multi touch capabilities
Date: Fri, 25 Dec 2009 12:54:16 +0100
Message-ID: <62e5edd40912250354j55a1bbe0pcd151c106b6bdcdb@mail.gmail.com>
References: <62e5edd40912230313r65593b0cmea9541ea7a246cfc@mail.gmail.com>
	 <200912231032.32526.dmitry.torokhov@gmail.com>
	 <62e5edd40912240254w19b0b6c6ye43e2805055bb0e5@mail.gmail.com>
	 <20091225065642.GA19401@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48851 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbZLYLyR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Dec 2009 06:54:17 -0500
Received: by fxm25 with SMTP id 25so3263625fxm.21
        for <linux-input@vger.kernel.org>; Fri, 25 Dec 2009 03:54:16 -0800 (PST)
In-Reply-To: <20091225065642.GA19401@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

2009/12/25 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Thu, Dec 24, 2009 at 11:54:27AM +0100, Erik Andr=E9n wrote:
>> 2009/12/23 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> > On Wednesday 23 December 2009 03:13:04 am Erik Andr=E9n wrote:
>> >> Hi,
>> >> I have a ASUS 1005HA netbook equipped with a Synaptics touch pad:
>> >> [ =A0 18.341491] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1a0=
b1,
>> >> caps: 0xd04731/0xa40000
>> >>
>> >> In Linux, no multitouch capabilities are detected (Zoom, two and =
three
>> >> finger button presses etc.).
>> >> This all works with the same hardware in windows 7.
>> >> Is there a bug in the linux driver preventing multitouch to work?
>> >>
>> >
>> > Linux Synaptics driver does not have full multitouch support (yet?=
). The 2-
>> > and 3- finger taps should work (provided that they are enabled in =
SYnaptics X
>> > driver) but there is no multiple finger tracking...
>> They don't. I've tried with the 1.1.2 and 1.2.0 version of the xorg
>> synaptics driver. But if this is the issue I guess I should take thi=
s
>> inquiry to the proper xorg mailing list.
>
> Not yet, kernel needs to add support for this as well.
>
>>
>> >
>> > BTW, the capability 0xd04731 indicates that your hardware does not=
 report
>> > multi-finger taps.
>> >
>> I'm aware of that, but why does pinch and zoom then work in windows =
7?
>> Is it possible to emulate this with a single touch touchpad?
>>
>
> I think your touchpad is a fully multi-finger one, not just multi-fin=
ger
> tapping like older touchpads. Only multi-finger tapping is currently
> supported by Synaptcs X driver.
>
Could you elaborate on what a multi-finger touchpad is?
The Synaptics PS/2 Touchpad Interface Guide, 3.2.6 states that two and
three fingers are only detected when the capMultiFinger capability is
detected which according to the driver isn't detected for this
touchpad.

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
