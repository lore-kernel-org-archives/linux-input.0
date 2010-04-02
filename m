From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech M705 thumb button
Date: Fri, 2 Apr 2010 12:05:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004021204310.8345@pobox.suse.cz>
References: <hoqak4$m6t$1@dough.gmane.org>  <20100330065625.GC12764@core.coreip.homeip.net>  <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>  <alpine.LRH.2.00.1003301418000.10181@twin.jikos.cz>  <319012f1003300602q708563ebo90b30c8d8b15e938@mail.gmail.com>
  <alpine.LNX.2.00.1003311401230.24576@pobox.suse.cz> <i2m319012f1003310554gd0a6a9fej27838c2c63bac171@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49066 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017Ab0DBKFs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Apr 2010 06:05:48 -0400
In-Reply-To: <i2m319012f1003310554gd0a6a9fej27838c2c63bac171@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Octoploid <cryptooctoploid@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 31 Mar 2010, Octoploid wrote:

> >> (The =BBunifying USB reciever=AB has three sub-devices. The first =
one is
> >> for keyboards, the second for mouses and the third is not used:
> >> usb 3-1: new full speed USB device using ohci_hcd and address 2
> >> input: Logitech USB Receiver as
> >> /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/input/input2
> >> generic-usb 0003:046D:C52B.0001: input,hidraw0: USB HID v1.11 Keyb=
oard
> >> [Logitech USB Receiver] on usb-0000:00:12.0-1/input0
> >> input: Logitech USB Receiver as
> >> /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/input/input3
> >> generic-usb 0003:046D:C52B.0002: input,hiddev96,hidraw1: USB HID v=
1.11
> >> Mouse [Logitech USB Receiver] on usb-0000:00:12.0-1/input1
> >> generic-usb 0003:046D:C52B.0003: hiddev97,hidraw2: USB HID v1.11
> >> Device [Logitech USB Receiver] on usb-0000:00:12.0-1/input2)
> >>
> >> The rdesc output for the mouse and the third device follows:
> >
> > Thanks for providing the output.
> >
> > The device defines 16 buttons in its report descriptor. How much do=
es it
> > actually physically have?
>=20
> 8 if I count correctly (left,middle,right,scrollwheel left,scrollwhee=
l right,
> forward, backward and the hidden (the non working) thumb button).
> Here is a photo of the mouse (the hidden button is located under the
> white underscore below the back and forward buttons):
> http://www.techfresh.net/wp-content/uploads/2010/03/logitech_m705.jpg
>=20
> > Is the other (non-used) interface also silent when you press the
> > non-working button? (I can see that it is claimed by HID as well).
>=20
> Yes.
>=20
> > Could you please apply the patch below and check whether there is s=
till no
> > event present when you press the button?
> >
>=20
> Yes, unfortunately there are still no events even with the patch appl=
ied.
> (I've tested both interfaces)

Could you please verify that there is indeed no USB event being trigger=
ed=20
by the button press at all, with usbmon [1]?

If it is the case, I am afraid the only option would be inspecting what=
=20
initialization sequence does the driver for Another OS perform, so that=
 it=20
makes the button work.

[1] Documentation/usb/usbmon.txt

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
