From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Fri, 4 Nov 2011 12:53:11 +0100
Message-ID: <201111041253.11738.heiko@sntech.de>
References: <201110211043.47742.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:47448 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751657Ab1KDMXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Nov 2011 08:23:40 -0400
In-Reply-To: <201110211043.47742.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>

Am Freitag 21 Oktober 2011, 10:43:47 schrieb Heiko St=FCbner:
> There exist tilt switches that simply report their tilt-state via som=
e
> gpios.
>=20
> The number and orientation of their axes can vary depending on the sw=
itch
> used and the build of the device. Also two or more one-axis switches
> could be combined to provide multi-dimensional orientation.
>=20
> One example of a device using such a switch is the family of Qisda
> ebook readers, where the switch provides information about the
> landscape / portrait orientation of the device. The example in
> Documentation/input/gpio-tilt.txt documents exactly this one-axis dev=
ice.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
ping ... comments?

Thanks
Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
