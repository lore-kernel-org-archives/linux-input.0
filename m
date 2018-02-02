From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: Trackpoint not found when loading psmouse before rmi_smbus
Date: Fri, 2 Feb 2018 10:37:25 +0100
Message-ID: <CAEk1YH5ypyAFH3qcOZ4=pHpoMGGVjUjETU5PRkFmoN1xX_HZtg@mail.gmail.com>
References: <CAEk1YH68KecWAyeKTu_paL3CLtxLuw1hrH7Z4B_FqiWQML666Q@mail.gmail.com>
 <CAKdAkRT4ktdJwFTQCDRA2GWir4hXuE34kfii6mvXauh1pK-X3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33310 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBBJh0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Feb 2018 04:37:26 -0500
Received: by mail-wm0-f52.google.com with SMTP id x4-v6so1639241wmc.0
        for <linux-input@vger.kernel.org>; Fri, 02 Feb 2018 01:37:26 -0800 (PST)
In-Reply-To: <CAKdAkRT4ktdJwFTQCDRA2GWir4hXuE34kfii6mvXauh1pK-X3g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 1 February 2018 at 23:54, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Damjan,
>
> On Tue, Jan 30, 2018 at 4:46 AM, Damjan Georgievski <gdamjan@gmail.com> wrote:
>> This is tested on X1 Carbon (gen 5)
>> pnp id: LEN0072
>> kernel 4.15.0
>>
>> Since by default psmouse complains about
>> "synaptics: Your touchpad (PNP: LEN0072 PNP0f13) says it can support a
>> different bus....",
>> I've patched the kernel to add the pnp id to smbus_pnp_ids in
>> drivers/input/mouse/synaptics.c [1],
>> and the trackpad seems to work at least a  bit smoother (it could be
>> placebo though).
>>
>> But, with the default setup, and rmi_smbus and psmouse are both
>> compiled as modules, the trackpoint device never appears in dmesg.
>> I can make it appear if I put rmi_smbus in /etc/modules-load.d/ so it
>> loads before psmouse, or if I unload psmouse and load it again.
>>
>> I can even reproduce it by unloading both rmi_smbus and psmouse, and
>> then only loading psmouse
>> (psmouse seems to load rmi_smbus and switch the trackpad to it but the
>> trackpoint is lost)
>
> Please try with these patches:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=next&id=a1ab69021a584d952e6548a44b93760547b1b6b5
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=next&id=6abe534f0776d2437c8302f58d8eb5abd483e926
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=next&id=9f87b9fc369f7719ccdac5077855c5c03b625571


Thanks Dmitry,
applied the patches[1] on 4.15.0 and it works fine now.
maybe it's time to add the pnp id to smbus_pnp_ids now [2]?

[   10.279278] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[   10.311351] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[   10.311359] psmouse serio1: synaptics: Trying to set up SMBus access
[   10.339907] rmi4_smbus 6-002c: registering SMbus-connected sensor
[   10.405488] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3289-002, fw id: 2492434
[   10.422386] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.422389] Bluetooth: BNEP filters: protocol multicast
[   10.422396] Bluetooth: BNEP socket layer initialized
[   10.469583] input: Synaptics TM3289-002 as /devices/rmi4-00/input/input18
[   10.475688] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
[   10.477518] mousedev: PS/2 mouse device common for all mice
[   10.581975] psmouse serio2: trackpoint: ALPS TrackPoint firmware:
0x01, buttons: 3/3
[   10.619066] input: TPPS/2 ALPS TrackPoint as
/devices/rmi4-00/rmi4-00.fn03/serio2/input/input19

[1]
for reference the branch I built:
https://github.com/gdamjan/linux/commits/linux-4.15.x-thinkpad

[2]
synaptics: X1 Carbon (5th gen) supports rmi4_smbus
https://github.com/gdamjan/linux/commit/fa6b3c893bea6d017b575438a4b367f2a7fc7717

-- 
damjan
