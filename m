From: Peter Stokes <linux@dadeos.co.uk>
Subject: Re: [PATCH] ati_remote2 loadable keymap support
Date: Fri, 18 Apr 2008 20:42:29 +0100
Message-ID: <200804182042.29337.linux@dadeos.co.uk>
References: <200804051930.10574.linux@dadeos.co.uk> <20080408201826.GG16619@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.wanadoo.co.uk ([193.252.22.158]:30916 "EHLO
	smtp1.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYDRTmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 15:42:36 -0400
In-Reply-To: <20080408201826.GG16619@sci.fi>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, dmitry.torokhov@gmail.com


Ville,

My apologies for not responding to your feedback sooner. I had not noti=
ced the=20
comments that you had inserted within the patch. Please find my respons=
es=20
below:

On Tuesday 08 April 2008 21:18:26 Ville Syrj=E4l=E4 wrote:
> On Sat, Apr 05, 2008 at 07:30:10PM +0100, Peter Stokes wrote:
> > The attached patch adds support for loadable key maps support to th=
e
> > ati_remote2 driver.
> >
> > This patch is similar to the previous version that I originally pos=
ted on
> > 16th February 2008. As requested, I have removed the code that
> > reconfigured this driver to utilise the input core's built in soft =
auto
> > repeat functionality. Those changes are pending further clarificati=
on on
> > how buttons that should not be auto repeated (e.g. mouse buttons) c=
an be
> > excluded from the soft auto repeat implementation.
> >
> > On Tuesday 04 March 2008 22:17:49 Ville Syrj=E4l=E4 wrote:
> > > However, since that seems unlikely to happen, and the input core
> > > already has support for keymaps I'm fine with adding the set/getk=
eycode
> > > stuff. What I'd like to drop is the support for five different ke=
ymaps
> > > since AFAICS that could be handled in a more generic way in user =
space.
> >
> > I do not agree that the opportunity to remap the resultant keycode
> > generated from any given physical key on the remote dependant upon =
which
> > 'mode' the remote is currently in should be dropped. Consequently I=
 have
> > left the implementation in the attached patch.
> >
> > I feel that a valid way of thinking about this implementation is th=
at the
> > hardware scancodes consist of the mode and key bytes combined. Give=
n any
> > such implementation it could be assumed that the device has 5 x 46 =
=3D 230
> > keys, it therefore seems entirely reasonable to me to provide a mec=
hanism
> > by which any of those keys can be remapped.
> >
> > On Tuesday 04 March 2008 20:38:22 Ville Syrj=E4l=E4 wrote:
> > > I think you could implement the multiple keymaps thing rather tri=
vially
> > > in user space by having a small daemon listening on the event dev=
ice
> > > and loading a new keymap when a mode key is pressed. That would l=
imit
> > > the changes to the driver, and it would not require any kernel ch=
anges
> > > when if you would need to adapt it to a device that uses a differ=
ent
> > > driver.
> >
> > I do not agree that it this functionality would be trivial to imple=
ment
> > in user space. The primary purpose behind making these changes is t=
o
> > provide full access to all of the keys within X windows, as such on=
e is
> > dependant upon the X input system interfacing to the event device. =
The
> > goal is to make this device behave as a regular keyboard, not requi=
ring
> > any special case code in any application the user might wish to con=
trol
> > using it.
>
> Userspace keymap handling would not require any special case code in
> many applications. It would just need a small daemon that would react
> to the mode keys and reload the keymap. Getting such a thing
> packaged/distributed might be a bigger challenge though, so if you
> really want to have it in the kernel driver I can live with it :)
>
> > I do not feel that my proposed code changes are particularly invasi=
ve. I
> > would accept that the static table outlining the default keycode ma=
ppings
> > represents a reasonable change. Whilst this table could be eliminat=
ed
> > (and generated programmatically) I feel that it serves in some part
> > towards documenting the implementation.
>
> It does increase the module size though.
>
> > All of the changes proposed have no effect upon the operation of th=
e
> > driver out-of-the-box they merely provide a mechanism by which an e=
nd
> > user can configure their setup to function as they desire.
> >
> > Best regards
> >
> > Peter Stokes
> >
> >
> >
> > Signed-off-by: Peter Stokes <linux@dadeos.co.uk>
> >
> >
> > --- linux-2.6.24-orig/drivers/input/misc/ati_remote2.c	2008-01-24
> > 22:58:37.000000000 +0000 +++
> > linux-2.6.24/drivers/input/misc/ati_remote2.c	2008-04-05
> > 18:34:31.000000000 +0100 @@ -2,7 +2,7 @@
> >   * ati_remote2 - ATI/Philips USB RF remote driver
> >   *
> >   * Copyright (C) 2005 Ville Syrjala <syrjala@sci.fi>
> > - * Copyright (C) 2007 Peter Stokes <linux@dadeos.freeserve.co.uk>
> > + * Copyright (C) 2007 Peter Stokes <linux@dadeos.co.uk>
>
> 2008?
>

