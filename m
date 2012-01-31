From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] gpio_keys: fix struct device declared inside parameter list
Date: Tue, 31 Jan 2012 22:27:55 +0100
Message-ID: <201201312227.55934.heiko@sntech.de>
References: <201201121011.31840.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:47663 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799Ab2AaV16 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 16:27:58 -0500
In-Reply-To: <201201121011.31840.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Am Donnerstag 12 Januar 2012, 10:11:31 schrieb Heiko St=FCbner:
> A struct device parameter is used in the enable and disable callbacks=
 to
> distinguish between different gpio_keys devices.
>=20
> Platforms that don't use these callbacks may not include struct devic=
e
> at all, as seen on arch/arm/mach-s3c2410/mach-n30.c
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
ping?

Thanks
Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
