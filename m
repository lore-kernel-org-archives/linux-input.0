From: =?UTF-8?Q?Abel_Garc=C3=ADa_Dorta?= <mercuriete@gmail.com>
Subject: Fwd: synaptic touchpad support different bus.
Date: Mon, 13 Nov 2017 23:01:17 +0100
Message-ID: <CADRD000x-EV3ZwO+AEBNVHP4cbpRLR_1fKzAsRLE2g49e9dhkQ@mail.gmail.com>
References: <CADRD001h0qzVhXxv7fc_0X4vQAngrnAySk+6Fag++NgqAY3Ntg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:52605 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbdKMWBT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Nov 2017 17:01:19 -0500
Received: by mail-vk0-f53.google.com with SMTP id o70so2654892vkc.9
        for <linux-input@vger.kernel.org>; Mon, 13 Nov 2017 14:01:19 -0800 (PST)
In-Reply-To: <CADRD001h0qzVhXxv7fc_0X4vQAngrnAySk+6Fag++NgqAY3Ntg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Sorry for the noise, I don't know where I should report this issue:

partial dmesg:
[    5.508933] psmouse serio4: synaptics: queried max coordinates: x
[..5660], y [..4696]
[    5.548728] psmouse serio4: synaptics: queried min coordinates: x
[1366..], y [1268..]
[    5.551455] psmouse serio4: synaptics: Your touchpad (PNP: TOS1151
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[    5.631613] psmouse serio4: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xd00123/0x840300/0x126800/0x0, board id: 2987, fw
id: 1595020
[    5.681318] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio4/input/input22

kernel config:
 cat /usr/src/linux/.config|grep RMI
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y
CONFIG_HID_RMI=y

cat /usr/src/linux/.config|grep I2C_HID
CONFIG_I2C_HID=y

Then I set the kernel parameter psmouse.synaptics_intertouch to 1
and it works fine.

[    5.443990] psmouse serio4: synaptics: queried max coordinates: x
[..5660], y [..4696]
[    5.483705] psmouse serio4: synaptics: queried min coordinates: x
[1366..], y [1268..]
[    5.486898] psmouse serio4: synaptics: Trying to set up SMBus access
[    5.497052] rmi4_smbus 15-002c: registering SMbus-connected sensor
[    5.549588] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM2987-001, fw id: 0
[    5.612277] input: Synaptics TM2987-001 as /devices/rmi4-00/input/input23



So summarizing:
my touchpad says (PNP: TOS1151 PNP0f13) says it can support a
different bus and when using
psmouse.synaptics_intertouch=1 it works perfect.

PS: this is my laptop, a toshiba one:
http://www.toshiba.es/discontinued-products/satellite-p50-b-11m/

Thanks!
