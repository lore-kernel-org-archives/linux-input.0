From: Mathieu Virbel <tito-aNgzRxDdy4Qdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Wed, 18 Aug 2010 11:33:37 +0200
Message-ID: <20100818093337.GA2514@bankiz.org>
References: <m339wl2ug6.fsf@pullcord.laptop.org>
 <m3hbiz8m11.fsf@pullcord.laptop.org>
 <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>
 <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr>
 <alpine.LNX.2.00.1008161557020.1019@pobox.suse.cz>
 <F35B802E-C47A-47BF-A350-8F57250D4394@enac.fr>
Reply-To: tito-aNgzRxDdy4Qdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F35B802E-C47A-47BF-A350-8F57250D4394-rXV5z7KbLFk@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty-rXV5z7KbLFk@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

* St=E9phane Chatty <chatty-rXV5z7KbLFk@public.gmane.org> [2010-08-16 17:17:52]:

>=20
> Le 16 ao=FBt 10 =E0 15:58, Jiri Kosina a =E9crit :
>=20
> >
> >
> >thanks for the analysis. How do devices in their report descriptor
> >describe the fact whether the events should be interleaved by sync
> >or not?
>=20
> As far as I know, they don't. I know of two multitouch devices that
> send groups of fingers over several HID messages:
>  - the 3M 22" panel, when there are more than 6 fingers on the
> panel. You know there are more messages coming when the number of
> fingers (reported through ContactCount in the first message) is
> greater than 6.
>  - the eGalax 72xx series, that adds a second message whenever there
> are two fingers; I am not sure yet how one knows when to wait  for a
> second message. Mathieu might be able to tell us.

Well, i've actually the problem, i can't known :)
So for my case, i dispatch event - 1, not current event, and doing the
merge on userland size by checking old event contact id. Since i known
that the screen is doing only one or two touches, it's kind of easy to
do the "sync" ourself... except when touch UP. With event - 1, i can't
known if it's finished or not...

It cannot be resolved until the kernel send correct sync message...


> The short term solution could be to add a .sync hook similar to
> .event. Each specific driver could override the call to input_sync()
> based on its knowledge of the device.

That would solve this case :)


Mathieu

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxrqPEACgkQhUnvgY6MdEgQVwCggy05H3VjNRW56lHG8hOtZzW8
nDQAn2GWJEaoucvxh+87y5S8xJjZ760o
=XZMF
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
