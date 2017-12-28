From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Thu, 28 Dec 2017 18:56:36 +0800
Message-ID: <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
References: <20171228091125.GA743@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdL1K4p (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Dec 2017 05:56:45 -0500
In-Reply-To: <20171228091125.GA743@marax.lan.yath.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

I haven't met your issue on X1 Carbon 5th, but Lenovo did ship different
touchapd/trackpoint on X1 Carbon 5th. And you didn't provide the whole
dmesg with pnd ID in it. so I can't tell if the hardware or firmware is
the same as I tested.

Could you try smbus mode first on mainline kernel?

1, download kernel package from:
http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.15-rc5/
   I am not sure if it can be installed and work well on debian.
   It enabled RMI4_SMB and SYNAPTICS_SMBUS.
2, boot with this kernel with "psmouse.synaptics_intertouch=1" in your
kernel cmdline.

If trackpoint still can not work, please send me the dmesg.

Regards,
Aaron

On 12/28/2017 05:11 PM, Sebastian Schmidt wrote:
> Hi,
> 
> in ec667683c532c93fb41e100e5d61a518971060e2, the ThinkPad X1 Carbon
> Gen5’s trackpoint was made recognized as a trackpoint instead of a
> generic PS/2 mouse.
> 
> However, starting with this commit, my trackpoint is *way* too
> sensitive. Changing the sensitivity in
> /sys/devices/platform/i8042/serio1/serio2 did have an effect on my
> pointer, but changing the speed (to any, even the same) value results
> in:
> 
> [  229.845014] psmouse serio2: Failed to enable mouse on synaptics-pt/serio0
> 
> I can reproduce this with:
> # cat /sys/devices/platform/i8042/serio1/serio2/speed
> 97
> # echo 97 > /sys/devices/platform/i8042/serio1/serio2/speed
> [a noticeable delay]
> #
> 
> Afterwards, the pointer jumps around briefly and one or two clicks are
> generated. Furthermore, actually clicking with the left trackpoint
> button (the one below the space bar) generated some other input event
> that let rxvt-unicode send a SIGINT to the running process. I can
> provide more details on that behaviour if it helps.
> 
> dmesg:
> | [    0.000000] Linux version 4.15.0-rc5 (yath@marax) (gcc version 7.2.0 (Debian 7.2.0-18)) #2 SMP Sun Dec 24 18:08:06 CET 2017
> | […]
> | [    0.900182] serio: i8042 KBD port at 0x60,0x64 irq 1
> | [    0.900199] serio: i8042 AUX port at 0x60,0x64 irq 12
> | [    0.900521] mousedev: PS/2 mouse device common for all mice
> | [    0.902025] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> | […]
> | [    1.920218] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4760]
> | [    1.952234] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1094..]
> | [    1.952242] psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
> | [    2.015302] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf002a3/0x940300/0x12e800/0x400000, board id: 3289, fw id: 2492434
> | [    2.015315] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> | [    2.055296] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
> | [    2.342490] psmouse serio2: trackpoint: failed to get extended button data, assuming 3 buttons
> | […]
> | [    5.836251] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x04, buttons: 3/3
> | [    6.038877] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input3
> 
> Regarding the “use better bus than PS/2” message, the .config is based
> on Debian’s config-4.14.0-1-amd64 (yes ""|make oldconfig) and therefore
> pretty generic.
> 
> % grep -E 'MOUSE_PS2_SYNAPTICS_SMBUS|RMI4_SMB' /boot/config-4.15.0-rc5
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> # CONFIG_RMI4_SMB is not set
> %
> 
> The message only talks about Touchpads and not Trackpoints, so I’m not
> sure whether this is an issue. I should also point out that I’m keeping
> the Touchpad disabled with ‘xinput disable "SynPS/2 Synaptics TouchPad"’
> in my ~/.Xsession.
> 
> dmidecode:
> 
> | Handle 0x000B, DMI type 0, 24 bytes
> | BIOS Information
> |         Vendor: LENOVO
> |         Version: N1MET39W (1.24 )
> |         Release Date: 09/27/2017
> |         Address: 0xE0000
> |         Runtime Size: 128 kB
> |         ROM Size: 16 MB
> | […]
> | Handle 0x000C, DMI type 1, 27 bytes
> | System Information
> |         Manufacturer: LENOVO
> |         Product Name: 20HRCTO1WW
> |         Version: ThinkPad X1 Carbon 5th
> |         Serial Number: [stripped]
> |         UUID: [stripped]
> |         Wake-up Type: Power Switch
> |         SKU Number: LENOVO_MT_20HR_BU_Think_FM_ThinkPad X1 Carbon 5th
> |         Family: ThinkPad X1 Carbon 5th
> | 
> | Handle 0x000D, DMI type 2, 15 bytes
> | Base Board Information
> |         Manufacturer: LENOVO
> |         Product Name: 20HRCTO1WW
> |         Version: SDK0J40697 WIN
> |         Serial Number: L1HF71L0014
> |         Asset Tag: Not Available
> |         Features:
> |                 Board is a hosting board
> |                 Board is replaceable
> |         Location In Chassis: Not Available
> |         Chassis Handle: 0x0000
> | 
> | Handle 0x000E, DMI type 3, 22 bytes
> | Chassis Information
> |         Manufacturer: LENOVO
> |         Type: Notebook
> |         Lock: Not Present
> |         Version: None
> |         Serial Number: [stripped]
> |         Asset Tag: No Asset Information
> |         Boot-up State: Unknown
> |         Power Supply State: Unknown
> |         Thermal State: Unknown
> |         Security Status: Unknown
> |         OEM Information: 0x00000000
> |         Height: Unspecified
> |         Number Of Power Cords: Unspecified
> |         Contained Elements: 0
> |         SKU Number: Not Specified
> | […]
> | Handle 0x0031, DMI type 21, 7 bytes
> | Built-in Pointing Device
> |         Type: Track Point
> |         Interface: PS/2
> |         Buttons: 3
> | 
> | Handle 0x0032, DMI type 21, 7 bytes
> | Built-in Pointing Device
> |         Type: Touch Pad
> |         Interface: PS/2
> |         Buttons: 2
> |
> 
> I couldn’t find any debugging knobs in input/trackpoint.c, but let me
> know if I can provide additional information.
> 
> Thanks!
> 
> Sebastian
> 
