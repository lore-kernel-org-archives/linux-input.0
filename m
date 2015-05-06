From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: adp5589-keys: handle i2c errors on the irq
 handler
Date: Wed, 6 May 2015 16:33:23 -0700
Message-ID: <20150506233323.GA5580@dtor-ws>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
 <1429626090-29022-2-git-send-email-guido@vanguardiasur.com.ar>
 <55366018.8050807@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37097 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbEFXd3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 19:33:29 -0400
Received: by igbsb11 with SMTP id sb11so9149449igb.0
        for <linux-input@vger.kernel.org>; Wed, 06 May 2015 16:33:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55366018.8050807@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

On Tue, Apr 21, 2015 at 04:35:04PM +0200, Michael Hennerich wrote:
> On 04/21/2015 04:21 PM, Guido Mart=EDnez wrote:
> >Bail out if reading the status register fails, otherwise we'll carry
> >on with a negative error code as if it were read from the keypad, an=
d
> >falsely report events or errors.
> >
> >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Dec=
oder and I/O Expander')
> >Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> >---
> >  drivers/input/keyboard/adp5589-keys.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/k=
eyboard/adp5589-keys.c
> >index a452677..19edd2d 100644
> >--- a/drivers/input/keyboard/adp5589-keys.c
> >+++ b/drivers/input/keyboard/adp5589-keys.c
> >@@ -622,6 +622,9 @@ static irqreturn_t adp5589_irq(int irq, void *ha=
ndle)
> >  	status =3D adp5589_read(client, ADP5589_5_INT_STATUS);
> >+	if (status < 0)
> >+		return IRQ_HANDLED;
> >+
> >  	if (status & OVRFLOW_INT)	/* Unlikely and should never happen */
> >  		dev_err(&client->dev, "Event Overflow Error\n");

Hmm, what about all other places where we read and ignore errors? Why
this place is more important than others?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
