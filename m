From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] input: New MATRIX_KEY macro
Date: Sun, 8 Feb 2009 08:40:36 -0800
Message-ID: <200902080840.36509.david-b@pacbell.net>
References: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com> <BD79186B4FD85F4B8E60E381CAEE19090120BD19@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:38004 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752336AbZBHQki (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 8 Feb 2009 11:40:38 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090120BD19@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Friday 06 February 2009, hartleys wrote:
> On Thursday, February 05, 2009 6:12 PM, David Brownell wrote:
> > On Friday 30 January 2009, hartleys wrote:
> >>> I'd support an overall cleanup patch that fixes all those things =
at once.
> >>
> >> How's this for a starting point? =A0I'm willing to create a cleanu=
p=20
> >> patch for all the mach-omap1, mach-omap2, and mach-pxa users.
> >>=20
> >> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> >
> > I think none of the twl4030 keypad users are in mainline, so far...
> >
> > My first reaction to this is that it's a bit incomplete.
> > It replaces only the KEY() macro in the $SUBJECT patch:
> >=20
> > - There are two more public ones (for board files):
> >     * KEY_PERSISTENT flags row/column values to ignore
> >     * PERSISTENT_KEY (sigh) generates a row/col entry
> >       with such a marking (instead of a keycode)
> > - Plus two driver-internal ones:
> >     * ROWCOL_MASK to strip R/C from KEY()
> >     * KEYCODE_MASK to stip the keycode from a KEY()
> >
> > If there is going to be something reusable across the whole input
> > subsystem (for drivers that don't need fancy stuff), it should
> > really address the whole problem...
> >
>=20
> Hello Dave,
>=20
> I'm responding to your comments through a different thread since I
> posted a patch series to handle this change.=20
>=20
> It appeared to me that only the KEY macro was common for the two
> keypad drivers that are currently in mainline.=20
>=20
> It does appear the two mask values should be added to input.h for
> completeness.=20
>=20
> #define MATRIX_ROWCOL_MASK	0xff000000
> #define MATRIX_KEYCODE_MASK	0x00ffffff

Obviously I'd do that the way I did it, though:  In terms
of the MATRIX_KEY() macro:  MATRIX_KEY(0x0f, 0x0f, 0) and
its bit-inverse, respectively.  Among other things that's
more obvious what's going on, and less breakable in the
face of changes to (a copy of) the MATRIX_KEY() macro.


> I wasn't quite sure what the KEY_PERSISTENT flag was for in your
> twl4030_keypad driver.  To me it seemed driver dependent and not
> generic.

Well, not "my" driver; I'm just sending it on for mainline.

The single use of that seems to be in arch/arm/mach-omap2/board-ldp.c
(not yet in mainline) where it flags a scancode to ignore.  That may
deserve a better treatment.



>=20
> Regards,
> Hartley
>=20
>=20
>=20
> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vge=
r.kernel.org] On Behalf Of hartleys
> Sent: Friday, January 30, 2009 11:46 AM
> To: linux-input@vger.kernel.org
> Subject: [PATCH 1/5] input: New MATRIX_KEY macro
>=20
> Introduce new macro to input.h for packing matrix keypad keycodes.
>=20
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>=20
> ---
>=20
> diff --git a/include/linux/input.h b/include/linux/input.h index 1249=
a0c..0879493 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -598,6 +598,14 @@ struct input_absinfo {
>  #define KEY_CNT			(KEY_MAX+1)
>=20
>  /*
> + * Macro to pack the row/col of a key on a matrix keypad and it's
> associated
> + * KEY_* code into into an array.  4 bits are used for both the row =
and
> column
> + * allowing for up to a 16x16 keypad.  The row (_r) and column (_c) =
are
> + * interchangable depending on a keypad drivers usage.
> + */
> +#define MATRIX_KEY(_r, _c, _v)	(((_r) << 28) | ((_c) << 24) | (_v))
> +
> +/*
>   * Relative axes
>   */
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in the body of a message to majordomo@vger.kernel.org More majordomo =
info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
