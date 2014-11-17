From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - correct MSC_SCAN events for force_release
 keys
Date: Sun, 16 Nov 2014 18:25:42 -0800
Message-ID: <20141117022542.GA4930@dtor-ws>
References: <45706882.ZrxtpIdaNX@pebbles.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58878 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaKQCZq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Nov 2014 21:25:46 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so569686iec.2
        for <linux-input@vger.kernel.org>; Sun, 16 Nov 2014 18:25:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45706882.ZrxtpIdaNX@pebbles.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: linux-input@vger.kernel.org

On Sun, Nov 16, 2014 at 11:18:31PM +0100, Stefan Br=FCns wrote:
> Without the change either no scancode would be reported on release
> of force_release keys, or - if the key is marked as force_release
> erroneously - the release event and the scancode would be reported
> in separate reports to the input layer.
>=20
> Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> ---
>=20
> Originally sent on 28.9.2014, but somehow got lost.
> Resending as per Dmitrys request from 24.10.2014=20

Applied, thank you, but please next time don't use Kmail for patches -
it line-wrapped the patch and encoded it as quoted-printable.

Thanks!

>=20
>  drivers/input/keyboard/atkbd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/=
atkbd.c
> index 2dd1d0d..6375ae6 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -456,8 +456,9 @@ static irqreturn_t atkbd_interrupt(struct serio *=
serio,=20
> unsigned char data,
> =20
>  	keycode =3D atkbd->keycode[code];
> =20
> -	if (keycode !=3D ATKBD_KEY_NULL)
> -		input_event(dev, EV_MSC, MSC_SCAN, code);
> +	if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)))
> +		if (keycode !=3D ATKBD_KEY_NULL)
> +			input_event(dev, EV_MSC, MSC_SCAN, code);
> =20
>  	switch (keycode) {
>  	case ATKBD_KEY_NULL:
> @@ -511,6 +512,7 @@ static irqreturn_t atkbd_interrupt(struct serio *=
serio,=20
> unsigned char data,
>  		input_sync(dev);
> =20
>  		if (value && test_bit(code, atkbd->force_release_mask)) {
> +			input_event(dev, EV_MSC, MSC_SCAN, code);
>  			input_report_key(dev, keycode, 0);
>  			input_sync(dev);
>  		}
> --=20
> 1.8.4.5
>=20
>=20
> --=20
> Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
> home: +49 241 53809034     mobile: +49 151 50412019
> work: +49 2405 49936-424

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
