From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: Unusual Focaltech driver behavior
Date: Fri, 17 Apr 2015 17:56:50 +0300
Message-ID: <55311F32.90300@gmail.com>
References: <5530C7D2.8090106@gmail.com>	<5530D8DE.7070604@gmail.com>	<CAN+gG=G-uTfBNOjcQuFrRKcywwsb1HLtXg=TFnv0gPXaTuPc2A@mail.gmail.com>	<55310D09.8010001@gmail.com> <CAN+gG=HGgdoBy1ugoawU2t6rkW1jq=HsBsWiq9T34d=fYvwaEg@mail.gmail.com> <55311D85.2030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34063 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbbDQO4x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2015 10:56:53 -0400
Received: by laat2 with SMTP id t2so82380549laa.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2015 07:56:51 -0700 (PDT)
In-Reply-To: <55311D85.2030706@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Mathias Gottschlag <mgottschlag@gmail.com>



17.04.2015 17:49, Dmitry Tunin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> 17.04.2015 16:57, Benjamin Tissoires =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On Fri, Apr 17, 2015 at 9:39 AM, Dmitry Tunin <hanipouspilot@gmail.c=
om> wrote:
>>>> Hi Dmitry,
>>>>
>>>> On Fri, Apr 17, 2015 at 5:56 AM, Dmitry Tunin <hanipouspilot@gmail=
=2Ecom> wrote:
>>>>>> I noticed that myself and got some complaints like this.
>>>>>> https://github.com/hanipouspilot/ubuntu-fixes/issues/2
>>>>>>
>>>>>> General issue is that when one finger is on the touchpad, moveme=
nt of a second finger is ignored, if the first finger does not move.
>>>>>> Usually with other touchpads, when you have one finger on the to=
uchpad and move the other, it is recognized as two-finger scrolling.
>>>>>> The device itself sends relative packages as normal in that case=
, but linux driver ignores them, until first finger is moved.
>>>>>>
>>>>>> I guess, Windows driver behaves same way. I can't test it, since=
 I do not have Windows installed on that laptop.
