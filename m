From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Thu, 24 Nov 2011 01:06:49 +0000 (GMT)
Message-ID: <1322096809.59552.YahooMailClassic@web29001.mail.ird.yahoo.com>
References: <1322088363.18388.13.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm6.bullet.mail.ird.yahoo.com ([77.238.189.63]:36228 "HELO
	nm6.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751909Ab1KXBGv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 20:06:51 -0500
In-Reply-To: <1322088363.18388.13.camel@flow>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, eric.y.miao@gmail.com, mad_soft@inbox.ru, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com

--- On Wed, 23/11/11, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Looked good on first glance, but a quick test run of those
> two patches
> against v3.2-rc2 resulted in an Oops in navpoint_int as
> soon as I
> touched the navpoint:

oops, sorry about that.

> I guess that's because you effectively pass drv_data into
> dev_warn as
> first argument here. Fix that and maybe rename the second
> parameter of
> navpoint_int to void *dev_id to avoid confusion.

Yes, void* and naming confusion conspired to pass unnoticed.

> I assume I hit this spurious interrupt because I was
> booting with haret
> and you use the SDG bootloader?

Yes I do use the SDG bootloader, but I don't know whether that accounts for my absence of spuriousness. If it does then perhaps there is a problem with haret intialization?

