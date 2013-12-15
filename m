From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: input: Include appropriate header file in
 cyttsp_i2c_common.c
Date: Sun, 15 Dec 2013 02:27:46 -0800
Message-ID: <20131215102745.GA20197@core.coreip.homeip.net>
References: <20131214133822.GA13124@rashika>
 <20131214205752.GS17601@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41531 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab3LOK1z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Dec 2013 05:27:55 -0500
Content-Disposition: inline
In-Reply-To: <20131214205752.GS17601@leaf>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, Ferruh Yigit <fery@cypress.com>, linux-input@vger.kernel.org

On Sat, Dec 14, 2013 at 12:57:52PM -0800, Josh Triplett wrote:
> On Sat, Dec 14, 2013 at 07:08:22PM +0530, Rashika Kheria wrote:
> > This patch includes appropriate header file cyttsp4_core.h in
> > touchscreen/cyttsp_i2c_common.c because functions
> > cyttsp_i2c_read_block_data() and cyttsp_i2c_write_block_data()
> > have their prototype declaration in cyttsp4_core.h.
> >=20
> > Thus, it also eliminates the following warning in cyttsp_i2c_common=
=2Ec:
> > drivers/input/touchscreen/cyttsp_i2c_common.c:34:5: warning: no pre=
vious prototype for =E2=80=98cyttsp_i2c_read_block_data=E2=80=99 [-Wmis=
sing-prototypes]
> > drivers/input/touchscreen/cyttsp_i2c_common.c:64:5: warning: no pre=
vious prototype for =E2=80=98cyttsp_i2c_write_block_data=E2=80=99 [-Wmi=
ssing-prototypes]
> >=20
> >=20
> > Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
>=20
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Applied, thank you.

>=20
> >  drivers/input/touchscreen/cyttsp_i2c_common.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/input/touchscreen/cyttsp_i2c_common.c b/driver=
s/input/touchscreen/cyttsp_i2c_common.c
> > index 1d7b6f1..ccefa56 100644
> > --- a/drivers/input/touchscreen/cyttsp_i2c_common.c
> > +++ b/drivers/input/touchscreen/cyttsp_i2c_common.c
> > @@ -31,6 +31,8 @@
> >  #include <linux/module.h>
> >  #include <linux/types.h>
> > =20
> > +#include "cyttsp4_core.h"
> > +
> >  int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf,
> >  				      u16 addr, u8 length, void *values)
> >  {
> > --=20
> > 1.7.9.5
> >=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
