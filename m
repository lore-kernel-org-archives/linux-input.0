From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH 1/3] Input: adp5589-keys: handle i2c errors on the irq
 handler
Date: Sat, 9 May 2015 16:48:43 -0300
Message-ID: <20150509194843.GA3969@fox>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
 <1429626090-29022-2-git-send-email-guido@vanguardiasur.com.ar>
 <55366018.8050807@analog.com>
 <20150506233323.GA5580@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35046 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbEITsu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 May 2015 15:48:50 -0400
Received: by qgej70 with SMTP id j70so51348608qge.2
        for <linux-input@vger.kernel.org>; Sat, 09 May 2015 12:48:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150506233323.GA5580@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

Dmitry,

On Wed, May 06, 2015 at 04:33:23PM -0700, Dmitry Torokhov wrote:
> On Tue, Apr 21, 2015 at 04:35:04PM +0200, Michael Hennerich wrote:
> > On 04/21/2015 04:21 PM, Guido Mart=EDnez wrote:
> > >Bail out if reading the status register fails, otherwise we'll car=
ry
> > >on with a negative error code as if it were read from the keypad, =
and
> > >falsely report events or errors.
> > >
> > >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad D=
ecoder and I/O Expander')
> > >Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> > Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> > >---
> > >  drivers/input/keyboard/adp5589-keys.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > >diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input=
/keyboard/adp5589-keys.c
> > >index a452677..19edd2d 100644
> > >--- a/drivers/input/keyboard/adp5589-keys.c
> > >+++ b/drivers/input/keyboard/adp5589-keys.c
> > >@@ -622,6 +622,9 @@ static irqreturn_t adp5589_irq(int irq, void *=
handle)
> > >  	status =3D adp5589_read(client, ADP5589_5_INT_STATUS);
> > >+	if (status < 0)
> > >+		return IRQ_HANDLED;
> > >+
> > >  	if (status & OVRFLOW_INT)	/* Unlikely and should never happen *=
/
> > >  		dev_err(&client->dev, "Event Overflow Error\n");
>=20
> Hmm, what about all other places where we read and ignore errors? Why
> this place is more important than others?
Good point. It's just the error we were hitting on our system since the
i2c controller failed. It should be the most common one should i2c fail=
,
but I agree that all other ones should be consistent with this one.

I'll work some more on it and resend.

Thanks!

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
