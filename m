From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 loadable keymap support
Date: Tue, 8 Apr 2008 23:18:26 +0300
Message-ID: <20080408201826.GG16619@sci.fi>
References: <200804051930.10574.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:51397 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbYDHUS2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Apr 2008 16:18:28 -0400
Content-Disposition: inline
In-Reply-To: <200804051930.10574.linux@dadeos.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stokes <linux@dadeos.co.uk>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, dmitry.torokhov@gmail.com

On Sat, Apr 05, 2008 at 07:30:10PM +0100, Peter Stokes wrote:
> The attached patch adds support for loadable key maps support to the=20
> ati_remote2 driver.
>=20
> This patch is similar to the previous version that I originally poste=
d on 16th=20
> February 2008. As requested, I have removed the code that reconfigure=
d this=20
> driver to utilise the input core's built in soft auto repeat function=
ality.=20
> Those changes are pending further clarification on how buttons that s=
hould=20
> not be auto repeated (e.g. mouse buttons) can be excluded from the so=
ft auto=20
> repeat implementation.
>=20
> On Tuesday 04 March 2008 22:17:49 Ville Syrj=E4l=E4 wrote:
> > However, since that seems unlikely to happen, and the input core al=
ready
> > has support for keymaps I'm fine with adding the set/getkeycode stu=
ff.
> > What I'd like to drop is the support for five different keymaps sin=
ce
> > AFAICS that could be handled in a more generic way in user space.
>=20
> I do not agree that the opportunity to remap the resultant keycode ge=
nerated=20
> from any given physical key on the remote dependant upon which 'mode'=
 the=20
> remote is currently in should be dropped. Consequently I have left th=
e=20
> implementation in the attached patch.
>=20
> I feel that a valid way of thinking about this implementation is that=
 the=20
> hardware scancodes consist of the mode and key bytes combined. Given =
any such=20
> implementation it could be assumed that the device has 5 x 46 =3D 230=
 keys, it=20
> therefore seems entirely reasonable to me to provide a mechanism by w=
hich any=20
> of those keys can be remapped.
>=20
> On Tuesday 04 March 2008 20:38:22 Ville Syrj=E4l=E4 wrote:
> > I think you could implement the multiple keymaps thing rather trivi=
ally
> > in user space by having a small daemon listening on the event devic=
e
> > and loading a new keymap when a mode key is pressed. That would lim=
it
> > the changes to the driver, and it would not require any kernel chan=
ges
> > when if you would need to adapt it to a device that uses a differen=
t
> > driver.
>=20
> I do not agree that it this functionality would be trivial to impleme=
nt in=20
> user space. The primary purpose behind making these changes is to pro=
vide=20
> full access to all of the keys within X windows, as such one is depen=
dant=20
> upon the X input system interfacing to the event device. The goal is =
to make=20
> this device behave as a regular keyboard, not requiring any special c=
ase code=20
> in any application the user might wish to control using it.

Userspace keymap handling would not require any special case code in
many applications. It would just need a small daemon that would react
to the mode keys and reload the keymap. Getting such a thing
packaged/distributed might be a bigger challenge though, so if you
really want to have it in the kernel driver I can live with it :)

> I do not feel that my proposed code changes are particularly invasive=
=2E I would=20
> accept that the static table outlining the default keycode mappings=20
> represents a reasonable change. Whilst this table could be eliminated=
 (and=20
> generated programmatically) I feel that it serves in some part toward=
s=20
> documenting the implementation.

It does increase the module size though.

> All of the changes proposed have no effect upon the operation of the =
driver=20
> out-of-the-box they merely provide a mechanism by which an end user c=
an=20
> configure their setup to function as they desire.
>=20
> Best regards
>=20
> Peter Stokes
>=20
>=20

> Signed-off-by: Peter Stokes <linux@dadeos.co.uk>
>=20
>=20
> --- linux-2.6.24-orig/drivers/input/misc/ati_remote2.c	2008-01-24 22:=
58:37.000000000 +0000
> +++ linux-2.6.24/drivers/input/misc/ati_remote2.c	2008-04-05 18:34:31=
=2E000000000 +0100
> @@ -2,7 +2,7 @@
>   * ati_remote2 - ATI/Philips USB RF remote driver
>   *
>   * Copyright (C) 2005 Ville Syrjala <syrjala@sci.fi>
> - * Copyright (C) 2007 Peter Stokes <linux@dadeos.freeserve.co.uk>
> + * Copyright (C) 2007 Peter Stokes <linux@dadeos.co.uk>

2008?

