From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 0/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 7 Mar 2014 11:51:49 -0500
Message-ID: <CAN+gG=GdRwOkZsNWT9H1tRtjTy9bMDkKv1KiMe0tEcThOAvEQA@mail.gmail.com>
References: <5319EB7C.5070209@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33851 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaCGQwC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 11:52:02 -0500
Received: by mail-la0-f41.google.com with SMTP id gl10so3057156lab.28
        for <linux-input@vger.kernel.org>; Fri, 07 Mar 2014 08:52:00 -0800 (PST)
In-Reply-To: <5319EB7C.5070209@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

Hi Derya,

On Fri, Mar 7, 2014 at 10:53 AM, Derya <derya.kiran@yahoo.de> wrote:
> The MS Surface Pro 2 has a very annoying USB composite device on port=
 2.3.
> It has 3 interfaces:
> - Interface 0 is the sensor-hub
> - Interface 1 is the wacom digitizer=C2=B2 (it's one without finger i=
nput, there
> is an atmel digitizer on port 2.4 for finger input)
> - Interface 2 is the keyboard, if a keyboard cover is attached.

Oh... yes, indeed, it's gona be tricky :)

>
> This USB composite device changes it product id depending if and whic=
h
> keyboard cover is attached.
> Each of this hid devices contains several collections, this complicat=
ed
> everything.
> I have uploaded a lsusb output to: http://pastebin.com/Jun5sa2t

Thanks

>
> I have to say, that I'm neither a developer nor a programmer, this me=
ans
> this things are beyond my ken, please excuse if my remarks aren't acc=
urate.

But you still made the patches, so you are a programmer :)

>
> The Touch and Type Covers (2) didn't work out of the box. Someone one=
 the
> ubuntuforums made a patch which adds them to the microsoft special dr=
iver,
> but this leads to loading that driver for all the 3 interfaces and pr=
events
> loading of hid-sensor-hub for interface 0, if a keyboard cover is att=
ached.
> Sadly this patch is submitted to the upstream kernel source.

Well, if it breaks things, it's still time to revert it.

> Without that patch the keyboard covers are loading hid-multitouch ins=
tead of
> hid-generic. This misbehaviour is a result of the fancy hid collectio=
ns,
> that the keyboards have. With hid-multitouch neither the keyboard nor=
 the
> touchpad of the cover works=C2=B2. I added an if clause to hid_scan_i=
nput_usage
> to prevent loading of hid-multitouch for the keyboards. With hid-gene=
ric
> keyboard and touchpad are working (they come up as one input)

More comment on that in the patch

>
> We also need the HID_QUIRK_NOGET for this usb composite device, witho=
ut it
> hid-sensor-hub fails with a submit urb failure evertime a keyboard co=
ver is
> (de)attached and it takes some seconds until the keyboard and wacom
> digitizer responds.

Can you test if HID_QUIRK_NO_INIT_INPUT_REPORTS works. It's a little
bit less a hammer than NO_GET, and I am pretty sure that this is what
Windows does by default.

>
> The second patch adds HID_SENSOR_HUB_ENUM_QUIRK for the Surface Pro 2=
's
> sensor-hub. There is still a bug with the sensors and the Surface Pro=
 2, but
> I didn't dig into it yet (hid-sensor-magn-3d fails to setup attribute=
s)
>
> Regards,
>
> Derya
>
>
>
> 1 I'm also working to get the wacom driver working. At the moment the=
 stylus
> works with hid-generic(if my patch is applied, without it use
> hid-microsoft). I got it working with wacom driver without disturbing=
 the
> other interfaces, but the wacom interface contains also some fancy
> collection. The wacom driver doesn't care of them, this leads to losi=
ng the
> on device volume and left meta keys. With hid-generic they work, but =
the
> input events get distorted after the use of the eraser. But, this is =
another
> story...

=46or the record, I am tempted (and some people at wacom too) to switch
the Wacom devices to use hid-wacom instead of wacom.ko. This may solve
your problems here.

>
> 2 @Benjamin Tissoires
> I have tried your patches for fancy collection in hid-multitouch. It =
seems
> to be the right way to solve the problem with the keyboard (better th=
an my
> approach to exclude this devices in hid_scan_input_usage), but it has=
 the
> some drawbacks at the moment. It splits the input into 5 pieces. 2 se=
perate
> keyboard inputs that leads into losing the caps lock led. The touchpa=
d is
> mapped as a mouse. There is also a consumer device, which gives me no=
 input
> and an unkown device, but no multitouch device. There is a HID_DG_INP=
UTMODE
> out of range error in dmesg. Please, contact me, if you need some log=
s.

With the lsusb output I should be able to conduct more tests. But I
may not have time to do them.
Did you used the latest patch applied this week by Jiri?

Cheers,
Benjamin

>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
