Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2783DC4D9
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699072; cv=pass; b=N37P8gHCrTC8Mnb2dcLqdwUvHPp6vU9Ni3i/CuzELJI5v1VJunUJfA+GdH50/jvHEM/S5hK94hGEuMBsXrYEjDipp/wJyFYxGKyYndl+WY31KFOP2sQO/74/1IO+N5qRdHUfy40dwzyUDxNPCJmVmQXgK4wNs5v33BcG1tc22+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699072; c=relaxed/simple;
	bh=OiFfvlWJs6VF81gj/qO4+BJh04sQYQTdaRDgChDt4T0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ShFIli4KAwgJ36sXmRvu0Ih3qUKJFocvq3mBL+nSTPxVpXO2A00OFa/0oGPq6M5hBZByPNJcthqKH/5nY3B536+fhaC0pBQDzaU9BHhxaOmu/Kui7QXO+ps+tRKqlHGy9uVVAva2TMsddbsEwFxTHI2wY78TWS1lOIvuwcDIfrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O14ajAyI; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O14ajAyI"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7b1e67fcd84so768734137.1
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 09:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699070; cv=none;
        d=google.com; s=arc-20260327;
        b=sVoAM+FzdqpIu81PbTzSzXt9dsDdjUYtMt3XUsXf1J140s/R6sXwAaZpp3veLjKg1p
         vzhFg3cZstAJhoBpyNpEcSAbivFFGqQ0SpKM2lGFx+GwxVOSruWWmeYqJVKKRFcSDcip
         nmS0v0Rt75oFDY+0yUt/aYsv4HBIobmnxhjuXkZgOAAinwwHirWmorvSOCMgtIC8cwYe
         N1Lhxm+98dLkRxG5NIOPOeRB9tAcGQJUvOpcUN80ABCcvpchZeer6rin8ny9kNQAvxJI
         A8XoTRAdrco1T/ib4tIcL2Icvq03qpEl3Rwt/ADeaxVxhts0grx2Yie1NzZp6SRY9fT8
         DWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KRnzn7RtxO1DWD+6hLZa3OrVg6rKZeVOY4ToBS5GP6s=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=UzXj3jDqX6NmbxDwbVGIUQ1RggTOV8YKi3WKRUL/Fsf1gN0IQE+3SHG2yGTt1KNFr/
         VvJus+sRKze9pdoDI8xw0nMyvVBbY1aRu8HA7z983FMxxx1ikHM10okwiyjlB0/F2zl+
         aN6gijrhh735yzZyBAUgHSmepVZ9nBA0QisEBiHYTJQDnRcgi5GyPuwjY1mVJAd+o50c
         oZ8KLgGtSy+lZpH0bXVrQ3MJhPbLykFYjeWlMKfUP3PSHZcq/MTEGU0oyc+Ve5fiHV+O
         B23NENhBx0px6MKHqMoGPkZj114lMXYdXWPXt09MdXJbcumnfa2UTM6Z7z4sUNT/aNFg
         NT5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699070; x=1791303870; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KRnzn7RtxO1DWD+6hLZa3OrVg6rKZeVOY4ToBS5GP6s=;
        b=O14ajAyIquqhlykVUS+flofSHaDqMnczJMf2GlfaNDp4KTeFeoGcU60/LlTblUWQWg
         Muz/SJoOgt9L6dS5BuCAQ+npCLphOs/63ytMK5N7o8dFL3kai3smFJfyOpneCr2WbUHT
         WkizJJAp/wf83Xrad+0v/gE+X6dcTDETXFSKce/RJZw6e09x756aRJxwoN0ZT9vw5iDs
         WrBZeW0iPh2a2CxLdZ9cyDvyrc1p+22XudsYIG3mDtWUZ/7W+RnuXzrG4rmTR76vexl9
         kJSqcjzKDs//shWvZv1LMKA8OqM2Ihy2snwfIgZuudY55w4RckKeDB/8qK4/bUxs01kC
         3nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699070; x=1791303870;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRnzn7RtxO1DWD+6hLZa3OrVg6rKZeVOY4ToBS5GP6s=;
        b=PmfYVXnbT/VK8kbfKs9Na9J/HDhs13pnJgxj8pDoL3B/GiUxhwt01/Hg7RaJgEsZOC
         C9Vv6KzuPJKbA7WIKWRRE1fCC11Z1n9FvU9ftKudHFtvXg9JW+2DiVRzmbnhiEaaem+t
         8MUuNBZwGD3MFbAZz5ZEz/DwLzkGEYn5pUqyP9NBIc7p0wJa4f21oe1bN3dHCu8q6USa
         JElk1t9H7VOLgqmikm9IoorNOZLngTRc4OzJiM4EhfUvQVZuWGq5rMiXDCESFDmrgFRa
         3hyA3co+zi3LXWceHK5BA1aVEw2AaOdRh1NAin3uIP39GefNr1PV1/SJkTMKPdAeGH4V
         yvOw==
