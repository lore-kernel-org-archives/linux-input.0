From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work in
 xorg or gpm
Date: Fri, 11 May 2012 08:38:26 +0200
Message-ID: <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com>
References: <20120503052000.GC15205@burratino> <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar> <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120506031428.GA20044@hugoo.com.ar> <20120506055508.GA21209@burratino>
 <4FA6162F.1020408@osvaldobarrera.com.ar> <20120506062309.GB26002@burratino> <20120511050639.GA13777@hugoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:50243 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756530Ab2EKGi6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 02:38:58 -0400
Received: by pbbrq8 with SMTP id rq8so3371050pbb.21
        for <linux-input@vger.kernel.org>; Thu, 10 May 2012 23:38:57 -0700 (PDT)
In-Reply-To: <20120511050639.GA13777@hugoo.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

Great news. Thanks Hugo for your help testing the patches.

Jonathan, how do we proceed now, I mean to submit the fix ?

Thanks,
Nestor

On Fri, May 11, 2012 at 7:06 AM, Hugo Osvaldo Barrera
<hugo@osvaldobarrera.com.ar> wrote:
> On 2012.05.06 01:23, Jonathan Nieder wrote:
>> Hugo Osvaldo Barrera wrote:
>> > On 2012-05-06 02:55, Jonathan Nieder wrote:
>>
>> >> The pairing (...add_djhid_device) happens during initialization,
>> >> before the mouse is turned on...
>> >
>> > I don't think I quite follow there. =A0By "pairing" I though you m=
eant
>> > when the receiver connects to the mouse. =A0How can the pairing be=
 done
