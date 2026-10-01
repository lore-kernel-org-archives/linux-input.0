Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5654248BB
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843043; cv=pass; b=T0WTWi52ClOBPAxR6y7n887y6FI0abCYN1fThA08qkDvQyiv5PHtUOcC8qAPCcjhtEQf80Dw4Q/b0ZO0I7hTYm6JW+BFi3mc49NLlVRKMq7mPTc+HB7R3/D7w9iUN2eXjCFUdFyFZjMzAceKg15C/5MkaGe2bnpWI9zmdJN1chY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843043; c=relaxed/simple;
	bh=5wfXFQSdx3WuVWYA28wHEm9CVrqHnPJe5SbssuBgSWI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VSYdK5IfI91FKULfBwBFulsud5RzlnytLI8MdNIM2xcfXF8nzDMiWJAZ8ejsIetaxT33wbKQmN0dKnaaRL8z/jrRL35c9ozbAUvvgxJuBS1N2GWyCoobafOZSBrV7y8cIHy1WRXXyQfD7KQr7A2vk3N7qdN+Esywiqb2YxCIAgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh4pVjeM; arc=pass smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh4pVjeM"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccfbaf6da8so1413230e0c.0
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 01:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790843039; cv=none;
        d=google.com; s=arc-20260327;
        b=UTYWFLEntY3PnwJcTpKud05tkP6pN/rDXgGeglDujMWTU7HqxKMXe5m3+xZxjOkg6A
         xKSqQ+GykFFR+78Kvo4e4EPA/V8bjsYH0EWW0EEyHRCbZcb/0dSBtPvy+pHI4eeaIzN8
         Dauj8x8zDvV0T7TfMaqQ3mdg5X28jkx+Vj5AJX11BCOJuf2oGZqyhrF+Zfnye1BZDca0
         h6PezW59WYX+b/HEaLRkEAczwUoKUNZ4GtW72YUrkIheabOr6xjqtPw9ca50SaiFHwD+
         EU1yOEHlaPBYgvoPo7zgNmOOtgJFTGPZBAKI6CcHpKN8E9SVQWuSsunkAIln35LCOK/V
         H2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=xDejQYLP0RgzVW8zV0eI/To/31/sQ7FepbOUK+nQZNk=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=eZgibZHOsnYYh3Vl3Y2/Dvpui/auXmADF6G5iIwLCD9kg5nwKYM20//zuK2JVQey6g
         D05KMu6Gd0p4aiFrmv4auelvwxicQjYTErtfkd+VkxkACxXvEGZEJKcwnHzZKsudwJGf
         Br+wOYtRwVgW99RxTSjkdVgViJ7il6hHe370goZ7RuV8TBFFsZ3Xt1KrAAGhSQeIpl1u
         LfvgNVuYvJpxhmt6pwSlC9HYENEtS7qKp5F3JnyF6RfHZ8MXy84JotpS6yAuseQwWQhg
         UW/3kFoRoHu8GxEGaaRRVG9E6liL3WfQx6XUMmaowpaIH+Yb37GMYSFfMypK4gclmmpM
         Rj/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790843039; x=1791447839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDejQYLP0RgzVW8zV0eI/To/31/sQ7FepbOUK+nQZNk=;
        b=Gh4pVjeMtMzDmywYHci6CkEa/1D+/+XPwbGXqu7Q7Zrya88IL8Cy/Hww3RYXo4ww0D
         Oc2E3EtZ2Bg9rXsFRP5bRM9ghONcirp9TamexF408CpOd/+ZPhIJ9/43qhDzL2u2InHh
         8IaDMgbujeCiYH5IyjtOggxi5SGEg3ZtKZcVeebE4minOkKHfs/EffCJ+1fdc6AYKsiB
         PSY2cu8vAvvdgKkPMlmViu9Dx0jmYHi8pte91gzy2j/6AogbeaCdQyLN06IDdl1I5x9L
         ZkLYYLSmaOIM2s/KOVhrwG3BEs+4XPUer1zuq7RDv8fxdK3NqSOhf8y/89lc1m0SUgoy
         H9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790843039; x=1791447839;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDejQYLP0RgzVW8zV0eI/To/31/sQ7FepbOUK+nQZNk=;
        b=lyOJ98exomZE4AbcVaqep7fMksQd8Qe5UP4RFH8Va1yrl2O07WW+pZ62pCwcsJMvHc
         Kv4H5ipRrmFlvWjWv6ZASmq6vFZLiE2Ozj0Vvp4q84SXczBoR6QWfUNNF1C6qoDh5hqR
         QTi1nPD0r72ains+tY2EvRk2GjZwfgErsfiaUA+JOsMSUGxZiLTXtOpeL8Kbk7kl437M
         KKXfiam2GIgw2Yo5jdwu35bv2KrAIEL813FPHhyc5kclBqpjO1qnJgGSQiz/1lOYq9D0
         t/NYyAZV7by6/OTQIisxknGiTw3YpsiUbV0igpaINhmzW4XBVrjTlRA/a6dZ3sqDq5ri
         W/mw==
