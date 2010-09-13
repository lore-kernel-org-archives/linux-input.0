From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] Input: ati-remote2 - switch to using new keycode
 interface
Date: Mon, 13 Sep 2010 09:28:07 -0700
Message-ID: <20100913162807.GA14598@core.coreip.homeip.net>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv>
 <20100908074205.32365.68835.stgit@hammer.corenet.prv>
 <20100909124003.GT10135@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64895 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0IMQ2T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:28:19 -0400
Content-Disposition: inline
In-Reply-To: <20100909124003.GT10135@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, David Hardeman <david@hardeman.nu>, Jiri Kosina <jkosina@suse.cz>

On Thu, Sep 09, 2010 at 03:40:04PM +0300, Ville Syrj=E4l=E4 wrote:
> On Wed, Sep 08, 2010 at 12:42:05AM -0700, Dmitry Torokhov wrote:
> > Switch the code to use new style of getkeycode and setkeycode
> > methods to allow retrieving and setting keycodes not only by
> > their scancodes but also by index.
> >=20
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >=20
> >  drivers/input/misc/ati_remote2.c |   93 ++++++++++++++++++++++++++=
+-----------
> >  1 files changed, 65 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/=
ati_remote2.c
> > index 2325765..b2e0d82 100644
> > --- a/drivers/input/misc/ati_remote2.c
> > +++ b/drivers/input/misc/ati_remote2.c
> > @@ -483,51 +483,88 @@ static void ati_remote2_complete_key(struct u=
rb *urb)
> >  }
> > =20
> >  static int ati_remote2_getkeycode(struct input_dev *idev,
> > -				  unsigned int scancode, unsigned int *keycode)
> > +				  struct input_keymap_entry *ke)
> >  {
> >  	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> >  	unsigned int mode;
> > -	int index;
> > +	int offset;
> > +	unsigned int index;
> > +	unsigned int scancode;
> > +
> > +	if (ke->flags & INPUT_KEYMAP_BY_INDEX) {
> > +		index =3D ke->index;
> > +		if (index >=3D (ATI_REMOTE2_MODES - 1) *
>                                                ^^^^
> That -1 looks wrong. Same in setkeycode().
>=20

Yes, indeed. Thanks for noticing.

> > +				ARRAY_SIZE(ati_remote2_key_table))
> > +			return -EINVAL;
> > +
> > +		mode =3D ke->index / ARRAY_SIZE(ati_remote2_key_table);
> > +		offset =3D ke->index % ARRAY_SIZE(ati_remote2_key_table);
> > +		scancode =3D (mode << 8) + ati_remote2_key_table[offset].hw_code=
;
> > +	} else {
> > +		if (input_scancode_to_scalar(ke, &scancode))
> > +			return -EINVAL;
> > +
> > +		mode =3D scancode >> 8;
> > +		if (mode > ATI_REMOTE2_PC)
> > +			return -EINVAL;
> > +
> > +		offset =3D ati_remote2_lookup(scancode & 0xff);
> > +		if (offset < 0)
> > +			return -EINVAL;
> > +
> > +		index =3D mode * ARRAY_SIZE(ati_remote2_key_table) + offset;
> > +	}
> > =20
> > -	mode =3D scancode >> 8;
> > -	if (mode > ATI_REMOTE2_PC || !((1 << mode) & ar2->mode_mask))
> > -		return -EINVAL;
>=20
> You're removing the mode_mask check here, but I think that's fine. I
> don't see why the keymap shouldn't be allowed to be queried/modified =
for
> the unused modes.

Rigth, that was my justification for removal of the check.

>=20
> > +	ke->keycode =3D ar2->keycode[mode][offset];
> > +	ke->len =3D sizeof(scancode);
> > +	memcpy(&ke->scancode, &scancode, sizeof(scancode));
>=20
> The scancodes fit into two bytes each. Does it matter that you're
> using 4 bytes here?

The old interface used 4 bytes and I think it just easier this way. I
think userspace will default to 4-byte scancodes unless they know they
need to handle bigger ones.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
