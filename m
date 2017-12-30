From: Leonardo Fontenelle <leonardof@fastmail.com>
Subject: dmesg asked me to email about touchpad
Date: Sat, 30 Dec 2017 10:33:18 -0200
Message-ID: <1514637198.2138681.1219545288.099EC796@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48601 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750759AbdL3MdS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 07:33:18 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CFD521969
        for <linux-input@vger.kernel.org>; Sat, 30 Dec 2017 07:33:18 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I got this on my dmesg:

[    8.757452] psmouse serio4: synaptics: Your touchpad (PNP: SYN019e SYN01=
00 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid=
-rmi are not used, you might want to try setting psmouse.synaptics_intertou=
ch to 1 and report this to linux-input@vger.kernel.org.
[    8.824695] psmouse serio4: synaptics: Touchpad model: 1, fw: 8.1, id: 0=
x1e2b1, caps: 0xd00123/0x840300/0x27c00/0x0, board id: 2251, fw id: 1241283
[    8.868370] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042=
/serio4/input/input24

After setting the boot parameter, dmesg says:

[=C2=A0=C2=A0=C2=A0 8.484085] psmouse serio4: synaptics: queried max coordi=
nates: x [..5660], y [..4742]
[=C2=A0=C2=A0=C2=A0 8.521340] psmouse serio4: synaptics: queried min coordi=
nates: x [1282..], y [1110..]
[=C2=A0=C2=A0=C2=A0 8.521344] psmouse serio4: synaptics: Trying to set up S=
MBus access
[=C2=A0=C2=A0=C2=A0 8.535868] rmi4_smbus 9-002c: registering SMbus-connecte=
d sensor

Both before and after setting psmouse.synaptics_intertouch, I had:

$ lsmod | fgrep hid
mac_hid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 16384=C2=A0 0

Despite the name, this is an HP Folio 9470m running Arch Linux with Linux 4=
.14.9. The touchpad works fine either way.

I do not subscribe to the list, please cc me so that I can provide further =
 necessary information.

Thanks for making things work.

Sincerely,

Leonardo Ferreira Fontenelle
