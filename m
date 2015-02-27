From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bug in i2c-core?
Date: Fri, 27 Feb 2015 09:46:11 -0800
Message-ID: <20150227174611.GC6679@dtor-ws>
References: <54F0507F.6030804@armadeus.com>
 <20150227153725.7404dea1@free-electrons.com>
 <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
 <20150227170545.GS7789@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:45240 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbbB0RqQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 12:46:16 -0500
Content-Disposition: inline
In-Reply-To: <20150227170545.GS7789@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?iso-8859-1?Q?S=E9bastien?= SZYMANSKI <sebastien.szymanski@armadeus.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, laurent.pinchart+renesas@ideasonboard.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Fri, Feb 27, 2015 at 06:05:45PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Feb 27, 2015 at 07:29:30AM -0800, Dmitry Torokhov wrote:
> > On February 27, 2015 6:37:25 AM PST, Thomas Petazzoni <thomas.petaz=
zoni@free-electrons.com> wrote:
> > >Dear S=E9bastien SZYMANSKI,
> > >
> > >On Fri, 27 Feb 2015 12:09:51 +0100, S=E9bastien SZYMANSKI wrote:
> > >
> > >>         error =3D input_register_device(sx8654->input);
> > >>         if (error)
> > >>                 return error;
> > >
> > >Where is your ->remove() function that unregisters the input devic=
e?
> >=20
> > Everything seems to be allocated with devm so remove is not needed.
> Everything is devm_* but input_register_device, right?

Input is allocated with devm_* and input_register_device knows how to
deal with that:

/**
 * devm_input_allocate_device - allocate managed input device
 * @dev: device owning the input device being created
 *
 * Returns prepared struct input_dev or %NULL.
 *
 * Managed input devices do not need to be explicitly unregistered or
 * freed as it will be done automatically when owner device unbinds fro=
m
 * its driver (or binding fails). Once managed input device is
 * allocated,
 * it is ready to be set up and registered in the same fashion as
 * regular
 * input device. There are no special devm_input_device_[un]register()
 * variants, regular ones work with both managed and unmanaged devices,

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 * should you need them. In most cases however, managed input device
 * need
 * not be explicitly unregistered or freed.
 *
 * NOTE: the owner device is set up as parent of input device and users
 * should not override it.
 */


Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
