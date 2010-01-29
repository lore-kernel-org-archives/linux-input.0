From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v5] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Fri, 29 Jan 2010 23:02:23 +0100
Message-ID: <1264802543.2975.17.camel@realization>
References: <1264799926.2975.3.camel@realization>
	 <20100129213727.GB21364@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:8847 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0A2WC3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 17:02:29 -0500
Received: by ey-out-2122.google.com with SMTP id d26so573097eyd.19
        for <linux-input@vger.kernel.org>; Fri, 29 Jan 2010 14:02:27 -0800 (PST)
In-Reply-To: <20100129213727.GB21364@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-input <linux-input@vger.kernel.org>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>

On ven, 2010-01-29 at 22:37 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Alberto,
>=20
> On Fri, Jan 29, 2010 at 10:18:46PM +0100, Alberto Panizzo wrote:
> > The MXC family of Application Processors is shipped with a Keypad P=
ort
> would you mind to do s/MXC/IMX/ in your patch?  Currently both are us=
ed
> but we (=3DSascha and me) will try to deprecate MXC.

=46or sure! and for what I can say I approve this plan.

>=20
> > + * >>Power management need to be implemented<<.
> s/need/needs/ (or alternatively do it :-)  and maybe s/<<\./.<</ ?

hehe, power management is the next part. What I wont is to put the=20
device running before the next merge window if it is possible and
then present all my work on mx31_3ds.


>=20
> > [...]
> > +
> > +	/* The matrix is stable only if no changes are detected after
> > +	 * MXC_KEYPAD_SCANS_FOR_STABILITY scans */
> unusual format of the comment.
>=20
> 	/*
> 	 * ...
> 	 * ...
> 	 */
>=20
> is the most found way in the kernel for multi-line comments.

Only a way to compress them..
>=20
> > [...]
> > +MODULE_LICENSE("GPL v2");
> There is no space expected in the string passed to MODULE_LICENSE.

Thanks.

Alberto!

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
