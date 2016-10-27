From: "Bird, Timothy" <Tim.Bird@am.sony.com>
Subject: RE: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 27 Oct 2016 21:36:16 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF0ABA40EA@USCULXMSG01.am.sony.com>
References: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn3nam01on0126.outbound.protection.outlook.com ([104.47.33.126]:31040
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935144AbcJ1AIy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 20:08:54 -0400
In-Reply-To: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "roderick@gaikai.com" <roderick@gaikai.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>



> -----Original Message-----
> From: Roderick Colenbrander  on Thursday, October 27, 2016 2:31 PM


> The input-mt driver pointer emulation from 'input_mt_sync_frame'
> regardless
> of the flags passed in to 'input_mt_init_slots' by device drivers.

There seems to be a verb missing from this sentence.
=20
> Pointer emulation is undesired on drivers, which didn't request this
> capability like the hid-sony driver for the Dualshock 4. This gamepad alr=
eady
> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
> inject touchpad values into these sticks, which is undesired.
>=20
> This patch checks the flags INPUT_MT_POINTER / INPUT_MT_DIRECT from
> within
> input_mt_sync_frame to only allow pointer emulation when the feature was
> requested by the driver as the flags were set in input_mt_init_slots.
> ---
>  drivers/input/input-mt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index a1bbec9..30c8128 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -305,7 +305,8 @@ void input_mt_sync_frame(struct input_dev *dev)
>  	if ((mt->flags & INPUT_MT_POINTER) && !(mt->flags &
> INPUT_MT_SEMI_MT))
>  		use_count =3D true;
>=20
> -	input_mt_report_pointer_emulation(dev, use_count);
> +	if (mt->flags & (INPUT_MT_POINTER | INPUT_MT_DIRECT))
> +		input_mt_report_pointer_emulation(dev, use_count);
>=20
>  	mt->frame++;
>  }
> --
> 2.7.4
>=20

