From: Markus Trippelsdorf <markus-xp2qqqlHh3xzoYq+O6RWwA@public.gmane.org>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being
 called
Date: Thu, 12 Aug 2010 13:45:13 +0200
Message-ID: <20100812114513.GA1584@arch.tripp.de>
References: <20100810210941.GA7938@fritha.org>
 <20100810223215.GA1609@arch.tripp.de>
 <alpine.LNX.2.00.1008121108540.2702@pobox.suse.cz>
 <20100812091659.GA1591@arch.tripp.de>
 <alpine.LNX.2.00.1008121148100.2702@pobox.suse.cz>
 <20100812113624.GB1591@arch.tripp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100812113624.GB1591-joY5NpejW+Hx3b7vapvTcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Heinz Diehl <htd-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 12, 2010 at 01:36:24PM +0200, Markus Trippelsdorf wrote:
> On Thu, Aug 12, 2010 at 01:18:15PM +0200, Jiri Kosina wrote:
> > On Thu, 12 Aug 2010, Markus Trippelsdorf wrote:
> >=20
> > > On Thu, Aug 12, 2010 at 11:11:50AM +0200, Jiri Kosina wrote:
> > > >=20
> > > > Guys, could you please send me your .config with which you are=20
> > > > experiencing the problem, so that I can try to reproduce it wit=
h it?
> > >=20
> > > Attached.
> >=20
> > So I had to add support for HW of mine (SATA_VIA, PATA_VIA, disable=
d the=20
> > radeon firmware stuff, and, most importantly, enabled UHCI, which i=
s what=20
> > is on machine I am using now for testing), and disconnect-connect c=
ycle=20
> > works nicely:
> >=20
> > usb 3-2: USB disconnect, address 3
> > usb 3-2: new low speed USB device using uhci_hcd and address 4
> > input: mouse USB mouse with wheel as /devices/pci0000:00/0000:00:10=
=2E1/usb3/3-2/3-2:1.0/input/input6
> > generic-usb 0003:05B8:3091.0004: input,hidraw0: USB HID v1.10 Mouse=
 [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input0
> > input: mouse USB mouse with wheel as /devices/pci0000:00/0000:00:10=
=2E1/usb3/3-2/3-2:1.1/input/input7
> > generic-usb 0003:05B8:3091.0005: input,hidraw1: USB HID v1.10 Keybo=
ard [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input1
> >=20
> > so still no BUG from kobject refcounting, and the hidraw numbers ar=
e the=20
> > same. The major difference seems to be that I am using UHCI and you=
 have=20
> > your HID devices connected through OHCI, is that correct?
>=20
> Correct. And I should add that it very easy to reproduce here; just
> disconnecting the usb receiver triggers the WARNING.

Disabling USB_HIDDEV in my .config solves the problem (there is no
WARNING anymore when disconnecting the receiver).

--=20
=BBA man who doesn't know he is in prison can never escape.=AB
William S. Burroughs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