The primary intention behind that change was to merely update my email=20
address. If you feel the year should be updated 2008 then that is fine =
with=20
me.

> >   *
> >   * This program is free software; you can redistribute it and/or m=
odify
> >   * it under the terms of the GNU General Public License version 2
> > @@ -12,7 +12,7 @@
> >  #include <linux/usb/input.h>
> >
> >  #define DRIVER_DESC    "ATI/Philips USB RF remote driver"
> > -#define DRIVER_VERSION "0.2"
> > +#define DRIVER_VERSION "0.3"
> >
> >  MODULE_DESCRIPTION(DRIVER_DESC);
> >  MODULE_VERSION(DRIVER_VERSION);
> > @@ -27,7 +27,7 @@
> >   * A remote's "channel" may be altered by pressing and holding the=
 "PC"
> > button for * approximately 3 seconds, after which the button will s=
lowly
> > flash the count of the * currently configured "channel", using the
> > numeric keypad enter a number between 1 and - * 16 and then the "PC=
"
> > button again, the button will slowly flash the count of the + * 16 =
and
> > then press the "PC" button again, the button will slowly flash the =
count
> > of the * newly configured "channel".
> >   */
>
> Unrelated change. I saw a couple of other unrelated changes too (just
> changing the whitespace) further down.
>

I was just updating my original poor English. I felt the clarification =
was=20
worthwhile but insufficiently important to submit a patch just to chang=
e a=20
comment.

> > @@ -45,61 +45,66 @@
> >  };
> >  MODULE_DEVICE_TABLE(usb, ati_remote2_id_table);
> >
> > +
> > +static u8 ati_remote2_modes[] =3D {
> > +	0x01, /* AUX1 */
> > +	0x02, /* AUX2 */
> > +	0x04, /* AUX3 */
> > +	0x08, /* AUX4 */
> > +	0x10, /* PC   */
> > +};
>
> It seems you only use this table to get the number of modes. A define
> would suffice.
>

That is indeed correct. This table is present in order to provide clear=
=20
documentation of the mapping layout at the top of the file.

