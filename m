From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: adp5589-keys: fix pull mask setting
Date: Wed, 6 May 2015 16:34:47 -0700
Message-ID: <20150506233447.GB5580@dtor-ws>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
 <1429626090-29022-3-git-send-email-guido@vanguardiasur.com.ar>
 <55366028.2010105@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35694 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbbEFXew (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 19:34:52 -0400
Received: by igbyr2 with SMTP id yr2so145473643igb.0
        for <linux-input@vger.kernel.org>; Wed, 06 May 2015 16:34:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55366028.2010105@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

On Tue, Apr 21, 2015 at 04:35:20PM +0200, Michael Hennerich wrote:
> On 04/21/2015 04:21 PM, Guido Mart=EDnez wrote:
> >The pull mask is created by looping each row (column) and building a=
n
> >8-bit integer with the configuration. It is written byte-by-byte, wh=
en
> >we reach the end of the rows (columns) or we're at the 3rd line (whi=
ch
> >finishes the first byte, since each pin is 2bits on the mask).
> >
> >However, this only works if we have at most 8 pins (2 bytes), which =
is
> >not the case for the ADP5589. So, write the byte at each boundary (e=
very
> >4 rows/columns).
> >
> >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Dec=
oder and I/O Expander')
> >Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Applied, thank you.

> >---
> >  drivers/input/keyboard/adp5589-keys.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/k=
eyboard/adp5589-keys.c
> >index 19edd2d..8709a7f 100644
> >--- a/drivers/input/keyboard/adp5589-keys.c
> >+++ b/drivers/input/keyboard/adp5589-keys.c
> >@@ -729,7 +729,7 @@ static int adp5589_setup(struct adp5589_kpad *kp=
ad)
> >  		pull_mask |=3D val << (2 * (i & 0x3));
> >-		if (i =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
> >+		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
> >  			ret |=3D adp5589_write(client, reg(ADP5585_RPULL_CONFIG_A)
> >  					     + (i >> 2), pull_mask);
> >  			pull_mask =3D 0;
> >@@ -749,7 +749,7 @@ static int adp5589_setup(struct adp5589_kpad *kp=
ad)
> >  		pull_mask |=3D val << (2 * (i & 0x3));
> >-		if (i =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
> >+		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
> >  			ret |=3D adp5589_write(client,
> >  					     reg(ADP5585_RPULL_CONFIG_C) +
> >  					     (i >> 2), pull_mask);
>=20
>=20
> --=20
> Greetings,
> Michael
>=20
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Marti=
n,
> Margaret Seif
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
