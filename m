From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Sun, 6 Jan 2013 20:27:39 +0100
Message-ID: <20130106192739.GA11566@avionic-0098.adnet.avionic-design.de>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com>
 <1357371910-3164-3-git-send-email-ldewangan@nvidia.com>
 <20130105080658.GA1315@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5096442939072299005=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130105080658.GA1315-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--===============5096442939072299005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2013 at 12:06:58AM -0800, Dmitry Torokhov wrote:
> On Sat, Jan 05, 2013 at 01:15:08PM +0530, Laxman Dewangan wrote:
[...]
> > @@ -735,25 +738,16 @@ static int tegra_kbc_probe(struct platform_device=
 *pdev)
> >  	spin_lock_init(&kbc->lock);
> >  	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigned long)kbc=
);
> > =20
> > -	res =3D request_mem_region(res->start, resource_size(res), pdev->name=
);
> > -	if (!res) {
> > -		dev_err(&pdev->dev, "failed to request I/O memory\n");
> > -		err =3D -EBUSY;
> > -		goto err_free_mem;
> > -	}
> > -
> > -	kbc->mmio =3D ioremap(res->start, resource_size(res));
> > +	kbc->mmio =3D devm_request_and_ioremap(&pdev->dev, res);
> >  	if (!kbc->mmio) {
> > -		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> > -		err =3D -ENXIO;
> > -		goto err_free_mem_region;
> > +		dev_err(&pdev->dev, "Cannot request memregion/iomap address\n");
> > +		return -EADDRNOTAVAIL;
>=20
> Erm, no, -EBUSY please.

EADDRNOTAVAIL is the canonical error for devm_request_and_ioremap()
failure. The kerneldoc comment in lib/devres.c even gives a short
example that uses this error code.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ6dArAAoJEN0jrNd/PrOhVc8P/RBfk2kdD1xrPNZQe60rRWi3
NaFakKFbFyZQrapu3n1bryZol6TiZ70hkKzl/sGvuRXGpP8PbzRW0OyOlBCKNtOk
BJVN56q7/fDEujKEs6sWKa17O9/Qw+rg58/yRgiTaAvjRIua0nT6lzDFaFkWv+k8
fX5Z6p6HqOPoCs+UjjHjeU4seWJIyv4fd6XsElckcTe64lalxAHqCUyFKERW1nto
QSEytY/H++u1gonCch0uf7xKZ/jVDobsOEogTbVdBopSqWIbTBKcTS48AIIiUIu3
0KHFrsOTWgxDVOWZgQXGcUoDZUazulRRHmTy6yV/9SSD7reZyy0KtqRK7inyaoU6
THckG8hItxhPEO2/JtOCky1toPo9RvVcKy1b/qjTDY8SRY/RlXRKjODWB0DmODfZ
WjVeZlRN6CTDPqMw65LKT86vr4X8rKw5gfWR4yxMVu7cpU0FDpCYCf8CmRzz8Oai
GkXyVAs1gLn19F7au/tc923IeBtOzoSMar5MvsZ0QuKAx2ITS1cNXlvYqgGRXLVe
EwbRHVBtR6ubbFGNQ4bIqDCwfh+JjTYmYx+RCiNmQAwewKfrsX8nNul897uTutge
SMyeWnzzBdko0B0Acnvwy2IzlhKyI0KIpmUkRmrfQQh0ZVBjvZieP9ksL0Fgo2fC
etKQZioi7maSHYwWuj7J
=qLcb
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

--===============5096442939072299005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5096442939072299005==--
