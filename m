From: Josep Pujadas-Jubany <jpujades@gmail.com>
Subject: Re: [Acer Travelmate B115-M] Synaptic touchpad
Date: Mon, 12 Oct 2015 21:27:32 +0200
Message-ID: <CAJ3dLCDZC6CZ=ZPyjMmB5=9No7PKNjefUxcPe_8PwdSrRmTH-A@mail.gmail.com>
References: <CAJ3dLCB2PDk--EsH785aDCquxPROLGbRGpz0qMCGgChcA9oRGA@mail.gmail.com>
 <CAN+gG=FovvQcDeOWusH2O=FzMwpz8Ld9Deww=-O-3+17UveVGQ@mail.gmail.com>
 <CAJ3dLCCfB7qCcMeRO6p1v5DT+hqj_cL3s4p8dKN_X6uznCCigQ@mail.gmail.com> <CAN+gG=FckT53cJE4DLSCqBLDZA2XTSF66vwSadzFfAbjtSuy+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11376c7480de770521ed54c5
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35099 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbbJLT2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 15:28:13 -0400
Received: by qgt47 with SMTP id 47so126947032qgt.2
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2015 12:28:12 -0700 (PDT)
In-Reply-To: <CAN+gG=FckT53cJE4DLSCqBLDZA2XTSF66vwSadzFfAbjtSuy+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>

--001a11376c7480de770521ed54c5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Benjamin,

Attached hid-recorder_output.txt

sudo ./src/hid-recorder /dev/hidraw* > hid-recorder_output.txt

I first unplugged the external USB mouse that I have. I launched
hid-recorder and I moved the TouchPad cursor.

I had to use sudo to avoid "Unable to open device: Permission denied" warni=
ng.

Regards,

Josep


