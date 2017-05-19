From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Fri, 19 May 2017 22:12:16 +0200
Message-ID: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34823 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755022AbdESUMT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 16:12:19 -0400
Received: by mail-wr0-f169.google.com with SMTP id z52so22597878wrc.2
        for <linux-input@vger.kernel.org>; Fri, 19 May 2017 13:12:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,
the trackpoint on the  Thinkpad X1 Carbon (5th gen) (model 20HQ) is
recognised as:
"ImPS/2 Generic Wheel Mouse" while typically it should be "TPPS/2 IBM
TrackPoint".

Conversely, the middle button is not configured to emulate a mouse
wheel for scrolling, so I need to enable it explicitly with:
xinput set-prop "ImPS/2 Generic Wheel Mouse" "libinput Scroll Method
Enabled" 0 0 1


I'm not sure what information to provide about the device. the kernel
seems to find it as:
[    0.690665] pnp 00:06: Plug and Play ACPI device, IDs LEN0072
PNP0f13 (active)



Additionally,
if I load the `psmouse` module with synaptics_intertouch=3D1 option I get:
$ xinput list
=E2=8E=9C   =E2=86=B3 Synaptics TM3289-002                      id=3D11   [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint Stick             id=3D12   [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint TouchPad          id=3D14   [=
slave  pointer  (2)]

and kernel log:
[ 3244.067726] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[ 3244.099572] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[ 3244.099577] psmouse serio1: synaptics: Trying to set up SMBus access
[ 3244.113905] rmi4_smbus 0-002c: registering SMbus-connected sensor
[ 3244.173149] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3289-002, fw id: 2492434
[ 3244.244186] input: Synaptics TM3289-002 as /devices/rmi4-00/input/input1=
04
[ 3246.073366] input: AlpsPS/2 ALPS DualPoint Stick as
/devices/rmi4-00/rmi4-00.fn03/serio4/input/input107
[ 3246.139663] input: AlpsPS/2 ALPS DualPoint TouchPad as
/devices/rmi4-00/rmi4-00.fn03/serio4/input/input106

but in that case the trackpoint is too sensitive and middle click
scrolling still doesn't work

--=20
damjan
