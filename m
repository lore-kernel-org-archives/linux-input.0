From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 10:37:57 +0200
Message-ID: <20140717083756.GA19686@ulmo>
References: <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at>
 <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at>
 <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com>
 <53C47725.8000005@gmail.com> <53C47B76.4080306@roeck-us.net>
 <53C47FB7.6080304@gmail.com> <53C53CE1.4090803@gmail.com>
 <53C7269E.4010702@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3884258058119984702=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C7269E.4010702@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, arnd@arndb.de, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org


--===============3884258058119984702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 09:27:58AM +0800, Chen Gang wrote:
[...]
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c2421e0..a7500c3 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -630,7 +630,16 @@ extern unsigned long devm_get_free_pages(struct devi=
ce *dev,
>  					 gfp_t gfp_mask, unsigned int order);
>  extern void devm_free_pages(struct device *dev, unsigned long addr);
> =20
> +#ifdef CONFIG_HAS_IOMEM
>  void __iomem *devm_ioremap_resource(struct device *dev, struct resource =
*res);
> +#elif defined(CONFIG_COMPILE_TEST)
> +static inline void __iomem *devm_ioremap_resource(struct device *dev,
> +						struct resource *res)
> +{
> +	pr_warn("no hardware io memory, only for COMPILE_TEST\n");

Maybe: "Hardware doesn't support memory-mapped I/O"? I'm not sure if
it's useful to include the reference to COMPILE_TEST, especially since
the #elif will be dropped in favour of a simple #else.

> +	return (__force void __iomem *)ERR_PTR(-ENXIO);

There's apparently an IOMEM_ERR_PTR() for this nowadays...

> +}
> +#endif /* CONFIG_HAS_IOMEM || CONFIG_COMPILE_TEST */
> =20
>  /* allows to add/remove a custom action to devres stack */
>  int devm_add_action(struct device *dev, void (*action)(void *), void *da=
ta);
> diff --git a/include/linux/io.h b/include/linux/io.h
> index b76e6e5..59128aa 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -58,14 +58,42 @@ static inline void devm_ioport_unmap(struct device *d=
ev, void __iomem *addr)
>  }
>  #endif
> =20
> +#ifdef CONFIG_HAS_IOMEM
> +
>  void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  			    unsigned long size);
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t o=
ffset,
>  				    unsigned long size);
>  void devm_iounmap(struct device *dev, void __iomem *addr);
> +void devm_ioremap_release(struct device *dev, void *res);
> +
> +#elif defined(CONFIG_COMPILE_TEST)
> +
> +static inline void __iomem *devm_ioremap(struct device *dev,
> +				resource_size_t offset, unsigned long size)

For consistency with other functions above, please keep arguments on
subsequent lines aligned with the first argument on the first line, like
so:

static inline void __iomem *devm_ioremap(struct device *dev,
					 resource_size_t offset,
					 unsigned long size)

> +{
> +	pr_warn("no hardware io memory, only for COMPILE_TEST\n");
> +	return NULL;
> +}
> +static inline void __iomem *devm_ioremap_nocache(struct device *dev,
> +				resource_size_t offset, unsigned long size)
> +{
> +	pr_warn("no hardware io memory, only for COMPILE_TEST\n");
> +	return NULL;
> +}

Perhaps this should call devm_ioremap() so we don't have to repeat the
same error message? Or maybe make it:

	#define devm_ioremap_nocache devm_ioremap

?

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx4tkAAoJEN0jrNd/PrOhPFsP/RtP+U7gdFVyMKLDo+VHJhfM
jUloIvPcehSqMA6dMW8RY5HcbHi4cDgtRSzTD+PsP+xmOmhsYyljZo8zRQUWUEzj
/oQ0/EGapQssJVPDzlwcw5hM1aIgMJ6Prte4JXDgNG0a/HtJYszSRCrjuqydFHgX
2nR7cJwABSAmCauB0ZciqyePMlIFArNeUzIIN6DvfnAhAsBC2IMSpHaa20Fd+9En
/nv2pN21Rkzis/521g6ECEdivS5SkIBuDMAa9bHvU7tRzae08Gdoa/MhAW8bP4SA
vh09U76m3W+eyvSiNAmrJ5ROIZBFTxewmDIxYFgdk1JCr5J/QyUTERPWNqxdiQG1
Ur6oPZ0C/j/Xi25w2oXSIojc1hMofYRIKVX3dDoRScjG1ylOtyW8gP3fjaHUW2gR
whwAJYkEWnRebJqpCBLlE2vu3DjNlDSMmAs9oYk9FO1dHxKdtucl0jw9YMRHaRHz
9KK5MnWwDune9dZM1MJYL6xGcPSrpCruW26Af4i9xMYjzlGiOJPE3FD8Ppu6R/iN
Jo8bF5N8Q38mqwetLRGaR36tdu+sfc2xhWi7O1CXrBzYq96hm62JIILTTdAFhHkZ
0kZ/OY9zudihO3kRAmTHGU1VcBfAc0COzjQMlCAtuFbXBBYnby2U8AvLwLiMdKb9
k/sXMgNrAeZRiM8ThB8D
=enXN
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============3884258058119984702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3884258058119984702==--