2015-10-06 10:59 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gmail.com=
>:
> Hi Josep,
>
> On Tue, Oct 6, 2015 at 10:02 AM, Josep Pujadas-Jubany
> <jpujades@gmail.com> wrote:
>> Benjamin,
>>
>> I'm sorry. I just wanted to summarize the problem I reported at
>> bugs.launchpad.net
>
> No worries. I know exactly why everyone coming from ubuntu always
> sends such a mail, and this is what annoys me ;)
>
>>
>> I followed the instructions that Ubuntu Team said to me,
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1493814/comments/33
>>
>> The rest is only my ignorance about Linux Kernel. I'm sorry twice!
>
> no worries twice :)
>
>>
>> I will try to explain a new time the problem. I have no idea if it's
>> caused by the input module or not. Perhaps it is a problem of the i2c
>> module.
>>
>> The Synaptic Touchpad is detected as SYN1B7D:01 06CB:2991 UNKNOWN with
>> default BIOS settings (i2c mode activated).
>>
>> I tried this with the last version of the BIOS and latest kernel 64
>> bit available.
>>
>> When this occurs the Touchpad works just like a simple mouse.
>
> OK, so the good thing is that your i2c module is working properly
> otherwise we would not see your touchpad at all under HID.
>
> The fact that the touchpad stays in mouse emulation mode means that
> there is something fishy with the touchpad which prevents us to switch
> it to the multitouch mode. (adding Andrew in CC, he should be able to
> help us).
>
> Can you upload a dmesg with "i2c-hid.debug=3D1" appended to the command
> line? (in grub, type this without quotes at the end of the line
> containing the kernel boot parameters).
>
> Also, could you send us the output of hid-recorder [1]? (download the
> source, compile it and run "src/hid-recorder /dev/hidraw*"). This
> should help us understanding what is going on.
>
> Cheers,
> Benjamin
>
> [1] http://bentiss.github.io/hid-replay-docs/
>
>>
>> Thanks!
>>
>> Josep
>>
>>
>> 2015-10-05 11:09 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gmail.=
com>:
>>> Hi Josep,
>>>
>>> [please do not take my rant personally, I know it can be difficult to
>>> report a problem upstream]
>>>
>>> On Sun, Oct 4, 2015 at 7:26 PM, Josep Pujadas-Jubany <jpujades@gmail.co=
m> wrote:
>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1493814
>>>>
>>>> Touchpad has issues working
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>>
>>>> The mainline kernel does not fix the issue
>>>>
>>>> Latest BIOS (1.38)
>>>
>>> Oh boy. We are not robots. Please add some valuable information like
>>> what is the issue, and what you are seeing. We are humans and a little
>>> bit of phrasing does not hurt (I know the ubuntu howto tells you to
>>> consider us as robot, and I really am offended each time we receive
>>> such a bug report).
>>>
>>>>
>>>> BIOS Touchpad option ---> Advanced
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> $ xinput
>>>> =E2=8E=9C =E2=86=B3 SYN1B7D:01 06CB:2991 UNKNOWN id=3D11 [slave pointe=
r (2)]
>>>>
>>>> $ dmesg | grep -E "(mouse|input)"
>>>> [ 14.668719] input: SYN1B7D:01 06CB:2991 UNKNOWN as
>>>> /devices/platform/80860F41:00/i2c-0/i2c-SYN1B7D:01/0018:06CB:2991.0001=
/input/input7
>>>> [ 14.669434] hid-multitouch 0018:06CB:2991.0001: input,hidraw0:
>>>> <UNKNOWN> HID v1.00 Mouse [SYN1B7D:01 06CB:2991] on
>>>
>>> This looks good to me from the input point of view. Please describe
>>> which issues you are seeing, because here, all we can say is that it
>>> is normal and there is nothing to be done.
>>>
>>>>
>>>> BIOS Touchpad option ---> Basic
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> $ xinput
>>>> =E2=8E=9C =E2=86=B3 SynPS/2 Synaptics TouchPad id=3D12 [slave pointer =
(2)]
>>>>
>>>> $ dmesg | grep -E "(mouse|input)"
>>>> [ 2.367407] psmouse serio2: synaptics: queried max coordinates: x
>>>> [..5662], y [..4728]
>>>> [ 2.410703] psmouse serio2: synaptics: queried min coordinates: x
>>>> [1322..], y [1190..]
>>>> [ 2.493774] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.1, id:
>>>> 0x1e2b1, caps: 0xd40123/0x840300/0x126800, board id: 2991, fw id:
>>>> 1626681
>>>> [ 2.543305] input: SynPS/2 Synaptics TouchPad as
>>>> /devices/platform/i8042/serio2/input/input11
>>>
>>> OK, this is normal too.
>>>
>>> Cheers,
>>> Benjamin

--001a11376c7480de770521ed54c5
Content-Type: text/plain; charset=US-ASCII; name="hid-recorder_output.txt"
Content-Disposition: attachment; filename="hid-recorder_output.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ifobtlh50

