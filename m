From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 11:09:41 +0800
Message-ID: <CAGS+omDgpsdDcpM3rVNJDo9CRBpqoeZZqug8RRBjyBjTpnKb2A@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <CAGS+omDm8RXPLXOnajrJ1hJPS5=mpzaLBybNYY92DMk1j=wByQ@mail.gmail.com>
 <4E4C813A.5010900@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:43156 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab1HRDKE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:10:04 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p7I3A4If001031
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 20:10:04 -0700
Received: from qwe5 (qwe5.prod.google.com [10.241.194.5])
	by wpaz21.hot.corp.google.com with ESMTP id p7I3A2Fo028747
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 20:10:03 -0700
Received: by qwe5 with SMTP id 5so1294554qwe.23
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 20:10:02 -0700 (PDT)
In-Reply-To: <4E4C813A.5010900@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 11:04 AM, Wanlong Gao <gaowanlong@cn.fujitsu.co=
m> wrote:
> On 08/18/2011 10:57 AM, Daniel Kurtz wrote:
>>
>> On Thu, Aug 18, 2011 at 9:57 AM, JJ Ding<jj_ding@emc.com.tw> =A0wrot=
e:
>>>
>>> v3 hardware's packet format is almost identical to v2 (one/three fi=
nger
>>> touch),
>>> except when sensing two finger touch, the hardware sends 12 bytes o=
f
>>> data.
>>>
>>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>>> ---
>>> =A0Documentation/input/elantech.txt | =A0104 ++++++++++++++++--
>>> =A0drivers/input/mouse/elantech.c =A0 | =A0218
>>> ++++++++++++++++++++++++++++++++++---
>>> =A0drivers/input/mouse/elantech.h =A0 | =A0 11 ++
>>> =A03 files changed, 303 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/Documentation/input/elantech.txt
>>> b/Documentation/input/elantech.txt
>>> index bce9941..ce578bd 100644
>>> --- a/Documentation/input/elantech.txt
>>> +++ b/Documentation/input/elantech.txt
>>> @@ -16,15 +16,22 @@ Contents
>>>
>>> =A01. Introduction
>>> =A02. Extra knobs
>>> - 3. Hardware version 1
>>> - =A0 =A03.1 Registers
>>> - =A0 =A03.2 Native relative mode 4 byte packet format
>>> - =A0 =A03.3 Native absolute mode 4 byte packet format
>>> - 4. Hardware version 2
>>> + 3. Differentiating hardware versions
>>> + 4. Hardware version 1
>>> =A0 =A0 4.1 Registers
>>> - =A0 =A04.2 Native absolute mode 6 byte packet format
>>> - =A0 =A0 =A0 =A04.2.1 One finger touch
>>> - =A0 =A0 =A0 =A04.2.2 Two finger touch
>>> + =A0 =A04.2 Native relative mode 4 byte packet format
>>> + =A0 =A04.3 Native absolute mode 4 byte packet format
>>> + 5. Hardware version 2
>>> + =A0 =A05.1 Registers
>>> + =A0 =A05.2 Native absolute mode 6 byte packet format
>>> + =A0 =A0 =A0 =A05.2.1 Parity checking and packet re-synchronizatio=
n
>>> + =A0 =A0 =A0 =A05.2.2 One/Three finger touch
>>> + =A0 =A0 =A0 =A05.2.3 Two finger touch
>>> + 6. Hardware version 3
>>> + =A0 =A06.1 Registers
>>> + =A0 =A06.2 Native absolute mode 6 byte packet format
>>> + =A0 =A0 =A0 =A06.2.1 One/Three finger touch
>>> + =A0 =A0 =A0 =A06.2.2 Two finger touch
>>>
>>>
>>>
>>> @@ -375,7 +382,7 @@ For all the other ones, there are just a few co=
nstant
>>> bits:
>>>
>>> =A0In case an error is detected, all the packets are shifted by one=
 (and
>>> packet[0] is discarded).
>>>
>>> -5.2.1 One/Three finger touch
>>> +5.2.2 One/Three finger touch
>>> =A0 =A0 =A0 ~~~~~~~~~~~~~~~~
>>>
>>> =A0byte 0:
>>> @@ -384,7 +391,7 @@ byte 0:
>>> =A0 =A0 =A0 =A0 n1 =A0n0 =A0w3 =A0w2 =A0 . =A0 . =A0 R =A0 L
>>>
>>> =A0 =A0 =A0 =A0 =A0L, R =3D 1 when Left, Right mouse button pressed
>>> - =A0 =A0 =A0 =A0 n1..n0 =3D numbers of fingers on touchpad
>>> + =A0 =A0 =A0 =A0 n1..n0 =3D number of fingers on touchpad
>>>
>>> =A0byte 1:
>>>
>>> @@ -432,7 +439,7 @@ byte 5:
>>> =A0 =A0 =A0 =A0 =A0y11..y0 =3D absolute y value (vertical)
>>>
>>>
>>> -4.2.2 Two finger touch
>>> +5.2.3 Two finger touch
>>> =A0 =A0 =A0 ~~~~~~~~~~~~~~~~
>>>
>>> =A0Note that the two pairs of coordinates are not exactly the coord=
inates
>>> of the
>>> @@ -446,7 +453,7 @@ byte 0:
>>> =A0 =A0 =A0 =A0 n1 =A0n0 =A0ay8 ax8 =A0. =A0 . =A0 R =A0 L
>>>
>>> =A0 =A0 =A0 =A0 =A0L, R =3D 1 when Left, Right mouse button pressed
>>> - =A0 =A0 =A0 =A0 n1..n0 =3D numbers of fingers on touchpad
>>> + =A0 =A0 =A0 =A0 n1..n0 =3D number of fingers on touchpad
>>>
>>> =A0byte 1:
>>>
>>> @@ -480,3 +487,76 @@ byte 5:
>>> =A0 =A0 =A0 =A0 by7 by8 by5 by4 by3 by2 by1 by0
>>>
>>> =A0 =A0 =A0 =A0 =A0by8..by0 =3D upper-right finger absolute y value
>>> +
>>>
>>> +//////////////////////////////////////////////////////////////////=
///////////
>>> +
>>> +6. Hardware version 3
>>> + =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +6.1 Registers
>>> + =A0 =A0~~~~~~~~~
>>> +* reg_10
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0 0 =A0 0 =A0 0 =A0 0 =A0 0 =A0 0 =A0 0 =A0 A
>>> +
>>> + =A0 =A0 =A0 =A0 A: 1 =3D enable absolute tracking
>>> +
>>> +6.2 Native absolute mode 6 byte packet format
>>> + =A0 =A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +1 and 3 finger touch shares the same 6-byte packet format, except =
that
>>> +3 finger touch only reports the position of the center of all thre=
e
>>> fingers.
>>> +
>>> +Firmware would send 12 bytes of data for 2 finger touch.
>>> +
>>> +6.2.1 One/Three finger touch
>>> + =A0 =A0 =A0~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +byte 0:
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0n1 =A0n0 =A0w3 =A0w2 =A0 0 =A0 1 =A0 R =A0 L
>>> +
>>> + =A0 =A0 =A0 =A0L, R =3D 1 when Left, Right mouse button pressed
>>> + =A0 =A0 =A0 =A0n1..n0 =3D number of fingers on touchpad
>>> +
>>> +byte 1:
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0p7 =A0p6 =A0p5 =A0p4 x11 x10 =A0x9 =A0x8
>>> +
>>> +byte 2:
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0x7 =A0x6 =A0x5 =A0x4 =A0x3 =A0x2 =A0x1 =A0x0
>>> +
>>> + =A0 =A0 =A0 =A0x11..x0 =3D absolute x value (horizontal)
>>> +
>>> +byte 3:
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0 0 =A0 0 =A0w1 =A0w0 =A0 0 =A0 0 =A0 1 =A0 0
>>> +
>>> + =A0 =A0 =A0 =A0 w3..w0 =3D width of the finger touch
>>> +
>>> +byte 4:
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0p3 =A0p1 =A0p2 =A0p0 =A0y11 y10 y9 =A0y8
>>> +
>>> + =A0 =A0 =A0 =A0p7..p0 =3D pressure
>>> +
>>> +byte 5:
>>> +
>>> + =A0 bit =A0 7 =A0 6 =A0 5 =A0 4 =A0 3 =A0 2 =A0 1 =A0 0
>>> + =A0 =A0 =A0 =A0y7 =A0y6 =A0y5 =A0y4 =A0y3 =A0y2 =A0y1 =A0y0
>>> +
>>> + =A0 =A0 =A0 =A0y11..y0 =3D absolute y value (vertical)
>>> +
>>> +6.2.2 Two finger touch
>>> + =A0 =A0 =A0~~~~~~~~~~~~~~~~
>>> +
>>> +The packet format is exactly the same for two finger touch, except=
 the