> >  static struct {
> > -	int hw_code;
> > -	int key_code;
> > -} ati_remote2_key_table[] =3D {
> > -	{ 0x00, KEY_0 },
> > -	{ 0x01, KEY_1 },
> > -	{ 0x02, KEY_2 },
> > -	{ 0x03, KEY_3 },
> > -	{ 0x04, KEY_4 },
> > -	{ 0x05, KEY_5 },
> > -	{ 0x06, KEY_6 },
> > -	{ 0x07, KEY_7 },
> > -	{ 0x08, KEY_8 },
> > -	{ 0x09, KEY_9 },
> > -	{ 0x0c, KEY_POWER },
> > -	{ 0x0d, KEY_MUTE },
> > -	{ 0x10, KEY_VOLUMEUP },
> > -	{ 0x11, KEY_VOLUMEDOWN },
> > -	{ 0x20, KEY_CHANNELUP },
> > -	{ 0x21, KEY_CHANNELDOWN },
> > -	{ 0x28, KEY_FORWARD },
> > -	{ 0x29, KEY_REWIND },
> > -	{ 0x2c, KEY_PLAY },
> > -	{ 0x30, KEY_PAUSE },
> > -	{ 0x31, KEY_STOP },
> > -	{ 0x37, KEY_RECORD },
> > -	{ 0x38, KEY_DVD },
> > -	{ 0x39, KEY_TV },
> > -	{ 0x54, KEY_MENU },
> > -	{ 0x58, KEY_UP },
> > -	{ 0x59, KEY_DOWN },
> > -	{ 0x5a, KEY_LEFT },
> > -	{ 0x5b, KEY_RIGHT },
> > -	{ 0x5c, KEY_OK },
> > -	{ 0x78, KEY_A },
> > -	{ 0x79, KEY_B },
> > -	{ 0x7a, KEY_C },
> > -	{ 0x7b, KEY_D },
> > -	{ 0x7c, KEY_E },
> > -	{ 0x7d, KEY_F },
> > -	{ 0x82, KEY_ENTER },
> > -	{ 0x8e, KEY_VENDOR },
> > -	{ 0x96, KEY_COFFEE },
> > -	{ 0xa9, BTN_LEFT },
> > -	{ 0xaa, BTN_RIGHT },
> > -	{ 0xbe, KEY_QUESTION },
> > -	{ 0xd5, KEY_FRONT },
> > -	{ 0xd0, KEY_EDIT },
> > -	{ 0xf9, KEY_INFO },
> > -	{ (0x00 << 8) | 0x3f, KEY_PROG1 },
> > -	{ (0x01 << 8) | 0x3f, KEY_PROG2 },
> > -	{ (0x02 << 8) | 0x3f, KEY_PROG3 },
> > -	{ (0x03 << 8) | 0x3f, KEY_PROG4 },
> > -	{ (0x04 << 8) | 0x3f, KEY_PC },
> > -	{ 0, KEY_RESERVED }
> > +	u8  hwcode;
> > +	u16 keycode[ARRAY_SIZE(ati_remote2_modes)];
> > +} ati_remote2_keycodes[] =3D {
> > +/*	 hwcode   AUX1             AUX2             AUX3             AU=
X4   =20
> >         PC                */
>
> checkpatch.pl doesn't like these long lines.
>

To limit the line length for these lines seemed unwise to me. Especiall=
y in=20
light of their primary purpose being to provide clear documentation of =
the=20
mapping implementation.

My reasoning with both these tables was two fold. Firstly, canvassing o=
ther=20
files within the input system indicated that there are a number of 'lar=
ge'=20
tables. Secondly, this is a driver for a remote control. I am envisagin=
g most=20
people will be using this device on a relatively high specification PC =
and=20
not on an embedded device. Accordingly I concluded the memory footprint=
s were=20
affordable.

> >  struct ati_remote2 {
> > @@ -117,6 +122,8 @@
> >
> >  	char name[64];
> >  	char phys[64];
> > +
> > +	u32
> > keycode[ARRAY_SIZE(ati_remote2_keycodes)][ARRAY_SIZE(ati_remote2_mo=
des)];
>
> Somehow it would seem more natural to me if you would swap the array
> dimensions. But that's a minor issue and you can leave it like this i=
f
> you prefer.
>
> >  };
> >
> >  static int ati_remote2_probe(struct usb_interface *interface, cons=
t
> > struct usb_device_id *id); @@ -159,11 +166,84 @@
> >  	usb_kill_urb(ar2->urb[1]);
> >  }
> >
> > +static int ati_remote2_lookup(u8 hwcode)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(ati_remote2_keycodes); i++)
> > +		if (ati_remote2_keycodes[i].hwcode =3D=3D hwcode)
> > +			return i;
> > +
> > +	return -1;
> > +}
> > +
> > +static int ati_remote2_getkeycode(struct input_dev *idev,
> > +				  int scancode, int *keycode)
> > +{
> > +	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> > +	int index, mode;
> > +
> > +	if (((scancode >> 8) & mode_mask) !=3D (scancode >> 8))
> > +		return -EINVAL;
> > +
> > +	index =3D ati_remote2_lookup(scancode & 0xFF);
> > +	if (index =3D=3D -1)
> > +		return -EINVAL;
> > +
> > +	for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> > +		if ((1 << mode) & (scancode >> 8)) {
> > +			*keycode =3D ar2->keycode[index][mode];
> > +			return 0;
> > +		}
> > +	}
>
> Is there a reason you using the high bits like a mask? IIRC the hardw=
are
> mode byte isn't a mask. So something like this should do:
>
> mode =3D scancode >> 8;
> if (mode < 0 || mode > MAX_MODE)
> 	return -EINVAL;
> index =3D ati_remote2_lookup(scancode & 0xff);
> if (index < 0)
> 	return -EINVAL;
>
>
> I'm not sure if mode_mask should affect the keymap handling at all si=
nce
> both can be changed runtime.
>

