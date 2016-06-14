From: Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [PATCH] Documentation: dt: gpio-keys-polled: add missed "label"
 property description
Date: Tue, 14 Jun 2016 15:52:58 +0300
Message-ID: <20160614155258.390200bf66e02966d17e3544@gmail.com>
References: <1465905151-1960-1-git-send-email-antonynpavlov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34637 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbcFNMv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 08:51:27 -0400
In-Reply-To: <1465905151-1960-1-git-send-email-antonynpavlov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>

On Tue, 14 Jun 2016 14:52:31 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

Please ignore previous email.

The "label" property description is not missed.

Sorry.

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled=
=2Etxt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> index 95d0fb1..e84d3eb 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> @@ -7,6 +7,7 @@ Required properties:
>  Optional properties:
>  	- autorepeat: Boolean, Enable auto repeat feature of Linux input
>  	  subsystem.
> +	- label: String, name of the input device.
> =20
>  Each button (key) is represented as a sub-node of "gpio-keys-polled"=
:
>  Subnode properties:
> --=20
> 2.7.0
>=20


--=20
--=A0
Best regards,
=A0 Antony Pavlov
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
