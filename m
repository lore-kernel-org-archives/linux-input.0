From: Josh Cartwright <joshc-acOepvfBmUk@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Wed, 18 Nov 2015 17:58:56 -0600
Message-ID: <20151118235856.GA30351@jcartwri.amer.corp.natinst.com>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
 <alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz>
 <20151118230544.5c6f0c26@adipc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151118230544.5c6f0c26@adipc>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ioan-Adrian Ratiu <adi-VBHIVgTnVYLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 11:05:44PM +0200, Ioan-Adrian Ratiu wrote:
> On Wed, 18 Nov 2015 21:37:42 +0100 (CET)
> Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> > On Wed, 18 Nov 2015, Ioan-Adrian Ratiu wrote:
> >=20
> > > The critical section protected by usbhid->lock in hid_ctrl() is too
> > > big and in rare cases causes a recursive deadlock because of its call
> > > to hid_input_report().
> > >=20
> > > This deadlock reproduces on newer wacom tablets like 056a:033c because
> > > the wacom driver in its irq handler ends up calling hid_hw_request()
> > > from wacom_intuos_schedule_prox_event() in wacom_wac.c. What this mea=
ns
> > > is that it submits a report to reschedule a proximity read through a
> > > sync ctrl call which grabs the lock in hid_ctrl(struct urb *urb)
> > > before calling hid_input_report(). When the irq kicks in on the same
> > > cpu, it also tries to grab the lock resulting in a recursive deadlock.
> > >=20
> > > The proper fix is to shrink the critical section in hid_ctrl() to
> > > protect only the instructions which modify usbhid, thus move the lock
> > > after the hid_input_report() call and the deadlock dissapears. =20
> >=20
> > I think the proper fix actually is to spin_lock_irqsave() in hid_ctrl()=
,=20
> > isn't it?
> >=20
>=20
> That was my first attempt, yes, but the deadlock still happens with inter=
rupts
> disabled. It is very weird, I know.

I think your best course of action is to figure out why this is the
case, instead of continuing with trying to solve the symptoms.  Do you
have actual callstacks showing the cases where you hit?  That might be
useful to share (your lockdep picture cuts out the callstacks).

Also, have you tried without the PREEMPT_RT patch in the picture at all?

  Josh

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWTRC9AAoJEKp7ZBKwQFArUnUIAJboPfTJEy/nGWNUx9cwE/kM
ZWozUTAZpVqPyMQFZ2Nsffbc5rnRfZ695mYnbYK2BA/2AdRycV+vJNlLdae3W9el
7w0kfzP4BC5PFHk+tAkLk2PAzTKeMH+NIMXYIm6GPm9OD6BuoEjWY4m6C/BePvWl
0x+Q8v1PQQh7saqzvALWHueoeJPm4X2eRqq9ZJh0xzti6/z19nX1mezettYAm8du
Hf2FqSsgtiioMnuW3ztDwmqMhEyYBRSD8oHi9aUEy70Zv3dUAk3ZcOBu2mWDk/xE
dl+hD/uT0nwCXFFHdBeKGJpSmBHJT227z4lJhr91vUGjWBSi6dx9N/3xjTfhS+8=
=ECU5
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
