From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input question: ambient light sensor button
Date: Tue, 26 Nov 2013 11:19:24 -0800
Message-ID: <20131126191924.GD22242@core.coreip.homeip.net>
References: <201309151553.34000@pali>
 <201311201550.05800@pali>
 <CAN+gG=HwuES-H4y5=_VcEQg4OiE2NYmra2+MzsbPusiOEq7Qsw@mail.gmail.com>
 <201311221213.49580@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56042 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab3KZTT2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 14:19:28 -0500
Content-Disposition: inline
In-Reply-To: <201311221213.49580@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Fri, Nov 22, 2013 at 12:13:49PM +0100, Pali Roh=E1r wrote:
> On Wednesday 20 November 2013 16:59:42 Benjamin Tissoires wrote:
> > Hi,
> >=20
> > On Wed, Nov 20, 2013 at 9:50 AM, Pali Roh=E1r <pali.rohar@gmail.com=
> wrote:
> > >> > > I guess we need patch adding
> > >> > >=20
> > >> > >   #define KEY_ALS_TOGGLE  0x230
> > >> > >=20
> > >> > > Thanks.
> > >> >=20
> > >> > So there is no good key for als yet?
> > >>=20
> > >> No, but if you send me a patch adding it I will gladly
> > >> apply it.
> > >>=20
> > >> Thanks.
> > >=20
> > > Ok, here is patch:
> > >=20
> > > Add key code for ambient light sensor button
> > >=20
> > > More notebooks have special button for enabling/disabling
> > > ambient light sensor. This patch adding new als code to
> > > input.h header file.
> > >=20
> > > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > >=20
> > > diff --git a/include/uapi/linux/input.h
> > > b/include/uapi/linux/input.h index a372627..1562f10 100644
> > > --- a/include/uapi/linux/input.h
> > > +++ b/include/uapi/linux/input.h
> > > @@ -719,6 +719,8 @@ struct input_keymap_entry {
> > >=20
> > >  #define BTN_DPAD_LEFT          0x222
> > >  #define BTN_DPAD_RIGHT         0x223
> > >=20
> > > +#define KEY_ALS_TOGGLE         0x230
> >=20
> > Could you just add a comment explaining that ALS is ambiant
> > light sensor? Otherwise, I'm sure someone else will use this
> > event code for an other thing... :)
> >=20
> > Cheers,
> > Benjamin
>=20
> Ok, here is new diff with comment:

Applied, thank you.

>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a372627..7bacdb5 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -719,6 +719,8 @@ struct input_keymap_entry {
>  #define BTN_DPAD_LEFT		0x222
>  #define BTN_DPAD_RIGHT		0x223
> =20
> +#define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
> +
>  #define BTN_TRIGGER_HAPPY		0x2c0
>  #define BTN_TRIGGER_HAPPY1		0x2c0
>  #define BTN_TRIGGER_HAPPY2		0x2c1
>=20
>=20
> --=20
> Pali Roh=E1r
> pali.rohar@gmail.com



--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