RDogMApSOiAzNzkgMDUgMDEgMDkgMDIgYTEgMDEgODUgMDIgMDkgMDEgYTEgMDAgMDUgMDkgMTkg
MDEgMjkgMDIgMTUgMDAgMjUgMDEgNzUgMDEgOTUgMDIgODEgMDIgOTUgMDYgODEgMDEgMDUgMDEg
MDkgMzAgMDkgMzEgMTUgODEgMjUgN2YgNzUgMDggOTUgMDIgODEgMDYgYzAgYzAgMDUgMGQgMDkg
MDUgYTEgMDEgODUgMDMgMDkgMjIgYTEgMDIgMTUgMDAgMjUgMDEgMDkgNDcgMDkgNDIgOTUgMDIg
NzUgMDEgODEgMDIgOTUgMDEgNzUgMDMgMjUgMDUgMDkgNTEgODEgMDIgNzUgMDEgOTUgMDMgODEg
MDMgMDUgMDEgMTUgMDAgMjYgYzcgMDQgNzUgMTAgNTUgMGUgNjUgMTEgMDkgMzAgMzUgMDAgNDYg
ZmIgMDMgOTUgMDEgODEgMDIgNDYgMzkgMDIgMjYgYWMgMDIgMDkgMzEgODEgMDIgMDUgMGQgYzAg
NTUgMGMgNjYgMDEgMTAgNDcgZmYgZmYgMDAgMDAgMjcgZmYgZmYgMDAgMDAgNzUgMTAgOTUgMDEg
MDkgNTYgODEgMDIgMDkgNTQgMjUgN2YgOTUgMDEgNzUgMDggODEgMDIgMDUgMDkgMDkgMDEgMjUg
MDEgNzUgMDEgOTUgMDEgODEgMDIgOTUgMDcgODEgMDMgMDUgMGQgODUgMDggMDkgNTUgMDkgNTkg
NzUgMDQgOTUgMDIgMjUgMGYgYjEgMDIgODUgMGQgMDkgNjAgNzUgMDEgOTUgMDEgMTUgMDAgMjUg
MDEgYjEgMDIgOTUgMDcgYjEgMDMgODUgMDcgMDYgMDAgZmYgMDkgYzUgMTUgMDAgMjYgZmYgMDAg
NzUgMDggOTYgMDAgMDEgYjEgMDIgYzAgMDUgMGQgMDkgMGUgYTEgMDEgODUgMDQgMDkgMjIgYTEg
MDIgMDkgNTIgMTUgMDAgMjUgMGEgNzUgMDggOTUgMDEgYjEgMDIgYzAgMDkgMjIgYTEgMDAgODUg
MDYgMDkgNTcgMDkgNTggNzUgMDEgOTUgMDIgMjUgMDEgYjEgMDIgOTUgMDYgYjEgMDMgYzAgYzAg
MDYgMDAgZmYgMDkgMDEgYTEgMDEgODUgMDkgMDkgMDIgMTUgMDAgMjYgZmYgMDAgNzUgMDggOTUg
MTQgOTEgMDIgODUgMGEgMDkgMDMgMTUgMDAgMjYgZmYgMDAgNzUgMDggOTUgMTQgOTEgMDIgODUg
MGIgMDkgMDQgMTUgMDAgMjYgZmYgMDAgNzUgMDggOTUgMWEgODEgMDIgODUgMGMgMDkgMDUgMTUg
MDAgMjYgZmYgMDAgNzUgMDggOTUgMWEgODEgMDIgODUgMGYgMDkgMDYgMTUgMDAgMjYgZmYgMDAg
NzUgMDggOTUgMDEgYjEgMDIgODUgMGUgMDkgMDcgMTUgMDAgMjYgZmYgMDAgNzUgMDggOTUgMDEg
YjEgMDIgYzAKTjogU1lOMUI3RDowMSAwNkNCOjI5OTEKUDogCkk6IDE4IDA2Y2IgMjk5MQpEOiAw
CkU6IDAuMDAwMDAwIDEwIDAzIDAzIGYxIDAyIDNkIDAxIGI0IGJjIDAxIDAwCkU6IDAuMDAxMzcw
IDEwIDAzIDAzIGVkIDAyIDNiIDAxIGZjIGJjIDAxIDAwCkU6IDAuMDA2ODg2IDEwIDAzIDAzIGVk
IDAyIDNiIDAxIDhjIGJkIDAxIDAwCkU6IDAuMDE0MDY4IDEwIDAzIDAzIGVkIDAyIDNhIDAxIGQ0
IGJkIDAxIDAwCkU6IDAuMDIxNTE4IDEwIDAzIDAzIGVkIDAyIDM5IDAxIDFjIGJlIDAxIDAwCkU6
IDAuMDI5MTUxIDEwIDAzIDAzIGVkIDAyIDM5IDAxIDY0IGJlIDAxIDAwCkU6IDAuMDM1ODAxIDEw
IDAzIDAzIGVkIDAyIDM5IDAxIGFjIGJlIDAxIDAwCkU6IDAuMDQzNjQzIDEwIDAzIDAzIGVjIDAy
IDM5IDAxIGY0IGJlIDAxIDAwCkU6IDAuMDUxNDg3IDEwIDAzIDAzIGVjIDAyIDM4IDAxIDNkIGJm
IDAxIDAwCkU6IDAuMDU4NjY4IDEwIDAzIDAzIGVjIDAyIDM4IDAxIDg1IGJmIDAxIDAwCkU6IDAu
MDY1OTQ2IDEwIDAzIDAzIGVjIDAyIDM4IDAxIGNkIGJmIDAxIDAwCkU6IDAuMDczNDU3IDEwIDAz
IDAzIGVjIDAyIDM4IDAxIDE1IGMwIDAxIDAwCkU6IDAuMDgwODAyIDEwIDAzIDAzIGVjIDAyIDM4
IDAxIDVkIGMwIDAxIDAwCkU6IDAuMDg4MjAxIDEwIDAzIDAzIGVjIDAyIDM4IDAxIGE1IGMwIDAx
IDAwCkU6IDAuMDk1MDc0IDEwIDAzIDAzIGVjIDAyIDM4IDAxIGVkIGMwIDAxIDAwCkU6IDAuMTAy
OTEyIDEwIDAzIDAzIGViIDAyIDM4IDAxIDM1IGMxIDAxIDAwCkU6IDAuMTEwMDY1IDEwIDAzIDAz
IGViIDAyIDM4IDAxIDdkIGMxIDAxIDAwCkU6IDAuMTE3NTU2IDEwIDAzIDAzIGViIDAyIDM4IDAx
IGM0IGMxIDAxIDAwCkU6IDAuMTI0OTI1IDEwIDAzIDAzIGViIDAyIDM4IDAxIDBjIGMyIDAxIDAw
CkU6IDAuMTMxNzI3IDEwIDAzIDAzIGVhIDAyIDM4IDAxIDU0IGMyIDAxIDAwCkU6IDAuMTM5NTk4
IDEwIDAzIDAzIGVhIDAyIDM3IDAxIDljIGMyIDAxIDAwCkU6IDAuMTQ3MDEwIDEwIDAzIDAzIGU5
IDAyIDM3IDAxIGU0IGMyIDAxIDAwCkU6IDAuMTU0NTU4IDEwIDAzIDAzIGU5IDAyIDM3IDAxIDJj
IGMzIDAxIDAwCkU6IDAuMTYxNDg1IDEwIDAzIDAzIGU4IDAyIDM3IDAxIDc0IGMzIDAxIDAwCkU6
IDAuMTY4NTM1IDEwIDAzIDAzIGU3IDAyIDM3IDAxIGJjIGMzIDAxIDAwCkU6IDAuMTc2MjE4IDEw
IDAzIDAzIGU2IDAyIDM3IDAxIDA1IGM0IDAxIDAwCkU6IDAuMTgzNDkzIDEwIDAzIDAzIGU1IDAy
IDM3IDAxIDRkIGM0IDAxIDAwCkU6IDAuMTkxNTU4IDEwIDAzIDAzIGU0IDAyIDM3IDAxIDk1IGM0
IDAxIDAwCkU6IDAuMTk3NzUxIDEwIDAzIDAzIGUyIDAyIDM4IDAxIGRkIGM0IDAxIDAwCkU6IDAu
MjA2MTczIDEwIDAzIDAzIGRmIDAyIDM5IDAxIDI1IGM1IDAxIDAwCkU6IDAuMjEzNDY2IDEwIDAz
IDAzIGRjIDAyIDNhIDAxIDZkIGM1IDAxIDAwCkU6IDAuMjIwMzAyIDEwIDAzIDAzIGQ3IDAyIDNj
IDAxIGI1IGM1IDAxIDAwCkU6IDAuMjI4MjM0IDEwIDAzIDAzIGQ0IDAyIDNkIDAxIGZjIGM1IDAx
IDAwCkU6IDAuMjM1NTg1IDEwIDAzIDAzIGNmIDAyIDNlIDAxIDQ0IGM2IDAxIDAwCkU6IDAuMjQy
ODEwIDEwIDAzIDAzIGNjIDAyIDNmIDAxIDhjIGM2IDAxIDAwCkU6IDAuMjUwMzc3IDEwIDAzIDAz
IGM3IDAyIDQxIDAxIGQ0IGM2IDAxIDAwCkU6IDAuMjU3NTc1IDEwIDAzIDAzIGM0IDAyIDQyIDAx
IDFjIGM3IDAxIDAwCkU6IDAuMjY0NzgwIDEwIDAzIDAzIGJmIDAyIDQ0IDAxIDYzIGM3IDAxIDAw
CkU6IDAuMjcyNTQ0IDEwIDAzIDAzIGJjIDAyIDQ2IDAxIGFiIGM3IDAxIDAwCkU6IDAuMjc4OTg4
IDEwIDAzIDAzIGI5IDAyIDQ3IDAxIGYzIGM3IDAxIDAwCkU6IDAuMjg3MDkyIDEwIDAzIDAzIGI0
IDAyIDQ5IDAxIDNhIGM4IDAxIDAwCkU6IDAuMjkzOTI4IDEwIDAzIDAzIGFmIDAyIDRjIDAxIDgy
IGM4IDAxIDAwCkU6IDAuMzAyMTQwIDEwIDAzIDAzIGE5IDAyIDRmIDAxIGNiIGM4IDAxIDAwCkU6
IDAuMzA4NzU0IDEwIDAzIDAzIGEzIDAyIDUyIDAxIDEzIGM5IDAxIDAwCkU6IDAuMzE2MTk2IDEw
IDAzIDAzIDlkIDAyIDU0IDAxIDViIGM5IDAxIDAwCkU6IDAuMzIzOTEyIDEwIDAzIDAzIDk4IDAy
IDU2IDAxIGEzIGM5IDAxIDAwCkU6IDAuMzMwNjg5IDEwIDAzIDAzIDkzIDAyIDU4IDAxIGViIGM5
IDAxIDAwCkU6IDAuMzM4NjM5IDEwIDAzIDAzIDkwIDAyIDVhIDAxIDMzIGNhIDAxIDAwCkU6IDAu
MzQ1NDcyIDEwIDAzIDAzIDg1IDAyIDYwIDAxIDdiIGNhIDAxIDAwCkU6IDAuMzUzNjM4IDEwIDAz
IDAzIDdmIDAyIDY0IDAxIGMzIGNhIDAxIDAwCkU6IDAuMzYwMjE2IDEwIDAzIDAzIDc4IDAyIDY5
IDAxIDBiIGNiIDAxIDAwCkU6IDAuMzY3Nzc2IDEwIDAzIDAzIDZmIDAyIDZmIDAxIDUzIGNiIDAx
IDAwCkU6IDAuMzc0Njc0IDEwIDAzIDAzIDZhIDAyIDcyIDAxIDliIGNiIDAxIDAwCkU6IDAuMzgy
MzIzIDEwIDAzIDAzIDY0IDAyIDc3IDAxIGUzIGNiIDAxIDAwCkU6IDAuMzg5ODY5IDEwIDAzIDAz
IDVmIDAyIDdiIDAxIDJiIGNjIDAxIDAwCkU6IDAuMzk3NjI2IDEwIDAzIDAzIDU5IDAyIDdmIDAx
IDczIGNjIDAxIDAwCkU6IDAuNDA0ODI3IDEwIDAzIDAzIDU0IDAyIDgyIDAxIGJiIGNjIDAxIDAw
CkU6IDAuNDExODQzIDEwIDAzIDAzIDUxIDAyIDg0IDAxIDAzIGNkIDAxIDAwCkU6IDAuNDE5NjU0
IDEwIDAzIDAzIDRjIDAyIDg3IDAxIDRiIGNkIDAxIDAwCkU6IDAuNDI2NjM3IDEwIDAzIDAzIDRh
IDAyIDg5IDAxIDkzIGNkIDAxIDAwCkU6IDAuNDM0MTcxIDEwIDAzIDAzIDQ3IDAyIDhiIDAxIGRi
IGNkIDAxIDAwCkU6IDAuNDQxNzU3IDEwIDAzIDAzIDQ1IDAyIDhkIDAxIDIzIGNlIDAxIDAwCkU6
IDAuNDQ4NjY3IDEwIDAzIDAzIDQ0IDAyIDhmIDAxIDZiIGNlIDAxIDAwCkU6IDAuNDU2MTQ5IDEw
IDAzIDAzIDQzIDAyIDkxIDAxIGIzIGNlIDAxIDAwCkU6IDAuNDYzMTY4IDEwIDAzIDAzIDQzIDAy
IDkyIDAxIGZiIGNlIDAxIDAwCkU6IDAuNDcwODI0IDEwIDAzIDAzIDQzIDAyIDkzIDAxIDQyIGNm
IDAxIDAwCkU6IDAuNDc4NTgyIDEwIDAzIDAzIDQzIDAyIDk0IDAxIDhhIGNmIDAxIDAwCkU6IDAu
NDg2MDM2IDEwIDAzIDAzIDQzIDAyIDk1IDAxIGQyIGNmIDAxIDAwCkU6IDAuNDkyODk1IDEwIDAz
IDAzIDQzIDAyIDk2IDAxIDFhIGQwIDAxIDAwCkU6IDAuNTAwNDgzIDEwIDAzIDAzIDQ0IDAyIDk4
IDAxIDYyIGQwIDAxIDAwCkU6IDAuNTA3NjcyIDEwIDAzIDAzIDQ3IDAyIDk5IDAxIGFhIGQwIDAx
IDAwCkU6IDAuNTE1MDA0IDEwIDAzIDAzIDQ5IDAyIDlhIDAxIGYxIGQwIDAxIDAwCkU6IDAuNTIy
OTA3IDEwIDAzIDAzIDRjIDAyIDliIDAxIDM4IGQxIDAxIDAwCkU6IDAuNTMwNjg0IDEwIDAzIDAz
IDRmIDAyIDljIDAxIDgwIGQxIDAxIDAwCkU6IDAuNTM3MzMxIDEwIDAzIDAzIDUyIDAyIDlkIDAx
IGM4IGQxIDAxIDAwCkU6IDAuNTQ0OTU0IDEwIDAzIDAzIDU2IDAyIDllIDAxIDEwIGQyIDAxIDAw
CkU6IDAuNTUxOTA3IDEwIDAzIDAzIDVhIDAyIDlmIDAxIDU4IGQyIDAxIDAwCkU6IDAuNTU4OTgz
IDEwIDAzIDAzIDVlIDAyIDlmIDAxIGEwIGQyIDAxIDAwCkU6IDAuNTY2NTU4IDEwIDAzIDAzIDYx
IDAyIGEwIDAxIGU3IGQyIDAxIDAwCkU6IDAuNTc0Mzk0IDEwIDAzIDAzIDY0IDAyIGEwIDAxIDJm
IGQzIDAxIDAwCkU6IDAuNTgxMjc5IDEwIDAzIDAzIDY3IDAyIGEwIDAxIDc3IGQzIDAxIDAwCkU6
IDAuNTg4NzcxIDEwIDAzIDAzIDZiIDAyIGEwIDAxIGJmIGQzIDAxIDAwCkU6IDAuNTk2NDMxIDEw
IDAzIDAzIDZlIDAyIGEwIDAxIDA3IGQ0IDAxIDAwCkU6IDAuNjAzMTQ1IDEwIDAzIDAzIDcxIDAy
IGEwIDAxIDRmIGQ0IDAxIDAwCkU6IDAuNjEwNjg0IDEwIDAzIDAzIDc1IDAyIGEwIDAxIDk3IGQ0
IDAxIDAwCkU6IDAuNjE4NTY4IDEwIDAzIDAzIDc5IDAyIGEwIDAxIGRmIGQ0IDAxIDAwCkU6IDAu
NjI1ODA3IDEwIDAzIDAzIDgxIDAyIDlmIDAxIDI3IGQ1IDAxIDAwCkU6IDAuNjMzMDI1IDEwIDAz
IDAzIDg0IDAyIDllIDAxIDZmIGQ1IDAxIDAwCkU6IDAuNjQwMjAxIDEwIDAzIDAzIDg2IDAyIDll
IDAxIGI3IGQ1IDAxIDAwCkU6IDAuNjQ2OTk4IDEwIDAzIDAxIDg2IDAyIDllIDAxIGZmIGQ1IDAx
IDAwCg==
--001a11376c7480de770521ed54c5--
