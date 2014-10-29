From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: About Dell Inspiron 3442 touchpad
Date: Tue, 28 Oct 2014 21:40:18 -0400
Message-ID: <CAN+gG=Hke079n9KgiYQZVDfN9h=qqG7CEYkmXXpT8kw_AewTsQ@mail.gmail.com>
References: <1414544444.169720.184461733.4C6DF47C@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:56859 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbaJ2BkT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 21:40:19 -0400
Received: by mail-qg0-f46.google.com with SMTP id i50so601063qgf.5
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 18:40:19 -0700 (PDT)
In-Reply-To: <1414544444.169720.184461733.4C6DF47C@webmail.messagingengine.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Luiz,

On Tue, Oct 28, 2014 at 9:00 PM, Luiz Carlos Ramos
<lramos.prof@yahoo.com.br> wrote:
> Hello,
>
> I'm trying to make a touchpad from a Dell Inspiron I14-3442 laptop work.
>
> Some details:
>
> - I'm using plain Slackware64 14.1, but raised the kernel to 3.16.3 for
> tests
>
> - xinput ignores the touchpad; it shows only a USB mouse/keyboard
> adapter and the laptop's keyboard:
>
> root@pace:/sys/bus/hid/devices# xinput
>  Virtual core pointer                            id=2    [master pointer
>   (3)]
>      Virtual core XTEST pointer                      id=4    [slave
>      pointer  (2)]
>      Generic USB K/B                                 id=12   [slave
>      pointer  (2)]
>   Virtual core keyboard                           id=3    [master
>   keyboard (2)]
>       Virtual core XTEST keyboard                     id=5    [slave
>       keyboard (3)]
>       Power Button                                    id=6    [slave
>       keyboard (3)]
>       Video Bus                                       id=7    [slave
>       keyboard (3)]
>       Power Button                                    id=9    [slave
>       keyboard (3)]
>       Sleep Button                                    id=10   [slave
>       keyboard (3)]
>       Integrated_Webcam_HD                            id=13   [slave
>       keyboard (3)]
>       AT Translated Set 2 keyboard                    id=14   [slave
>       keyboard (3)]
>       Dell WMI hotkeys                                id=15   [slave
>       keyboard (3)]
>       Video Bus                                       id=8    [slave
>       keyboard (3)]
>       Generic USB K/B                                 id=11   [slave
>       keyboard (3)]
>
> - it seems Ubuntu certified this machine (check
> http://www.ubuntu.com/certification/hardware/201402-14674/components/),
> but it assumes the touchpad is PS/2. I haven't found it as a PS/2 thing,
> even loading psmouse.ko, or doing other tricks
>
> - some articles lists some tips for making it work (like
> http://askubuntu.com/questions/134627/how-do-i-get-the-touchpad-settings-working-on-a-dell-xps-13-ultrabook,
> or https://bugzilla.redhat.com/show_bug.cgi?id=1048314#c2), but I read
> them carefully, made some tests, and they didn't work. One article says
> I could blacklist i2c_hid or like in order to make the bring up the
> touchpad in PS/2 mode, but I couldn't succeed doing so
>
> - at Dell's site, it is offered a driver for Ubuntu 12.04, but it's
> almost obsolete. It seems to be just merged into the kernel
>
> - from Windows 8.1, which runs in the same machine (dual boot), I
> concluded the proper way of making it work is to use HID over I2C. It
> seems that there are two components loaded; one I2CHID, and a Synaptics
> HID. This makes me hint it may be a Synaptics device

Well, if this is a Synaptics HID over I2C device, it should be handled
by hid-rmi in recent kernels (or hid-multitouch but I would say
hid-rmi in your case).
Is the hid-rmi module loaded? Can we get a dmesg output so we can see
if there is any problem?

>
> - it seems there are two I2C busses in the machine. One is related to
> the Intel video graphics subsystem (i801). The other seems to be linked
> to the touchpad (i2c_designware_platform). I'm not sure that latest kmod
> (i2c_designware_platform) is the right one to be used in this case, but
> it appears to be working:

Yeah, i2c_designware_platform is pretty common for Haswell processors.

>
> root@pace:/sys/bus/i2c/devices# ls -l /sys/bus/i2c/devices
> total 0
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-0 ->
> ../../../devices/pci0000:00/INT33C2:00/i2c-0
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-1 ->
> ../../../devices/pci0000:00/INT33C3:00/i2c-1
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-2 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-2
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-3 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-3
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-4 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-4
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-5 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-5
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-6 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-6
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-7 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-7
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-8 ->
> ../../../devices/pci0000:00/0000:00:02.0/i2c-8
> lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-DLL0652:00 ->
> ../../../devices/pci0000:00/INT33C3:00/i2c-1/i2c-DLL0652:00

This one is the touchpad.

>
> root@pace:/sys/bus/i2c/devices# lsmod | grep i2c
> i2c_hid                10682  0
> hid                    94632  3 i2c_hid,hid_generic,usbhid
> i2c_dev                 5739  0
> i2c_designware_platform     3189  0
> i2c_i801               13732  0
> i2c_designware_core     6045  1 i2c_designware_platform
> i2c_algo_bit            5351  1 i915
> i2c_core               35216  11
> drm,i915,i2c_i801,i2c_dev,i2c_hid,i2c_designware_platform,drm_kms_helper,i2c_algo_bit,v4l2_common,synaptics_i2c,videodev
>
> - in the HID /sys directory, there are three devices. Two are related to
> a keyboard/mouse USB adapter. The third seems to be the linked to the
> touchpad:
>
> root@pace:/sys/bus/hid/devices# ls -l /sys/bus/hid/devices
> total 0
> lrwxrwxrwx 1 root root 0 Out 28 22:40 0003:13BA:0017.004F ->
> ../../../devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.3/3-1.3:1.0/0003:13BA:0017.004F
> lrwxrwxrwx 1 root root 0 Out 28 22:40 0003:13BA:0017.0050 ->
> ../../../devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.3/3-1.3:1.1/0003:13BA:0017.0050
> lrwxrwxrwx 1 root root 0 Out 28 22:40 0018:06CB:2985.0052 ->
> ../../../devices/pci0000:00/INT33C3:00/i2c-1/i2c-DLL0652:00/0018:06CB:2985.0052

This is the HID over I2C touchpad.

>
> - when I load the kernel module i2c-hid.ko (with debug=1), I read this
> in dmesg:
>
> [146172.568787] i2c_hid i2c-DLL0652:00: Fetching the HID descriptor
> [146172.568791] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=20 00
> [146172.574806] i2c_hid i2c-DLL0652:00: HID Descriptor: 1e 00 00 01 85
> 00 21 00 24 00 20 00 25 00 17 00 22 00 23 00 cb 06 85 29 00 00 00 00 00
> 00
> [146172.574845] i2c_hid i2c-DLL0652:00: entering i2c_hid_parse
> [146172.574847] i2c_hid i2c-DLL0652:00: i2c_hid_hwreset
> [146172.574849] i2c_hid i2c-DLL0652:00: i2c_hid_set_power
> [146172.574850] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=22 00 00
> 08
> [146172.575436] i2c_hid i2c-DLL0652:00: resetting...
> [146172.575442] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=22 00 00
> 01
> [146172.576113] i2c_hid i2c-DLL0652:00: __i2c_hid_command: waiting...
> [146172.577414] i2c_hid i2c-DLL0652:00: __i2c_hid_command: finished.
> [146172.577417] i2c_hid i2c-DLL0652:00: asking HID report descriptor
> [146172.577419] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=21 00
> [146172.581072] i2c_hid i2c-DLL0652:00: Report Descriptor: 05 01 09 02
> a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02
> 95 06 81 01 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0 06 00
> ff 09 01 a1 01 85 09 09 02 15 00 26
> [146172.581126] i2c_hid i2c-DLL0652:00: i2c_hid_set_power
> [146172.581129] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=22 00 01
> 08

Everything is fine, this is the normal behavior while connecting a
i2c_hid device.
Normally, we should have then hid-rmi asking for more things and then
it will eventually set up the input device.

>
> I am aware this information probably is not sufficient to draw any
> conclusions, but I'd appreciate to hear from someone who knows i2c_hid
> in detail what steps I should take next. For me the last command timed
> out or got stuck, but I haven't checked the code to see if it's the
> case. Anyway, if it was a timeout case, it should have something logged
> after the time expired.

There is no answer from the device when a SET_POWER is emitted. So
this is not a timeout problem.

If hid-rmi is compiled and is not taking the device, we have a big
problem, but for now, the symptoms look like you do not have this
driver compiled and hid-generic does not bind the device because it
waits for hid-rmi to handle it.

>
> I have some programming skills, and so if it's the case of applying any
> patches, or recompiling the kernel or any subsystem to make tests, I'm
> up to.

Cool, thanks.

Cheers,
Benjamin
