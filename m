From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: [PATCH v4 2/2] input: rotary encoder: Add wake up support
Date: Tue, 13 Oct 2015 15:16:14 +0200
Message-ID: <20151013131614.GA32765@gradator.net>
References: <1444677212-9590-1-git-send-email-sylvain.rochet@finsecur.com>
 <1444677212-9590-3-git-send-email-sylvain.rochet@finsecur.com>
 <20151013123948.GI8067@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:42751 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbJMNQS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 09:16:18 -0400
Content-Disposition: inline
In-Reply-To: <20151013123948.GI8067@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Johan,


On Tue, Oct 13, 2015 at 02:39:48PM +0200, Johan Hovold wrote:
> On Mon, Oct 12, 2015 at 09:13:32PM +0200, Sylvain Rochet wrote:
> > This patch adds wake up support to GPIO rotary encoders.
> >=20
> > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> > Reviewed-by: Johan Hovold <johan@kernel.org>
>=20
> Hmm. I have not yet reviewed the changes you did in v4.

Woops, sorry, I forgot to remove it while rebasing.


> > ---
> >  drivers/input/misc/rotary_encoder.c | 39 +++++++++++++++++++++++++=
++++++++++++
> >  include/linux/rotary_encoder.h      |  1 +
> >  2 files changed, 40 insertions(+)
> >=20
> > diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/mi=
sc/rotary_encoder.c
> > index f27f81e..0d86dc4 100644
> > --- a/drivers/input/misc/rotary_encoder.c
> > +++ b/drivers/input/misc/rotary_encoder.c
>=20
> > @@ -280,6 +283,10 @@ static int rotary_encoder_probe(struct platfor=
m_device *pdev)
> >  		goto exit_free_irq_b;
> >  	}
> > =20
> > +	device_set_wakeup_capable(&pdev->dev, true);
>=20
> You should continue to use the platform data to determine whether the
> device is capable of wakeup or not.
>=20
> > +	if (pdata->wakeup_source)
> > +		device_wakeup_enable(&pdev->dev);
> > +
>=20
> Just stick to
>=20
> 	device_init_wakeup(&pdev->dev, pdata->wakeup_source);

There is unfortunately no or poor documentation on how "wakeup-source"=20
DT property should behave. We have no clue if wake up should be enabled=
=20
by default, which is what device_init_wakeup() is doing. If=20
"wakeup-source" is just a flag to determine whether the device is=20
capable of wakeup or not then it should probably not change the behavio=
r=20
and wake up should probably be off by default, thus the right way would=
=20
be to call device_set_wakeup_capable(&pdev->dev, pdata->wakeup_source);

device_init_wakeup() is a bit confusing, its introductory comment says=20
that "By default, most devices should leave wakeup disabled." but it=20
actually enables it by default. In this case we are the exception "The=20
exceptions are devices that everyone expects to be wakeup sources:=20
keyboards, =E2=80=A6" but it only adds more confusion, we are the excep=
tion, but=20
by default we are not.

Anyway, I don't really care and I will resend with device_init_wakeup()=
=20
because wakeup support enabled by default is what I need.

Thank you very much :-)

Cheers,
Sylvain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
