From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: ThinkPad X270 Synaptics Touchpad, RMI4 SMB
Date: Tue, 31 Oct 2017 12:21:37 +0100
Message-ID: <CAEk1YH4G17adR_OF4QD1Uy-Hio=ceX=G5Gp+iLmkvVyutzrpOg@mail.gmail.com>
References: <ed4fdc87-393e-421f-d5bb-768bfaa88be4@bootc.boo.tc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54704 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdJaLVj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Oct 2017 07:21:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id r68so22422260wmr.3
        for <linux-input@vger.kernel.org>; Tue, 31 Oct 2017 04:21:38 -0700 (PDT)
In-Reply-To: <ed4fdc87-393e-421f-d5bb-768bfaa88be4@bootc.boo.tc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Boot <lists@bootc.boo.tc>
Cc: linux-input@vger.kernel.org, 875621@bugs.debian.org

On 30 October 2017 at 23:36, Chris Boot <lists@bootc.boo.tc> wrote:
> Hi folks,
>
> I have a Lenovo ThinkPad X270 and noticed that my kernel (Debian
> buster/testing stock kernel) was suggesting that my Touchpad would
> benefit from having CONFIG_RMI4_SMB enabled, so I raised this Debian bug:
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D875621
>
> This was closed today with an updated Debian kernel upload,
> linux_4.13.10-1 (thanks Ben). The new kernel now says:
>
> Oct 30 22:13:49 muta kernel: [    3.557065] hid-generic
> 0003:1050:0407.0002: hiddev0,hidraw1: USB HID v1.10 Device [Yubico
> Yubikey 4 OTP+U2F+CCID] on usb-0000:00:14.0-6/input1
> Oct 30 22:13:49 muta kernel: [    3.574540] psmouse serio1: synaptics:
> queried max coordinates: x [..5712], y [..4780]
> Oct 30 22:13:49 muta kernel: [    3.608224] psmouse serio1: synaptics:
> queried min coordinates: x [1232..], y [1074..]
> Oct 30 22:13:49 muta kernel: [    3.608238] psmouse serio1: synaptics:
> Your touchpad (PNP: LEN2049 PNP0f13) says it can support a different
> bus. If i2c-hid and hid-rmi are not used, you might want to try setting
> psmouse.synaptics_intertouch to 1 and report this to
> linux-input@vger.kernel.org.
> Oct 30 22:13:49 muta kernel: [    3.674976] psmouse serio1: synaptics:
> Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps:
> 0xf407a3/0x943300/0x12e800/0x410000, board id: 3075, fw id: 2477413
> Oct 30 22:13:49 muta kernel: [    3.674997] psmouse serio1: synaptics:
> serio: Synaptics pass-through port at isa0060/serio1/input0
> Oct 30 22:13:49 muta kernel: [    3.717820] input: SynPS/2 Synaptics
> TouchPad as /devices/platform/i8042/serio1/input/input2
> Oct 30 22:13:49 muta kernel: [    4.393051] psmouse serio2: trackpoint:
> IBM TrackPoint firmware: 0x0e, buttons: 3/3
> Oct 30 22:13:49 muta kernel: [    4.620327] input: TPPS/2 IBM TrackPoint
> as /devices/platform/i8042/serio1/serio2/input/input4
>
> So I enabled psmouse.synaptics_intertouch=3D1 on my kernel command line
> and voila, rmi4_smbus is used and my Touchpad is apparently much better
> off for it. Great! Except I can't use my TrackPoint now, it no longer
> shows up at all:
>
> Oct 30 22:17:20 muta kernel: [    3.478867] psmouse serio1: synaptics:
> queried max coordinates: x [..5712], y [..4780]
> Oct 30 22:17:20 muta kernel: [    3.513094] psmouse serio1: synaptics:
> queried min coordinates: x [1232..], y [1074..]
> Oct 30 22:17:20 muta kernel: [    3.513098] psmouse serio1: synaptics:
> Trying to set up SMBus access
> Oct 30 22:17:20 muta kernel: [    9.163140] rmi4_smbus 0-002c:
> registering SMbus-connected sensor
> Oct 30 22:17:20 muta kernel: [    9.262824] rmi4_f01 rmi4-00.fn01: found
> RMI device, manufacturer: Synaptics, product: TM3075-007, fw id: 2477413
> Oct 30 22:17:20 muta kernel: [    9.375014] input: Synaptics TM3075-007
> as /devices/rmi4-00/input/input10
>
> So I'm emailing both about having to enable synaptics_intertouch for my
> Touchpad as instructed in dmesg, and also that enabling it makes my
> TrackPoint disappear.

I had the same issue on X1 Carbon (5th gen)

you need to load the =C2=BB rmi_smbus =C2=AB module before loading psmouse



--=20
damjan
