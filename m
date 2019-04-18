From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 09/26] compat_ioctl: move drivers to compat_ptr_ioctl
Date: Thu, 18 Apr 2019 12:10:17 +0100
Message-ID: <20190418111017.GE23876@stefanha-x1.localdomain>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-10-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-10-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@mellanox.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Tomas Winkler <tomas.winkler@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod>
List-Id: linux-input@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 10:19:47PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
>=20
> We now have a generic implementation of that, so use it.
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/ppdev.c              | 12 +---------
>  drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
>  drivers/firewire/core-cdev.c      | 12 +---------
>  drivers/hid/usbhid/hiddev.c       | 11 +--------
>  drivers/hwtracing/stm/core.c      | 12 +---------
>  drivers/misc/mei/main.c           | 22 +----------------
>  drivers/mtd/ubi/cdev.c            | 36 +++-------------------------
>  drivers/net/tap.c                 | 12 +---------
>  drivers/staging/pi433/pi433_if.c  | 12 +---------
>  drivers/usb/core/devio.c          | 16 +------------
>  drivers/vfio/vfio.c               | 39 +++----------------------------
>  drivers/vhost/net.c               | 12 +---------
>  drivers/vhost/scsi.c              | 12 +---------
>  drivers/vhost/test.c              | 12 +---------
>  drivers/vhost/vsock.c             | 12 +---------
>  fs/fat/file.c                     | 13 +----------
>  16 files changed, 20 insertions(+), 237 deletions(-)

The vhost parts look good:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcuFsZAAoJEJykq7OBq3PIjmUH/3YzT8r/nZGWhf+D9Jhao8p9
N6eNCnBkQtsAj+s6IhmhZxdmPlkw0b8X0ws3iIw/zE3PNeLtIt2hG92evE9QSRzD
dkSG0m+8KJ1fQK73GrmLousrFnSOagczYoTD/svPhC3WMptVGlPB4aqBZO4Eh79w
SyUrD7cXe2NQXUFVRI9/QVj+yu59BtvUivzkDwGZxYa5Y8RvwDvelz+xTAkKP/cl
CZ9Gnc2gCrzuK26f5odjmby93QWbAVkiMe5k22pzy/RRpuzsijL5ujr+Ayeti45g
cDTLJ4YjNSzM07rYoa8nqHgZATbSokG/gvbNByeC//MoqtmpE23wNzmMwuFJdi8=
=85Rm
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
