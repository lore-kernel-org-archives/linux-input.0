From: x0r <x0r-MmyNGb77m7ovJsYlp49lxw@public.gmane.org>
Subject: Re: ACRUX gamepads not happy with autosuspend?
Date: Tue, 20 Jul 2010 23:14:13 +1100
Message-ID: <1279628053.6419.3.camel@desktop>
References: <4C3F8A90.3020308@dv-life.ru>
	 <201007201007.04518.oneukum@suse.de>
	 <alpine.LNX.2.00.1007201058190.4741@pobox.suse.cz>
	 <201007201203.43573.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201007201203.43573.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

=D0=92 =D0=92=D1=82=D1=80, 20/07/2010 =D0=B2 12:03 +0200, Oliver Neukum=
 =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Am Dienstag, 20. Juli 2010, 10:58:50 schrieb Jiri Kosina:
> > On Tue, 20 Jul 2010, Oliver Neukum wrote:
> >=20
> > > > It looks like ACRUX game controllers do not like autopm. There =
is
> > > > a bug report over at Ubuntu's launchpad:
> > > >=20
> > > > 	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/448446
> > >=20
> > > That report shows that the symptoms are consistent with autosuspe=
nd,
> > > but it doesn't show that autosuspend was on.
> >=20
> > That would be my first question -- who enabled autosuspend, if it w=
as=20
> > really on? I thought it should be still off by default, shouldn't i=
t?
>=20
> It is off by default, but that doesn't stop Ubuntu having a udev rule=
 to
> switch it on or patching the kernel, so it might be on. We simply nee=
d
> to know.
>=20
> 	Regards
> 		Oliver
>=20

x0r@desktop:~$ cat /sys/bus/usb/devices/5-1/power/autosuspend
2

Does it mean that autosuspend is enabled?

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
