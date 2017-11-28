From: Chris Henhawke <chris@hamiltonshells.ca>
Subject: psmouse.synaptics_intertouch SYN1222 PNP0f13
Date: Tue, 28 Nov 2017 14:17:23 -0500
Message-ID: <799a61bd-f654-ce70-8203-267a7207e38b@hamiltonshells.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.cogeco.net ([216.221.81.25]:61695 "EHLO fipsb01.cogeco.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752226AbdK1T2n (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Nov 2017 14:28:43 -0500
Received: from localhost (bloomfield.hamiltonshells.ca [127.0.0.1])
        by bloomfield.hamiltonshells.ca (Postfix) with ESMTP id 002E71C8
        for <linux-input@vger.kernel.org>; Tue, 28 Nov 2017 14:17:24 -0500 (EST)
Received: from bloomfield.hamiltonshells.ca ([127.0.0.1])
        by localhost (bloomfield.hamiltonshells.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iY3xhf_Gb7KK for <linux-input@vger.kernel.org>;
        Tue, 28 Nov 2017 14:17:23 -0500 (EST)
Received: from [192.168.0.12] (gazelle.hamiltonshells.ca [192.168.0.12])
        by bloomfield.hamiltonshells.ca (Postfix) with ESMTP id A690A1C7
        for <linux-input@vger.kernel.org>; Tue, 28 Nov 2017 14:17:23 -0500 (EST)
Content-Language: en-CA
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Reporting as requested.  Setting the parameter appears to be working. 
If you need more info, please mail me directly.

System76 Gazelle upgrading from 4.9.34 to 4.14.2

First boot:
Nov 28 11:24:37 gazelle kernel: psmouse serio2: synaptics: queried max
coordinates: x [..5674], y [..4764]
Nov 28 11:24:37 gazelle kernel: psmouse serio2: synaptics: queried min
coordinates: x [1266..], y [1086..]
Nov 28 11:24:37 gazelle kernel: psmouse serio2: synaptics: The touchpad
can support a better bus than the too old PS/2 protocol. Make sure
MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better
touchpad experience.
Nov 28 11:24:37 gazelle kernel: psmouse serio2: synaptics: Touchpad
model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00223/0x840300/0x26800/0x0,
board id: 3189, fw id: 2302754
Nov 28 11:24:37 gazelle kernel: input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio2/input/input12

After enabling SMBUS:
Nov 28 11:54:44 gazelle kernel: psmouse serio2: synaptics: queried max
coordinates: x [..5674], y [..4764]
Nov 28 11:54:44 gazelle kernel: psmouse serio2: synaptics: queried min
coordinates: x [1266..], y [1086..]
Nov 28 11:54:44 gazelle kernel: psmouse serio2: synaptics: Your touchpad
(PNP: SYN1222 PNP0f13) says it can support a different bus. If i2c-hid
and hid-rmi are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
Nov 28 11:54:44 gazelle kernel: psmouse serio2: synaptics: Touchpad
model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00223/0x840300/0x26800/0x0,
board id: 3189, fw id: 2302754
Nov 28 11:54:44 gazelle kernel: input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio2/input/input12

After adding parameter to boot line:
Nov 28 13:55:28 gazelle kernel: psmouse serio2: synaptics: queried max
coordinates: x [..5674], y [..4764]
Nov 28 13:55:28 gazelle kernel: psmouse serio2: synaptics: queried min
coordinates: x [1266..], y [1086..]
Nov 28 13:55:28 gazelle kernel: psmouse serio2: synaptics: Trying to set
up SMBus access
Nov 28 13:55:28 gazelle kernel: rmi4_smbus 5-002c: registering
SMbus-connected sensor
Nov 28 13:55:28 gazelle kernel: rmi4_f01 rmi4-00.fn01: found RMI device,
manufacturer: Synaptics, product: TM3189-002, fw id: 2302754
Nov 28 13:55:28 gazelle kernel: input: Synaptics TM3189-002 as
/devices/rmi4-00/input/input13

Cheers
