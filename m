From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
Date: Fri, 29 Jan 2010 22:37:27 +0100
Message-ID: <20100129213727.GB21364@pengutronix.de>
References: <1264799926.2975.3.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34887 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0A2Vhb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 16:37:31 -0500
Content-Disposition: inline
In-Reply-To: <1264799926.2975.3.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-input <linux-input@vger.kernel.org>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>

Hello Alberto,

On Fri, Jan 29, 2010 at 10:18:46PM +0100, Alberto Panizzo wrote:
> The MXC family of Application Processors is shipped with a Keypad Por=
t
would you mind to do s/MXC/IMX/ in your patch?  Currently both are used
but we (=3DSascha and me) will try to deprecate MXC.

> + * >>Power management need to be implemented<<.
s/need/needs/ (or alternatively do it :-)  and maybe s/<<\./.<</ ?

> [...]
> +
> +	/* The matrix is stable only if no changes are detected after
> +	 * MXC_KEYPAD_SCANS_FOR_STABILITY scans */
unusual format of the comment.

	/*
	 * ...
	 * ...
	 */

is the most found way in the kernel for multi-line comments.

> [...]
> +MODULE_LICENSE("GPL v2");
There is no space expected in the string passed to MODULE_LICENSE.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
