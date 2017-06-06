From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Tue, 6 Jun 2017 19:28:37 +0200
Message-ID: <CAEk1YH6tQOyj31huuE2+kMQW23a6C6FjNTGxFCOx5TPxiJub2w@mail.gmail.com>
References: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
 <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com>
 <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
 <CAEk1YH54DWWonBcMKaz17+O_UOaWFSm-FWZchUpkT+czVwS93Q@mail.gmail.com>
 <KAWPR01MB1092B90F0C1C12D5E3C40DB5C7CA0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170606074909.GU1293@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33990 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFFR2k (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 13:28:40 -0400
Received: by mail-wr0-f196.google.com with SMTP id u101so8372970wrc.1
        for <linux-input@vger.kernel.org>; Tue, 06 Jun 2017 10:28:39 -0700 (PDT)
In-Reply-To: <20170606074909.GU1293@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 6 June 2017 at 09:49, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> On Jun 05 2017 or thereabouts, Masaki Ota wrote:
>> Hi, Damjan,
>>
>> Latest X1 Carbon system has two TrackPoint venders.
>> One is Alps, the other is Elantech. ( Touchpad is only Synaptics.)
>>
>> To detect the device, we can send "E1" command by using pass-through.
>> The device response is as below.
>> If Alps, E1 -> 02
>> If Elantech, E1-> 01
>>
>> It's a spec, but I have not checked it.
>
> Thanks. This made me realize that we have a difference between the PS/2
> handling of the touchpad and the RMI4 use: in the PS/2 protocol, we
> mark the pass-through device as such by using SERIO_PS_PSTHRU.
> While in RMI4, we mark it as if it was a platform device, meaning we
> check on every protocol.
>
> Damjan, would you mind trying the following change:
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index 77dad04..ad71a5e 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -146,7 +146,7 @@ static int rmi_f03_register_pt(struct f03_data *f03)
>         if (!serio)
>                 return -ENOMEM;
>
> -       serio->id.type =3D SERIO_8042;
> +       serio->id.type =3D SERIO_PS_PSTHRU;
>         serio->write =3D rmi_f03_pt_write;
>         serio->port_data =3D f03;
>
> ---
>
> If this gives equal results than when using synaptics_intertouch=3D0, the=
n
> I guess this will be a good candidate for an rc.

what equal results?

based on 4.12-rc4 (ba7b2387ad239a519041f2a2d35a1902bdd03dfb) and this
change, and 'psmouse' loaded with no options, I get:

[    9.151247] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[    9.181297] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[    9.181300] psmouse serio1: synaptics: Your touchpad (PNP: LEN0072
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[    9.240307] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2,
id: 0x1e2b1, caps: 0xf002a3/0x940300/0x12e800/0x400000, board id:
3289, fw id: 2492434
[    9.240310] psmouse serio1: synaptics: serio: Synaptics
pass-through port at isa0060/serio1/input0
[    9.278160] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
[    9.281307] mousedev: PS/2 mouse device common for all mice

$ xinput
=E2=8E=A1 Virtual core pointer                          id=3D2    [master p=
ointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                id=3D4    [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 SynPS/2 Synaptics TouchPad                id=3D11   [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 ImPS/2 Generic Wheel Mouse                id=3D12   [=
slave  pointer  (2)]


--=20
damjan
