From: Cedric Sodhi <manday@gmx.net>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Thu, 17 Nov 2011 07:58:04 +0100
Message-ID: <20111117065804.GA2110@slate>
References: <20111116095030.GC3335@slate>
 <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
 <20111116102514.GA3831@slate>
 <CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
 <20111116145518.GA7080@slate>
 <20111116154049.GA8444@slate>
 <CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
 <4EC3EC63.4020700@gmail.com>
 <20111116204759.GA2153@slate>
 <CAN+gG=H18JdRBJeXAYPuOa97HbjYsUzTYMvnuAdddjLW30eckg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:52589 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751709Ab1KQG61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 01:58:27 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=H18JdRBJeXAYPuOa97HbjYsUzTYMvnuAdddjLW30eckg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

On Wed, Nov 16, 2011 at 10:22:58PM +0100, Benjamin Tissoires wrote:
> Hi Chris,
>=20
> it looks like the quirks were not taken into account.
> Normally, you don't need to manually add the VID:PID with the sysfs a=
s
> you already registered your device in the list.

Assuming that it was me who you were addressing: I'm aware of that. As
the diff shows, I added the device to the "hardcoded" whitelist as
MULTITOUCH5, using the quirks SLOT_IS_CONTACTID and ALWAYS_VALID.
>=20
> 1) What is the value of the quirks sysfs attrib ? (according to your
> logs, it should show 1, instead of 18)

Cat'ing quirks returns 18. Conclusion ahead: I think I must have taken
those logs in the TAR file before I added the device to the whitelist
and then forgot to write out the quirks to sysfs, while manually adding
it.

>=20
> 2) did you do depmod and are you sure the hid-multitouch module loade=
d
> is the one with USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5?
> to be sure, please provide the outputs of:
> $ modinfo hid-multitouch
> $ modinfo <path to jiri-hid>/drivers/hid/hid-multitouch.ko
>=20
> If you added your device through the sysfs because it was not taken b=
y
> hid-multitouch, replace the last parameter by 104:
> $ echo 3 0eef a001 104 > new_id
> But again, this is not the right way as you registered it.
>=20

Therefore, no, everything seems to work now. The device is picked up
through the patch and, according to Chris, returns the correct values.

The log which I attached to my last email was the one I took after
making the changes to the code. I forgot to specify that.

Cedric

> Cheers,
> Benjamin
>=20
>=20
> On Wed, Nov 16, 2011 at 21:48, Cedric Sodhi <manday@gmx.net> wrote:
> > Dear Benjamin,
> >
> > I applied your patch tp 3.2-jikos (uname shows 3.1, though). The
> > diff to jikos' original is now [attached].
> >
> > Chris says the output of evtest still signifies problems with
> > multitouch:
> >
> >> > http://ompldr.org/iYmIzYw
> >>
> >> Cedric, can you send these logs to Benjamin for ideas? =A0The HID =
events
> >> look good but the evtest log for 2 fingers is not. =A0The two touc=
hes
> >> are fighting each other. =A0That "-1" value is interrupted as each
> >> finger is being lifted in between each new X/Y report.
> >>
> >> Also, can you send me and Benjamin the source code diff of what yo=
ur
> >> testing against kernel tree?
> >>
> >> The behavior in your evtest log looks like what would happen if yo=
ur
> >> setting the MT_QUIRK_NOT_SEEN_MEANS_UP. =A0Since your HW only send=
s 1
> >> fingers worth of data per packet, you do not want that quirk.
> >>
> >> I'll still hold off on xf86-input-wacom issues until the events co=
ming
> >> are sane. =A0Your current events will cause xf86-input-wacom to do=
 all
> >> kinds of weird stuff thats not worth effort to weed threw.
> >>
> >> Chris
> >
> > These logs in that tarfile were created while still manually adding=
 the
> > ID via your sysfs interface. You find yet another evtest log for
> > two-finger touch attached.
> >
> > Cedric
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
