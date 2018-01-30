From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Trackpoint not found when loading psmouse before rmi_smbus
Date: Tue, 30 Jan 2018 13:46:29 +0100
Message-ID: <CAEk1YH68KecWAyeKTu_paL3CLtxLuw1hrH7Z4B_FqiWQML666Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54543 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeA3Mqb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Jan 2018 07:46:31 -0500
Received: by mail-wm0-f47.google.com with SMTP id i186so850170wmi.4
        for <linux-input@vger.kernel.org>; Tue, 30 Jan 2018 04:46:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is tested on X1 Carbon (gen 5)
pnp id: LEN0072
kernel 4.15.0

Since by default psmouse complains about
"synaptics: Your touchpad (PNP: LEN0072 PNP0f13) says it can support a
different bus....",
I've patched the kernel to add the pnp id to smbus_pnp_ids in
drivers/input/mouse/synaptics.c [1],
and the trackpad seems to work at least a  bit smoother (it could be
placebo though).

But, with the default setup, and rmi_smbus and psmouse are both
compiled as modules, the trackpoint device never appears in dmesg.
I can make it appear if I put rmi_smbus in /etc/modules-load.d/ so it
loads before psmouse, or if I unload psmouse and load it again.

I can even reproduce it by unloading both rmi_smbus and psmouse, and
then only loading psmouse
(psmouse seems to load rmi_smbus and switch the trackpad to it but the
trackpoint is lost)

Here's the output of dmesg. first part when psmouse is loaded before
rmi_smbus, second when rmi_smbus is first loaded, then psmouse:

[ 3720.674955] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[ 3720.707854] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[ 3720.707866] psmouse serio1: synaptics: Trying to set up SMBus access
[ 3720.719392] rmi4_smbus 6-002c: registering SMbus-connected sensor
[ 3720.780999] rmi4_f01 rmi4-02.fn01: found RMI device, manufacturer:
Synaptics, product: TM3289-002, fw id: 2492434
[ 3720.848800] input: Synaptics TM3289-002 as /devices/rmi4-02/input/input26

<...  no other messages here I just put a separator to be a bit more clear ...>

[ 3755.533836] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[ 3755.565863] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[ 3755.565875] psmouse serio1: synaptics: Trying to set up SMBus access
[ 3755.569661] rmi4_smbus 6-002c: registering SMbus-connected sensor
[ 3755.636795] rmi4_f01 rmi4-03.fn01: found RMI device, manufacturer:
Synaptics, product: TM3289-002, fw id: 2492434
[ 3755.701859] input: Synaptics TM3289-002 as /devices/rmi4-03/input/input30
[ 3755.836966] psmouse serio5: trackpoint: ALPS TrackPoint firmware:
0x01, buttons: 3/3
[ 3755.880664] input: TPPS/2 ALPS TrackPoint as
/devices/rmi4-03/rmi4-03.fn03/serio5/input/input31
[ 3758.969259] psmouse serio5: TrackPoint at
synaptics-rmi4-pt/serio1/input0 lost synchronization, throwing 1 bytes
away.


[1]
https://github.com/gdamjan/linux/commit/fa6b3c893bea6d017b575438a4b367f2a7fc7717

-- 
damjan