X-Gm-Message-State: AFq9FYIU9UBm963E9dsSnowOR8u7QK+aY0icGKeBRoJ2Q8kG1YI8w1Nq
	ShHyzPhV7eHJUIyj2g0X6SCgQH5VlxcpQYT2jBItRhWn1PJtm1smXMkEA3bCTOyUegoQoiPKDxm
	8QqI0pZFGZo/4c0ioy1JwzzgG2/dJ15kS6D6+
X-Gm-Gg: AYBFou0lKiSL4t6t5zSTiuHds/16I4qUaVndahxraUElBs3jiTq6btwjSBUn2tyOGet
	s378Sb93KL+3BCa+6enPRcQffUSmlp+73SQdMJ9eamEnlxZ9M58eASC3UN7ivMn5U1gqOuBoAFg
	6Lz42hXZ86rvDa9GqAnxmrI3tz3egJ8J7F16ctpM6xKVBZN7wJ+lk7IOOsj4OraS7qRJv8styzL
	u5kUPWy7W2RSYElUGOiSRB7R2POPvkfvbuk8i+2Klf/oQ675G9SJ0JLP6bdatAH4uXOtHjE+d2c
	QH9uBP84PALPG6NxO8uzQmQhn4komu0tMd6ULIjRlGkQ4rN/zZ8TN3f2oiqPPaRah4gAMZRA3zr
	jxIHinceaaWWdVoj4eAF4zwA4kvI6YRGJFVbexCOjkJY=
X-Received: by 2002:a05:6122:513:b0:5ce:d56f:efa6 with SMTP id
 71dfb90a1353d-5d7ae169825mr698757e0c.2.1790843038586; Thu, 01 Oct 2026
 01:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Saeed Alian <aliansaeed82@gmail.com>
Date: Thu, 1 Oct 2026 11:53:44 +0330
X-Gm-Features: AclHuK_AwvLYH6AlAqDRt4j72eNot74EsMEjiV3w__LpKF0u8yJviEBVeooWXZw
Message-ID: <CAOjs+X2drSJrBVfcvhHuVzYXouvGnbpTZyvohA_bDHHmTgp2cw@mail.gmail.com>
Subject: Re: [update] psmouse/synaptics: "lost sync at byte 1" + 1s touchpad
 freeze after keyboard use, ThinkPad T14 Gen 1 AMD (LEN2064)
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have confirmed the issue:

When I press the bottom of the keyboard (space key) the trackpoint
(the nipple on the thinkpad) will get frozen (I proved this in BIOS
menu, Windows and Lenovo Diagnostics app) and in Windows or BIOS menu,
if the trackpoint gets frozen, the touchpad still works, but in Linux,
we get the psmouse 'lost sync' error and both touchpad and trackpoint
get frozen.