>> > while the device is off? =A0Or what am I missing here?
>>
>> I'm guessing the actual pairing happens without Linux being involved=
=2E
>> Then the driver sends a "get paired devices" request during
>> initialization and the device sends the "device paired" notification=
s
>> I'm interested in in response.
>>
>> > Do I need to apply only this patch, or both the previous one and t=
his one?
>>
>> Only this patch.
>>
>> Cheers,
>> Jonathan
>
> Hi!
> I apologize for the really (really) long delay in replying. =A0I've h=
ad a
> really busy week. I rebuilt the kernel with the patch (rebuilding the
> module did't work because I'd updated the kernel tree, and the re-bui=
lt
> module wasn't recognized):
>
> # uname -a
> Linux athena 3.4.0-rc5+ #1 Fri May 4 19:14:24 ART 2012 ppc GNU/Linux
>
> And I captured the dmesg from before plugging in the mouse (after a
> clean reboot).
> The good news is there's a "41" event this time! :)
>
> /sys/kernel/debug/hid/ is empty at this point, so I can't cat /sys/..=
=2E .../events
>
>
>
> [ =A0365.757237] usbcore: registered new interface driver usbhid
> [ =A0365.757448] usbhid: USB HID core driver
> [ =A0365.761458] drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_i=
nit
> [ =A0528.822188] usb 4-1: new full-speed USB device number 2 using oh=
ci_hcd
> [ =A0529.044194] usb 4-1: New USB device found, idVendor=3D046d, idPr=
oduct=3Dc52b
> [ =A0529.044417] usb 4-1: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> [ =A0529.044646] usb 4-1: Product: USB Receiver
> [ =A0529.044783] usb 4-1: Manufacturer: Logitech
> [ =A0529.054294] drivers/hid/usbhid/hid-core.c: HID probe called for =
ifnum 0
> [ =A0529.054436] drivers/hid/hid-logitech-dj.c: logi_dj_probe called =
for ifnum 0
> [ =A0529.054442] drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignori=
ng ifnum 0
> [ =A0529.054561] drivers/hid/usbhid/hid-core.c: HID probe called for =
ifnum 1
> [ =A0529.054658] drivers/hid/hid-logitech-dj.c: logi_dj_probe called =
for ifnum 1
> [ =A0529.054664] drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignori=
ng ifnum 1
> [ =A0529.054754] drivers/hid/usbhid/hid-core.c: HID probe called for =
ifnum 2
> [ =A0529.054852] drivers/hid/hid-logitech-dj.c: logi_dj_probe called =
for ifnum 2
> [ =A0529.061218] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: =
Get_Report wValue=3D0x1001 wIndex=3D0x0200 wLength=3D1792
> [ =A0529.063218] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: =
Get_Report wValue=3D0x1101 wIndex=3D0x0200 wLength=3D5120
> [ =A0529.064204] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: =
Get_Report wValue=3D0x2001 wIndex=3D0x0200 wLength=3D3840
> [ =A0529.065199] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: =
Get_Report wValue=3D0x2101 wIndex=3D0x0200 wLength=3D8192
> [ =A0529.066942] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hid=
raw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-=
1/input2
> [ =A0529.073214] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, si=
ze:15
> [ =A0529.073230] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event: re=
port =3D =A020 01 41 01 1a 10 04 00 00 00 00 00 00 00 00
> [ =A0529.073277] drivers/hid/hid-logitech-dj.c: delayedwork_callback
> [ =A0529.073447] drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse
> [ =A0529.073453] drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse: sen=
ding a mouse descriptor, reports_supported: 4
> [ =A0529.074068] drivers/hid/hid-logitech-dj.c: logi_dj_ll_start
> [ =A0529.074276] input: Logitech Unifying Device. Wireless PID:101a a=
s /devices/pci0001:10/0001:10:1b.1/usb4/4-1/4-1:1.2/0003:046D:C52B.0003=
/input/input5
> [ =A0529.075216] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, si=
ze:15
> [ =A0529.075229] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event: re=
port =3D =A020 00 41 02 00 00 00 00 00 00 00 00 00 00 00
> [ =A0529.075854] drivers/hid/hid-logitech-dj.c: logi_dj_ll_open:usb-0=
001:10:1b.1-1:1
> [ =A0529.075887] drivers/hid/hid-logitech-dj.c: logi_dj_ll_close:usb-=
0001:10:1b.1-1:1
> [ =A0529.075929] drivers/hid/hid-logitech-dj.c: logi_dj_ll_open:usb-0=
001:10:1b.1-1:1
> [ =A0529.075966] drivers/hid/hid-logitech-dj.c: logi_dj_ll_close:usb-=
0001:10:1b.1-1:1
> [ =A0529.076072] logitech-djdevice 0003:046D:C52B.0004: input,hidraw1=
: USB HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:101a] on =
usb-0001:10:1b.1-1:1
> [ =A0529.076547] drivers/hid/hid-logitech-dj.c: delayedwork_callback
> [ =A0529.076554] drivers/hid/hid-logitech-dj.c: logi_dj_recv_add_djhi=
d_device: device list is empty
>
> <receiver plugged in>
>
> [ =A0593.872745] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, si=
ze:15
> [ =A0593.872760] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event: re=
port =3D =A020 01 42 00 00 00 00 00 00 00 00 00 00 00 00
> <mouse turned on>
>
>
> Since /sys/kernel/debug/hid/ is empty until I plug in the receiver, I
> can't cat the events until then. The output of the events is the same
> as before when I turned on the mouse (I'm thinking you won't need thi=
s,
> but I'd rather be sure).
>
> # cat /sys/kernel/debug/hid/0003\:046D\:C52B.0003/events
> report (size 15) (numbered) =3D =A020 01 42 00 00 00 00 00 00 00 00 0=
0 00 00 00
>
> -----
>
> JUST as I was about to send this e-mail, I was reading the output of
> that dmesg and noticed that a few more /inputX devices were mentioned=
,
> so I decided to actually try the mouse, something that I'd neglected
> to do this last round (I though this patch only added debuging output=
).
>
> The mouse actually works now on Xorg just fine. :)
>
> A big thanks (truly) for all your effort on this. =A0I'm still includ=
ing
> the above info because I'm not sure if it's of use to you or not.
>
> Cheers,
>
> Hugo
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
