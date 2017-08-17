From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH] HID: core: assign usbhid to handle EETI PID=0x0001 HID
 device
Date: Thu, 17 Aug 2017 15:59:49 +0200
Message-ID: <02072032-55e2-e969-f78d-10e65d8d0c18@pr.hu>
References: <20170811074201.2747-1-jam.chen.egalax@gmail.com>
 <778fb127-4e62-943b-a14f-f219ffdac152@pr.hu>
 <CAPHAoVBjJPekxs8=m314f9ziD60ANgzeuvOVoXeYridoEt3FeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:51018 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdHQOAC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 10:00:02 -0400
In-Reply-To: <CAPHAoVBjJPekxs8=m314f9ziD60ANgzeuvOVoXeYridoEt3FeQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JiaMing Chen <jam.chen.egalax@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

it's a funny thing. Currently I can't reproduce the problem.

This was the situation that occurred previously:

At the first touch after X started, the pointer went to the correct location.
Moving the finger made the pointer move with the finger, the pointer
location was always good.

Then lifted the finger up and touched a different location.
Moving the finger made the pointer move with the finger, but the pointer
didn't match the finger location, the difference was the vector
between the last location in the first step and the first location in
this second step.

I was thinking that since the touchscreen is demoted to be a mouse,
it's the expected behaviour, since only relative motion is processed.

This was not a panel orientation problem which can be easily solved
by calibration.

But I was just after upgrading the system from libevdev 1.4.6 to 1.5.7
and from libinput 1.5.0 to 1.8.1 and it is possible that something still
referenced the old library versions even after restarting Xorg.
It's also possible that the ordering of the input devices influences things.

 From dmesg, there's no difference between boots:

[    3.718370] usb 1-1.1.4: new full-speed USB device number 8 using ehci-pci
[    3.810812] usb 1-1.1.4: New USB device found, idVendor=0eef, idProduct=0001
[    3.810815] usb 1-1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.810818] usb 1-1.1.4: Product: USB TouchController
[    3.810819] usb 1-1.1.4: Manufacturer: eGalax Inc.
[    3.815502] input: eGalax Inc. USB TouchController as 
/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.0/0003:0EEF:0001.0003/input/input8
[    3.815712] input: eGalax Inc. USB TouchController as 
/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.0/0003:0EEF:0001.0003/input/input9
[    3.815888] input: eGalax Inc. USB TouchController as 
/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.0/0003:0EEF:0001.0003/input/input10
[    3.816008] input: eGalax Inc. USB TouchController as 
/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.0/0003:0EEF:0001.0003/input/input11
[    3.816297] hid-generic 0003:0EEF:0001.0003: input,hiddev96,hidraw2: USB HID v1.00 
Pointer [eGalax Inc. USB TouchController] on usb-0000:00:1d.0-1.1.4/input0

According to evtest, the 4 devices provide these features:

input8: EV_SYN, EV_ABS (ABS_X/ABS_Y), EV_KEY (BTN_LEFT/BTN_RIGHT),
         EV_MSC (MSC_SCAN)

input9: EV_SYN, EV_ABS (ABS_X/ABS_Y), EV_KEY (BTN_TOOL_PEN/BTN_TOUCH),
         EV_MSC (MSC_SCAN)

input10: EV_SYN

input11: EV_SYN, EV_ABS (ABS_X/ABS_Y/ABS_MISC), EV_KEY (BTN_TOOL_FINGER/BTN_TOUCH),
          EV_MSC (MSC_SCAN)

Now, that it's working, the first device of the four emit events,
the one with the mouse buttons. The pointer behaves perfectly.

I remember that when it wasn't working properly, then some of the other
devices emitted the events and produced the above described behaviour.

It's probably a different kernel bug or the old libevdev/libinput were
doing something wrong that made the input devices work differently.

I have re-rested downgrading to the old libevdev / libinput libraries
but I still couldn't reproduce the problem.

Maybe it's gremlins in the machine. Sorry for the noise.

Best regards,
Zoltán Böszörményi

2017-08-17 13:08 keltezéssel, JiaMing Chen írta:
> Hi Zoltán,
> 
> Is it the panel orientation issue?
> If you run the position calibration using the tslib, can it be fixed?
> 
> Best regards,
> Jam Chen
> 
> 
> 2017-08-15 17:43 GMT+08:00 Boszormenyi Zoltan <zboszor@pr.hu <mailto:zboszor@pr.hu>>:
> 
>     Hi,
> 
> 
>     2017-08-11 09:42 keltezéssel, JamChen wrote:
> 
>         From: Jam Chen <jam.chen.egalax@gmail.com <mailto:jam.chen.egalax@gmail.com>>
> 
>         The vendor used the same PID(0x0001) for multiple touch IC controllers.
>         The newer ICs can support HID class and report the multitouch collection
>         in the descriptor. So they were handled by the hid-multitouch driver.
>         But some customized firmwares don't support multitouch protocol even if
>         driver have got the Win8 blob data.
> 
>         Actually, those ICs only support the single touch function, and report
>         the mouse protocol by default. We can assign usbhid to handle them all.
> 
>         Signed-off-by: Jam Chen <jam.chen.egalax@gmail.com <mailto:jam.chen.egalax@gmail.com>>
>         ---
>            drivers/hid/hid-core.c | 4 ++++
>            1 file changed, 4 insertions(+)
> 
>         diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>         index 9017dcc14502..df4696022488 100644
>         --- a/drivers/hid/hid-core.c
>         +++ b/drivers/hid/hid-core.c
>         @@ -828,6 +828,10 @@ static int hid_scan_report(struct hid_device *hid)
>                                           */
>                                          hid->group = HID_GROUP_RMI;
>                          break;
>         +       case USB_VENDOR_ID_DWAV:
>         +               if (hid->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
>         +                       hid->group = HID_GROUP_GENERIC;
>         +               break;
>                  }
>                  /* fall back to generic driver in case specific driver doesn't exist */
> 
> 
>     I have tested this patch on 4.12.7 and unfortunately it doesn't work perfectly.
> 
>     Software versions:
> 
>     Xorg server 1.19.3
>     xf86-input-evdev 2.10.5
>     xf86-input-keyboard 1.9.0
>     xf86-input-libinput 0.25.1
>     xf86-input-mouse 1.9.2
>     xf86-input-synaptics 1.9.0
>     libinput 1.8.1
>     libevdev 1.5.7
> 
>     Because the device is now handled as a mouse, the pointer location
>     on the screen doesn't match the actual location of the finger.
>     Caused by this, touches can deliver clicks at the wrong location.
> 
>     Best regards,
>     Zoltán Böszörményi
> 
> 