X-Gm-Message-State: AFq9FYIEeBcT2o/bpw/FaqyutZNKbIKVHFPO8Y7sRqy7kC7AqJln2xG2
	8tlktENqcv1znUnwY6kVvOuVkU3jwcyaN+8835baGpCoL1pqqdHVbmHETao4uRiE7QrvlGqQdx/
	u6Syl/5GsZiOicVQBfCHuc58dywloEM1XMVyqGj4=
X-Gm-Gg: AYBFou3edIYpsOA/HAmH9aG7K3R1+8MSBwK2gPGhLCU+Xb74jWRs8ajBWPI3k2r3men
	gld5LwxEQrboU+kuS90yNdv5C6dK/4wlb4HNr2aFolQ3i9ydF1Yrq/+dljSoLnNaeANiP+9XXwg
	ptLtcUQgRrpLcyb0GCpTQYy0R56dVwP+QOH4qI9/A/HyCtiHFk6uKs7f2XT0y/mSK5kB+YyLDGb
	wwh5qRXcocBg+ra82BL8tOS3ZQe80t2Wn+HDWC6Bu11pYApZvTttUMuY+rAkvqBuk65d8YcCBss
	iHnjF2twg7kq3Rrg3U7bXwkElpbVfAvAGPo0y4+H+DlfQrlNJa4TjPQ=
X-Received: by 2002:a05:6102:860e:20b0:7a1:f2b5:646a with SMTP id
 ada2fe7eead31-7b950f91f71mr626389137.39.1790699069965; Tue, 29 Sep 2026
 09:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Saeed Alian <aliansaeed82@gmail.com>
Date: Tue, 29 Sep 2026 19:54:18 +0330
X-Gm-Features: AclHuK-DU0mmayqLeQvlWn__Ek_EgqwWDbveo0974IQwMqOtvqfww_GXLfz8vek
Message-ID: <CAOjs+X05nhF7QUM9i7NuBZe-6+rdQ4Ch1LRj31K+-tvTzjLoAA@mail.gmail.com>
Subject: psmouse/synaptics: "lost sync at byte 1" + 1s touchpad freeze after
 keyboard use, ThinkPad T14 Gen 1 AMD (LEN2064)
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

My ThinkPad T14 Gen 1 (AMD) has a touchpad that freezes for about 1 second
after keyboard use. It does not happen on Windows 11 on the same machine.

Hardware/Software:

Laptop: Lenovo ThinkPad T14 Gen 1 (AMD), Ryzen 5 PRO 4650U, 16 GB
BIOS: R1BET87W (1.56), firmware up to date
Touchpad: Synaptics, PNP: LEN2064 PNP0f13 (PS/2, serio1)
TrackPoint: Elan, fw 0x12 (serio2, via Synaptics pass-through)
System: Devuan (Debian 13 based), runit, X11 + bspwm
Kernels: 6.12.107+deb13-amd64 (Debian), and [Arch kernel version], both affected

Symptom:

When I type and then start using the touchpad, the pointer freezes for
about 1 second and then recovers. It happens most of the time after
keyboard use, but is somewhat random. Otherwise the touchpad works.

psmouse dmesg at boot:

[    1.629431] psmouse serio1: synaptics: queried max coordinates: x
[..5678], y [..4694]
[    1.668582] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1162..]
[    1.668604] psmouse serio1: synaptics: Your touchpad (PNP: LEN2064
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[    1.735086] psmouse serio1: synaptics: Touchpad model: 1, fw:
10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
id: 3471, fw id: 3972349
[    1.735110] psmouse serio1: synaptics: serio: Synaptics
pass-through port at isa0060/serio1/input0
[    2.330797] psmouse serio2: trackpoint: Elan TrackPoint firmware:
0x12, buttons: 3/3

and dmesg when a freeze happens:

[   33.971790] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   33.972796] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   33.975158] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   33.982765] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   33.985432] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   33.985443] psmouse serio1: issuing reconnect request
[   34.788737] psmouse serio1: synaptics: queried max coordinates: x
[..5678], y [..4694]
[   34.829578] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1162..]

so I tried using psmouse.synaptics_intertouch=1 in /etc/default/grub:

GRUB_CMDLINE_LINUX_DEFAULT="loglevel=1 nowatchdog quiet
udev.log_level=1 psmouse.synaptics_intertouch=1"

and `update-grub` then reboot.
I got this log in the dmesg:

[ 1.695701] psmouse serio1: synaptics: Trying to set up SMBus access
[ 1.698722] psmouse serio1: synaptics: SMbus companion is not ready yet

