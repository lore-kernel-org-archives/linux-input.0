From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce: fix possible driver hang during suspend
Date: Sun, 15 Dec 2013 02:43:13 -0800
Message-ID: <20131215104313.GE20197@core.coreip.homeip.net>
References: <201312101650.04799.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47733 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3LOKnS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Dec 2013 05:43:18 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so1759077pad.24
        for <linux-input@vger.kernel.org>; Sun, 15 Dec 2013 02:43:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201312101650.04799.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Tue, Dec 10, 2013 at 04:50:04PM +0100, Heiko St=FCbner wrote:
> handle_level_irq masks the interrupt before handling it, and only
> unmasks it after the handler is finished. So when a touch event
> happens after threads are suspended, but before the system is fully a=
sleep
> the irq handler tries to wakeup the thread which will only happen on =
the
> next resume, resulting in the wakeup event never being sent and the d=
river
> not being able to wake the system from sleep due to the masked irq.
>=20
> Therefore move the wakeup_event to a small non-threaded handler.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/zforce_ts.c |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/to=
uchscreen/zforce_ts.c
> index 75762d6..aa127ba 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -455,7 +455,18 @@ static void zforce_complete(struct zforce_ts *ts=
, int cmd, int result)
>  	}
>  }
> =20
> -static irqreturn_t zforce_interrupt(int irq, void *dev_id)
> +static irqreturn_t zforce_irq(int irq, void *dev_id)
> +{
> +	struct zforce_ts *ts =3D dev_id;
> +	struct i2c_client *client =3D ts->client;
> +
> +	if (ts->suspended && device_may_wakeup(&client->dev))
> +		pm_wakeup_event(&client->dev, 500);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
>  {
>  	struct zforce_ts *ts =3D dev_id;
>  	struct i2c_client *client =3D ts->client;
> @@ -465,12 +476,10 @@ static irqreturn_t zforce_interrupt(int irq, vo=
id *dev_id)
>  	u8 *payload;
> =20
>  	/*
> -	 * When suspended, emit a wakeup signal if necessary and return.
> +	 * When still suspended, return.
>  	 * Due to the level-interrupt we will get re-triggered later.
>  	 */
>  	if (ts->suspended) {
> -		if (device_may_wakeup(&client->dev))
> -			pm_wakeup_event(&client->dev, 500);
>  		msleep(20);
>  		return IRQ_HANDLED;
>  	}
> @@ -763,8 +772,8 @@ static int zforce_probe(struct i2c_client *client=
,
>  	 * Therefore we can trigger the interrupt anytime it is low and do
>  	 * not need to limit it to the interrupt edge.
>  	 */
> -	ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					zforce_interrupt,
> +	ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> +					zforce_irq, zforce_irq_thread,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					input_dev->name, ts);
>  	if (ret) {
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