>>> hardware
>>> +sends two 6 byte packets. The first packet contains data for the f=
irst
>>> finger,
>>> +the second packet has data for the second finger. So for two finge=
r
>>> touch a
>>> +total of 12 bytes are sent.
>>> diff --git a/drivers/input/mouse/elantech.c
>>> b/drivers/input/mouse/elantech.c
>>> index ddd40eb..e13a719 100644
>>> --- a/drivers/input/mouse/elantech.c
>>> +++ b/drivers/input/mouse/elantech.c
>>> @@ -108,6 +108,16 @@ static int elantech_read_reg(struct psmouse
>>> *psmouse, unsigned char reg,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> +
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (elantech_ps2_command(psmouse, NUL=
L,
>>> ETP_PS2_CUSTOM_COMMAND) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL,
>>> ETP_REGISTER_READWRITE) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL,
>>> ETP_PS2_CUSTOM_COMMAND) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL, reg) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 param,
>>> PSMOUSE_CMD_GETINFO)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0if (rc)
>>> @@ -154,6 +164,18 @@ static int elantech_write_reg(struct psmouse
>>> *psmouse, unsigned char reg,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> +
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (elantech_ps2_command(psmouse, NUL=
L,
>>> ETP_PS2_CUSTOM_COMMAND) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL,
>>> ETP_REGISTER_READWRITE) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL,
>>> ETP_PS2_CUSTOM_COMMAND) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL, reg) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL,
>>> ETP_PS2_CUSTOM_COMMAND) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL, val) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_ps2_command(psmouse,=
 NULL,
>>> PSMOUSE_CMD_SETSCALE11)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0if (rc)
>>> @@ -352,6 +374,94 @@ static void elantech_report_absolute_v2(struct
>>> psmouse *psmouse)
>>> =A0 =A0 =A0 =A0input_sync(dev);
>>> =A0}
>>>
>>> +/*
>>> + * firmware tells us there's noise.
>>> + */
>>> +static inline int debounce(unsigned int x, unsigned int y)
>>> +{
>>> + =A0 =A0 =A0 return (x =3D=3D 0xfff)&& =A0(y =3D=3D 0xfff);
>>
>> Perhaps you could document this behavior in the elantech.txt.
>>
>>> +}
>>> +
>>> +/*
>>> + * Interpret complete data packets and report absolute mode input =
events
>>> for
>>> + * hardware version 3. (12 byte packets for two fingers)
>>> + */
>>> +static void elantech_report_absolute_v3(struct psmouse *psmouse,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int packet_type)
>>> +{
>>> + =A0 =A0 =A0 struct input_dev *dev =3D psmouse->dev;
>>> + =A0 =A0 =A0 struct elantech_data *etd =3D psmouse->private;
>>> + =A0 =A0 =A0 unsigned char *packet =3D psmouse->packet;
>>> + =A0 =A0 =A0 unsigned int fingers =3D 0, x1 =3D 0, y1 =3D 0, x2 =3D=
 0, y2 =3D 0;
>>> + =A0 =A0 =A0 unsigned int width =3D 0, pres =3D 0;
>>> +
>>> + =A0 =A0 =A0 /* byte 0: n1 =A0n0 =A0 . =A0 . =A0 . =A0 . =A0 R =A0=
 L */
>>> + =A0 =A0 =A0 fingers =3D (packet[0]& =A00xc0)>> =A06;
>>> +
>>> + =A0 =A0 =A0 switch (fingers) {
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 case 1:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 1: =A0. =A0 . =A0 . =A0 . =A0=
x11 x10 x9 =A0x8
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 2: x7 =A0x6 =A0x5 =A0x4 =A0=
x4 =A0x2 =A0x1 =A0x0
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x1 =3D ((packet[1]& =A00x0f)<< =A08) =
| packet[2];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 4: =A0. =A0 . =A0 . =A0 . =A0=
y11 y10 y9 =A0y8
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 5: y7 =A0y6 =A0y5 =A0y4 =A0=
y3 =A0y2 =A0y1 =A0y0
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y1 =3D etd->y_max - (((packet[4]& =A0=
0x0f)<< =A08) |
>>> packet[5]);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fingers =3D=3D 3&& =A0debounce(x1=
, y1))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> +
>>> + =A0 =A0 =A0 case 2:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (packet_type =3D=3D PACKET_V3_HEAD=
) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 1: =A0 . =A0=
 =A0. =A0 =A0. =A0 =A0. =A0ax11 ax10 ax9 =A0ax8
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 2: ax7 =A0a=
x6 =A0ax5 =A0ax4 =A0ax3 =A0ax2 =A0ax1 =A0ax0
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->prev_x =3D ((pac=
ket[1]& =A00x0f)<< =A08) |
>>> packet[2];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 4: =A0 . =A0=
 =A0. =A0 =A0. =A0 =A0. =A0ay11 ay10 ay9 =A0ay8
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* byte 5: ay7 =A0a=
y6 =A0ay5 =A0ay4 =A0ay3 =A0ay2 =A0ay1 =A0ay0
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->prev_y =3D etd->=
y_max -
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((pa=
cket[4]& =A00x0f)<< =A08) | packet[5]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wait for next pa=
cket
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* packet_type =3D=3D PACKET_V3_TAIL =
*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x1 =3D etd->prev_x;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y1 =3D etd->prev_y;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x2 =3D ((packet[1]& =A00x0f)<< =A08) =
| packet[2];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y2 =3D etd->y_max - (((packet[4]& =A0=
0x0f)<< =A08) |
>>> packet[5]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 pres =3D (packet[1]& =A00xf0) | ((packet[4]& =A00xf0)=
>> =A04);
>>> + =A0 =A0 =A0 width =3D ((packet[0]& =A00x30)>> =A02) | ((packet[3]=
& =A00x30)>> =A04);
>>> +
>>> + =A0 =A0 =A0 input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>>> + =A0 =A0 =A0 input_report_abs(dev, ABS_X, x1);
>>> + =A0 =A0 =A0 input_report_abs(dev, ABS_Y, y1);
>>> + =A0 =A0 =A0 elantech_report_semi_mt_data(dev, fingers, x1, y1, x2=
, y2);
>>> + =A0 =A0 =A0 input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D=
 1);
>>> + =A0 =A0 =A0 input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=
=3D 2);
>>> + =A0 =A0 =A0 input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=
=3D 3);
>>> + =A0 =A0 =A0 input_report_key(dev, BTN_LEFT, packet[0]& =A00x01);
>>> + =A0 =A0 =A0 input_report_key(dev, BTN_RIGHT, packet[0]& =A00x02);
>>> + =A0 =A0 =A0 input_report_abs(dev, ABS_PRESSURE, pres);
>>> + =A0 =A0 =A0 input_report_abs(dev, ABS_TOOL_WIDTH, width);
>>> +
>>> + =A0 =A0 =A0 input_sync(dev);
>>> +}
>>> +
>>> =A0static int elantech_check_parity_v1(struct psmouse *psmouse)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct elantech_data *etd =3D psmouse->private;
>>> @@ -396,11 +506,31 @@ static int packet_simple_check_v2(struct psmo=
use
>>> *psmouse)
>>> =A0}
>>>
>>> =A0/*
>>> + * We check the constant bits to determine what packet type we get=
,
>>> + * so packet checking is mandatory for v3 hardware.
>>> + */
>>> +static int determine_packet_v3(struct psmouse *psmouse)
>>> +{
>>> + =A0 =A0 =A0 unsigned char *packet =3D psmouse->packet;
>>> +
>>> + =A0 =A0 =A0 if ((packet[0]& =A00x0c) =3D=3D 0x04&&
>>> + =A0 =A0 =A0 =A0 =A0 (packet[3]& =A00xcf) =3D=3D 0x02)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PACKET_V3_HEAD;
>>> +
>>> + =A0 =A0 =A0 if ((packet[0]& =A00x0c) =3D=3D 0x0c&&
>>> + =A0 =A0 =A0 =A0 =A0 (packet[3]& =A00xce) =3D=3D 0x0c)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PACKET_V3_TAIL;
>>> +
>>> + =A0 =A0 =A0 return PACKET_UNKNOWN;
>>> +}
>>> +
>>> +/*
>>> =A0* Process byte stream from mouse and handle complete packets
>>> =A0*/
>>> =A0static psmouse_ret_t elantech_process_byte(struct psmouse *psmou=
se)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct elantech_data *etd =3D psmouse->private;
>>> + =A0 =A0 =A0 int packet_type;
>>>
>>> =A0 =A0 =A0 =A0if (psmouse->pktcnt< =A0psmouse->pktsize)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PSMOUSE_GOOD_DATA;
>>> @@ -422,6 +552,14 @@ static psmouse_ret_t elantech_process_byte(str=
uct
>>> psmouse *psmouse)
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elantech_report_absolute_v2(psmouse)=
;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> +
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_type =3D determine_packet_v3(p=
smouse);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (packet_type =3D=3D PACKET_UNKNOWN=
)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad_packet;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_report_absolute_v3(psmouse, =
packet_type);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0return PSMOUSE_FULL_PACKET;
>>> @@ -459,10 +597,17 @@ static int elantech_set_absolute_mode(struct
>>> psmouse *psmouse)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->reg_21 =3D 0x60; =A0 =A0 /* 0x0=
0 */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (elantech_write_reg(psmouse, 0x10=
, etd->reg_10) ||
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elantech_write_reg(psmouse, =
0x11, etd->reg_11) ||
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_write_reg(psmouse, 0=
x21, etd->reg_21)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_write_reg(psmouse, 0=
x21, etd->reg_21))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -1;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> +
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->reg_10 =3D 0x0b;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (elantech_write_reg(psmouse, 0x10,=
 etd->reg_10))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -1;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0if (rc =3D=3D 0) {
>>> @@ -496,11 +641,12 @@ static int elantech_set_absolute_mode(struct
>>> psmouse *psmouse)
>>> =A0 =A0 =A0 =A0return rc;
>>> =A0}
>>>
>>> -static void set_range(struct psmouse *psmouse, unsigned int *x_min=
,
>>> +static int set_range(struct psmouse *psmouse, unsigned int *x_min,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *y_min, unsign=
ed int *x_max,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *y_max, unsign=
ed int *y_2ft_max)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct elantech_data *etd =3D psmouse->private;
>>> + =A0 =A0 =A0 unsigned char param[3];
>>> =A0 =A0 =A0 =A0int i;
>>>
>>> =A0 =A0 =A0 =A0switch (etd->hw_version) {
>>> @@ -529,19 +675,30 @@ static void set_range(struct psmouse *psmouse=
,
>>> unsigned int *x_min,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*y_max =3D (etd->capabilities[2] - i=
) * 64;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*y_2ft_max =3D (*y_max - i) * 64 / 4=
;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> +
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (synaptics_send_cmd(psmouse, ETP_F=
W_ID_QUERY, param))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *x_max =3D (0x0f& =A0param[0])<< =A08=
 | param[1];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *y_max =3D (0xf0& =A0param[0])<< =A04=
 | param[2];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0}
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> =A0}
>>>
>>> =A0/*
>>> =A0* Set the appropriate event bits for the input subsystem
>>> =A0*/
>>> -static void elantech_set_input_params(struct psmouse *psmouse)
>>> +static int elantech_set_input_params(struct psmouse *psmouse)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct input_dev *dev =3D psmouse->dev;
>>> =A0 =A0 =A0 =A0struct elantech_data *etd =3D psmouse->private;
>>> =A0 =A0 =A0 =A0unsigned int x_min =3D 0, y_min =3D 0, x_max =3D 0, =
y_max =3D 0, y_2ft_max
>>> =3D 0;
>>>
>>> - =A0 =A0 =A0 set_range(psmouse,&x_min,&y_min,&x_max,&y_max,&y_2ft_=
max);
>>> + =A0 =A0 =A0 if (set_range(psmouse,&x_min,&y_min,&x_max,&y_max,&y_=
2ft_max))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>>
>>> =A0 =A0 =A0 =A0__set_bit(EV_KEY, dev->evbit);
>>> =A0 =A0 =A0 =A0__set_bit(EV_ABS, dev->evbit);
>>> @@ -582,10 +739,26 @@ static void elantech_set_input_params(struct
>>> psmouse *psmouse)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_MT_POS=
ITION_X, x_min, x_max,
>>> 0, 0);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_MT_POS=
ITION_Y, y_min, y_max,
>>> 0, 0);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> +
>>> + =A0 =A0 =A0 case 3:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_X, x_mi=
n, x_max, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_Y, y_mi=
n, y_max, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* range of pressure and width is the=
 same as v2 */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSUR=