What i tried (no effect unless noted):
  - psmouse.synaptics_intertouch=1
  - psmouse.synaptics_intertouch=0
  - i8042.nomux=1, i8042.reset=1, i8042.noloop=1, all combinations,
    with and without intertouch=1
  - psmouse.resetafter=10/60/100: no change; =0: touchpad stays dead
  - psmouse.rate=50/100
  - i8042.nopnp, i8042.notimeout, i8042.kbdreset, all combinations.
  - TrackPoint disabled [BIOS]
  - processor.max_cstate=1
  - psmouse.proto=imps or exps: freezes stop, but two-finger scrolling
is lost, which I need.
  - Windows 11 (all drivers updated): no freeze
  - Arch with kernel 7.2.2: same freeze

Also here are some commands that I used to debug the whole situation:

`
> lsmod | grep -E 'i2c|rmi'
i2c_algo_bit           16384  1 amdgpu
i2c_piix4              28672  0
i2c_smbus              16384  1 i2c_piix4
i2c_scmi               16384  0

> cat /proc/bus/input/devices | grep -A5 -i synaptics
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input3
U: Uniq=
H: Handlers=mouse0 event2
B: PROP=5
--
P: Phys=synaptics-pt/serio0/input0
S: Sysfs=/devices/platform/i8042/serio1/serio2/input/input4
U: Uniq=
H: Handlers=mouse1 event3
B: PROP=21
B: EV=7
`

installed `i2c-tools`:

`
> i2cdetect -l
(got no output)



> i2cdetect -F 0
Error: Could not open file /dev/i2c-0' or /dev/i2c/0': No such file or directory
`

so I loaded i2c-dev `modprobe i2c-dev`:

`
> i2cdetect -F 0
Functionalities implemented by /dev/i2c-0:
I2C                              yes
SMBus Quick Command              no
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               no
SMBus Block Write                yes
SMBus Block Read                 yes
SMBus Block Process Call         no
SMBus PEC                        no
I2C Block Write                  yes
I2C Block Read                   yes
SMBus Host Notify                no
10-bit addressing                yes
Target mode                      no



> i2cdetect -l
i2c-0   i2c             Synopsys DesignWare I2C adapter         I2C adapter
i2c-1   smbus           SMBus PIIX4 adapter port 0 at 0b00      SMBus adapter
i2c-2   smbus           SMBus PIIX4 adapter port 2 at 0b00      SMBus adapter
i2c-3   smbus           SMBus PIIX4 adapter port 1 at 0b20      SMBus adapter
i2c-4   i2c             AMDGPU DM i2c hw bus 0                  I2C adapter
i2c-5   i2c             AMDGPU DM i2c hw bus 1                  I2C adapter
i2c-6   i2c             AMDGPU DM i2c hw bus 2                  I2C adapter
i2c-7   i2c             AMDGPU DM i2c hw bus 3                  I2C adapter
i2c-8   i2c             AMDGPU DM aux hw bus 0                  I2C adapter
i2c-9   i2c             AMDGPU DM aux hw bus 2                  I2C adapter
i2c-10  i2c             AMDGPU DM aux hw bus 3                  I2C adapter



> i2cdetect -F 1
Functionalities implemented by /dev/i2c-1:
I2C                              no
SMBus Quick Command              yes
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               no
SMBus Block Write                yes
SMBus Block Read                 yes
SMBus Block Process Call         no
SMBus PEC                        no
I2C Block Write                  no
I2C Block Read                   no
SMBus Host Notify                no
10-bit addressing                no
Target mode                      no



> i2cdetect -F 2
Functionalities implemented by /dev/i2c-2:
I2C                              no
SMBus Quick Command              yes
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               no
SMBus Block Write                yes
SMBus Block Read                 yes
SMBus Block Process Call         no
SMBus PEC                        no
I2C Block Write                  no
I2C Block Read                   no
SMBus Host Notify                no
10-bit addressing                no
Target mode                      no



> i2cdetect -F 3
Functionalities implemented by /dev/i2c-3:
I2C                              no
SMBus Quick Command              yes
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               no
SMBus Block Write                yes
SMBus Block Read                 yes
SMBus Block Process Call         no
SMBus PEC                        no
I2C Block Write                  no
I2C Block Read                   no
SMBus Host Notify                no
10-bit addressing                no
Target mode                      no
`


QUESTIONS
  1. Is there a known fix or patch for this PS/2 sync loss?
  2. Is this pad expected to be reachable over SMBus/RMI4 on this
     platform, and if so what is missing on AMD PIIX4?
  3. Could this be hardware related, given that Windows is unaffected?

I can provide full dmesg, acpidump and i8042 debug output, and can test
patches.

Thanks,
Saeed Alian
