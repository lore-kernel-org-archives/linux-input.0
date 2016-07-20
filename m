From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] Input: rotary_encoder - support binary encoding of
 states
Date: Wed, 20 Jul 2016 08:19:38 -0500
Message-ID: <20160720131938.GA4165@rob-hp-laptop>
References: <1468957119-16458-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36371 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbcGTNTk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 09:19:40 -0400
Content-Disposition: inline
In-Reply-To: <1468957119-16458-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel@pengutronix.de

On Tue, Jul 19, 2016 at 09:38:39PM +0200, Uwe Kleine-K=F6nig wrote:
> It's not advisable to use this encoding, but to support existing devi=
ces
> add support for this to the driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Notes:
>     Changes since (implicit) v1, sent with
>     Message-Id: 1458680914-4533-1-git-send-email-u.kleine-koenig <at>=
 pengutronix.de
>    =20
>      - switch format of dt properties to use strings
>    =20
>     Changes since v2, sent with
>     Message-Id: 1458806232-22403-1-git-send-email-u.kleine-koenig <at=
> pengutronix.de
>    =20
>      - be more strict about parsing the encoding string
>    =20
>     Changes since v3, sent with
>     Message-Id: 1460055528-13814-1-git-send-email-u.kleine-koenig@pen=
gutronix.de
>    =20
>      - use device_property_match_string to parse device tree as reque=
sted
>        by Rob Herring.
>=20
>  .../devicetree/bindings/input/rotary-encoder.txt   |  4 ++++
>  drivers/input/misc/rotary_encoder.c                | 23 ++++++++++++=
+++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
