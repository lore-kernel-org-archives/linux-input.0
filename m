From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms
 after reset"
Date: Fri, 8 Apr 2016 19:30:34 -0400
Message-ID: <20160408233034.GN23166@bill-the-cat>
References: <1460069545-10322-1-git-send-email-trini@konsulko.com>
 <5707756E.30506@itdev.co.uk>
 <20160408121418.GT23166@bill-the-cat>
 <5707A376.2080404@itdev.co.uk>
 <20160408123913.GV23166@bill-the-cat>
 <570822DA.9090203@itdev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zXynAY8ehR+YXUvL"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35841 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbcDHX27 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2016 19:28:59 -0400
Received: by mail-yw0-f176.google.com with SMTP id o66so60843763ywc.3
        for <linux-input@vger.kernel.org>; Fri, 08 Apr 2016 16:28:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <570822DA.9090203@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, simon.raphael@gmail.com


--zXynAY8ehR+YXUvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 10:30:02PM +0100, Nick Dyer wrote:
> On 2016-04-08 13:39, Tom Rini wrote:
> >>>> I have a Pixel 2 here - can you advise how to reproduce?
> >>>
> >>> I (and a bunch of other folks, the linux-samus people now point people
> >>> at using mxt-app every boot to reset the device) see this every time I
> >>> either suspend the laptop or do a warm boot into a new kernel (I didn=
't
> >>> try kexec but it too is probably broken).  Note that I'm not using
> >>> mainline to boot ChromeOS but I've got a regular Linux distro in ROOT=
-C.
> >>
> >> OK. I will try it. My Pixel is running Ubuntu with a mainline kernel, =
so
> >> should be able to repro.
> >=20
> > Thanks.  Happy to test patches when you get there and feel free to shoot
> > me patches to have more info get dumped out or whatever if needed.
>=20
> Could you try the below patch to correctly acquire the IRQ after soft res=
et on
> systems using IRQF_TRIGGER_FALLING.
>=20
> Appears to work correctly on my Pixel 2 during a brief test.

This also works for me so:

Tested-by: Tom Rini <trini@konsulko.com>

=2E.. and adding in the linux-samus github project person so it can get
fixed there too.

On an unrelated note and since you have a Pixel 2 as well, the
touchscreen doesn't work for input after suspend (before and after this
patch) but is fine on cold and warm reboots.  Any chance you can debug
that one as well?  Thanks!

>=20
> A workaround also seems to be to reconfig T18 COMMSCONFIG to enable
> the RETRIGEN bit using mxt-app:
>     mxt-app -W -T18 44
>     mxt-app --backup
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 28 ++++++++++++++------------=
--
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 2160512e..5af7907 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1093,6 +1093,19 @@ static int mxt_t6_command(struct mxt_data *data, u=
16 cmd_offset,
>  	return 0;
>  }
> =20
> +static int mxt_acquire_irq(struct mxt_data *data)
> +{
> +	int error;
> +
> +	enable_irq(data->irq);
> +
> +	error =3D mxt_process_messages_until_invalid(data);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
>  static int mxt_soft_reset(struct mxt_data *data)
>  {
>  	struct device *dev =3D &data->client->dev;
> @@ -1111,7 +1124,7 @@ static int mxt_soft_reset(struct mxt_data *data)
>  	/* Ignore CHG line for 100ms after reset */
>  	msleep(100);
> =20
> -	enable_irq(data->irq);
> +	mxt_acquire_irq(data);
> =20
>  	ret =3D mxt_wait_for_completion(data, &data->reset_completion,
>  				      MXT_RESET_TIMEOUT);
> @@ -1466,19 +1479,6 @@ static int mxt_update_cfg(struct mxt_data *data, c=
onst struct firmware *cfg)
>  	return ret;
>  }
> =20
> -static int mxt_acquire_irq(struct mxt_data *data)
> -{
> -	int error;
> -
> -	enable_irq(data->irq);
> -
> -	error =3D mxt_process_messages_until_invalid(data);
> -	if (error)
> -		return error;
> -
> -	return 0;
> -}
> -
>  static int mxt_get_info(struct mxt_data *data)
>  {
>  	struct i2c_client *client =3D data->client;

--=20
Tom

--zXynAY8ehR+YXUvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJXCD8aAAoJEIf59jXTHXZSUyAQALbdRcDBhxno3146kfZNtI7e
AX6RFWfx6nY5ri/nOl7ppa0Q59xNh6+PLhD1I0uC//jY5x61Dgi74BZcmf27MlZ7
YzZDkujpmONQVylvMFz8QuvuwVRL6zLP4oyC+9xQ+pZ4j0uAMiscJIlhg/SdjwqC
vMXlURNDEm0mzLXxnwftZdj2IDVClelwF/4aK/INGMlMj2ENuEpLuaNkyTjXY1d4
Ln4DSlWyhaUNwFDZBmuAI0BaSsZS2/7ftwg7SadK3JhcIvTgMSRSZr8iAi8nHhkw
rNVSv+P8auGa8hWiv5OyJiNf34CMIfHqM66ph1VT2t2eBiMAkTCx5V5CSrnHWGwX
ORjJyh0zNrYBhiH9oyTPaHAL9EKFHSJu7dRGvL5f/esAka85bMHn9nl+nB1r3Bg7
btnS6bUaEn5fi094ia7/XLrGeySut51X3auQ9LFxXbtJ2kfshUjNeO8deMrX2dif
tE7ne1ZYftvOksJXtILbPY8GIZN+v0IiHQHU5Ut+INeK5qAK36BheY8SxhCmtUxU
SzYnykqne0RfsHFfZ8eAEzv9EfilpEJZTLT1llxmh43hlHnk+WWdI4u60G2Ahqxm
Mhs+aS+1vvtyo4SHeR3BGZIObWvxAOYj4rI3XkWK9vhgM/DZK9O99fXz7OQm6jEX
kguJmv/bOYUzok0Im/Rq
=bWq6
-----END PGP SIGNATURE-----

--zXynAY8ehR+YXUvL--
