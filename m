From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
Date: Wed, 23 Nov 2011 23:49:01 +0100
Message-ID: <1322088541.18388.16.camel@flow>
References: <1322081102.2448.YahooMailClassic@web29004.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52859 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab1KWWtG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 17:49:06 -0500
Received: by bke11 with SMTP id 11so2154793bke.19
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2011 14:49:05 -0800 (PST)
In-Reply-To: <1322081102.2448.YahooMailClassic@web29004.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, eric.y.miao@gmail.com, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Am Mittwoch, den 23.11.2011, 20:45 +0000 schrieb Paul Parsons:
> --- On Wed, 23/11/11, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> > BTW, it's funny that driver is placed in input/mouse, but
> > actually
> > reports only keyboard events :)
> > Anyway, reporting coordinates can be added at some later
> > point.
> 
> That's right, the underlying hardware is a touchpad so the driver could report mouse events if required. Obviously the hx4700 already has a working touchscreen so it's not obvious what benefit a second mouse device would add. And I'm not aware of any other platforms which use the NavPoint.

I agree, the NavPoint is pretty useless as a touchpad.

I think there's some kind of Logitech Wireless Keyboard / Remote that
has a NavPoint, but I'm not aware of anything with them that would run
linux either.

regards
Philipp

