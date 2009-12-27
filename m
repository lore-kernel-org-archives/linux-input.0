From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics Multi touch capabilities
Date: Sun, 27 Dec 2009 15:13:26 -0800
Message-ID: <AB7DE919-8205-4759-8236-4DFE5FB83BAE@gmail.com>
References: <62e5edd40912230313r65593b0cmea9541ea7a246cfc@mail.gmail.com> <200912231032.32526.dmitry.torokhov@gmail.com> <62e5edd40912240254w19b0b6c6ye43e2805055bb0e5@mail.gmail.com> <20091225065642.GA19401@core.coreip.homeip.net> <62e5edd40912250354j55a1bbe0pcd151c106b6bdcdb@mail.gmail.com> <20091227101331.GE14655@core.coreip.homeip.net> <62e5edd40912270843y30cb74d0ida01bfa4b98b05cb@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53445 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZL0XNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2009 18:13:44 -0500
Received: by pzk1 with SMTP id 1so2545419pzk.33
        for <linux-input@vger.kernel.org>; Sun, 27 Dec 2009 15:13:43 -0800 (PST)
In-Reply-To: <62e5edd40912270843y30cb74d0ida01bfa4b98b05cb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?Erik_Andr=C3=A9n?= <erik.andren@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Dec 27, 2009, at 8:43 AM, Erik Andr=C3=A9n <erik.andren@gmail.com> w=
rote:

> 2009/12/27 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> On Fri, Dec 25, 2009 at 12:54:16PM +0100, Erik Andr=C3=A9n wrote:
>>> 2009/12/25 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>> On Thu, Dec 24, 2009 at 11:54:27AM +0100, Erik Andr=C3=A9n wrote:
>>>>> 2009/12/23 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>>>> On Wednesday 23 December 2009 03:13:04 am Erik Andr=C3=A9n wrote=
:
>>>>>>> Hi,
>>>>>>> I have a ASUS 1005HA netbook equipped with a Synaptics touch =20
>>>>>>> pad:
>>>>>>> [   18.341491] Synaptics Touchpad, model: 1, fw: 7.2, id: =20
>>>>>>> 0x1a0b1,
>>>>>>> caps: 0xd04731/0xa40000
>>>>>>>
>>>>>>> In Linux, no multitouch capabilities are detected (Zoom, two =20
>>>>>>> and three
>>>>>>> finger button presses etc.).
>>>>>>> This all works with the same hardware in windows 7.
>>>>>>> Is there a bug in the linux driver preventing multitouch to =20
>>>>>>> work?
>>>>>>>
>>>>>>
>>>>>> Linux Synaptics driver does not have full multitouch support =20
>>>>>> (yet?). The 2-
>>>>>> and 3- finger taps should work (provided that they are enabled =20
>>>>>> in SYnaptics X
>>>>>> driver) but there is no multiple finger tracking...
>>>>> They don't. I've tried with the 1.1.2 and 1.2.0 version of the =20
>>>>> xorg
>>>>> synaptics driver. But if this is the issue I guess I should take =
=20
>>>>> this
>>>>> inquiry to the proper xorg mailing list.
>>>>
>>>> Not yet, kernel needs to add support for this as well.
>>>>
>>>>>
>>>>>>
>>>>>> BTW, the capability 0xd04731 indicates that your hardware does =20
>>>>>> not report
>>>>>> multi-finger taps.
>>>>>>
>>>>> I'm aware of that, but why does pinch and zoom then work in =20
>>>>> windows 7?
>>>>> Is it possible to emulate this with a single touch touchpad?
>>>>>
>>>>
>>>> I think your touchpad is a fully multi-finger one, not just multi-=
=20
>>>> finger
>>>> tapping like older touchpads. Only multi-finger tapping is =20
>>>> currently
>>>> supported by Synaptcs X driver.
>>>>
>>> Could you elaborate on what a multi-finger touchpad is?
>>
>> Multi-finger touchpad (or touchscreen) is a device that can recogniz=
e
>> several objects touching the surface of the device and report =20
>> separate
>> sets of coordinates (and maybe more data) for every object.
>>
>>> The Synaptics PS/2 Touchpad Interface Guide, 3.2.6 states that two =
=20
>>> and
>>> three fingers are only detected when the capMultiFinger capability =
=20
>>> is
>>> detected which according to the driver isn't detected for this
>>> touchpad.
>>>
>>
>> Apparently this guide is a bit obsolete.
>>
>
> I've downloaded the document from the synaptics website and it has a
> 2009 copyright which means its fairly recent.

As witnessed by the presence of ClickPads that are not documented =20
there it is not complete.

> Are you sure there are any other documentation? If so, do you have an=
y
> access to it? Or is this some kind of proprietary interface?

>
No, I do not.

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
