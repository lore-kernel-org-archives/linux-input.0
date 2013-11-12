From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH] input: ti_am33x_tsc: make the documentation for the ti,wire-config parameter clear
Date: Tue, 12 Nov 2013 10:24:39 -0600
Message-ID: <5C68A2CC-A8C8-4B56-A414-B9EBE438F767@codeaurora.org>
References: <1384273323-15329-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:46101 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab3KLQYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 11:24:44 -0500
In-Reply-To: <1384273323-15329-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org


On Nov 12, 2013, at 10:22 AM, Sebastian Andrzej Siewior <bigeasy@linutr=
onix.de> wrote:

> The document says "first four bits" and means the upper nibble. Most
> people would probably agree that the first four bits are bits 0=853 a=
nd
> that is the lower nibble.
> This patch updates the documentation so it is clear what is meant.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt | =
4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-t=
sc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc=
-adc.txt
> index 491c97b..0fcd430 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.=
txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.=
txt
> @@ -17,8 +17,8 @@
> 				remaining 4 can be used by the ADC.
> 	ti,wire-config: Different boards could have a different order for
> 			connecting wires on touchscreen. We need to provide an
> -			8 bit number where in the 1st four bits represent the
> -			analog lines and the next 4 bits represent positive/
> +			8 bit number where the upper nibble represent the
> +			analog lines and the lower nibble represent positive/
> 			negative terminal on that input line. Notations to
> 			represent the input lines and terminals resoectively
> 			is as follows:

Is it possible to give an example because that might help with the conf=
usion.

- k

> --=20
> 1.8.4.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