>>>>>>
>>>>>> As I understood, Windows driver ignores that one finger is on bu=
tton area and recognizes movement of the other as one-finger movement.
>>>>>>
>>>>>> It is clear that we do not know the full protocol or parameters =
of all touchpad models to have that button area always correct.
>>>>>> But it looks like button area is set when 3rd byte in abs packag=
e is 00. There is a good chance that it is common for all touchpad mode=
ls.
>>>>>>
>>>>>> Do you have ideas how to fix it the easiest way?
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Dmitry
>>>>>>
>>>>>
>>>>> I looked at it some more and noticed that if I put one finger on =
touchpad, then another, then move the second one, rel packets are ignor=
ed.
>>>>> But if keeping both fingers on touchpad, I move the first one, re=
l packets work OK.
>>>>> This is wrong. I can't get what's wrong with the code at the mome=
nt.
>>>>
>>>>
>>>> It looks like your touchpad is in the mouse emulation mode, not th=
e
>>>> raw touch mode. What you get is fed by the touchpad FW ans there i=
s
>>>> nothing we can do in userspace to fix that.
>>>> That being said, there has been a lot of work with the focaltech
>>>> drivers in the previous kernel releases, and maybe trying a v4.0 w=
ill
>>>> switch your touchpad in the raw mode.
>>>> Once it is in raw mode, the software buttons, scrolling and gestur=
es
>>>> are all treated in userspace and you will get the expected behavio=
r.
>>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>
>>> No, the mouse is in proprietary mode. Multitouch is supported. In e=
mulation mode it is not supported at all.
>>> I am testing actually the driver from kernel 4.0. Everything works =
great except this strange problem, when some relative packets are ignor=
ed.
>>> I mentioned above the test case. Now I added some debug and trying =
to figure it out. But no success so far.
>>>
>>>
>>
>> If you are in absolute (raw) mode, then can you share the evemu-reco=
rd
>> of the gesture you are trying to support?
>> We should be able to see what is going on and be able to pinpoint if
>> this is a kernel problem or a user space problem.
>>
>> Cheers,
>> Benjamin
>>
>=20
> Here is the record. I put one finger on the touchpad and moved the ot=
her from top to bottom. This gesture is ignored.
> But if I move first finger or both, it is recognized as scrolling
>=20
> # EVEMU 1.2
> # Input device name: "PS/2 FocalTech FocalTech Touchpad"
> # Input device ID: bus 0x11 vendor 0x02 product 0x01 version 0000
> # Supported events:
> #   Event type 0 (EV_SYN)
> #     Event code 0 (SYN_REPORT)
> #     Event code 1 (SYN_CONFIG)
> #     Event code 3 (SYN_MAX)
> #   Event type 1 (EV_KEY)
> #     Event code 272 (BTN_LEFT)
> #     Event code 325 (BTN_TOOL_FINGER)
> #     Event code 328 (BTN_TOOL_QUINTTAP)
> #     Event code 330 (BTN_TOUCH)
> #     Event code 333 (BTN_TOOL_DOUBLETAP)
> #     Event code 334 (BTN_TOOL_TRIPLETAP)
> #     Event code 335 (BTN_TOOL_QUADTAP)
> #   Event type 3 (EV_ABS)
> #     Event code 0 (ABS_X)
> #       Value   1051
> #       Min        0
> #       Max     2944
> #       Fuzz       0
> #       Flat       0
> #       Resolution 0
> #     Event code 1 (ABS_Y)
> #       Value    920
> #       Min        0
> #       Max     1664
> #       Fuzz       0
> #       Flat       0
> #       Resolution 0
> #     Event code 47 (ABS_MT_SLOT)
> #       Value      0
> #       Min        0
> #       Max        4
> #       Fuzz       0
> #       Flat       0
> #       Resolution 0
> #     Event code 53 (ABS_MT_POSITION_X)
> #       Value      0
> #       Min        0
> #       Max     2944
> #       Fuzz       0
> #       Flat       0
> #       Resolution 0
> #     Event code 54 (ABS_MT_POSITION_Y)
> #       Value      0
> #       Min        0
> #       Max     1664
> #       Fuzz       0
> #       Flat       0
> #       Resolution 0
> #     Event code 57 (ABS_MT_TRACKING_ID)
> #       Value      0
> #       Min        0
> #       Max    65535
> #       Fuzz       0
> #       Flat       0
> #       Resolution 0
> # Properties:
> #   Property  type 0 (INPUT_PROP_POINTER)
> #   Property  type 2 (INPUT_PROP_BUTTONPAD)
> N: PS/2 FocalTech FocalTech Touchpad
> I: 0011 0002 0001 0000
> P: 05 00 00 00 00 00 00 00
> B: 00 0b 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 01 00 00 00 00 00
> B: 01 20 e5 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 01 00 00 00 00 00 00 00 00
> B: 02 00 00 00 00 00 00 00 00
> B: 03 03 00 00 00 00 80 60 02
> B: 04 00 00 00 00 00 00 00 00
> B: 05 00 00 00 00 00 00 00 00
> B: 11 00 00 00 00 00 00 00 00
> B: 12 00 00 00 00 00 00 00 00
> B: 15 00 00 00 00 00 00 00 00
> B: 15 00 00 00 00 00 00 00 00
> A: 00 0 2944 0 0 0
> A: 01 0 1664 0 0 0
> A: 2f 0 4 0 0 0
> A: 35 0 2944 0 0 0
> A: 36 0 1664 0 0 0
> A: 39 0 65535 0 0 0
> ################################
> #      Waiting for events      #
> ################################
> E: 0.000000 0003 0039 0279	# EV_ABS / ABS_MT_TRACKING_ID   279
> E: 0.000000 0003 0035 0750	# EV_ABS / ABS_MT_POSITION_X    750
> E: 0.000000 0003 0036 0680	# EV_ABS / ABS_MT_POSITION_Y    680
> E: 0.000000 0001 014a 0001	# EV_KEY / BTN_TOUCH            1
> E: 0.000000 0001 0145 0001	# EV_KEY / BTN_TOOL_FINGER      1
> E: 0.000000 0003 0000 0750	# EV_ABS / ABS_X                750
> E: 0.000000 0003 0001 0680	# EV_ABS / ABS_Y                680
> E: 0.000000 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 0.160846 0003 0036 0678	# EV_ABS / ABS_MT_POSITION_Y    678
> E: 0.160846 0003 0001 0678	# EV_ABS / ABS_Y                678
> E: 0.160846 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 0.853482 0003 002f 0001	# EV_ABS / ABS_MT_SLOT          1
> E: 0.853482 0003 0039 0280	# EV_ABS / ABS_MT_TRACKING_ID   280
> E: 0.853482 0003 0035 2238	# EV_ABS / ABS_MT_POSITION_X    2238
> E: 0.853482 0003 0036 0046	# EV_ABS / ABS_MT_POSITION_Y    46
> E: 0.853482 0001 0145 0000	# EV_KEY / BTN_TOOL_FINGER      0
> E: 0.853482 0001 014d 0001	# EV_KEY / BTN_TOOL_DOUBLETAP   1
> E: 0.853482 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.053646 0003 0035 2237	# EV_ABS / ABS_MT_POSITION_X    2237
> E: 1.053646 0003 0036 0049	# EV_ABS / ABS_MT_POSITION_Y    49
> E: 1.053646 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.069850 0003 0036 0053	# EV_ABS / ABS_MT_POSITION_Y    53
> E: 1.069850 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.086012 0003 0035 2240	# EV_ABS / ABS_MT_POSITION_X    2240
> E: 1.086012 0003 0036 0068	# EV_ABS / ABS_MT_POSITION_Y    68
> E: 1.086012 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.102159 0003 0035 2242	# EV_ABS / ABS_MT_POSITION_X    2242
> E: 1.102159 0003 0036 0092	# EV_ABS / ABS_MT_POSITION_Y    92
> E: 1.102159 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.118366 0003 0036 0108	# EV_ABS / ABS_MT_POSITION_Y    108
> E: 1.118366 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.134448 0003 0036 0135	# EV_ABS / ABS_MT_POSITION_Y    135
> E: 1.134448 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.150600 0003 0035 2240	# EV_ABS / ABS_MT_POSITION_X    2240
> E: 1.150600 0003 0036 0200	# EV_ABS / ABS_MT_POSITION_Y    200
> E: 1.150600 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.166755 0003 0035 2236	# EV_ABS / ABS_MT_POSITION_X    2236
> E: 1.166755 0003 0036 0236	# EV_ABS / ABS_MT_POSITION_Y    236
> E: 1.166755 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.182997 0003 0035 2234	# EV_ABS / ABS_MT_POSITION_X    2234
> E: 1.182997 0003 0036 0278	# EV_ABS / ABS_MT_POSITION_Y    278
> E: 1.182997 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.203908 0003 0035 2230	# EV_ABS / ABS_MT_POSITION_X    2230
> E: 1.203908 0003 0036 0326	# EV_ABS / ABS_MT_POSITION_Y    326
> E: 1.203908 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.220070 0003 0035 2228	# EV_ABS / ABS_MT_POSITION_X    2228
> E: 1.220070 0003 0036 0382	# EV_ABS / ABS_MT_POSITION_Y    382
> E: 1.220070 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.236227 0003 0036 0410	# EV_ABS / ABS_MT_POSITION_Y    410
> E: 1.236227 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.252415 0003 0036 0459	# EV_ABS / ABS_MT_POSITION_Y    459
> E: 1.252415 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.268505 0003 0035 2226	# EV_ABS / ABS_MT_POSITION_X    2226
> E: 1.268505 0003 0036 0584	# EV_ABS / ABS_MT_POSITION_Y    584
> E: 1.268505 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.285702 0003 0035 2224	# EV_ABS / ABS_MT_POSITION_X    2224
> E: 1.285702 0003 0036 0666	# EV_ABS / ABS_MT_POSITION_Y    666
> E: 1.285702 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.304459 0003 0035 2222	# EV_ABS / ABS_MT_POSITION_X    2222
> E: 1.304459 0003 0036 0738	# EV_ABS / ABS_MT_POSITION_Y    738
> E: 1.304459 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.322557 0003 002f 0000	# EV_ABS / ABS_MT_SLOT          0
> E: 1.322557 0003 0035 0751	# EV_ABS / ABS_MT_POSITION_X    751
> E: 1.322557 0003 0036 0676	# EV_ABS / ABS_MT_POSITION_Y    676
> E: 1.322557 0003 002f 0001	# EV_ABS / ABS_MT_SLOT          1
> E: 1.322557 0003 0035 2220	# EV_ABS / ABS_MT_POSITION_X    2220
> E: 1.322557 0003 0036 0804	# EV_ABS / ABS_MT_POSITION_Y    804
> E: 1.322557 0003 0000 0751	# EV_ABS / ABS_X                751
> E: 1.322557 0003 0001 0676	# EV_ABS / ABS_Y                676
> E: 1.322557 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.339614 0003 0036 0835	# EV_ABS / ABS_MT_POSITION_Y    835
> E: 1.339614 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.356413 0003 0035 2218	# EV_ABS / ABS_MT_POSITION_X    2218
> E: 1.356413 0003 0036 0940	# EV_ABS / ABS_MT_POSITION_Y    940
> E: 1.356413 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.374034 0003 002f 0000	# EV_ABS / ABS_MT_SLOT          0
> E: 1.374034 0003 0036 0674	# EV_ABS / ABS_MT_POSITION_Y    674
> E: 1.374034 0003 002f 0001	# EV_ABS / ABS_MT_SLOT          1
> E: 1.374034 0003 0036 0979	# EV_ABS / ABS_MT_POSITION_Y    979
> E: 1.374034 0003 0001 0674	# EV_ABS / ABS_Y                674
> E: 1.374034 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.391422 0003 0035 2214	# EV_ABS / ABS_MT_POSITION_X    2214
> E: 1.391422 0003 0036 1098	# EV_ABS / ABS_MT_POSITION_Y    1098
> E: 1.391422 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.408860 0003 0035 2210	# EV_ABS / ABS_MT_POSITION_X    2210
> E: 1.408860 0003 0036 1168	# EV_ABS / ABS_MT_POSITION_Y    1168
> E: 1.408860 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.425074 0003 0035 2206	# EV_ABS / ABS_MT_POSITION_X    2206
> E: 1.425074 0003 0036 1238	# EV_ABS / ABS_MT_POSITION_Y    1238
> E: 1.425074 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.441161 0003 0035 2204	# EV_ABS / ABS_MT_POSITION_X    2204
> E: 1.441161 0003 0036 1312	# EV_ABS / ABS_MT_POSITION_Y    1312
> E: 1.441161 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.457252 0003 0035 2200	# EV_ABS / ABS_MT_POSITION_X    2200
> E: 1.457252 0003 0036 1384	# EV_ABS / ABS_MT_POSITION_Y    1384
> E: 1.457252 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.473426 0003 0035 2198	# EV_ABS / ABS_MT_POSITION_X    2198
> E: 1.473426 0003 0036 1450	# EV_ABS / ABS_MT_POSITION_Y    1450
> E: 1.473426 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.489499 0003 0036 1484	# EV_ABS / ABS_MT_POSITION_Y    1484
> E: 1.489499 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.505633 0003 0036 1532	# EV_ABS / ABS_MT_POSITION_Y    1532
> E: 1.505633 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.521753 0003 0036 1580	# EV_ABS / ABS_MT_POSITION_Y    1580
> E: 1.521753 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 1.537900 0003 0039 -001	# EV_ABS / ABS_MT_TRACKING_ID   -1
> E: 1.537900 0001 0145 0001	# EV_KEY / BTN_TOOL_FINGER      1
> E: 1.537900 0001 014d 0000	# EV_KEY / BTN_TOOL_DOUBLETAP   0
> E: 1.537900 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
> E: 2.342684 0003 002f 0000	# EV_ABS / ABS_MT_SLOT          0
> E: 2.342684 0003 0039 -001	# EV_ABS / ABS_MT_TRACKING_ID   -1
> E: 2.342684 0001 014a 0000	# EV_KEY / BTN_TOUCH            0
> E: 2.342684 0001 0145 0000	# EV_KEY / BTN_TOOL_FINGER      0
> E: 2.342684 0000 0000 0000	# ------------ SYN_REPORT (0) ----------
>=20

In addition. I grab packages through serio_raw and see that in both cas=
es packages are sent normally form the device.
This must be something with state->finger[i].active or valid. But I add=
ed debug to the code and can't catch any problem there either.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
