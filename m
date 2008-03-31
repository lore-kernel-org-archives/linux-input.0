From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [patch]race between open and disconnect in usbhid
Date: Mon, 31 Mar 2008 16:25:43 +0200
Message-ID: <200803311625.43803.oliver@neukum.org>
References: <200803311535.10067.oliver@neukum.org> <200803311547.56448.oliver@neukum.org> <Pine.LNX.4.64.0803311534240.5541@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0803311534240.5541-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Montag, 31. M=E4rz 2008 15:35:15 schrieb Jiri Kosina:
> On Mon, 31 Mar 2008, Oliver Neukum wrote:
>=20
> > > > +=A0char disconnected:1;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0/* indicates undead device - no use */
> > > Wouldn't introduction of new flag (HID_DISCONNECTED) to=20
> > > usbhid_device->iofl be cleaner?
> > A matter of taste. I don't use atomic ops if I don't have to, but i=
f you
> > like it better the other way I can redo it.
>=20
> I would really appreciate that, thanks. It really reflects the status=
 of=20
> the device with respect to the I/O in a very similar way as other I/O=
=20
> flags, so we should keep it together if possible.

Done.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