The reason I am using the high bits as a mode mask is in order to addre=
ss the=20
issues I felt some people might have regarding the interpretation of th=
e=20
device that allows mapping separate keycodes to each physical button=20
dependant upon which mode the remote control is currently in. This appr=
oach=20
address two issues.

=46irstly, whilst the input system provides a mechanism to configure th=
e=20
scancode to keycode mapping on a per-device basis (each device can have=
 it's=20
own mapping table) unfortunately the mechanism by which the mapping tab=
les=20
can be manipulated (via the 'setkeycodes' utility) does not allow for t=
he=20
device that should be modified to be specified. What actually appears t=
o=20
happen is that the first device that accepts the specified scancode as =
being=20
one it can produce changes it's mapping for that scancode to use the ne=
w=20
keycode provided. The practical upshot of this is that I wish to be abl=
e to=20
remap the keycodes associated with the remote control but if the scanco=
des=20
the remote control reports are within the normal range associated with =
a=20
regular keyboard (i.e. <=3D255) then the keyboard driver accepts the ch=
ange=20
first. This not only results in the ati_remote2 not even seeing the req=
uest=20
for the new mapping it also has the undesirable side effect of corrupti=
ng the=20
mappings for the regular keyboard. To overcome this problem, I decided =
that=20
instead of using the mode byte as is (i.e. a number between 0 and 4) I =
would=20
convert it into a bit mask, thus moving all the remote's reported scanc=
odes=20
(0x0100 -> 0x1FF9) outside to the regular keyboard range.

Secondly. whilst I decided to provide the flexibility of a mechanism by=
 which=20
a single key may be mapped to different keycodes dependant upon which m=
ode=20
the remote is currently in, I expected that not everyone would need tha=
t=20
functionality. A potential downside to providing the flexible implement=
ation=20
could be that if a user simply wanted to change the mapping for a given=
=20
physical button regardless of what mode the remote is currently in then=
 it=20
might be necessary to submit five requests to update the mappings for e=
ach=20
mode. By converting the mode byte into a mode bit mask it allows a mapp=
ing=20
request to simultaneously update the mapping for a single physical butt=
on for=20
all modes. So, for example:

setkeycodes 0x015C 28    - Would map the OK button for AUX1 mode to be =
'enter'
setkeycodes 0x1F5C 28    - Would map the OK button for all modes to be =
'enter'

The usage of the mode_mask module parameter in the 'ati_remote2_getkeyc=
ode'=20
and 'ati_remote2_setkeycode' is only used determine whether the driver,=
 as=20
currently configured, will respond to the specified scancode. If the dr=
iver=20
will not currently respond, because a given mode is masked out, then it=
 is=20
not possible to request or modify the keymapping for a physical button =
in=20
that mode.=20


> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int ati_remote2_setkeycode(struct input_dev *idev,
> > +				  int scancode, int keycode)
> > +{
> > +	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> > +	int old_keycode =3D -1;
> > +	int index, mode;
> > +
> > +	if (((scancode >> 8) & mode_mask) !=3D (scancode >> 8))
> > +		return -EINVAL;
> > +
>
> Same comments as above.
>
> > +	index =3D ati_remote2_lookup(scancode & 0xFF);
> > +	if (index =3D=3D -1)
> > +		return -EINVAL;
> > +
> > +	if (keycode < 0 || keycode > KEY_MAX)
>
> Are KEY_RESERVED/KEY_MAX valid here?
>

Yes, this is merely checking that the keycode provided is within the ra=
nge=20
expected by the linux input system.


> > +		return -EINVAL;
> > +
> > +	for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> > +		if ((1 << mode) & (scancode >> 8)) {
> > +			old_keycode =3D ar2->keycode[index][mode];
> > +			ar2->keycode[index][mode] =3D keycode;
> > +		}
> > +	}
> > +
> > +	set_bit(keycode, idev->keybit);
> > +
> > +	for (index =3D 0; index < ARRAY_SIZE(ati_remote2_keycodes); index=
++) {
> > +		for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> > +			if (ar2->keycode[index][mode] =3D=3D old_keycode)
> > +				return 0;
> > +		}
> > +	}
>
> Because of using the scancode high bits as a mask this could leave so=
me
> bits set even though they are no longer in the map.
>

No, in this function the 'mode' variable is an index into the ar2->keyc=
ode=20
table (i.e. a number between 0 and 4). The implementation is attempting=
 to=20
ascertain whether or not the 'old_keycode' is still in use within the k=
ey=20
table. The implementation does not filter the contents of idev->keybit =
based=20
upon whether a given keycode is only used by the remote in modes that a=
re=20
currently masked off. Is that what you meant?

