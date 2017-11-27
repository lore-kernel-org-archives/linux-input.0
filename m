From: Leonardo Fontenelle <leonardof@fastmail.com>
Subject: Touchpad not using i2c-hid or hid-rmi
Date: Mon, 27 Nov 2017 12:44:56 -0200
Message-ID: <1511793896.1646905.1185533184.57AE9B5F@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50083 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752356AbdK0Oo4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Nov 2017 09:44:56 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 34FC920D7D
        for <linux-input@vger.kernel.org>; Mon, 27 Nov 2017 09:44:56 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I was looking for something else in dmesg when I found this:

[=C2=A0 +0,009016] psmouse serio4: synaptics: queried min coordinates: x
[1282..], y [1110..]
[=C2=A0 +0,000009] psmouse serio4: synaptics: Your touchpad (PNP: SYN019e
SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid
and hid-rmi are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[=C2=A0 +0,069488] psmouse serio4: synaptics: Touchpad model: 1, fw: 8.1, i=
d:
0x1e2b1, caps: 0xd00123/0x840300/0x27c00/0x0, board id: 2251, fw id:
1241283
[=C2=A0 +0,044265] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio4/input/input23

i2c-hid and hid-rmi are absent from the output of lsmod.

I don't believe I can feel any side effect from this, so I didn't set
psmouse.synaptics_intertouch to 1 yet. Do you want me to set it and send
dmesg again?

Sincerely,

Leonardo Ferreira Fontenelle

PS, the mail daemon rejected this email when I sent if using my
leonardof@gnome.org alias.
