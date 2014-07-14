From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Mon, 14 Jul 2014 10:18:10 +0200
Message-ID: <20140714081809.GJ2081@ulmo>
References: <53C1F7DE.3060102@gmail.com> <201407130545.23004.marex@denx.de>
 <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
 <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de>
 <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de>
 <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de>
 <20140713192202.GA19090@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3240095306049651059=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140713192202.GA19090@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Chen Gang <gang.chen.5i5j@gmail.com>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jic23@kernel.org, teg@jklm.no, Martin Schwidefsky <schwidefsky@de.ibm.com>, msalter@redhat.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, knaack.h@gmx.de, devel@driverdev.osuosl.org, linux-input@vger.kernel.org, Mischa.Jonker@synopsys.com, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--===============3240095306049651059==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Content-Disposition: inline


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2014 at 12:22:02PM -0700, Greg Kroah-Hartman wrote:
> On Sun, Jul 13, 2014 at 04:25:06PM +0200, Lars-Peter Clausen wrote:
> > On 07/13/2014 04:03 PM, Richard Weinberger wrote:
> > >Am 13.07.2014 15:56, schrieb Lars-Peter Clausen:
> > >>On 07/13/2014 03:40 PM, Richard Weinberger wrote:
> > >>>Am 13.07.2014 15:26, schrieb Lars-Peter Clausen:
> > >>>>On 07/13/2014 11:45 AM, Richard Weinberger wrote:
> > >>>>>Am 13.07.2014 11:27, schrieb Lennox Wu:
> > >>>>>>As I said before, some configurations don't make sense.
> > >>>>>
> > >>>>>If such a configuration can be achieved using allmod/yesconfig it =
has to be fixed.
> > >>>>>Chen's fixes seem reasonable as not all architectures support iome=
m.
> > >>>>
> > >>>>Maybe we should stub out ioremap() and friends when COMPILE_TEST is=
 enabled to avoid these linker errors. That's in my opinion better than tur=
ning most of the 'depends on
> > >>>>COMPILE_TEST' into 'depends on COMPILE_TEST && HAS_IOMEM'. The issu=
e comes up quite a lot and it is often overlooked when adding a driver that=
 can be build when COMPILE_TEST is
> > >>>>enabled.
> > >>>
> > >>>And what should this stub do?
> > >>>Except calling BUG()...
> > >>
> > >>return NULL;
> > >>
> > >>It's for compile testing, it's not meant to work at runtime.
> > >
> > >Hm, I really don't like the idea of having a non-working kernel.
> > >IMHO either it should build _and_ run and nothing else.
> > >Greg, what do you think?
> >=20
> > The kernel will still be working fine and you can run it on a system. T=
he
> > drivers which use ioremap() or similar are probably not instantiated on=
 a
> > system that does not provide HAS_IOMEM. But even if it was the driver s=
hould
> > handle ioremap() returning NULL gracefully and abort the driver probe. =
That
> > said you'll probably not run a kernel that was built with COMPILE_TEST =
on
> > your real hardware since it contains so many drivers that are completely
> > useless on your hardware. The idea of COMPILE_TEST is to have as much
> > compile test exposure as possible to the code that is enabled by
> > COMPILE_TEST. Stubbing out ioremap() and friends when HAS_IOMEM is not =
set
> > and COMPILE_TEST is set makes it easier to get there.
>=20
> I run my kernels with COMPILE_TEST enabled as I need to build test
> things that I don't happen to use.
>=20
> I like the 'return NULL' option for this, it hits us all the time, might
> as well fix it properly like this so that we don't have to deal with
> Kconfig changes everywhere.

I agree. One nit, though: devm_ioremap_resource() returns an ERR_PTR()-
encoded error code, so the dummy should probably be returning something
like ERR_PTR(-ENOSYS) instead of NULL.

> Also put a big "This platform does not support IOMEM" error printk in
> there, so that people have a chance to figure out what is going on if
> they happen to run such a driver on a platform that can't support it.

Yes, that sounds like a very good idea and should be indication enough
of what exactly has gone wrong.

Thierry

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTw5JBAAoJEN0jrNd/PrOhjqEP/2Ul93ulC/7A4lZBNo6jm7bH
9iCLPnVC8QWk77FXi9HOB2yVjGsyYjtMApBSwj7DfYsxu/FBhOG6lXcVMIPhs2Kx
rByJ+QQON/YRcVzDYvI7HoOqcMFxaA60A/DfRE1S4rBxPJ+THR3cEx1jIvyIvz/+
tSNkHPvV/5qu2jq4KXX2jMaY1L9xyD7TNVV9jDjKK/qIa5d9VZ8qehfy/t/cp7sW
jsN/XkDJCcvmPMbw+M4zHtm2MtDoZbnf32XL8geE3OjxdTY3DLJ6aHKCuKeaPx5P
guVXbvbtHWuqP2WXPrSQV2qiPX+xgICrZirygy7hfqmvouomDT6AzdwhrQyDOZLM
nScJYZP1PWvbh4bKTFCOymf/K36QQciZZLVl20JLAqF9SVN2ew1bv3g6YrXVNYNg
klOQFwRQ8TLUDSsSZtj/rMpr1sB7hdtMPTHjF4m+kcvAq1g8OfAHOT4EFXRdQqjq
c5W508a/Vffnm+uBJjiGlzT87IHHUQ1GJ22EXNmKJHEr2H7ril8yMBMzUTB4uzOJ
z9OBk5+gmNihzMaL2HcbIEsBBH88ymozpNQOHI3P857b7Esrfwkce1S3K2TWfAdx
bn58JkyfJlGMiRVvL4GrhIzd75yUrKU+GdplUmqzYS7bMmv1jwxC1ZQ/VmhInOG8
sSUlOlxTRVflqAJBcp/e
=q6Y2
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--

--===============3240095306049651059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3240095306049651059==--
