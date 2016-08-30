From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
Date: Tue, 30 Aug 2016 18:34:10 +0200
Message-ID: <20160830163410.GI18605@lukather>
References: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
 <20160829003725.GA20749@rob-hp-laptop>
 <20160829051834.GW3165@lukather>
 <64d65f63-db47-d9c2-1c3f-cc544c2da2ab@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <64d65f63-db47-d9c2-1c3f-cc544c2da2ab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2016 at 11:35:47AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 29-08-16 07:18, Maxime Ripard wrote:
> >Hi Rob,
> >
> >On Sun, Aug 28, 2016 at 07:37:25PM -0500, Rob Herring wrote:
> >>On Tue, Aug 23, 2016 at 05:04:48PM +0200, Hans de Goede wrote:
> >>>The driver has supported touchscreen-fw-name to specify the firmware to
> >>>load since day 0, but this was omitted from the binding, document this.
> >>>
> >>>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>>---
> >>> Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.tx=
t | 1 +
> >>> 1 file changed, 1 insertion(+)
> >>
> >>I'd really like to deprecate in favor of a standard property name. We've
> >>somewhat agreed on 'firmware-name' though there is no common binding doc
> >>yet. But given this is in use:
> >
> >This has been introduced in 4.8-rc1, so it hasn't been used in any
> >stable version yet, and we don't have any users in tree so far.
> >
> >If you want to something else, it feels like now is the time to change
> >it.
>=20
> Ack, I can still change it to firmware-name if you want (Maxime has not y=
et
> merged any dts changes using the touchscreen-fw-name). We should probably
> also decide if the silead/ prefix we're using (so the firmware files are
> /lib/firmware/silead/foo.fw under Linux) goes into the firmware-name
> property as my current wip code is doing, or if we put the "silead/"
> part in the driver and only put the part after it in the property.
>=20
> I've a feeling that just putting only the base filename (so no "silead/"
> prefix) in the property is best.

Yes, I would agree too.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxbWCAAoJEBx+YmzsjxAgl6EP/iRPOHav0ETRyz3pPFE2c/Ij
6Ww5v4mhs2HIBozc5htZ3d4uJoZHG+9Wr9Nd8JNgKlm4hgk2g5y75vX94slosgNY
TbzzLsaNBqtgPYlIJt2IVZ6veCm90qb8OTKiJZyYwxJhi7CE1kjkwY++Bzie/K1k
y4kbIoEHvQali1rS3KmuUvZoOVezMU7V/uSm2e4q9gjLtyx6hOpyZmcERVcevwa3
6efsDeRmSD6YktDcQxLIKPrtEmXG71AMNlp0X/Q+sugrq/otWkiVkHYpuaa9s/T6
qcvxltrTqO0eh4dSc+Hmv+AA7PmEaTrieevYEeF1Z2ZlWvEZpex+QR5gkxgos1fs
WEv7o/iBoITvbg0/uA9KfBeQlnNQDbvr27e5ls2AP+jFej+dUCQt7ayFRqHLR4W0
0ix63Mg3o/GtAElLNHapoVU2ssDYv14DFpBTCnPo6xtDpOmaDDoRzjigKsSOB08T
dX9ooraMVUfu8a+O5n5SlVcV11b1e06vOhhO13nfKMU0o+g+RKVWdLr7UapRz+mv
fpIe0OrAHTkGGgKIFsOzK/lW0K8vJDho5IBDWDjdae6TcaIDoEgV1HAjsRloOBBh
X+AePwHduR5AGyuKZ/GSD5EBk9nzR5Pmgz8GZQ2LmIRha+UXsXH7ZhbRmSxb7fHY
fm3NNApN6pk3MoLf/Yub
=r9jG
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
