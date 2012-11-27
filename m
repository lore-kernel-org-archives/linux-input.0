From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] Input: bu21013_ts - Request a regulator that
 actually exists
Date: Tue, 27 Nov 2012 14:34:07 +0000
Message-ID: <20121127143407.GG2013@gmail.com>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-2-git-send-email-lee.jones@linaro.org>
 <20121127133404.GA13065@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42791 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab2K0OeM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 09:34:12 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5171680bkw.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 06:34:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121127133404.GA13065@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-input@vger.kernel.org

On Tue, 27 Nov 2012, Mark Brown wrote:

> On Tue, Nov 27, 2012 at 01:13:08PM +0000, Lee Jones wrote:
> > Currently the BU21013 Touch Screen driver requests a regulator by t=
he
> > name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
> > correct name, as referenced in platform regulator code is 'avdd'. H=
ere,
> > when we request a regulator, we use the correct name instead.
>=20
> The regulator should be requested using whatever the name for the sup=
ply
> in the datasheet - AVDD does sound very pluasible but it'd be good to
> check.

Right. 'avdd' is correct.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
