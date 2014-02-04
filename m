From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Wed, 5 Feb 2014 00:45:08 +0100
Message-ID: <201402050045.08532.marex@denx.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <52CEA4AA.8050503@free-electrons.com> <201401100955.45885.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60441 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbaBDXpM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:45:12 -0500
In-Reply-To: <201401100955.45885.jbe@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org

On Friday, January 10, 2014 at 09:55:45 AM, J=FCrgen Beisert wrote:

[...]

> > While this is not necessarily an issue with ts_calibrate (it is pos=
sible
> > to click longer so it collects more samples), I don't see that work=
ing
> > with xinput_calibrator.
> >=20
> > While I don't have much experience with the TS part of the code but=
 I
> > can investigate if you don't have any idea.
>=20
> You are right. I have seen the same behaviour here a few times. Curre=
ntly
> I'm short in time to dig deeper into this issue, but I will try to do=
 so.

Hi guys, is this still broken?

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
