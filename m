From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL Touchscreen
Date: Mon, 28 Apr 2008 07:55:58 +0200
Message-ID: <20080428055558.GC9804@digi.com>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com> <1209149798-20418-2-git-send-email-justin.waters@timesys.com> <20080425211041.GC28497@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:56802 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYD1F4H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2008 01:56:07 -0400
Content-Disposition: inline
In-Reply-To: <20080425211041.GC28497@flint.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Justin Waters <justin.waters@timesys.com>, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za, linux-input@vger.kernel.org

Hello,

> > +	/* Setup Clock */
> > +	ts->tsc_clk =3D clk_get(&pdev->dev,"tsc_clk");
> > +	if (IS_ERR(ts->tsc_clk)) {
>=20
> Great, nice to see a driver using the clock API properly.
>=20
> > +		dev_err(&pdev->dev, "unable to get clock\n");
> > +		err =3D PTR_ERR(ts->tsc_clk);
> > +		goto err_iounmap;
> > +        }
>=20
> Odd indentation on the last line above.
>=20
> > +	clk_enable(ts->tsc_clk);
To use the clock API properly you should check the return value of
clk_enable, too :-)

Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
