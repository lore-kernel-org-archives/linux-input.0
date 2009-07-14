From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] tsc2007: remove HR timer
Date: Tue, 14 Jul 2009 09:08:06 +0200
Message-ID: <20090714070806.GA1619@avionic-design.de>
References: <4A40C288.2060702@mocean-labs.com>
 <20090714044957.GD2822@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61361 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbZGNHIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 03:08:41 -0400
Content-Disposition: inline
In-Reply-To: <20090714044957.GD2822@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kwangwoo.lee@gmail.com, Trilok Soni <soni.trilok@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

* Dmitry Torokhov wrote:
> Hi Richard,
>=20
> On Tue, Jun 23, 2009 at 01:54:48PM +0200, Richard R=C3=B6jfors wrote:
[...]
> +static void tsc2007_free_irq(struct tsc2007 *ts)
> +{
> +	free_irq(ts->irq, ts);
> +	if (cancel_delayed_work_sync(&ts->work)) {
> +		/*
> +		 * Work was pending, therefore we need to enable
> +		 * IRQ here to balance the disable_irq() done in the
> +		 * interrupt handler.
> +		 */
> +		enable_irq(ts->irq);
> +	}
> +}
[...]
> -static int tsc2007_remove(struct i2c_client *client)
> +static int __devexit tsc2007_remove(struct i2c_client *client)
>  {
>  	struct tsc2007	*ts =3D i2c_get_clientdata(client);
> -	struct tsc2007_platform_data *pdata;
> +	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
> =20
> -	cancel_delayed_work_sync(&ts->work);
> +	free_irq(ts->irq, ts);
> +	if (cancel_delayed_work_sync(&ts->work)) {
> +		/*
> +		 * Work was pending, therefore we need to enable
> +		 * IRQ here to balance the disabel done in the
> +		 * interrupt handler.
> +		 */
> +		enable_irq(ts->irq);
> +	}

Shouldn't this be tsc2007_free_irq(ts) as well?

Thierry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
