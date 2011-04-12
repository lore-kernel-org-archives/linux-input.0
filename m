From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input_polling_devices design question + adxl34x polling mode
 patch
Date: Mon, 11 Apr 2011 23:23:10 -0700
Message-ID: <20110412062310.GD1854@core.coreip.homeip.net>
References: <17876647.33591302538862973.JavaMail.www@wsfrf1114>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34691 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab1DLGXQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:23:16 -0400
Received: by iyb14 with SMTP id 14so6325837iyb.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 23:23:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <17876647.33591302538862973.JavaMail.www@wsfrf1114>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: paul.chavent@fnac.net
Cc: michael.hennerich@analog.com, device-driver-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

Hi Paul,

On Mon, Apr 11, 2011 at 06:21:02PM +0200, paul.chavent@fnac.net wrote:
> Hi.
>=20
> I have=A0 a board with an adxl34x (an accelerometer) on a two wire bu=
s.
> Its interrupt line aren't routed.
>=20
> So i would like to use the driver in polling mode.
>=20
> I submit this patch as a beta version of my work.
>=20
> I tried to reuse the input_polling structure but I'm facing some
> problems.
>=20
> The driver has a "rate" attribute that i would like to control when i
> setup the "interval" attribute of the input_pollling.
>=20
> And vice versa, when i setup the "interval" attribute i would like to
> setup the "rate".
>=20
> So my questions : =A0- Is it possible to reimplement a workqueue for
> this driver only ? As it seems to have been done yet in other drivers=
,
> i wonder if it's acceptable, or if we should avoid this practice.  =A0=
-
> I think it would be complicated to have hooks in input and
> input_polling for calling each other. I wonder if i haven't any desig=
n
> problem.
>=20
> I would need an advice in order to cleaning this patch please.
>=20

Yes, just use the system workqueue (now even dedicated workqueue is not
really needed) and leave input_polldev alone - it makes sense to use fo=
r
devices that are purely polled ones. The devices that may or may not be
interrupt driven I think we should just hook workqueue handling in the
driver.

Note that I normally oppose supporting polling mode for devices that ma=
y
be interrupt driven, since this normally increases power consumption.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
