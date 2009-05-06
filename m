From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Input: add MAX7359 key switch controller driver
Date: Wed, 6 May 2009 19:08:25 +0530
Message-ID: <5d5443650905060638l52b3c17dle0d138b689a23252@mail.gmail.com>
References: <4A012C64.1020101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f125.google.com ([209.85.221.125]:59228 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbZEFNor convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2009 09:44:47 -0400
In-Reply-To: <4A012C64.1020101@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kim Kyuwon <q1.kim@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Hi Kim,

On Wed, May 6, 2009 at 11:51 AM, Kim Kyuwon <q1.kim@samsung.com> wrote:
> The Maxim MAX7359 is a I2C interfaced key switch controller which pro=
vides microprocessors with management of up to 64 key switches.
> This patch adds support for the MAX7359 key switch controller.
>

Could you please restrict the commit text line to 80/72 columns? It
will look good.

> +static irqreturn_t max7359_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct max7359_keypad *keypad =3D (struct max7359_keypa=
d *) dev_id;

No need of casting. Please remove.

> +
> + =A0 =A0 =A0 if (!work_pending(&keypad->work)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(keypad->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&keypad->work);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&keypad->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Anothe=
r job is currently pending \n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +

> +
> +static int __devinit max7359_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 const struct i2c_device_id *id)

You may want to remove __devinit as it is i2c client driver . I have
added linux-i2c for i2c
specific review.

> +static int max7359_suspend(struct i2c_client *client, pm_message_t m=
esg)
> +{
> + =A0 =A0 =A0 /* If no keys are pressed, enter sleep mode for 8192 ms=
 */
> + =A0 =A0 =A0 max7359_write_reg(client, MAX7359_REG_SLEEP, 0x01);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int max7359_resume(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 /* Restore the default setting (autosleep for 256 ms) *=
/
> + =A0 =A0 =A0 max7359_write_reg(client, MAX7359_REG_SLEEP, 0x07);
> +
> + =A0 =A0 =A0 return 0;
> +}

Protect these two function with #ifdef CONFIG_PM please.

> +

> +
> +static struct i2c_driver max7359_i2c_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "max7359",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D max7359_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(max7359_remove),


> +};
> +
> +
> +MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
> +MODULE_DESCRIPTION("MAX7359 Key Switch Controller Driver");
> +MODULE_LICENSE("GPL v2");

MODULE_ALIAS ??

> diff --git a/include/linux/max7359_keypad.h b/include/linux/max7359_k=
eypad.h

> +
> +#define KEY(row, col, val) =A0 =A0 (((row) << 28) | ((col) << 24) | =
(val))

Looks like this macro is highly used by many input drivers, anyone
looking at it to place it at common location?


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
