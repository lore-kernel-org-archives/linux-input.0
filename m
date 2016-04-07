From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3] Input: rotary_encoder - support binary encoding of states
Date: Thu, 7 Apr 2016 17:45:00 -0500
Message-ID: <CAL_JsqLfQQu69LcsFuJkKmjppp047vW5Ga+y5XiDAAG-Weh6ug@mail.gmail.com>
References: <1460055528-13814-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48308 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278AbcDGWpX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Apr 2016 18:45:23 -0400
In-Reply-To: <1460055528-13814-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>

On Thu, Apr 7, 2016 at 1:58 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> It's not advisable to use this encoding, but to support existing devi=
ces
> add support for this to the driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Ack for the binding, but...

> @@ -213,6 +222,17 @@ static int rotary_encoder_probe(struct platform_=
device *pdev)
>         encoder->rollover =3D
>                 device_property_read_bool(dev, "rotary-encoder,rollov=
er");
>
> +       err =3D device_property_read_string(dev, "rotary-encoder,enco=
ding",
> +                                         &encoding);
> +       if (!err && !strcmp(encoding, "binary")) {
> +               encoder->encoding =3D ROTENC_BINARY;
> +       } else if (err || !strcmp(encoding, "gray")) {
> +               encoder->encoding =3D ROTENC_GRAY;
> +       } else {
> +               dev_err(dev, "unknown encoding setting");
> +               return -EINVAL;

device_property_match_string() here instead.

> +       }
> +
>         device_property_read_u32(dev, "linux,axis", &encoder->axis);
>         encoder->relative_axis =3D
>                 device_property_read_bool(dev, "rotary-encoder,relati=
ve-axis");
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