>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2
> @@ -12,7 +12,7 @@
>  #include <linux/usb/input.h>
> =20
>  #define DRIVER_DESC    "ATI/Philips USB RF remote driver"
> -#define DRIVER_VERSION "0.2"
> +#define DRIVER_VERSION "0.3"
> =20
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_VERSION(DRIVER_VERSION);
> @@ -27,7 +27,7 @@
>   * A remote's "channel" may be altered by pressing and holding the "=
PC" button for
>   * approximately 3 seconds, after which the button will slowly flash=
 the count of the
>   * currently configured "channel", using the numeric keypad enter a =
number between 1 and
> - * 16 and then the "PC" button again, the button will slowly flash t=
he count of the
> + * 16 and then press the "PC" button again, the button will slowly f=
lash the count of the
>   * newly configured "channel".
>   */

Unrelated change. I saw a couple of other unrelated changes too (just
changing the whitespace) further down.

> =20
> @@ -45,61 +45,66 @@
>  };
>  MODULE_DEVICE_TABLE(usb, ati_remote2_id_table);
> =20
> +
> +static u8 ati_remote2_modes[] =3D {
> +	0x01, /* AUX1 */
> +	0x02, /* AUX2 */
> +	0x04, /* AUX3 */
> +	0x08, /* AUX4 */
> +	0x10, /* PC   */
> +};

It seems you only use this table to get the number of modes. A define
would suffice.

>  static struct {
> -	int hw_code;
> -	int key_code;
> -} ati_remote2_key_table[] =3D {
> -	{ 0x00, KEY_0 },
> -	{ 0x01, KEY_1 },
> -	{ 0x02, KEY_2 },
> -	{ 0x03, KEY_3 },
> -	{ 0x04, KEY_4 },
> -	{ 0x05, KEY_5 },
> -	{ 0x06, KEY_6 },
> -	{ 0x07, KEY_7 },
> -	{ 0x08, KEY_8 },
> -	{ 0x09, KEY_9 },
> -	{ 0x0c, KEY_POWER },
> -	{ 0x0d, KEY_MUTE },
> -	{ 0x10, KEY_VOLUMEUP },
> -	{ 0x11, KEY_VOLUMEDOWN },
> -	{ 0x20, KEY_CHANNELUP },
> -	{ 0x21, KEY_CHANNELDOWN },
> -	{ 0x28, KEY_FORWARD },
> -	{ 0x29, KEY_REWIND },
> -	{ 0x2c, KEY_PLAY },
> -	{ 0x30, KEY_PAUSE },
> -	{ 0x31, KEY_STOP },
> -	{ 0x37, KEY_RECORD },
> -	{ 0x38, KEY_DVD },
> -	{ 0x39, KEY_TV },
> -	{ 0x54, KEY_MENU },
> -	{ 0x58, KEY_UP },
> -	{ 0x59, KEY_DOWN },
> -	{ 0x5a, KEY_LEFT },
> -	{ 0x5b, KEY_RIGHT },
> -	{ 0x5c, KEY_OK },
> -	{ 0x78, KEY_A },
> -	{ 0x79, KEY_B },
> -	{ 0x7a, KEY_C },
> -	{ 0x7b, KEY_D },
> -	{ 0x7c, KEY_E },
> -	{ 0x7d, KEY_F },
> -	{ 0x82, KEY_ENTER },
> -	{ 0x8e, KEY_VENDOR },
> -	{ 0x96, KEY_COFFEE },
> -	{ 0xa9, BTN_LEFT },
> -	{ 0xaa, BTN_RIGHT },
> -	{ 0xbe, KEY_QUESTION },
> -	{ 0xd5, KEY_FRONT },
> -	{ 0xd0, KEY_EDIT },
> -	{ 0xf9, KEY_INFO },
> -	{ (0x00 << 8) | 0x3f, KEY_PROG1 },
> -	{ (0x01 << 8) | 0x3f, KEY_PROG2 },
> -	{ (0x02 << 8) | 0x3f, KEY_PROG3 },
> -	{ (0x03 << 8) | 0x3f, KEY_PROG4 },
> -	{ (0x04 << 8) | 0x3f, KEY_PC },
> -	{ 0, KEY_RESERVED }
> +	u8  hwcode;
> +	u16 keycode[ARRAY_SIZE(ati_remote2_modes)];
> +} ati_remote2_keycodes[] =3D {
> +/*	 hwcode   AUX1             AUX2             AUX3             AUX4=
             PC                */

checkpatch.pl doesn't like these long lines.

>  struct ati_remote2 {
> @@ -117,6 +122,8 @@
> =20
>  	char name[64];
>  	char phys[64];
> +
> +	u32 keycode[ARRAY_SIZE(ati_remote2_keycodes)][ARRAY_SIZE(ati_remote=
2_modes)];

Somehow it would seem more natural to me if you would swap the array
dimensions. But that's a minor issue and you can leave it like this if
you prefer.

>  };
> =20
>  static int ati_remote2_probe(struct usb_interface *interface, const =
struct usb_device_id *id);
> @@ -159,11 +166,84 @@
>  	usb_kill_urb(ar2->urb[1]);
>  }
> =20
> +static int ati_remote2_lookup(u8 hwcode)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ati_remote2_keycodes); i++)
> +		if (ati_remote2_keycodes[i].hwcode =3D=3D hwcode)
> +			return i;
> +
> +	return -1;
> +}
> +
> +static int ati_remote2_getkeycode(struct input_dev *idev,
> +				  int scancode, int *keycode)
> +{
> +	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> +	int index, mode;
> +
> +	if (((scancode >> 8) & mode_mask) !=3D (scancode >> 8))
> +		return -EINVAL;
> +
> +	index =3D ati_remote2_lookup(scancode & 0xFF);
> +	if (index =3D=3D -1)
> +		return -EINVAL;
> +
> +	for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> +		if ((1 << mode) & (scancode >> 8)) {
> +			*keycode =3D ar2->keycode[index][mode];
> +			return 0;
> +		}
> +	}

