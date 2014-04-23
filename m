From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v2 09/24] input: Port hid-dr to ff-memless-next
Date: Wed, 23 Apr 2014 15:41:03 +0200
Message-ID: <1398260463.32091.5.camel@linux-fkkt.site>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
	 <1398175209-9565-10-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398175209-9565-10-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Tue, 2014-04-22 at 15:59 +0200, Michal Mal=C3=BD wrote:
>  static int drff_play(struct input_dev *dev, void *data,
> -                                struct ff_effect *effect)
> +                       const struct mlnx_effect_command *command)
>  {
>         struct hid_device *hid =3D input_get_drvdata(dev);
>         struct drff_device *drff =3D data;
> +       const struct mlnx_rumble_force *rumble_force =3D
> &command->u.rumble_force;
>         int strong, weak;
> =20
> -       strong =3D effect->u.rumble.strong_magnitude;
> -       weak =3D effect->u.rumble.weak_magnitude;
> +       strong =3D rumble_force->strong;
> +       weak =3D rumble_force->weak;
> =20
>         dbg_hid("called with 0x%04x 0x%04x", strong, weak);
> =20
> -       if (strong || weak) {
> -               strong =3D strong * 0xff / 0xffff;
> -               weak =3D weak * 0xff / 0xffff;
> -
> -               /* While reverse engineering this device, I found tha=
t
> when
> -                  this value is set, it causes the strong rumble to
> function
> -                  at a near maximum speed, so we'll bypass it. */
> -               if (weak =3D=3D 0x0a)
> -                       weak =3D 0x0b;
> -
> -               drff->report->field[0]->value[0] =3D 0x51;
> -               drff->report->field[0]->value[1] =3D 0x00;
> -               drff->report->field[0]->value[2] =3D weak;
> -               drff->report->field[0]->value[4] =3D strong;
> -               hid_hw_request(hid, drff->report, HID_REQ_SET_REPORT)=
;
> -
> -               drff->report->field[0]->value[0] =3D 0xfa;
> -               drff->report->field[0]->value[1] =3D 0xfe;
> -       } else {
> +       switch (command->cmd) {
> +       case MLNX_START_RUMBLE:
> +               if (strong || weak) {
> +                       strong =3D strong * 0xff / 0xffff;
> +                       weak =3D weak * 0xff / 0xffff;
> +
> +                       /* While reverse engineering this device, I
> found that when
> +                       this value is set, it causes the strong rumbl=
e
> to function
> +                       at a near maximum speed, so we'll bypass it.
> */
> +                       if (weak =3D=3D 0x0a)
> +                               weak =3D 0x0b;
> +
> +                       drff->report->field[0]->value[0] =3D 0x51;
> +                       drff->report->field[0]->value[1] =3D 0x00;
> +                       drff->report->field[0]->value[2] =3D weak;
> +                       drff->report->field[0]->value[4] =3D strong;

This looks like an endianness bug.

> +                       hid_hw_request(hid, drff->report,
> HID_REQ_SET_REPORT);

	Regards
		Oliver
