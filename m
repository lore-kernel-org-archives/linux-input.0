From: Josep Pujadas-Jubany <jpujades@gmail.com>
Subject: [Acer Travelmate B115-M] Synaptic touchpad
Date: Sun, 4 Oct 2015 19:26:04 +0200
Message-ID: <CAJ3dLCB2PDk--EsH785aDCquxPROLGbRGpz0qMCGgChcA9oRGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33041 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbJDR0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Oct 2015 13:26:44 -0400
Received: by qgev79 with SMTP id v79so132110517qge.0
        for <linux-input@vger.kernel.org>; Sun, 04 Oct 2015 10:26:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1493814

Touchpad has issues working
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

The mainline kernel does not fix the issue

Latest BIOS (1.38)

BIOS Touchpad option ---> Advanced
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

$ xinput
=E2=8E=9C =E2=86=B3 SYN1B7D:01 06CB:2991 UNKNOWN id=3D11 [slave pointer=
 (2)]

$ dmesg | grep -E "(mouse|input)"
[ 14.668719] input: SYN1B7D:01 06CB:2991 UNKNOWN as
/devices/platform/80860F41:00/i2c-0/i2c-SYN1B7D:01/0018:06CB:2991.0001/=
input/input7
[ 14.669434] hid-multitouch 0018:06CB:2991.0001: input,hidraw0:
<UNKNOWN> HID v1.00 Mouse [SYN1B7D:01 06CB:2991] on

BIOS Touchpad option ---> Basic
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

$ xinput
=E2=8E=9C =E2=86=B3 SynPS/2 Synaptics TouchPad id=3D12 [slave pointer (=
2)]

$ dmesg | grep -E "(mouse|input)"
[ 2.367407] psmouse serio2: synaptics: queried max coordinates: x
[..5662], y [..4728]
[ 2.410703] psmouse serio2: synaptics: queried min coordinates: x
[1322..], y [1190..]
[ 2.493774] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.1, id:
0x1e2b1, caps: 0xd40123/0x840300/0x126800, board id: 2991, fw id:
1626681
[ 2.543305] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio2/input/input11
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
