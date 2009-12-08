From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ATKBD: adding force-release quirks
Date: Mon, 7 Dec 2009 20:24:49 -0800
Message-ID: <20091208042448.GF11147@core.coreip.homeip.net>
References: <20090911051245.GB23210@core.coreip.homeip.net> <4B065F86.8070702@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:45846 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935106AbZLHEYq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 23:24:46 -0500
Received: by pwj9 with SMTP id 9so1371008pwj.21
        for <linux-input@vger.kernel.org>; Mon, 07 Dec 2009 20:24:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B065F86.8070702@pardus.org.tr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozan@pardus.org.tr>
Cc: Linux Input <linux-input@vger.kernel.org>, hal@lists.freedesktop.org

On Fri, Nov 20, 2009 at 11:21:10AM +0200, Ozan =C3=87a=C4=9Flayan wrote=
:
> Dmitry Torokhov wrote:
> > Hi,
> >
> > It appears that more and more laptops do not send release events fo=
r
> > their multimedia keys requiring adding their DMI info to the atkbd
> > driver. I don't think we can continue this practice any longer and =
I
> > would like to punt this responsibility to HAL/DevKit/whatever. In 2=
=2E6.32
> > there will be a new sysfs attribute, force_release, attached to the
> > serio port that is bound to atkbd driver. Writing to that attribute=
 will
> > allow setting a new bitmap for the keys that require forced release=
,
> > reading will produce current bitmap. The format as follows:
> >
> > echo 133-139,143,147 > /sys/devices/platform/i8042/serio0/force_rel=
ease
> >
> >  =20
>=20
> Is there currently any work for this support in udev/dk?

Johannes Stezenbach <js@sig21.net> started on adding this fucntionality
to udev.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
