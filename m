From: Pablo Cholaky <waltercool@slash.cl>
Subject: rmi-smbus SYN1219 PNP0f13 not correctly detected
Date: Mon, 24 Jul 2017 21:17:52 -0400
Message-ID: <CAD_UamUKvpQ_VEyH9i0MEBbG2S=FAx4zDdoCwYGNy05rwc+1-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35063 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbdGYBSN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 21:18:13 -0400
Received: by mail-yw0-f181.google.com with SMTP id l82so1952358ywc.2
        for <linux-input@vger.kernel.org>; Mon, 24 Jul 2017 18:18:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Guys,

As far I read on the kernel output, I tried to make anything match
with the touchpad and I didn't get a good solution, so I loaded
psmouse with synaptics_intertouch 1 to properly debug the device and
might be useful.

[ 1751.202901] psmouse serio2: synaptics: queried max coordinates: x
[..5654], y [..4716]
[ 1751.320068] psmouse serio2: synaptics: queried min coordinates: x
[1326..], y [1228..]
[ 1751.320073] psmouse serio2: synaptics: Your touchpad (PNP: SYN1219
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[ 1751.469029] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.2,
id: 0x1e2b1, caps: 0xf00123/0x840300/0x26800/0x0, board id: 3163, fw
id: 1924066
[ 1751.509697] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio2/input/input48
[ 1778.905227] psmouse serio2: synaptics: queried max coordinates: x
[..5654], y [..4716]
[ 1779.020816] psmouse serio2: synaptics: queried min coordinates: x
[1326..], y [1228..]
[ 1779.020819] psmouse serio2: synaptics: Trying to set up SMBus access
[ 1779.109162] rmi4_smbus 0-002c: registering SMbus-connected sensor
[ 1779.163347] rmi4_f01 rmi4-01.fn01: found RMI device, manufacturer:
Synaptics, product: TM3163-001, fw id: 1924066
[ 1779.220800] input: Synaptics TM3163-001 as /devices/rmi4-01/input/input84

Question, there is something else I can provide you to identify this?
Currently I'm under kernel 4.12.2 using I2C 801, custom kernel.

Regards

-- 
Pablo Cholaky
Computer Science and TI Engineer
Gentoo Linux user and developer
Slash.cl Owner
Blablabla
