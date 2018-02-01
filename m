From: <Mario.Limonciello@dell.com>
Subject: RE: Dell docking station & Dell Embedded Controller & PS/2 devices
Date: Thu, 1 Feb 2018 19:35:21 +0000
Message-ID: <bb5156667d084d77841f7078d373a265@ausx13mpc120.AMER.DELL.COM>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, pali.rohar@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Thursday, February 1, 2018 1:30 PM
> To: Pali Roh=E1r <pali.rohar@gmail.com>
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devic=
es
>=20
> Hi Pali,
>=20
> On Wed, Jan 24, 2018 at 11:41:21AM +0100, Pali Roh=E1r wrote:
> > Hi Dmitry!
> >
> > I'm observing a problem with internal touchpad (handled by psmouse.ko)
> > on Dell laptops connected to Dell E docking station. When I connect
> > external PS/2 keyboard to docking station then internal laptop touchpad
> > switch from multitouch absolute mode to relative bare PS/2 mode.
> >
> > And because ALPS driver in psmouse.ko is capable to process interleaved
> > bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
> > trackstick data on some ALPS models), ALPS driver does not show any
> > message about this "downgrade" from multitouch to bare mode. And
> > continue working in bare mode.
> >
> > When I rmmod psmouse and modprobe it again, then touchpad switch back t=
o
> > multitouch mode.
> >
> > Mario told me that Dell Embedded Controller, which handle internal
> > keyboard, internal touchpad and external PS/2 keyboard, automatically
> > send RESET command to *all* those devices when external PS/2 keyboard i=
s
> > connected. Therefore this is reason why touchpad downgrade to to bare
> > mode. And according to Mario, host system should issue vendor specific
> > PS/2 commands to re-initialize all PS/2 devices when this situation
> > happen. Mario also told me that Windows is doing this action.
>=20
> Yeah, I remember fun with Inspiron 8100 - when you dock it it woudl
> silently switch Synaptics touchpad into standard mode and it would not
> come back as Synaptics until you disconnect. And there was no
> notification to the kernel as far as I could tell.
>=20
> It could be that we need to monitor dock events and then kick reconnect
> of serio port, either from userspace via udev (I think that would be
> preferred), or in kernel.
>=20
> >
> > Every time when I connect external PS/2 keyboard to dock I see this
> > message in dmesg:
> >
> > Spurious ACK... Some program might be trying to access hardware directl=
y.
> >
> > I see it also every time when I dock laptop into docking station (to
> > which is keyboard already connected). And it happens also when I connec=
t
> > external PS/2 mouse to dock.
> >
> > Dmitry, how to handle this situation to re-initialize psmouse.ko when
> > external PS/2 device is connected to Dell E docking station? According
> > to Mario, this is how Dell Embedded Controller is designed and suppose
> > how OS should work with it.
> >
> > Manually rmmoding and modprobing for every docking/undocking laptop is
> > not ideal solution.
> >
> > Could it be possible to use that Spurious ATKBD_RET_ACK from atkbd.c be
> > handled on Dell systems (probably via DMI) as an event to reset and
> > reinitialize all PS/2 devices?
>=20
> So we need to figure out what exactly we are getting from the docking
> station in this case. We do try to handle the new device 0xaa 0x00
> announcements:

Docking station itself won't have sent any events.  The PS2 ports in it
are electrically wired to the external PS2 pins in the docking adapter on
the system.

System EC is what will be sending any PS2 events.

>=20
> 	/* Check if this is a new device announcement (0xAA 0x00) */
> 	if (unlikely(psmouse->packet[0] =3D=3D PSMOUSE_RET_BAT && psmouse-
> >pktcnt <=3D 2)) {
> 		if (psmouse->pktcnt =3D=3D 1) {
> 			psmouse->last =3D jiffies;
> 			goto out;
> 		}
>=20
> 		if (psmouse->packet[1] =3D=3D PSMOUSE_RET_ID ||
> 		    (psmouse->protocol->type =3D=3D PSMOUSE_HGPK &&
> 		     psmouse->packet[1] =3D=3D PSMOUSE_RET_BAT)) {
> 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> 			serio_reconnect(serio);
> 			goto out;
> 		}
>=20
> ...
>=20
> I am not sure where the "spurious ACK comes from". Can you enable i8042
> debug before trying to dock and capture the data stream from the mouse?
>=20

The system EC has reset PS2 devices (but AFAIK kernel won't have seen this
communication).