On Tue, Sep 29, 2026, 7:54=E2=80=AFPM Saeed Alian <aliansaeed82@gmail.com> =
wrote:
>
> Hello,
>
> My ThinkPad T14 Gen 1 (AMD) has a touchpad that freezes for about 1 secon=
d
> after keyboard use. It does not happen on Windows 11 on the same machine.
>
> Hardware/Software:
>
> Laptop: Lenovo ThinkPad T14 Gen 1 (AMD), Ryzen 5 PRO 4650U, 16 GB
> BIOS: R1BET87W (1.56), firmware up to date
> Touchpad: Synaptics, PNP: LEN2064 PNP0f13 (PS/2, serio1)
> TrackPoint: Elan, fw 0x12 (serio2, via Synaptics pass-through)
> System: Devuan (Debian 13 based), runit, X11 + bspwm
> Kernels: 6.12.107+deb13-amd64 (Debian), and [Arch kernel version], both a=
ffected
>
> Symptom:
>
> When I type and then start using the touchpad, the pointer freezes for
> about 1 second and then recovers. It happens most of the time after
> keyboard use, but is somewhat random. Otherwise the touchpad works.
>
> psmouse dmesg at boot:
>
> [    1.629431] psmouse serio1: synaptics: queried max coordinates: x
> [..5678], y [..4694]
> [    1.668582] psmouse serio1: synaptics: queried min coordinates: x
> [1266..], y [1162..]
> [    1.668604] psmouse serio1: synaptics: Your touchpad (PNP: LEN2064
> PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
> are not used, you might want to try setting
> psmouse.synaptics_intertouch to 1 and report this to
> linux-input@vger.kernel.org.
> [    1.735086] psmouse serio1: synaptics: Touchpad model: 1, fw:
> 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
> id: 3471, fw id: 3972349
> [    1.735110] psmouse serio1: synaptics: serio: Synaptics
> pass-through port at isa0060/serio1/input0
> [    2.330797] psmouse serio2: trackpoint: Elan TrackPoint firmware:
> 0x12, buttons: 3/3
>
> and dmesg when a freeze happens:
>
> [   33.971790] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> sync at byte 1
> [   33.972796] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> sync at byte 1
> [   33.975158] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> sync at byte 1
> [   33.982765] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> sync at byte 1
> [   33.985432] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> sync at byte 1
> [   33.985443] psmouse serio1: issuing reconnect request
> [   34.788737] psmouse serio1: synaptics: queried max coordinates: x
> [..5678], y [..4694]
> [   34.829578] psmouse serio1: synaptics: queried min coordinates: x
> [1266..], y [1162..]
>
> so I tried using psmouse.synaptics_intertouch=3D1 in /etc/default/grub:
>
> GRUB_CMDLINE_LINUX_DEFAULT=3D"loglevel=3D1 nowatchdog quiet
> udev.log_level=3D1 psmouse.synaptics_intertouch=3D1"
>
> and `update-grub` then reboot.
> I got this log in the dmesg:
>
> [ 1.695701] psmouse serio1: synaptics: Trying to set up SMBus access
> [ 1.698722] psmouse serio1: synaptics: SMbus companion is not ready yet
>
> What i tried (no effect unless noted):
>   - psmouse.synaptics_intertouch=3D1
>   - psmouse.synaptics_intertouch=3D0
>   - i8042.nomux=3D1, i8042.reset=3D1, i8042.noloop=3D1, all combinations,
>     with and without intertouch=3D1
>   - psmouse.resetafter=3D10/60/100: no change; =3D0: touchpad stays dead
>   - psmouse.rate=3D50/100
>   - i8042.nopnp, i8042.notimeout, i8042.kbdreset, all combinations.
>   - TrackPoint disabled [BIOS]
>   - processor.max_cstate=3D1
>   - psmouse.proto=3Dimps or exps: freezes stop, but two-finger scrolling
> is lost, which I need.
>   - Windows 11 (all drivers updated): no freeze
>   - Arch with kernel 7.2.2: same freeze
>
> Also here are some commands that I used to debug the whole situation:
>
> `
> > lsmod | grep -E 'i2c|rmi'
> i2c_algo_bit           16384  1 amdgpu
> i2c_piix4              28672  0
> i2c_smbus              16384  1 i2c_piix4
> i2c_scmi               16384  0
>
> > cat /proc/bus/input/devices | grep -A5 -i synaptics
> N: Name=3D"SynPS/2 Synaptics TouchPad"
> P: Phys=3Disa0060/serio1/input0
> S: Sysfs=3D/devices/platform/i8042/serio1/input/input3
> U: Uniq=3D
> H: Handlers=3Dmouse0 event2
> B: PROP=3D5
> --
> P: Phys=3Dsynaptics-pt/serio0/input0
> S: Sysfs=3D/devices/platform/i8042/serio1/serio2/input/input4
> U: Uniq=3D
> H: Handlers=3Dmouse1 event3
> B: PROP=3D21
> B: EV=3D7
> `
>
> installed `i2c-tools`:
>
> `
> > i2cdetect -l
> (got no output)
>
>
>
> > i2cdetect -F 0
> Error: Could not open file /dev/i2c-0' or /dev/i2c/0': No such file or di=
rectory
> `
>
> so I loaded i2c-dev `modprobe i2c-dev`:
>
> `
> > i2cdetect -F 0
> Functionalities implemented by /dev/i2c-0:
> I2C                              yes
> SMBus Quick Command              no
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                yes
> SMBus Block Read                 yes
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  yes
> I2C Block Read                   yes
> SMBus Host Notify                no
> 10-bit addressing                yes
> Target mode                      no
>
>
>
> > i2cdetect -l
> i2c-0   i2c             Synopsys DesignWare I2C adapter         I2C adapt=
er
> i2c-1   smbus           SMBus PIIX4 adapter port 0 at 0b00      SMBus ada=
pter
> i2c-2   smbus           SMBus PIIX4 adapter port 2 at 0b00      SMBus ada=
pter
> i2c-3   smbus           SMBus PIIX4 adapter port 1 at 0b20      SMBus ada=
pter
> i2c-4   i2c             AMDGPU DM i2c hw bus 0                  I2C adapt=
er
> i2c-5   i2c             AMDGPU DM i2c hw bus 1                  I2C adapt=
er
> i2c-6   i2c             AMDGPU DM i2c hw bus 2                  I2C adapt=
er
> i2c-7   i2c             AMDGPU DM i2c hw bus 3                  I2C adapt=
er
> i2c-8   i2c             AMDGPU DM aux hw bus 0                  I2C adapt=
er
> i2c-9   i2c             AMDGPU DM aux hw bus 2                  I2C adapt=
er
> i2c-10  i2c             AMDGPU DM aux hw bus 3                  I2C adapt=
er
>
>
>
> > i2cdetect -F 1
> Functionalities implemented by /dev/i2c-1:
> I2C                              no
> SMBus Quick Command              yes
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                yes
> SMBus Block Read                 yes
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  no
> I2C Block Read                   no
> SMBus Host Notify                no
> 10-bit addressing                no
> Target mode                      no
>
>
>
> > i2cdetect -F 2
> Functionalities implemented by /dev/i2c-2:
> I2C                              no
> SMBus Quick Command              yes
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                yes
> SMBus Block Read                 yes
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  no
> I2C Block Read                   no
> SMBus Host Notify                no
> 10-bit addressing                no
> Target mode                      no
>
>
>
> > i2cdetect -F 3
> Functionalities implemented by /dev/i2c-3:
> I2C                              no
> SMBus Quick Command              yes
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                yes
> SMBus Block Read                 yes
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  no
> I2C Block Read                   no
> SMBus Host Notify                no
> 10-bit addressing                no
> Target mode                      no
> `
>
>
> QUESTIONS
>   1. Is there a known fix or patch for this PS/2 sync loss?
>   2. Is this pad expected to be reachable over SMBus/RMI4 on this
>      platform, and if so what is missing on AMD PIIX4?
>   3. Could this be hardware related, given that Windows is unaffected?
>
> I can provide full dmesg, acpidump and i8042 debug output, and can test
> patches.
>
> Thanks,
> Saeed Alian
