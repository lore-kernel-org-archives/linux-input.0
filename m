From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being
 called
Date: Thu, 12 Aug 2010 15:04:11 +0200
Message-ID: <20100812130411.GA1626@arch.tripp.de>
References: <20100810210941.GA7938@fritha.org>
 <20100810223215.GA1609@arch.tripp.de>
 <alpine.LNX.2.00.1008121108540.2702@pobox.suse.cz>
 <20100812091659.GA1591@arch.tripp.de>
 <alpine.LNX.2.00.1008121148100.2702@pobox.suse.cz>
 <20100812113624.GB1591@arch.tripp.de>
 <20100812114513.GA1584@arch.tripp.de>
 <20100812115657.GA1611@arch.tripp.de>
 <alpine.LNX.2.00.1008121401580.2702@pobox.suse.cz>
 <alpine.LNX.2.00.1008121457060.2702@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1008121457060.2702@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Heinz Diehl <htd@fritha.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 12, 2010 at 02:57:57PM +0200, Jiri Kosina wrote:
> On Thu, 12 Aug 2010, Jiri Kosina wrote:
>=20
> > > > > > > > Guys, could you please send me your .config with which =
you are=20
> > > > > > > > experiencing the problem, so that I can try to reproduc=
e it with it?
> > > > > > >=20
> > > > > > > Attached.
> > > > > >=20
> > > > > > So I had to add support for HW of mine (SATA_VIA, PATA_VIA,=
 disabled the=20
> > > > > > radeon firmware stuff, and, most importantly, enabled UHCI,=
 which is what=20
> > > > > > is on machine I am using now for testing), and disconnect-c=
onnect cycle=20
> > > > > > works nicely:
> > > > > >=20
> > > > > > usb 3-2: USB disconnect, address 3
> > > > > > usb 3-2: new low speed USB device using uhci_hcd and addres=
s 4
> > > > > > input: mouse USB mouse with wheel as /devices/pci0000:00/00=
00:00:10.1/usb3/3-2/3-2:1.0/input/input6
> > > > > > generic-usb 0003:05B8:3091.0004: input,hidraw0: USB HID v1.=
10 Mouse [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input0
> > > > > > input: mouse USB mouse with wheel as /devices/pci0000:00/00=
00:00:10.1/usb3/3-2/3-2:1.1/input/input7
> > > > > > generic-usb 0003:05B8:3091.0005: input,hidraw1: USB HID v1.=
10 Keyboard [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input1
> > > > > >=20
> > > > > > so still no BUG from kobject refcounting, and the hidraw nu=
mbers are the=20
> > > > > > same. The major difference seems to be that I am using UHCI=
 and you have=20
> > > > > > your HID devices connected through OHCI, is that correct?
> > > > >=20
> > > > > Correct. And I should add that it very easy to reproduce here=
; just
> > > > > disconnecting the usb receiver triggers the WARNING.
> > > >=20
> > > > Disabling USB_HIDDEV in my .config solves the problem (there is=
 no
> > > > WARNING anymore when disconnecting the receiver).
> > >=20
> > > Reverting bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a with USB_HIDDE=
V
> > > enabled also solves the problem. So there must be a bug in that p=
atch:
> > >=20
> > > commit bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a
> > > Author: Arnd Bergmann <arnd@arndb.de>
> > > Date:   Sun Jul 11 15:34:05 2010 +0200
> > >=20
> > >     HID: hiddev: use usb_find_interface, get rid of BKL
> > >    =20
> > >     This removes the private hiddev_table in the usbhid
> > >     driver and changes it to use usb_find_interface
> > >     instead.
> > >    =20
> > >     The advantage is that we can avoid the race between
> > >     usb_register_dev and usb_open and no longer need the
> > >     big kernel lock.
> > >    =20
> > >     This doesn't introduce race condition -- the intf pointer cou=
ld be
> > >     invalidated only in hiddev_disconnect() through usb_deregiste=
r_dev(),
> > >     but that will block on minor_rwsem and not actually remove th=
e device
> > >     until usb_open().
> > >    =20
> > >     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >     Cc: Jiri Kosina <jkosina@suse.cz>
> > >     Cc: "Greg Kroah-Hartman" <gregkh@suse.de>
> > >     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> >=20
> > Thanks, I had my suspicion about this commit (that's why I asked to=
 you=20
> > verify with CONFIG_USB_HIDDEV turned off as well).
> >=20
> > Adding Arnd to CC and will look into it myself as well soon.
> >=20
> > Arnd, the complete thread can be found at=20
> > http://lkml.org/lkml/2010/8/10/280
>=20
> Could please those of you, who are able to reproduce the problem, ver=
ify=20
> whether the patch below (completely untested) makes everything behave=
=20
> again? Thanks.

Yes, everything behaves again. Thanks Jiri.

--=20
=BBA man who doesn't know he is in prison can never escape.=AB
William S. Burroughs