Is there a reason you using the high bits like a mask? IIRC the hardwar=
e
mode byte isn't a mask. So something like this should do:

mode =3D scancode >> 8;
if (mode < 0 || mode > MAX_MODE)
	return -EINVAL;
index =3D ati_remote2_lookup(scancode & 0xff);
if (index < 0)
	return -EINVAL;


I'm not sure if mode_mask should affect the keymap handling at all sinc=
e both
can be changed runtime.

> +
> +	return -EINVAL;
> +}
> +
> +static int ati_remote2_setkeycode(struct input_dev *idev,
> +				  int scancode, int keycode)
> +{
> +	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> +	int old_keycode =3D -1;
> +	int index, mode;
> +
> +	if (((scancode >> 8) & mode_mask) !=3D (scancode >> 8))
> +		return -EINVAL;
> +

Same comments as above.

> +	index =3D ati_remote2_lookup(scancode & 0xFF);
> +	if (index =3D=3D -1)
> +		return -EINVAL;
> +
> +	if (keycode < 0 || keycode > KEY_MAX)

Are KEY_RESERVED/KEY_MAX valid here?

> +		return -EINVAL;
> +
> +	for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> +		if ((1 << mode) & (scancode >> 8)) {
> +			old_keycode =3D ar2->keycode[index][mode];
> +			ar2->keycode[index][mode] =3D keycode;
> +		}
> +	}
> +
> +	set_bit(keycode, idev->keybit);
> +
> +	for (index =3D 0; index < ARRAY_SIZE(ati_remote2_keycodes); index++=
) {
> +		for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> +			if (ar2->keycode[index][mode] =3D=3D old_keycode)
> +				return 0;
> +		}
> +	}

Because of using the scancode high bits as a mask this could leave some
bits set even though they are no longer in the map.

