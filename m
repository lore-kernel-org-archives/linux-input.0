From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACRUX gamepads not happy with autosuspend?
Date: Tue, 20 Jul 2010 14:24:20 +0200
Message-ID: <201007201424.20880.oneukum@suse.de>
References: <4C3F8A90.3020308@dv-life.ru> <201007201203.43573.oneukum@suse.de> <1279628053.6419.3.camel@desktop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1279628053.6419.3.camel@desktop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: x0r <x0r-MmyNGb77m7ovJsYlp49lxw@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Dienstag, 20. Juli 2010, 14:14:13 schrieb x0r:
> =D0=92 =D0=92=D1=82=D1=80, 20/07/2010 =D0=B2 12:03 +0200, Oliver Neuk=
um =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Am Dienstag, 20. Juli 2010, 10:58:50 schrieb Jiri Kosina:
> > > On Tue, 20 Jul 2010, Oliver Neukum wrote:
> > >=20
> > > > > It looks like ACRUX game controllers do not like autopm. Ther=
e is
> > > > > a bug report over at Ubuntu's launchpad:
> > > > >=20
> > > > > 	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/4484=
46
> > > >=20
> > > > That report shows that the symptoms are consistent with autosus=
pend,
> > > > but it doesn't show that autosuspend was on.
> > >=20
> > > That would be my first question -- who enabled autosuspend, if it=
 was=20
> > > really on? I thought it should be still off by default, shouldn't=
 it?
> >=20
> > It is off by default, but that doesn't stop Ubuntu having a udev ru=
le to
> > switch it on or patching the kernel, so it might be on. We simply n=
eed
> > to know.
> >=20
> > 	Regards
> > 		Oliver
> >=20
>=20
> x0r@desktop:~$ cat /sys/bus/usb/devices/5-1/power/autosuspend
> 2
>=20
> Does it mean that autosuspend is enabled?

No, this means that if it is enabled a heuristic timeout of 2s is used.
That is if your device has been being idle for 2s, it will be autosuspe=
nd.

Whether it is autosuspended at all all is controlled in the "level" att=
ribute.

on =3D no autosuspend
auto =3D autosuspend activated

	HTH
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
