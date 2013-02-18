From: =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?=
	<cywang@google.com>
Subject: Re: [PATCH] Input: psmouse - retry getid command in psmouse_probe()
Date: Mon, 18 Feb 2013 17:45:07 +0800
Message-ID: <CAM2ehZZ9LyTkG+qi_ihGzYJn2fB=s9RCLT67ThZUB9mmyQSzhw@mail.gmail.com>
References: <1351678279-32615-1-git-send-email-cywang@chromium.org> <1361179560.7859.5.camel@liguang.fnst.cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361179560.7859.5.camel@liguang.fnst.cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: li guang <lig.fnst@cn.fujitsu.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tai-hwa Liang <avatar@sentelic.com>, Rusty Russell <rusty@rustcorp.com.au>, Paul Fox <pgf@laptop.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Yes, I could add CONFIG_MOUSE_PS2_SYNAPTICS for the change as we only
need it for synaptics touchpad/touchpoint on lenovo's machines.


On Mon, Feb 18, 2013 at 5:26 PM, li guang <lig.fnst@cn.fujitsu.com> wro=
te:
> seems a special change for a special device
> so, you may need to place this change with
> corresponding CONFIG_xxx_xxx.
> generally, if command F2 failed, we will assume
> there's no ps2 device, it's normal,
> or do you have some materials(SPEC) to specify
> the change you have made?
>
>
>
> =E5=9C=A8 2012-10-31=E4=B8=89=E7=9A=84 18:11 +0800=EF=BC=8CChung-yih =
Wang=E5=86=99=E9=81=93=EF=BC=9A
>> As the synaptics device may not respond to the first command in psmo=
use_probe
>> when a machine is booting up, the patch gives a second probe if the =
first
>> one fails.
>>
>> Signed-off-by: Chung-yih Wang <cywang@chromium.org>
>> ---
>>  drivers/input/mouse/psmouse-base.c |   13 +++++++++++--
>>  1 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mous=
e/psmouse-base.c
>> index 22fe254..c4fc5ad 100644
>> --- a/drivers/input/mouse/psmouse-base.c
>> +++ b/drivers/input/mouse/psmouse-base.c
>> @@ -1053,8 +1053,17 @@ static int psmouse_probe(struct psmouse *psmo=
use)
>>   */
>>
>>       param[0] =3D 0xa5;
>> -     if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
>> -             return -1;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID)) {
>> +             /*
>> +              * Reprobe the device if it did not respond to the GET=
ID
>> +              * command. Before retry, additional dummy command is =
sent
>> +              * to clear the 'RESEND' response if exists.
>> +              */
>> +             psmouse_warn(psmouse, "GETID probe failed, retrying...=
\n");
>> +             ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
>> +             if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
>> +                     return -1;
>> +     }
>>
>>       if (param[0] !=3D 0x00 && param[0] !=3D 0x03 &&
>>           param[0] !=3D 0x04 && param[0] !=3D 0xff)
>
>
