From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Wed, 23 Nov 2011 20:45:02 +0000 (GMT)
Message-ID: <1322081102.2448.YahooMailClassic@web29004.mail.ird.yahoo.com>
References: <20111123195144.GB9918@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm23-vm4.bullet.mail.ird.yahoo.com ([212.82.109.233]:43440 "HELO
	nm23-vm4.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751196Ab1KWUpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 15:45:04 -0500
In-Reply-To: <20111123195144.GB9918@rainbow>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: eric.y.miao@gmail.com, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com, philipp.zabel@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--- On Wed, 23/11/11, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> BTW, it's funny that driver is placed in input/mouse, but
> actually
> reports only keyboard events :)
> Anyway, reporting coordinates can be added at some later
> point.

That's right, the underlying hardware is a touchpad so the driver could report mouse events if required. Obviously the hx4700 already has a working touchscreen so it's not obvious what benefit a second mouse device would add. And I'm not aware of any other platforms which use the NavPoint.
