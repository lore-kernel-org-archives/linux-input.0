From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] Input: rotary_encoder - support binary encoding of
 states
Date: Fri, 25 Mar 2016 09:21:38 -0500
Message-ID: <20160325142138.GA15449@rob-hp-laptop>
References: <1458806232-22403-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47110 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbcCYOVo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2016 10:21:44 -0400
Content-Disposition: inline
In-Reply-To: <1458806232-22403-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rojhalat Ibrahim <imr@rtschenk.de>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, kernel@pengutronix.de, Daniel Mack <daniel@zonque.org>

On Thu, Mar 24, 2016 at 08:57:12AM +0100, Uwe Kleine-K=F6nig wrote:
> It's not advisable to use this encoding, but to support existing devi=
ces
> add support for this to the driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>=20
> Notes:
>     Changes since (implicit) v1, sent with
>     Message-Id: 1458680914-4533-1-git-send-email-u.kleine-koenig@peng=
utronix.de
>    =20
>      - switch format of dt properties to use strings
>=20
>  .../devicetree/bindings/input/rotary-encoder.txt   |  4 ++++
>  drivers/input/misc/rotary_encoder.c                | 22 ++++++++++++=
+++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
