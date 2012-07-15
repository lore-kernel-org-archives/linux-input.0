From: littlebat <dashing.meng@gmail.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as
 "PS/2 Generic Mouse"(with newly dmesg information)
Date: Sun, 15 Jul 2012 10:15:57 +0800
Message-ID: <20120715101557.e20a039b.dashing.meng@gmail.com>
References: <20120706113942.40152322.dashing.meng@gmail.com>
	<20120706051141.GA2937@thinkpad-t410>
	<20120707133519.25bf82d4.dashing.meng@gmail.com>
	<20120709144508.GB4985@thinkpad-t410>
	<20120710121627.22558c22.dashing.meng@gmail.com>
	<20120710045714.GA3429@ubuntu-mba>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54090 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2GOB5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Jul 2012 21:57:23 -0400
Received: by pbbrp8 with SMTP id rp8so7877219pbb.19
        for <linux-input@vger.kernel.org>; Sat, 14 Jul 2012 18:57:23 -0700 (PDT)
In-Reply-To: <20120710045714.GA3429@ubuntu-mba>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com

On Mon, 9 Jul 2012 23:57:14 -0500
Seth Forshee <seth.forshee@canonical.com> wrote:

> I did a write-up a while back about how I did it.
> http://swapspace.forshee.me/2011/11/touchpad-protocol-reverse-engineering.html

Hi,
I have done some testing on my Lenovo G360 Laptop according to the
instruction above, but it seems can't work as the instruction says.
Here is my steps:

1, Install Ubuntu 11.10 for i386 on laptop.
2, sudo apt-get update
3, sudo apt-get build-dep virtualbox
4, sudo apt-get source virtualbox (download
virtualbox_4.1.2-dfsg-1ubuntu1 source into home folder) 
5, Applied the virtualbox patch "vbox-psmouse-serio-passthrough.patch"
downloaded from instruction page 
6, sudo apt-get -b source virtualbox (this will compile patched source
and generate several deb virtualbox packages into home folder) 
7, sudo dpkg -i virtualbox_4.1.2-dfsg-1ubuntu1_i386.deb
virtualbox-dbg_4.1.2-dfsg-1ubuntu1_i386.deb
virtualbox-dkms_4.1.2-dfsg-1ubuntu1_all.deb
virtualbox-fuse_4.1.2-dfsg-1ubuntu1_i386.deb
virtualbox-qt_4.1.2-dfsg-1ubuntu1_i386.deb (install generated
virtualbox packages) 
8, Installed Windows 7 (or Windows xp SP2, has the
almost same testing result) into VirtualBox virtual machine. 
9, Installed Touchpad driver in Windows 7 in VirtualBox virtual machine.
But, the touchpad still act as a normal ps/2 mouse in Windows in
virtual machine, it misses edge scrolling function although has
installed windows touchpad driver successfully. 
10, Do the test:
y@y-PC:~$ sudo ./psmouse-reverse/mouse-to-serio.sh 1 
y@y-PC:~$ sudo chmod 666 /dev/serio_raw0 
y@y-PC:~$ ls -la /dev/serio*
crw-rw-rw- 1 root root 10, 55 2012-07-14 07:40 /dev/serio_raw0 
y@y-PC:~ $ export PSMOUSE_SERIO_DEV_PATH="/dev/serio_raw0" 
y@y-PC:~$ export
PSMOUSE_SERIO_LOG_PATH="/home/y/psmouse-reverse/reverse.log" 
y@y-PC:~$ virtualbox --startvm w7 ("w7" is my VirtualBox virtual
machine Windows 7 guest OS name)

In the Windows 7 guest OS, the touchpad "Lenovo pointing device"
disappeared from the hardwares list. And, the log file in Ubuntu 11.10
has the content below: 
y@y-PC:~$ cat ./psmouse-reverse/reverse.log 
S ff
R fe
S ff
R fe
S ff
R fe
S ed
R fe

Then, restart Windows 7 guest OS without the environment variables
"PSMOUSE_SERIO_DEV_PATH", "PSMOUSE_SERIO_LOG_PATH", the touchpad
"Lenovo pointing device" appeared in the Windows 7 guest OS hardwares
list. I replaced touchpad "Lenovo pointing device" driver with normal
"Microsoft PS/2 Mouse" driver. Restart Windows 7 guest OS, I can see
"Microsoft PS/2 Mouse" in the hardwares list.

Then, empty the log file "./psmouse-reverse/reverse.log", set
"PSMOUSE_SERIO_DEV_PATH", "PSMOUSE_SERIO_LOG_PATH" environment
variables and restart Windows 7 guest OS.

In the Windows 7 guest OS, "Microsoft PS/2 Mouse" disappeared from the
hardwares list. And, the log file in Ubuntu 11.10 has the content
below: 
y@y-PC:~$ cat ./psmouse-reverse/reverse.log 
S ff
R fe
S ff
R fe
S ff
R fe
S ed
R fe

Note, the content of the log file is same as when enable "Lenovo
pointing device" touchpad driver. And, when enable environment
variables, under  VirtualBox Windows 7 guest OS,  although the device
"Lenovo pointing device" or "Microsoft PS/2 Mouse" disappeared from the
hardwares list, the touchpad can still work as a normal PS/2 mouse in
the Windows 7. But, when I operate touchpad under Windows 7 guest OS,
there isn't any other bit wrote into the log file
"./psmouse-reverse/reverse.log". Only when start virtualbox machine
Windows guest OS, the log file will be written the same eight lines as
above.

I have alse tested "qemu-kvm_0.14.1+noroms-0ubuntu6" with Windows XP
SP2 guest OS installed, the result is same except two points: 
1, When I start guest OS without environment variables, the terminal
output as below: 
y@y-PC:~$ qemu -m 1024 ./QEMU/wxp.img 
open /dev/kvm: No such file or directory Could not initialize KVM, will
disable KVM support 
qemu: ps2 mouse init

qemu: serio_pt_init

qemu: No serio device specified in environment

qemu: pci_add_option_rom: failed to find romfile "pxe-rtl8139.bin"

And, when start it with environment variables set, the terminal output
as below: 
y@y-PC:~$ qemu -m 1024 ./QEMU/wxp.img
open /dev/kvm: No such file or directory
Could not initialize KVM, will disable KVM support
qemu: ps2 mouse init

qemu: serio_pt_init

qemu: pci_add_option_rom: failed to find romfile "pxe-rtl8139.bin"

2, When start qemu windows xp sp2 guest OS with environment variables
set, unlike in the virtualbox Windows guest OS, the touchpad and USB
mouse can't work in the qemu windows xp sp2 guest OS, the cursor can't
move.

Briefly, it seems the instruction at
"http://swapspace.forshee.me/2011/11/touchpad-protocol-reverse-engineering.html"
can't work on my Lenovo G360, is there any thing wrong with me?

Thanks.
