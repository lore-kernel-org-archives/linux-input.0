From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [PATCH v2 09/24] input: Port hid-dr to ff-memless-next
Date: Thu, 24 Apr 2014 12:32:28 +0200
Message-ID: <2156054.MZkXeC543k@sigyn>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net> <1398175209-9565-10-git-send-email-madcatxster@devoid-pointer.net> <1398260463.32091.5.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398260463.32091.5.camel@linux-fkkt.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Wednesday 23 of April 2014 15:41:03 Oliver Neukum wrote:
> On Tue, 2014-04-22 at 15:59 +0200, Michal Mal=FD wrote:
> >  static int drff_play(struct input_dev *dev, void *data,
> >=20
> > -                                struct ff_effect *effect)
> > +                       const struct mlnx_effect_command *command)
> >=20
> >  {
> > =20
> >         struct hid_device *hid =3D input_get_drvdata(dev);
> >         struct drff_device *drff =3D data;
> >=20
> > +       const struct mlnx_rumble_force *rumble_force =3D
> > &command->u.rumble_force;
> >=20
> >         int strong, weak;
> >=20
> > -       strong =3D effect->u.rumble.strong_magnitude;
> > -       weak =3D effect->u.rumble.weak_magnitude;
> > +       strong =3D rumble_force->strong;
> > +       weak =3D rumble_force->weak;
> >=20
> >         dbg_hid("called with 0x%04x 0x%04x", strong, weak);
> >=20
> > -       if (strong || weak) {
> > -               strong =3D strong * 0xff / 0xffff;
> > -               weak =3D weak * 0xff / 0xffff;
> > -
> > -               /* While reverse engineering this device, I found t=
hat
> > when
> > -                  this value is set, it causes the strong rumble t=
o
> > function
> > -                  at a near maximum speed, so we'll bypass it. */
> > -               if (weak =3D=3D 0x0a)
> > -                       weak =3D 0x0b;
> > -
> > -               drff->report->field[0]->value[0] =3D 0x51;
> > -               drff->report->field[0]->value[1] =3D 0x00;
> > -               drff->report->field[0]->value[2] =3D weak;
> > -               drff->report->field[0]->value[4] =3D strong;
> > -               hid_hw_request(hid, drff->report, HID_REQ_SET_REPOR=
T);
> > -
> > -               drff->report->field[0]->value[0] =3D 0xfa;
> > -               drff->report->field[0]->value[1] =3D 0xfe;
> > -       } else {
> > +       switch (command->cmd) {
> > +       case MLNX_START_RUMBLE:
> > +               if (strong || weak) {
> > +                       strong =3D strong * 0xff / 0xffff;
> > +                       weak =3D weak * 0xff / 0xffff;
> > +
> > +                       /* While reverse engineering this device, I
> > found that when
> > +                       this value is set, it causes the strong rum=
ble
> > to function
> > +                       at a near maximum speed, so we'll bypass it=
=2E
> > */
> > +                       if (weak =3D=3D 0x0a)
> > +                               weak =3D 0x0b;
> > +
> > +                       drff->report->field[0]->value[0] =3D 0x51;
> > +                       drff->report->field[0]->value[1] =3D 0x00;
> > +                       drff->report->field[0]->value[2] =3D weak;
> > +                       drff->report->field[0]->value[4] =3D strong=
;
>=20
> This looks like an endianness bug.

I don't have a big endian machine to check but why would this be an end=
ianness=20
issue? We're dealing with values all the time here, not addresses so I'=
d=20
expect the 'weak' and 'strong' values to be truncated if they won't fit=
 into=20
byte. Division done beforehand makes sure that the values are within <0=
; 255>=20
range. As far as I can see this is quite common in the HID and Input co=
de. Am=20
I missing something here?

Thanks,
Michal
