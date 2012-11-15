From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] HID: wiimote: add Nintendo-Wii-Remote-Plus IDs
Date: Thu, 15 Nov 2012 13:36:40 +0100
Message-ID: <CANq1E4QAT6QLXFJyHvOmBmYBq3pu3pQGKpCrG=0CCe1Ttrxmpg@mail.gmail.com>
References: <1350895071-4017-1-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1210221134580.12268@pobox.suse.cz>
	<CAEfj2kDDyXbLcJTrhmbrG2MedVcu9u5q6ZmfcRB-86Cc1Rm+Sw@mail.gmail.com>
	<CANq1E4TJPs0nHVmECkQU7pth6a7Dj7G6Pan00w+12FmhiVPpeA@mail.gmail.com>
	<CAEfj2kBMzvSF7XswQC7s_AuKJFnhtwAyXeM77wtRmKSM89UR6Q@mail.gmail.com>
	<CAEfj2kBfjzVp7+Zw+Cn2QfD_eCNz=Z5c1j-ku5vHxL5W-Zb_QA@mail.gmail.com>
	<CANq1E4T+s4igeAj-YN7nW=37UKcprmU_V9JgyML+H5E8eL3fLg@mail.gmail.com>
	<CAEfj2kC7hFeTpCSz+w9=HWG1qKrSY6x5FSo9kHwcqkWoEca+pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49235 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993283Ab2KOMgm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Nov 2012 07:36:42 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so927048eek.19
        for <linux-input@vger.kernel.org>; Thu, 15 Nov 2012 04:36:40 -0800 (PST)
In-Reply-To: <CAEfj2kC7hFeTpCSz+w9=HWG1qKrSY6x5FSo9kHwcqkWoEca+pQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Olson <peter.olson@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Peter

On Tue, Nov 13, 2012 at 3:53 AM, Peter Olson <peter.olson@gmail.com> wrote:
> RE: flashing LEDs, the LEDs are always flashing every connect. I
> haven't had them once switch from all-flashing to having only LED1 (or
> just any single LED) lit. Also, I've never heard of / used the sysfs
> API, so I don't know how to test controlling the LEDs directly.

That doesn't sound right. Looks like they changed the protocol with
the new Wii Remotes. Or at least our implementation is not compatible
with them.

> RE: dolphin-emu, Ok, after we have all the kinks worked out here, I'll
> approach them separately to try and get their code updated.
>
> RE: xwiishow, I use it by executing [xwiishow list] as a regular user.
> I tried it as root once, just out of curiosity, but that made no
> difference.
>
> $ ls -l /sys/bus/hid/devices/
> total 0
> lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C068.0003 ->
> ../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8:1.0/0003:046D:C068.0003
> lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C068.0004 ->
> ../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8:1.1/0003:046D:C068.0004
> lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C31C.0001 ->
> ../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.5/4-1.5:1.0/0003:046D:C31C.0001
> lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C31C.0002 ->
> ../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.5/4-1.5:1.1/0003:046D:C31C.0002
> lrwxrwxrwx 1 root root 0 Nov 12 18:27 0005:057E:0330.0009 ->
> ../../../devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009

Yeah, the last device is the right device. It's the VID/PID
information, not the btaddr, you're right.

> $ xwiishow /sys/bus/hid/devices/0005:057E:0330.0009
> Cannot open core iface '/sys/bus/hid/devices/0005:057E:0330.0009' err:-13

That's EACCES, you need to run it as root.

> $ sudo xwiishow /sys/bus/hid/devices/0005:057E:0330.0009
> Cannot open core iface '/sys/bus/hid/devices/0005:057E:0330.0009' err:-22

22 is EINVAL. After looking into libxwiimote I know understand the
problem. I use the VID/PID information to detect the devices there.
That doesn't work if you use other IDs.

Can you change ./xwiimote/lib/xwiimote.h line 32/33:

#define XWII_ID_VENDOR>->-------0x057e
#define XWII_ID_PRODUCT>>-------0x0306

to:

#define XWII_ID_VENDOR>->-------0x057e
#define XWII_ID_PRODUCT>>-------0x0330

This should work. If it still returns EINVAL, then simply remove all
tests in ./xwiimote/lib/*.c that use these IDs. They're only used for
forward-compatibility if the IDs change and we modify APIs.

> Speaking of fun dmesg messages, I got this when I tried re-connecting
> my wiimote after connecting and disconnecting it as shown just above:
> http://pastebin.com/ehjvfpcf

Yeah, the linux bluetooth kernel modules have a lot of bugs in the HID
layer. I reported them like 2 years ago but they keep on breaking
these. It's like if you connect more than 1 device, their module shows
these bugs.

It's all on my TODO list but I currently have no time to fix the
Bluetooth layer. Feel free to report this to
linux-bluetooth@vger.kernel.org. This isn't related to this driver at
all. I am sorry for that.

> I get a similar looking dump if I try connecting again, and now
> bluetooth is just confused on my machine. I'll have to reboot before
> trusting any further output from the computer on this mater.
>
> Hopefully the early part of this email will help you solve the general
> issue (with xwiishow and such). Please let me know if I should worry
> about the crash-dump in the later part of this email, or if I should
> just reboot and ignore it for now.

Easiest way is simply rebooting and then retrying it. But with the
changes to xwiimote above, you should now be able to use xwiishow.

Thanks
David
