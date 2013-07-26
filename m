From: Rolf Morel <rolfmorel@gmail.com>
Subject: [BUG?] EV_LED events not seperated from other events by SYN_REPORT
Date: Fri, 26 Jul 2013 16:45:09 +0200
Message-ID: <CAFRyfCz4A_o6ECVb34Xf2KEtFh3neAOU4f6cBvevsQA9PJcGtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f68.google.com ([209.85.219.68]:40187 "EHLO
	mail-oa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759039Ab3GZOpK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Jul 2013 10:45:10 -0400
Received: by mail-oa0-f68.google.com with SMTP id n12so573858oag.7
        for <linux-input@vger.kernel.org>; Fri, 26 Jul 2013 07:45:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hello,

I am having some trouble with how device LED switches are being
presented in the, userspace API, event stream.

If a program sets the LED using the evdev interface, write EV_LED
input_event to device, other programs connected to the device will
have the event in their stream, as expected. The problem is the
received EV_LED events are not separated in time, as in moment in
time. It does not generate a separate SYN_REPORT to make the EV_LED
event a separate event in time.

I have only two devices which have this functionality, set LED state
through evdev, to test and they both are 3Dconnexion devices. They
both exhibit the same behavior.

So my questions are:
Is this considered a bug (/should it be filed as a bug)?
Does the fault lie in the input-subsystem or a more specific driver?

Here is some evtest data which has only button BTN_0 presses and a
separate program setting the LED state by writing an input_event
to the device.

$ evtest /dev/input/event7
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x46d product 0xc626 version 0x110
Input device name: "3Dconnexion SpaceNavigator"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 256 (BTN_0)
...
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 8 (LED_MISC)
Properties:
Testing ... (interrupt to exit)
Event: time 1374507104.352812, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507104.352812, type 1 (EV_KEY), code 256 (BTN_0), value 1
Event: time 1374507104.352812, -------------- SYN_REPORT ------------
Event: time 1374507104.504809, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507104.504809, type 1 (EV_KEY), code 256 (BTN_0), value 0
Event: time 1374507104.504809, -------------- SYN_REPORT ------------
...
Switch terminal and run program which sets LED using evdev and
wait 5 seconds before pressing the button.
...
Event: time 1374507117.496465, type 17 (EV_LED), code 8 (LED_MISC), value 1
Event: time 1374507117.496465, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507117.496465, type 1 (EV_KEY), code 256 (BTN_0), value 1
Event: time 1374507117.496465, -------------- SYN_REPORT ------------
Event: time 1374507117.616560, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507117.616560, type 1 (EV_KEY), code 256 (BTN_0), value 0
Event: time 1374507117.616560, -------------- SYN_REPORT ------------

The EV_LED events even accumelate.
Event: time 1374507610.679128, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507610.679128, type 1 (EV_KEY), code 256 (BTN_0), value 1
Event: time 1374507610.679128, -------------- SYN_REPORT ------------
Event: time 1374507610.791126, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507610.791126, type 1 (EV_KEY), code 256 (BTN_0), value 0
Event: time 1374507610.791126, -------------- SYN_REPORT ------------
Event: time 1374507617.247107, type 17 (EV_LED), code 8 (LED_MISC), value 0
Event: time 1374507617.247107, type 17 (EV_LED), code 8 (LED_MISC), value 1
Event: time 1374507617.247107, type 17 (EV_LED), code 8 (LED_MISC), value 0
Event: time 1374507617.247107, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507617.247107, type 1 (EV_KEY), code 256 (BTN_0), value 1
Event: time 1374507617.247107, -------------- SYN_REPORT ------------
Event: time 1374507617.423105, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1374507617.423105, type 1 (EV_KEY), code 256 (BTN_0), value 0
Event: time 1374507617.423105, -------------- SYN_REPORT ------------

Event used to 'write' to device ('int state' is either 0 or 1):
struct input_event input_event;
input_event.type = EV_LED;
input_event.code = LED_MISC;
input_event.value = state;

Relevant part of 'cat /proc/bus/input/devices':
I: Bus=0003 Vendor=046d Product=c626 Version=0110
N: Name="3Dconnexion SpaceNavigator"
P: Phys=usb-0000:00:13.1-1/input0
S: Sysfs=/devices/pci0000:00/0000:00:13.1/usb6/6-1/6-1:1.0/input/input53
U: Uniq=
H: Handlers=event7 js0
B: PROP=0
B: EV=2001b
B: KEY=3 0 0 0 0
B: ABS=3f
B: MSC=10
B: LED=100

Relevant part of 'dmesg':
[124497.173908] usb 6-1: new low-speed USB device number 5 using ohci_hcd
[124497.456966] logitech 0003:046D:C626.0007: fixing up rel/abs in
Logitech report descriptor
[124497.521043] input: 3Dconnexion SpaceNavigator as
/devices/pci0000:00/0000:00:13.1/usb6/6-1/6-1:1.0/input/input54
[124497.521208] logitech 0003:046D:C626.0007: input,hidraw3: USB HID
v1.10 Multi-Axis Controller [3Dconnexion SpaceNavigator] on
usb-0000:00:13.1-1/input0

Tested on two home desktop machines, ArchLinux and XUbuntu.
$ cat /proc/version
Linux version 3.10.2-1-ARCH (tobias@T-POWA-LX) (gcc version 4.8.1
(GCC) ) #1 SMP PREEMPT Mon Jul 22 08:47:24 CEST 2013
$ cat /proc/version
Linux version 3.8.0-26-generic (buildd@panlong) (gcc version 4.7.3
(Ubuntu/Linaro 4.7.3-1ubuntu1) ) #38-Ubuntu SMP Mon Jun 17 21:43:33
UTC 2013

P.S. This is my first time posting to a kernel mailing list,
I hope that this message is adequate and in the right place.
