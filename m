From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Tue, 15 Nov 2011 10:02:04 +0100
Message-ID: <201111151002.07286.heiko@sntech.de>
References: <201110211043.47742.heiko@sntech.de> <201111041253.11738.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:51382 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab1KOJCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 04:02:10 -0500
In-Reply-To: <201111041253.11738.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Am Freitag, 4. November 2011, 12:53:11 schrieb Heiko St=FCbner:
> Am Freitag 21 Oktober 2011, 10:43:47 schrieb Heiko St=FCbner:
> > There exist tilt switches that simply report their tilt-state via s=
ome
> > gpios.
> >=20
> > The number and orientation of their axes can vary depending on the =
switch
> > used and the build of the device. Also two or more one-axis switche=
s
> > could be combined to provide multi-dimensional orientation.
> >=20
> > One example of a device using such a switch is the family of Qisda
> > ebook readers, where the switch provides information about the
> > landscape / portrait orientation of the device. The example in
> > Documentation/input/gpio-tilt.txt documents exactly this one-axis d=
evice.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
>=20
another ping ... comments?

Thanks
Heiko

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