E, ETP_PMIN_V2,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ETP_PMAX_V2, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_TOOL_WI=
DTH, ETP_WMIN_V2,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ETP_WMAX_V2, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_SEMI_MT, dev->pr=
opbit);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(dev, 2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_POSI=
TION_X, x_min,
>>> x_max, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_POSI=
TION_Y, y_min,
>>> y_max, 0, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0etd->y_max =3D y_max;
>>> =A0 =A0 =A0 =A0etd->y_2ft_max =3D y_2ft_max;
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> =A0}
>>>
>>> =A0struct elantech_attr_data {
>>> @@ -727,7 +900,8 @@ int elantech_detect(struct psmouse *psmouse, bo=
ol
>>> set_properties)
>>> =A0 =A0 =A0 =A0 * Report this in case there are Elantech models tha=
t use a
>>> different
>>> =A0 =A0 =A0 =A0 * set of magic numbers
>>> =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 if (param[0] !=3D 0x3c || param[1] !=3D 0x03 || param=
[2] !=3D 0xc8) {
>>> + =A0 =A0 =A0 if (param[0] !=3D 0x3c || param[1] !=3D 0x03 ||
>>> + =A0 =A0 =A0 =A0 =A0 (param[2] !=3D 0xc8&& =A0param[2] !=3D 0x00))=
 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("unexpected magic knock res=
ult 0x%02x, 0x%02x,
>>> 0x%02x.\n",
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 param[0], param[1],=
 param[2]);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>>> @@ -793,16 +967,16 @@ static int elantech_reconnect(struct psmouse
>>> *psmouse)
>>> =A0/*
>>> =A0* determine hardware version and set some properties according t=
o it.
>>> =A0*/
>>> -static void elantech_set_properties(struct elantech_data *etd)
>>> +static int elantech_set_properties(struct elantech_data *etd)
>>> =A0{
>>> - =A0 =A0 =A0 /*
>>> - =A0 =A0 =A0 =A0* Assume every version greater than 0x020030 is ne=
w EeePC style
>>> - =A0 =A0 =A0 =A0* hardware with 6 byte packets, except 0x020600
>>> - =A0 =A0 =A0 =A0*/
>>> =A0 =A0 =A0 =A0if (etd->fw_version< =A00x020030 || etd->fw_version =
=3D=3D 0x020600)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->hw_version =3D 1;
>>> - =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 else if (etd->fw_version< =A00x150600)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->hw_version =3D 2;
>>> + =A0 =A0 =A0 else if ((etd->fw_version& =A00x0f0000)>> =A016 =3D=3D=
 5)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->hw_version =3D 3;
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>>
>>> =A0 =A0 =A0 =A0/*
>>> =A0 =A0 =A0 =A0 * Turn on packet checking by default.
>>> @@ -817,13 +991,15 @@ static void elantech_set_properties(struct
>>> elantech_data *etd)
>>> =A0 =A0 =A0 =A0etd->jumpy_cursor =3D
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(etd->fw_version =3D=3D 0x020022 || =
etd->fw_version =3D=3D
>>> 0x020600);
>>>
>>> - =A0 =A0 =A0 if (etd->hw_version =3D=3D 2) {
>>> + =A0 =A0 =A0 if (etd->hw_version> =A01) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* For now show extra debug informat=
ion */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->debug =3D 1;
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (etd->fw_version>=3D 0x020800)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->reports_pressur=
e =3D true;
>>> =A0 =A0 =A0 =A0}
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> =A0}
>>>
>>> =A0/*
>>> @@ -850,9 +1026,12 @@ int elantech_init(struct psmouse *psmouse)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("failed to query firmware ver=
sion.\n");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
>>> =A0 =A0 =A0 =A0}
>>> -
>>> =A0 =A0 =A0 =A0etd->fw_version =3D (param[0]<< =A016) | (param[1]<<=
 =A08) | param[2];
>>> - =A0 =A0 =A0 elantech_set_properties(etd);
>>> +
>>> + =A0 =A0 =A0 if (elantech_set_properties(etd)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unknown hardware version, abo=
rting...\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_fail;
>>> + =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0pr_info("assuming hardware version %d "
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(with firmware version 0x%02x%02x%0=
2x)\n",
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->hw_version, param[0], param[1],=
 param[2]);
>>> @@ -871,7 +1050,10 @@ int elantech_init(struct psmouse *psmouse)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
>>> =A0 =A0 =A0 =A0}
>>>
>>> - =A0 =A0 =A0 elantech_set_input_params(psmouse);
>>> + =A0 =A0 =A0 if (elantech_set_input_params(psmouse)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to query touchpad rang=
e.\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_fail;
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0error =3D sysfs_create_group(&psmouse->ps2dev.serio-=
>dev.kobj,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &elantech_attr_group);
>>> @@ -883,7 +1065,7 @@ int elantech_init(struct psmouse *psmouse)
>>> =A0 =A0 =A0 =A0psmouse->protocol_handler =3D elantech_process_byte;
>>> =A0 =A0 =A0 =A0psmouse->disconnect =3D elantech_disconnect;
>>> =A0 =A0 =A0 =A0psmouse->reconnect =3D elantech_reconnect;
>>> - =A0 =A0 =A0 psmouse->pktsize =3D etd->hw_version =3D=3D 2 ? 6 : 4=
;
>>> + =A0 =A0 =A0 psmouse->pktsize =3D etd->hw_version> =A01 ? 6 : 4;
>>>
>>> =A0 =A0 =A0 =A0return 0;
>>>
>>> diff --git a/drivers/input/mouse/elantech.h
>>> b/drivers/input/mouse/elantech.h
>>> index 4b7447e..4f01fc6 100644
>>> --- a/drivers/input/mouse/elantech.h
>>> +++ b/drivers/input/mouse/elantech.h
>>> @@ -16,6 +16,7 @@
>>> =A0/*
>>> =A0* Command values for Synaptics style queries
>>> =A0*/
>>> +#define ETP_FW_ID_QUERY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x00
>>
>> One tab too many?
>
> No.

Yeah, weird patchwork diff'ing artifact....


>>
>>> =A0#define ETP_FW_VERSION_QUERY =A0 =A0 =A0 =A0 =A0 0x01
>>> =A0#define ETP_CAPABILITIES_QUERY =A0 =A0 =A0 =A0 0x02
>>>
>>> @@ -24,6 +25,7 @@
>>> =A0*/
>>> =A0#define ETP_REGISTER_READ =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
>>> =A0#define ETP_REGISTER_WRITE =A0 =A0 =A0 =A0 =A0 =A0 0x11
>>> +#define ETP_REGISTER_READWRITE =A0 =A0 =A0 =A0 0x00
>>>
>>> =A0/*
>>> =A0* Hardware version 2 custom PS/2 command value
>>> @@ -93,6 +95,13 @@
>>> =A0#define ETP_2FT_YMIN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( =A00 =
+ ETP_2FT_FUZZ)
>>> =A0#define ETP_2FT_YMAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (192 - =
ETP_2FT_FUZZ)
>>>
>>> +/*
>>> + * v3 hardware has 2 kinds of packet types.
>>> + */
>>> +#define PACKET_UNKNOWN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01
>>> +#define PACKET_V3_HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>>> +#define PACKET_V3_TAIL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03
>>> +
>>> =A0struct elantech_data {
>>> =A0 =A0 =A0 =A0unsigned char reg_10;
>>> =A0 =A0 =A0 =A0unsigned char reg_11;
>>> @@ -113,6 +122,8 @@ struct elantech_data {
>>> =A0 =A0 =A0 =A0unsigned int single_finger_reports;
>>> =A0 =A0 =A0 =A0unsigned int y_max;
>>> =A0 =A0 =A0 =A0unsigned int y_2ft_max;
>>> + =A0 =A0 =A0 unsigned int prev_x;
>>> + =A0 =A0 =A0 unsigned int prev_y;
>>> =A0 =A0 =A0 =A0unsigned char parity[256];
>>> =A0};
>>>
>>> --
>>> 1.7.4.1
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Thanks
> Wanlong Gao
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
