From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Thu, 27 Oct 2011 11:25:16 +0200
Message-ID: <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
References: <20111026213705.GA32664@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63097 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab1J0JZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 05:25:17 -0400
Received: by wwe6 with SMTP id 6so3846622wwe.1
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2011 02:25:16 -0700 (PDT)
In-Reply-To: <20111026213705.GA32664@pequod.mess.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@bitmath.org>

Hi Sean,


On Wed, Oct 26, 2011 at 23:37, Sean Young <sean@mess.org> wrote:
> Since this commit:
>
> =A0 =A0 =A0 =A0commit 0db3bfc72adf0cb70f08dfe92e4040f64e25e205
>
> =A0 =A0 =A0 =A0HID: multitouch: decide if hid-multitouch needs to han=
dle mt devices
>
> I get the following when I insert a smartjoy device (hid-sjoy driver)=
:
>
> [ 3727.405037] usb 7-1: new low speed USB device number 2 using uhci_=
hcd
> [ 3727.709082] usb 7-1: New USB device found, idVendor=3D6666, idProd=
uct=3D8802
> [ 3727.709087] usb 7-1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
> [ 3727.709092] usb 7-1: Product: TigerGame PS/PS2 Game Controller Ada=
pter
> [ 3727.709095] usb 7-1: Manufacturer: WiseGroup.,Ltd
> [ 3738.002095] hid-multitouch 0003:6666:8802.0005: timeout initializi=
ng reports
> [ 3738.007861] input: WiseGroup.,Ltd TigerGame PS/PS2 Game Controller=
 Adapter as /devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/input/inp=
ut17
> [ 3738.008137] smartjoyplus 0003:6666:8802.0005: input,hidraw4: USB H=
ID v1.00 Joystick [WiseGroup.,Ltd TigerGame PS/PS2 Game Controller Adap=
ter] on usb-0000:00:1d.1-1/input0
> [ 3738.008163] smartjoyplus 0003:6666:8802.0005: Force feedback for S=
martJoy PLUS PS2/USB adapter
>
> Note the 10 second delay caused by the hid-multitouch error.

Thanks for this bug report. It's great that this bug that concerns
only 9 devices has been reported.
To sum up, I'll have to redo my patch.

>
> If I understand it correctly, the problem is that hid-multitouch now =
has
> a catch-all usb-id field, and does a usbhid_init_reports() on the dev=
ice
> without the quirk HID_QUIRK_NOGET.

yep

>
> The HID_QUIRK_NOGET for this device is listed in the hid-sjoy.c drive=
r itself
> rather than in hid-quirks.c; presumably the latter is handled correct=
ly.

It should work, but this patch was a little bit too invasive.

>
> Is there a different way of handling this rather than hid-multitouch
> messing with every usb device which identifies itself as hid? Alterna=
tively,
> should all quirks for all devices be specified in hid-quirks.c and no=
t in
> individual drivers?
>
>

I'm working on a better solution than this patch (I've just found it
but I need some time to format and send it...)

Cheers,
Benjamin

> Sean
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
