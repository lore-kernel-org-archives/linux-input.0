From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: matrix_keypad - make driver useable with GPIO
 drivers requiring threaded irqs
Date: Tue, 9 Sep 2014 14:42:45 -0700
Message-ID: <20140909214245.GD28774@core.coreip.homeip.net>
References: <1410251584-5031-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:43349 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaIIVmu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Sep 2014 17:42:50 -0400
Content-Disposition: inline
In-Reply-To: <1410251584-5031-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

On Tue, Sep 09, 2014 at 10:33:04AM +0200, Lothar Wa=DFmann wrote:
> When trying to use the matrix-keypad driver with GPIO drivers that
> require nested irq handlers (e.g. I2C GPIO adapters like PCA9554),
> request_irq() fails because the GPIO driver requires a threaded
> interrupt handler.
>=20
> Use request_any_context_irq() to be able to use any GPIO driver as
> keypad driver.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>

Applied, thank you.

> ---
>  drivers/input/keyboard/matrix_keypad.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/k=
eyboard/matrix_keypad.c
> index 8d2e19e..e651fa6 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -332,23 +332,24 @@ static int matrix_keypad_init_gpio(struct platf=
orm_device *pdev,
>  	}
> =20
>  	if (pdata->clustered_irq > 0) {
> -		err =3D request_irq(pdata->clustered_irq,
> +		err =3D request_any_context_irq(pdata->clustered_irq,
>  				matrix_keypad_interrupt,
>  				pdata->clustered_irq_flags,
>  				"matrix-keypad", keypad);
> -		if (err) {
> +		if (err < 0) {
>  			dev_err(&pdev->dev,
>  				"Unable to acquire clustered interrupt\n");
>  			goto err_free_rows;
>  		}
>  	} else {
>  		for (i =3D 0; i < pdata->num_row_gpios; i++) {
> -			err =3D request_irq(gpio_to_irq(pdata->row_gpios[i]),
> +			err =3D request_any_context_irq(
> +					gpio_to_irq(pdata->row_gpios[i]),
>  					matrix_keypad_interrupt,
>  					IRQF_TRIGGER_RISING |
>  					IRQF_TRIGGER_FALLING,
>  					"matrix-keypad", keypad);
> -			if (err) {
> +			if (err < 0) {
>  				dev_err(&pdev->dev,
>  					"Unable to acquire interrupt for GPIO line %i\n",
>  					pdata->row_gpios[i]);
> --=20
> 1.7.10.4
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