> > +
> > +	clear_bit(old_keycode, idev->keybit);
> > +
> > +	return 0;
> > +}
> > +
> > +
> >  static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
> >  {
> >  	struct input_dev *idev =3D ar2->idev;
> >  	u8 *data =3D ar2->buf[0];
> > -	int channel, mode;
> > +	u8 channel, mode;
> >
> >  	channel =3D data[0] >> 4;
> >
> > @@ -187,22 +267,12 @@
> >  	input_sync(idev);
> >  }
> >
> > -static int ati_remote2_lookup(unsigned int hw_code)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; ati_remote2_key_table[i].key_code !=3D KEY_RESERVED=
; i++)
> > -		if (ati_remote2_key_table[i].hw_code =3D=3D hw_code)
> > -			return i;
> > -
> > -	return -1;
> > -}
> > -
> >  static void ati_remote2_input_key(struct ati_remote2 *ar2)
> >  {
> >  	struct input_dev *idev =3D ar2->idev;
> >  	u8 *data =3D ar2->buf[1];
> > -	int channel, mode, hw_code, index;
> > +	u8 channel, mode;
> > +	int index;
> >
> >  	channel =3D data[0] >> 4;
> >
> > @@ -218,12 +288,10 @@
> >  		return;
> >  	}
> >
> > -	hw_code =3D data[2];
> > -	/*
> > -	 * Mode keys (AUX1-AUX4, PC) all generate the same code byte.
> > -	 * Use the mode byte to figure out which one was pressed.
> > -	 */
> > -	if (hw_code =3D=3D 0x3f) {
> > +	if (!((1 << mode) & mode_mask))
> > +		return;
> > +
> > +	if (data[2] =3D=3D 0x3f) {
> >  		/*
> >  		 * For some incomprehensible reason the mouse pad generates
> >  		 * events which look identical to the events from the last
> > @@ -236,14 +304,9 @@
> >
> >  		if (data[1] =3D=3D 0)
> >  			ar2->mode =3D mode;
> > -
> > -		hw_code |=3D mode << 8;
> >  	}
> >
> > -	if (!((1 << mode) & mode_mask))
> > -		return;
>
> Moving this test before updating ar2->mode could leave the driver
> unaware of the actual mode it's in. I think it could leave to key
> events getting through from the mouse at least when mode_mask is
> suitably changed runtime. Was there a reason for this change?
>

Will undo.

> > -
> > -	index =3D ati_remote2_lookup(hw_code);
> > +	index =3D ati_remote2_lookup(data[2]);
> >  	if (index < 0) {
> >  		dev_err(&ar2->intf[1]->dev,
> >  			"Unknown code byte (%02x %02x %02x %02x)\n",
> > @@ -260,8 +323,7 @@
> >  	case 2:	/* repeat */
> >
> >  		/* No repeat for mouse buttons. */
> > -		if (ati_remote2_key_table[index].key_code =3D=3D BTN_LEFT ||
> > -		    ati_remote2_key_table[index].key_code =3D=3D BTN_RIGHT)
> > +		if (data[2] =3D=3D 0xa9 || data[2] =3D=3D 0xaa)
> >  			return;
> >
> >  		if (!time_after_eq(jiffies, ar2->jiffies))
> > @@ -276,7 +338,7 @@
> >  		return;
> >  	}
> >
> > -	input_event(idev, EV_KEY, ati_remote2_key_table[index].key_code,
> > data[1]); +	input_event(idev, EV_KEY, ar2->keycode[index][mode],
> > data[1]); input_sync(idev);
> >  }
> >
> > @@ -334,10 +396,11 @@
> >  			"%s(): usb_submit_urb() =3D %d\n", __FUNCTION__, r);
> >  }
> >
> > +
> >  static int ati_remote2_input_init(struct ati_remote2 *ar2)
> >  {
> >  	struct input_dev *idev;
> > -	int i, retval;
> > +	int index, mode, retval;
> >
> >  	idev =3D input_allocate_device();
> >  	if (!idev)
> > @@ -347,11 +410,15 @@
> >  	input_set_drvdata(idev, ar2);
> >
> >  	idev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> > BIT_MASK(EV_REL); -	idev->keybit[BIT_WORD(BTN_MOUSE)] =3D
> > BIT_MASK(BTN_LEFT) |
> > -		BIT_MASK(BTN_RIGHT);
> > +	idev->keybit[BIT_WORD(BTN_MOUSE)] =3D BIT_MASK(BTN_LEFT) |
> > BIT_MASK(BTN_RIGHT); idev->relbit[0] =3D BIT_MASK(REL_X) | BIT_MASK=
(REL_Y);
> > -	for (i =3D 0; ati_remote2_key_table[i].key_code !=3D KEY_RESERVED=
; i++)
> > -		set_bit(ati_remote2_key_table[i].key_code, idev->keybit);
> > +
> > +	for (index =3D 0; index < ARRAY_SIZE(ati_remote2_keycodes); index=
++) {
> > +		for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) {
> > +			ar2->keycode[index][mode] =3D
> > ati_remote2_keycodes[index].keycode[mode];
> > +			set_bit(ar2->keycode[index][mode], idev->keybit);
> > +		}
> > +	}
> >
> >  	idev->rep[REP_DELAY]  =3D 250;
> >  	idev->rep[REP_PERIOD] =3D 33;
> > @@ -359,6 +426,9 @@
> >  	idev->open =3D ati_remote2_open;
> >  	idev->close =3D ati_remote2_close;
> >
> > +	idev->getkeycode =3D ati_remote2_getkeycode;
> > +	idev->setkeycode =3D ati_remote2_setkeycode;
> > +
> >  	idev->name =3D ar2->name;
> >  	idev->phys =3D ar2->phys;
> >
> > @@ -532,6 +602,9 @@
> >  	else
> >  		printk(KERN_INFO "ati_remote2: " DRIVER_DESC " " DRIVER_VERSION =
"\n");
> >
> > +	mode_mask &=3D 0x1F;
> > +	channel_mask &=3D 0xFFFF;
> > +
>
> As I said these can be changed runtime, so masking them should happen
> every time they are used. A nicer solution would be to actually
> reject invalid values.
>

Will add masking where they are used instead.

> >  	return r;
> >  }



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