> +
> +	clear_bit(old_keycode, idev->keybit);
> +
> +	return 0;
> +}
> +
> +
>  static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
>  {
>  	struct input_dev *idev =3D ar2->idev;
>  	u8 *data =3D ar2->buf[0];
> -	int channel, mode;
> +	u8 channel, mode;
> =20
>  	channel =3D data[0] >> 4;
> =20
> @@ -187,22 +267,12 @@
>  	input_sync(idev);
>  }
> =20
> -static int ati_remote2_lookup(unsigned int hw_code)
> -{
> -	int i;
> -
> -	for (i =3D 0; ati_remote2_key_table[i].key_code !=3D KEY_RESERVED; =
i++)
> -		if (ati_remote2_key_table[i].hw_code =3D=3D hw_code)
> -			return i;
> -
> -	return -1;
> -}
> -
>  static void ati_remote2_input_key(struct ati_remote2 *ar2)
>  {
>  	struct input_dev *idev =3D ar2->idev;
>  	u8 *data =3D ar2->buf[1];
> -	int channel, mode, hw_code, index;
> +	u8 channel, mode;
> +	int index;
> =20
>  	channel =3D data[0] >> 4;
> =20
> @@ -218,12 +288,10 @@
>  		return;
>  	}
> =20
> -	hw_code =3D data[2];
> -	/*
> -	 * Mode keys (AUX1-AUX4, PC) all generate the same code byte.
> -	 * Use the mode byte to figure out which one was pressed.
> -	 */
> -	if (hw_code =3D=3D 0x3f) {
> +	if (!((1 << mode) & mode_mask))
> +		return;
> +
> +	if (data[2] =3D=3D 0x3f) {
>  		/*
>  		 * For some incomprehensible reason the mouse pad generates
>  		 * events which look identical to the events from the last
> @@ -236,14 +304,9 @@
> =20
>  		if (data[1] =3D=3D 0)
>  			ar2->mode =3D mode;
> -
> -		hw_code |=3D mode << 8;
>  	}
> =20
> -	if (!((1 << mode) & mode_mask))
> -		return;

Moving this test before updating ar2->mode could leave the driver
unaware of the actual mode it's in. I think it could leave to key=20
events getting through from the mouse at least when mode_mask is
suitably changed runtime. Was there a reason for this change?

> -
> -	index =3D ati_remote2_lookup(hw_code);
> +	index =3D ati_remote2_lookup(data[2]);
>  	if (index < 0) {
>  		dev_err(&ar2->intf[1]->dev,
>  			"Unknown code byte (%02x %02x %02x %02x)\n",
> @@ -260,8 +323,7 @@
>  	case 2:	/* repeat */
> =20
>  		/* No repeat for mouse buttons. */
> -		if (ati_remote2_key_table[index].key_code =3D=3D BTN_LEFT ||
> -		    ati_remote2_key_table[index].key_code =3D=3D BTN_RIGHT)
> +		if (data[2] =3D=3D 0xa9 || data[2] =3D=3D 0xaa)
>  			return;
> =20
>  		if (!time_after_eq(jiffies, ar2->jiffies))
> @@ -276,7 +338,7 @@
>  		return;
>  	}
> =20
> -	input_event(idev, EV_KEY, ati_remote2_key_table[index].key_code, da=
ta[1]);
> +	input_event(idev, EV_KEY, ar2->keycode[index][mode], data[1]);
>  	input_sync(idev);
>  }
> =20
> @@ -334,10 +396,11 @@
>  			"%s(): usb_submit_urb() =3D %d\n", __FUNCTION__, r);
>  }
> =20
> +
>  static int ati_remote2_input_init(struct ati_remote2 *ar2)
>  {
>  	struct input_dev *idev;
> -	int i, retval;
> +	int index, mode, retval;
> =20
>  	idev =3D input_allocate_device();
>  	if (!idev)
> @@ -347,11 +410,15 @@
>  	input_set_drvdata(idev, ar2);
> =20
>  	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) | BIT_MASK(E=
V_REL);
> -	idev->keybit[BIT_WORD(BTN_MOUSE)] =3D BIT_MASK(BTN_LEFT) |
> -		BIT_MASK(BTN_RIGHT);
> +	idev->keybit[BIT_WORD(BTN_MOUSE)] =3D BIT_MASK(BTN_LEFT) | BIT_MASK=
(BTN_RIGHT);
>  	idev->relbit[0] =3D BIT_MASK(REL_X) | BIT_MASK(REL_Y);
> -	for (i =3D 0; ati_remote2_key_table[i].key_code !=3D KEY_RESERVED; =
i++)
> -		set_bit(ati_remote2_key_table[i].key_code, idev->keybit);
> +
> +	for (index =3D 0; index < ARRAY_SIZE(ati_remote2_keycodes); index++=
) {
> +		for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> +			ar2->keycode[index][mode] =3D ati_remote2_keycodes[index].keycode=
[mode];
> +			set_bit(ar2->keycode[index][mode], idev->keybit);
> +		}
> +	}
> =20
>  	idev->rep[REP_DELAY]  =3D 250;
>  	idev->rep[REP_PERIOD] =3D 33;
> @@ -359,6 +426,9 @@
>  	idev->open =3D ati_remote2_open;
>  	idev->close =3D ati_remote2_close;
> =20
> +	idev->getkeycode =3D ati_remote2_getkeycode;
> +	idev->setkeycode =3D ati_remote2_setkeycode;
> +
>  	idev->name =3D ar2->name;
>  	idev->phys =3D ar2->phys;
> =20
> @@ -532,6 +602,9 @@
>  	else
>  		printk(KERN_INFO "ati_remote2: " DRIVER_DESC " " DRIVER_VERSION "\=
n");
> =20
> +	mode_mask &=3D 0x1F;
> +	channel_mask &=3D 0xFFFF;
> +

As I said these can be changed runtime, so masking them should happen
every time they are used. A nicer solution would be to actually
reject invalid values.

>  	return r;
>  }
> =20

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
