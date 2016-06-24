From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Fri, 24 Jun 2016 09:14:19 +0200
Message-ID: <20160624071419.GO24234@mail.corp.redhat.com>
References: <1466196443.21223.1.camel@gmail.com>
 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
 <20160617211142.GH24234@mail.corp.redhat.com>
 <1466275994.2669.11.camel@gmail.com>
 <20160618194534.GI24234@mail.corp.redhat.com>
 <1466369282.15726.7.camel@gmail.com>
 <20160620095934.GN24234@mail.corp.redhat.com>
 <1466739490.3464.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40760 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbcFXHOY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 03:14:24 -0400
Content-Disposition: inline
In-Reply-To: <1466739490.3464.8.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org

On Jun 23 2016 or thereabouts, Dennis Chen wrote:
> On Mon, 2016-06-20 at 11:59 +0200, Benjamin Tissoires wrote:
> > Could you send the dmesg after disconnet/reconnect
> > and some hid-recorder[1] trace after re-attaching the device when
> > the keyboard is not working?
> >=20
>=20
> I've noticed that the problem resolves itself after a while. Here are
> the relevant dmseg lines.
>=20
> ---SNIP--
> [ 2409.650260] usb 1-3: new full-speed USB device number 16 using xhc=
i_hcd
> [ 2409.815845] usb 1-3: New USB device found, idVendor=3D045e, idProd=
uct=3D07dc
> [ 2409.815853] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
> [ 2409.815858] usb 1-3: Product: Surface Type Cover
> [ 2409.815861] usb 1-3: Manufacturer: Microsoft
> [ 2409.815864] usb 1-3: SerialNumber: 041396550454
> [ 2419.823679] hid-multitouch 0003:045E:07DC.0012: usb_submit_urb(ctr=
l) failed: -1
> [ 2419.823710] hid-multitouch 0003:045E:07DC.0012: timeout initializi=
ng reports
> [ 2419.824295] input: Microsoft Surface Type Cover Keyboard as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0012/input/i=
nput179
> [ 2419.875399] input: Microsoft Surface Type Cover Consumer Control a=
s /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0012=
/input/input181
> [ 2419.875837] input: Microsoft Surface Type Cover Touchpad as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0012/input/i=
nput183
> [ 2419.876411] hid-multitouch 0003:045E:07DC.0012: input,hiddev0,hidr=
aw4: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:=
00:14.0-3/input0
> [ 2419.876641] usb 1-3: USB disconnect, device number 16
> [ 2419.934821] hid-multitouch 0003:045E:07DC.0012: usb_submit_urb(ctr=
l) failed: -19
> [ 2420.191569] usb 1-3: new full-speed USB device number 17 using xhc=
i_hcd
> [ 2420.356899] usb 1-3: New USB device found, idVendor=3D045e, idProd=
uct=3D07dc
> [ 2420.356902] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
> [ 2420.356903] usb 1-3: Product: Surface Type Cover
> [ 2420.356904] usb 1-3: Manufacturer: Microsoft
> [ 2420.356905] usb 1-3: SerialNumber: 041396550454
> [ 2430.361044] hid-multitouch 0003:045E:07DC.0013: usb_submit_urb(ctr=
l) failed: -1
> [ 2430.361072] hid-multitouch 0003:045E:07DC.0013: timeout initializi=
ng reports
> [ 2430.361967] input: Microsoft Surface Type Cover Keyboard as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0013/input/i=
nput195
> [ 2430.414002] input: Microsoft Surface Type Cover Consumer Control a=
s /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0013=
/input/input197
> [ 2430.414356] input: Microsoft Surface Type Cover Touchpad as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0013/input/i=
nput199
> [ 2430.415114] hid-multitouch 0003:045E:07DC.0013: input,hiddev0,hidr=
aw4: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:=
00:14.0-3/input0
> [ 2430.415365] usb 1-3: USB disconnect, device number 17
> [ 2430.457425] hid-multitouch 0003:045E:07DC.0013:=C2=A0usb_submit_ur=
b(ctrl)
> failed: -19
> [ 2430.714979] usb 1-3: new full-speed USB device number 18 using xhc=
i_hcd
> [ 2430.880521] usb 1-3: New USB device found, idVendor=3D045e, idProd=
uct=3D07dc
> [ 2430.880528] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
> [ 2430.880532] usb 1-3: Product: Surface Type Cover
> [ 2430.880534] usb 1-3: Manufacturer: Microsoft
> [ 2430.880537] usb 1-3: SerialNumber: 041396550454
> [ 2434.993319] input: Microsoft Surface Type Cover Keyboard as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0014/input/i=
nput211
> [ 2435.045167] input: Microsoft Surface Type Cover Consumer Control a=
s /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0014=
/input/input213
> [ 2435.045506] input: Microsoft Surface Type Cover Touchpad as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0014/input/i=
nput215
> [ 2435.046174] hid-multitouch 0003:045E:07DC.0014: input,hiddev0,hidr=
aw4: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:=
00:14.0-3/input0
> ---END---
>=20
> Hopefully this is helpful. I've looked at the your patch, and - as
> you've mentioned - have no idea why this only occurs with your patch.=
=C2=A0
>=20

Looks like the same issue Andy is seeing on the Surface Book. So I thin=
k
my patch must have a bug where it resets the quirks set by usbhid. And
this is why we are screwed here.

Regarding your disconnect issue, what happens I think is that you
disconnect it before the timeout of usb_submit_urb(), and so the usb
layer is stuck trying to access the device and can't access the newly
plugged one. If you wait enough (initial timeout + new timeout -> 20
secs), then the device behaves properly again.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
