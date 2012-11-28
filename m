From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
Date: Wed, 28 Nov 2012 08:57:31 +0000
Message-ID: <20121128085731.GH2013@gmail.com>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
 <20121128070332.GC23378@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45702 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab2K1I5h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 03:57:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5544847bkw.19
        for <linux-input@vger.kernel.org>; Wed, 28 Nov 2012 00:57:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121128070332.GC23378@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, linux-input@vger.kernel.org

Hi Dmitry,

> On Tue, Nov 27, 2012 at 01:13:10PM +0000, Lee Jones wrote:
> > Now we can register the BU21013_ts touch screen when booting with
> > Device Tree enabled. Here we parse all the necessary components
> > previously expected to be passed from platform data.
>=20
> I applied these 3 patches, but for DT we also need to specify compati=
ble
> ID and set up of_match_table pointer.=20

Why do you need a compatible string?

> Please send me a follow-up patches
> doing that and also describing DT bindings for BU21013.

I'll send the documentation as a seperate reply to your email.

Kind regards,
Lee

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
