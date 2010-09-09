From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 5/6] Input: ati-remote2 - switch to using new keycode
 interface
Date: Thu, 9 Sep 2010 15:40:04 +0300
Message-ID: <20100909124003.GT10135@sci.fi>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv>
 <20100908074205.32365.68835.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100908074205.32365.68835.stgit@hammer.corenet.prv>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, David Hardeman <david@hardeman.nu>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 08, 2010 at 12:42:05AM -0700, Dmitry Torokhov wrote:
> Switch the code to use new style of getkeycode and setkeycode
> methods to allow retrieving and setting keycodes not only by
> their scancodes but also by index.
>=20
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>=20
>  drivers/input/misc/ati_remote2.c |   93 +++++++++++++++++++++++++++-=
----------
>  1 files changed, 65 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/at=
i_remote2.c
> index 2325765..b2e0d82 100644
> --- a/drivers/input/misc/ati_remote2.c
> +++ b/drivers/input/misc/ati_remote2.c
> @@ -483,51 +483,88 @@ static void ati_remote2_complete_key(struct urb=
 *urb)
>  }
> =20
>  static int ati_remote2_getkeycode(struct input_dev *idev,
> -				  unsigned int scancode, unsigned int *keycode)
> +				  struct input_keymap_entry *ke)
>  {
>  	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
>  	unsigned int mode;
> -	int index;
> +	int offset;
> +	unsigned int index;
> +	unsigned int scancode;
> +
> +	if (ke->flags & INPUT_KEYMAP_BY_INDEX) {
> +		index =3D ke->index;
> +		if (index >=3D (ATI_REMOTE2_MODES - 1) *
                                               ^^^^
That -1 looks wrong. Same in setkeycode().

> +				ARRAY_SIZE(ati_remote2_key_table))
> +			return -EINVAL;
> +
> +		mode =3D ke->index / ARRAY_SIZE(ati_remote2_key_table);
> +		offset =3D ke->index % ARRAY_SIZE(ati_remote2_key_table);
> +		scancode =3D (mode << 8) + ati_remote2_key_table[offset].hw_code;
> +	} else {
> +		if (input_scancode_to_scalar(ke, &scancode))
> +			return -EINVAL;
> +
> +		mode =3D scancode >> 8;
> +		if (mode > ATI_REMOTE2_PC)
> +			return -EINVAL;
> +
> +		offset =3D ati_remote2_lookup(scancode & 0xff);
> +		if (offset < 0)
> +			return -EINVAL;
> +
> +		index =3D mode * ARRAY_SIZE(ati_remote2_key_table) + offset;
> +	}
> =20
> -	mode =3D scancode >> 8;
> -	if (mode > ATI_REMOTE2_PC || !((1 << mode) & ar2->mode_mask))
> -		return -EINVAL;

You're removing the mode_mask check here, but I think that's fine. I
don't see why the keymap shouldn't be allowed to be queried/modified fo=
r
the unused modes.

> +	ke->keycode =3D ar2->keycode[mode][offset];
> +	ke->len =3D sizeof(scancode);
> +	memcpy(&ke->scancode, &scancode, sizeof(scancode));

The scancodes fit into two bytes each. Does it matter that you're
using 4 bytes here?

> +	ke->index =3D index;
> =20
> -	index =3D ati_remote2_lookup(scancode & 0xFF);
> -	if (index < 0)
> -		return -EINVAL;
> -
> -	*keycode =3D ar2->keycode[mode][index];
>  	return 0;
>  }
> =20
>  static int ati_remote2_setkeycode(struct input_dev *idev,
> -				  unsigned int scancode, unsigned int keycode)
> +				  const struct input_keymap_entry *ke,
> +				  unsigned int *old_keycode)
>  {
>  	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> -	unsigned int mode, old_keycode;
> -	int index;
> -
> -	mode =3D scancode >> 8;
> -	if (mode > ATI_REMOTE2_PC || !((1 << mode) & ar2->mode_mask))
> -		return -EINVAL;
> -
> -	index =3D ati_remote2_lookup(scancode & 0xFF);
> -	if (index < 0)
> -		return -EINVAL;
> +	unsigned int mode;
> +	int offset;
> +	unsigned int index;
> +	unsigned int scancode;
> +
> +	if (ke->flags & INPUT_KEYMAP_BY_INDEX) {
> +		if (ke->index >=3D (ATI_REMOTE2_MODES - 1) *
> +				ARRAY_SIZE(ati_remote2_key_table))
> +			return -EINVAL;
> +
> +		mode =3D ke->index / ARRAY_SIZE(ati_remote2_key_table);
> +		offset =3D ke->index % ARRAY_SIZE(ati_remote2_key_table);
> +	} else {
> +		if (input_scancode_to_scalar(ke, &scancode))
> +			return -EINVAL;
> +
> +		mode =3D scancode >> 8;
> +		if (mode > ATI_REMOTE2_PC)
> +			return -EINVAL;
> +
> +		offset =3D ati_remote2_lookup(scancode & 0xff);
> +		if (offset < 0)
> +			return -EINVAL;
> +	}
> =20
> -	old_keycode =3D ar2->keycode[mode][index];
> -	ar2->keycode[mode][index] =3D keycode;
> -	__set_bit(keycode, idev->keybit);
> +	*old_keycode =3D ar2->keycode[mode][offset];
> +	ar2->keycode[mode][offset] =3D ke->keycode;
> +	__set_bit(ke->keycode, idev->keybit);
> =20
>  	for (mode =3D 0; mode < ATI_REMOTE2_MODES; mode++) {
>  		for (index =3D 0; index < ARRAY_SIZE(ati_remote2_key_table); index=
++) {
> -			if (ar2->keycode[mode][index] =3D=3D old_keycode)
> +			if (ar2->keycode[mode][index] =3D=3D *old_keycode)
>  				return 0;
>  		}
>  	}
> =20
> -	__clear_bit(old_keycode, idev->keybit);
> +	__clear_bit(*old_keycode, idev->keybit);
> =20
>  	return 0;
>  }
> @@ -575,8 +612,8 @@ static int ati_remote2_input_init(struct ati_remo=
te2 *ar2)
>  	idev->open =3D ati_remote2_open;
>  	idev->close =3D ati_remote2_close;
> =20
> -	idev->getkeycode =3D ati_remote2_getkeycode;
> -	idev->setkeycode =3D ati_remote2_setkeycode;
> +	idev->getkeycode_new =3D ati_remote2_getkeycode;
> +	idev->setkeycode_new =3D ati_remote2_setkeycode;
> =20
>  	idev->name =3D ar2->name;
>  	idev->phys =3D ar2->phys;
>=20

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
