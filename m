From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Bug in i2c-core?
Date: Fri, 27 Feb 2015 18:05:45 +0100
Message-ID: <20150227170545.GS7789@pengutronix.de>
References: <54F0507F.6030804@armadeus.com>
 <20150227153725.7404dea1@free-electrons.com>
 <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45820 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbB0RFu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 12:05:50 -0500
Content-Disposition: inline
In-Reply-To: <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?iso-8859-1?Q?S=E9bastien?= SZYMANSKI <sebastien.szymanski@armadeus.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, laurent.pinchart+renesas@ideasonboard.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Fri, Feb 27, 2015 at 07:29:30AM -0800, Dmitry Torokhov wrote:
> On February 27, 2015 6:37:25 AM PST, Thomas Petazzoni <thomas.petazzo=
ni@free-electrons.com> wrote:
> >Dear S=E9bastien SZYMANSKI,
> >
> >On Fri, 27 Feb 2015 12:09:51 +0100, S=E9bastien SZYMANSKI wrote:
> >
> >>         error =3D input_register_device(sx8654->input);
> >>         if (error)
> >>                 return error;
> >
> >Where is your ->remove() function that unregisters the input device?
>=20
> Everything seems to be allocated with devm so remove is not needed.
Everything is devm_* but input_register_device, right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
