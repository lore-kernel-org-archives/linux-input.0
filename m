From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] gpio_keys: fix struct device declared inside parameter
 list
Date: Fri, 3 Feb 2012 00:37:02 -0800
Message-ID: <20120203083702.GB24226@core.coreip.homeip.net>
References: <201201121011.31840.heiko@sntech.de>
 <201201312227.55934.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33199 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab2BCIhG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Feb 2012 03:37:06 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so2560686dad.19
        for <linux-input@vger.kernel.org>; Fri, 03 Feb 2012 00:37:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201201312227.55934.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

On Tue, Jan 31, 2012 at 10:27:55PM +0100, Heiko St=FCbner wrote:
> Am Donnerstag 12 Januar 2012, 10:11:31 schrieb Heiko St=FCbner:
> > A struct device parameter is used in the enable and disable callbac=
ks to
> > distinguish between different gpio_keys devices.
> >=20
> > Platforms that don't use these callbacks may not include struct dev=
ice
> > at all, as seen on arch/arm/mach-s3c2410/mach-n30.c
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ping?
>=20

Applied, thank you Heiko.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
