From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 11:29:21 +0200
Message-ID: <003701cb1124$3e335f00$ba9a1d00$%szyprowski@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
 <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:10023 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab0FUJae (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 05:30:34 -0400
In-reply-to: <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
Content-language: pl
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Eric Miao' <eric.y.miao@gmail.com>, 'Joonyoung Shim' <jy0922.shim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-input@vger.kernel.org

Hello,

On Monday, June 21, 2010 11:06 AM Eric Miao wrote:

> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsung.com>
> wrote:
> > This patch adds samsung keypad device definition for samsung cpus.
> >
> > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/plat-samsung/Kconfig                    |    5 ++
> >  arch/arm/plat-samsung/Makefile                   |    1 +
> >  arch/arm/plat-samsung/dev-keypad.c               |   58
> +++++++++++++++++++++
> 
> Why need an individual file for a simple device?  In the end, these files
> will flood over the plat-samsung/ directory. And now think this - in your
> new SoC design ,the keypad IP is replaced with a completely new one, does
> that mean a new dev-keypad-new1.c, dev-keypad-new2.c?
> 
> I personally prefer a single devices.c for all the devices, if you
> orgnize well, shouldn't take up much code size in that single file.

A separate dev-abc.c files has been chosen by a platform maintainer. This
has some advantages as some unused data can be easily not compiled into
the kernel which is configured specially for a particular board.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center



