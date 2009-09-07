From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 7 Sep 2009 15:26:58 +0900
Message-ID: <20090907062658.GS3962@prithivi.gnumonks.org>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com> <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:47415 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZIGG7H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 02:59:07 -0400
Content-Disposition: inline
In-Reply-To: <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAL0UzL+yCvOyEseyghOyekA==?= <ki0351.kim@samsung.com>, =?utf-8?B?6rmA6rWt7KeEL0FQ6rCc67Cc7YyAL0U1L+yCvOyEseyghOyekA==?= <kgene.kim@samsung.com>

Dear all,

On Mon, Sep 07, 2009 at 12:25:14PM +0900, Kyungmin Park wrote:
> > +static const unsigned char s3c_keycode[] =3D {
> > + =A0 =A0 =A0 1, 2, KEY_1, KEY_Q, KEY_A, 6, 7, KEY_LEFT,
> > + =A0 =A0 =A0 9, 10, KEY_2, KEY_W, KEY_S, KEY_Z, KEY_RIGHT, 16,
> > + =A0 =A0 =A0 17, 18, KEY_3, KEY_E, KEY_D, KEY_X, 23, KEY_UP,
> > + =A0 =A0 =A0 25, 26, KEY_4, KEY_R, KEY_F, KEY_C, 31, 32,
> > + =A0 =A0 =A0 33, KEY_O, KEY_5, KEY_T, KEY_G, KEY_V, KEY_DOWN, KEY_=
BACKSPACE,
> > + =A0 =A0 =A0 KEY_P, KEY_0, KEY_6, KEY_Y, KEY_H, KEY_SPACE, 47, 48,
> > + =A0 =A0 =A0 KEY_M, KEY_L, KEY_7, KEY_U, KEY_J, KEY_N, 55, KEY_ENT=
ER,
> > + =A0 =A0 =A0 KEY_LEFTSHIFT, KEY_9, KEY_8, KEY_I, KEY_K, KEY_B, 63,=
 KEY_COMMA,
> > +};
>=20
> Why do you use fixed keycode? Dose it provided from board specific
> platform? and If we want to use only 3 * 3 keypad then how do you
> handle this one?

As Jinsung mailed, the keymap can always be reconfigured from userspace=
=2E

Whether or not the board specific code wants to set a different default=
 keymap
is probably a matter of taste.  omap-kbd has it, pxa27x_kbd also has it=
=2E  So
yes, there is some reason to align with what they are doing.

> > +struct s3c_keypad {
> > + =A0 =A0 =A0 struct s3c_platform_keypad *pdata;
> > + =A0 =A0 =A0 unsigned char keycodes[ARRAY_SIZE(s3c_keycode)];
>=20
> We don't need full keycode array here. It should be allocated with
> required size.

I think this is really an implementation detail up to the author.  Havi=
ng
a static array with the maximum size (8*8 =3D=3D 64) is not a big waste=
 of
memory, if you can on the other hand save some code complexity for dyna=
mic
kmalloc()/kfree() and the associated error paths.

> Why do you use timer. As other input drivers how about to use workque=
ue?

Sorry, what exactly do you mean?  I see many (if not all) other keypad =
drivers
also using a timer.

> > +static int s3c_keypad_open(struct input_dev *dev)
> > +{
> > + =A0 =A0 =A0 struct s3c_keypad *keypad =3D input_get_drvdata(dev);
> > + =A0 =A0 =A0 u32 cfg;
> > +
> > + =A0 =A0 =A0 clk_enable(keypad->clk);
> > +
> > + =A0 =A0 =A0 /* init keypad h/w block */
> > + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> > + =A0 =A0 =A0 cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> > + =A0 =A0 =A0 cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_KEYIF_DF_EN | S3C=
_KEYIF_FC_EN);
> > + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCON);
> > +
> > + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFFC);
> > + =A0 =A0 =A0 cfg |=3D 0x1;
>=20
> What's the meaning of '0x1'?

I agree. Jinsung: The 0x1 should not be a number but a #define from
the register definition.

> > + =A0 =A0 =A0 if (keypad->timer_enabled) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&keypad->timer, keypad->tim=
er.expires);
> > + =A0 =A0 =A0 } else {
>=20
> useless curly braces

That's what I said, too.  However, the kernel CodingStyle document expl=
icitly
states that if there is an 'else' block with multiple lines, the first =
block
should also have curly braces.   Despite this, I have not seen it much =
in use.

> > + =A0 =A0 =A0 keypad->pdata =3D pdata;
> > + =A0 =A0 =A0 memcpy(keypad->keycodes, s3c_keycode, sizeof(keypad->=
keycodes));
>=20
> memcpy??? if you don't modify s3c_keycode. just assign it.

keypad->keycodes is a pointer to the keycode array in the s3c private d=
ata
structure.  This memory can be changed from userspace by using the keyp=
ad
set/get ioctl's (e.g. 'loadkeys' command).

s3c_keycode is a const array of the default keymap that is loaded durin=
g boot.
right now there is only one 6410 specific default keymap, but as you su=
ggested
there should probably be a platform_data (board specific) default keyma=
p.

In any case, I personally believe the memcpy to memory that is owned by
the driver is a good idea, since userspace can modify it.

> Finally, We did duplicated works. We already implement the keypad dri=
ver for
> s5pc100 & s5pc110. but we use workqueue structure instead of timer.

This is why System LSI and DMC Lab should coordinate more on what they =
work.

System LSI's kernel tree is on git.kernel.org and updated every night, =
so you
(or other interested parties) can stay up-to-date with what is happenin=
g.  If
you base your work on top of System LSI's tree, you would always follow=
 their
work.  System LSI's tree is what is scheduled to be submitted to mainli=
ne.

> I will post the our works.

I'm not sure if two different Samsung departments posting competing dri=
vers to
the mainline mailing lists will really help.  You need to define which =
group
will be the 'master' inside Samsung (the logical choice would be System=
 LSI).

You should then submit your code / modifications as patches to that mas=
ter
tree, and System LSI is submitting it mainline.

The same should be the case for other departments who work on Samsung S=
oC
related kernel code..

Regards,
--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks=
=2Eorg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch=
=2E A6)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
