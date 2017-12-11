From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Mon, 11 Dec 2017 15:23:25 -0800
Message-ID: <CANRwn3SA8ABi++jsv=pE70scjvnMurwnmpL5nicd_g=9a-Tr8Q@mail.gmail.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
 <cae6e993-80af-9acd-b52f-34e493908820@scrye.com> <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
 <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com> <CANRwn3SWMhrodDbgDn3WzzwEZcgvdo_vWndesD=O87JiEBWAyg@mail.gmail.com>
 <20350601-a07b-aab8-f16e-6d25344efb22@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:46608 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLKXX1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 18:23:27 -0500
Received: by mail-ua0-f170.google.com with SMTP id t24so13175141uaa.13
        for <linux-input@vger.kernel.org>; Mon, 11 Dec 2017 15:23:27 -0800 (PST)
In-Reply-To: <20350601-a07b-aab8-f16e-6d25344efb22@scrye.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Mon, Dec 11, 2017 at 1:03 PM, Kevin Fenzi <kevin@scrye.com> wrote:
> On 12/11/2017 10:19 AM, Jason Gerecke wrote:
>>
>> Thanks for the sysinfo output :) It looks like your system has the
>> sensor connected through a designware I2C controller. The only place I
>> see EREMOTEIO used within the designware driver is to signal that it
>> got a NAK at some point during the transfer. It is supposed to print
>> out additional details using dev_dbg, but that won't be useful until
>> the "Operation not permitted" error is overcome.
>>
>> Some NAK conditions are transient, so its possible that our driver
>> just needs to retry the command. Please read the page at [1] for
>> instructions to compile out out-of-tree version of the wacom driver.
>> In place of the "Download" instructions on that page, use the
>> "Development" instructions. Once you're set, apply the attached patch
>> by running `git am /path/to/file.patch` from within the input-wacom
>> directory. Compile the driver and then load it in place of the system
>> driver by running `sudo modprobe -r wacom && sudo insmod
>> 4.5/wacom.ko`. Check to see if there's any interesting dmesg output
>> and if the pen works.
>>
>> [1]: http://linuxwacom.sourceforge.net/wiki/index.php/Input-wacom
>
> So, not much change in dmesg:
>
> [Mon Dec 11 12:38:16 2017] wacom: loading out-of-tree module taints kerne=
l.
> [Mon Dec 11 12:38:16 2017] wacom: module verification failed: signature a=
nd/or required key missing - tainting kernel
> [Mon Dec 11 12:38:18 2017] input: Wacom HID 5110 Pen as /devices/pci0000:=
00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0018:056A:5110.0003/=
input/input24
> [Mon Dec 11 12:38:18 2017] input: Wacom HID 5110 Finger as /devices/pci00=
00:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0018:056A:5110.00=
03/input/input25
> [Mon Dec 11 12:38:18 2017] wacom 0018:056A:5110.0003: hidraw3: I2C HID v1=
.00 Mouse [WCOM5110:00 056A:5110] on i2c-WCOM5110:00
> [Mon Dec 11 12:38:20 2017] i2c_hid i2c-WCOM5110:00: failed to set a repor=
t to device.
> [Mon Dec 11 12:38:20 2017] wacom 0018:056A:5110.0003: wacom_set_report: r=
an out of retries (last error =3D -121)
> [Mon Dec 11 12:38:20 2017] i2c_hid i2c-WCOM5110:00: failed to set a repor=
t to device.
>
> However, the pen now works. ;)
>

\o/

Guess I'll have to add EREMOTEIO to our whitelist of "things to retry on"..=
.

> The tablet/stylus doesn't show up in gnome prefs oddly, but that could be
> a problem in the stack somewhere. ;(
>
> kevin
>
>

GNOME only shows devices that have a libwacom entry, so we'll need to
add one for your device. The sysinfo output you gave should be enough
for me to whip one up. Go ahead and file a bug at
https://github.com/linuxwacom/libwacom/issues with a link to your
wacom-hid-descriptors bug in case somebody else gets to it before me.
If I don't get to it myself in the next few days, please do poke me :)

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
