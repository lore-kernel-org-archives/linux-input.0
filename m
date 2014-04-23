From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [PATCH v2 11/24] input: Port hid-holtekff to ff-memless-next
Date: Wed, 23 Apr 2014 14:31:42 +0200
Message-ID: <1592278.pD8vu465lA@sigyn>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net> <1398175209-9565-12-git-send-email-madcatxster@devoid-pointer.net> <1398255470.32091.3.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398255470.32091.3.camel@linux-fkkt.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Wednesday 23 of April 2014 14:17:50 Oliver Neukum wrote:
> On Tue, 2014-04-22 at 15:59 +0200, Michal Mal=FD wrote:
> >  static int holtekff_play(struct input_dev *dev, void *data,
> >=20
> > -                        struct ff_effect *effect)
> > +                        const struct mlnx_effect_command *command)
> >=20
> >  {
> > =20
> >         struct hid_device *hid =3D input_get_drvdata(dev);
> >         struct holtekff_device *holtekff =3D data;
> >=20
> > +       const struct mlnx_rumble_force *rumble_force =3D
> > &command->u.rumble_force;
> >=20
> >         int left, right;
> >         /* effect type 1, length 65535 msec */
> >         u8 buf[HOLTEKFF_MSG_LENGTH] =3D
> >        =20
> >                 { 0x01, 0x01, 0xff, 0xff, 0x10, 0xe0, 0x00 };
>=20
> On the kernel stack.
>=20
> > -       left =3D effect->u.rumble.strong_magnitude;
> > -       right =3D effect->u.rumble.weak_magnitude;
> > -       dbg_hid("called with 0x%04x 0x%04x\n", left, right);
> > +       switch (command->cmd) {
> > +       case MLNX_START_RUMBLE:
> > +               left =3D rumble_force->strong;
> > +               right =3D rumble_force->weak;
> > +               dbg_hid("called with 0x%04x 0x%04x\n", left, right)=
;
> >=20
> > -       if (!left && !right) {
> > -               holtekff_send(holtekff, hid, stop_all6);
> > -               return 0;
> > -       }
> > +               if (!left && !right) {
> > +                       holtekff_send(holtekff, hid, stop_all6);
> > +                       return 0;
> > +               }
> >=20
> > -       if (left)
> > -               buf[1] |=3D 0x80;
> > -       if (right)
> > -               buf[1] |=3D 0x40;
> > +               if (left)
> > +                       buf[1] |=3D 0x80;
> > +               if (right)
> > +                       buf[1] |=3D 0x40;
> >=20
> > -       /* The device takes a single magnitude, so we just sum them
> > up. */
> > -       buf[6] =3D min(0xf, (left >> 12) + (right >> 12));
> > +               /* The device takes a single magnitude, so we just =
sum
> > them up. */
> > +               buf[6] =3D min(0xf, (left >> 12) + (right >> 12));
> >=20
> > -       holtekff_send(holtekff, hid, buf);
> > -       holtekff_send(holtekff, hid, start_effect_1);
> > +               holtekff_send(holtekff, hid, buf);
> > +               holtekff_send(holtekff, hid, start_effect_1);
> > +               return 0;
> > +       case MLNX_STOP_RUMBLE:
> > +               holtekff_send(holtekff, hid, stop_all6);
> > +               return 0;
> > +       default:
> > +               return -EINVAL;
> > +       }
> >=20
> >         return 0;
> > =20
> >  }
>=20
> This looks very much like doing DMA on the kernel stack.
> That is very strictly forbidden. The bug is also in the current
> code, but would you care to fix it up?

Okay, I'll look into it.

Michal
