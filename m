From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 RESEND 1/3] input: mc13783: Prepare driver to
 support MC13892 and OF
Date: Sat, 17 Aug 2013 11:23:02 +0200
Message-ID: <20130817092302.GS26614@pengutronix.de>
References: <1376718381-16924-1-git-send-email-shc_work@mail.ru>
 <20130817062012.GA26693@pengutronix.de>
 <20130817105305.5201c078d4f2cf52ffb172f8@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32775 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab3HQJXL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 05:23:11 -0400
Content-Disposition: inline
In-Reply-To: <20130817105305.5201c078d4f2cf52ffb172f8@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Michael Grzeschik <mgr@pengutronix.de>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>

On Sat, Aug 17, 2013 at 10:53:05AM +0400, Alexander Shiyan wrote:
> On Sat, 17 Aug 2013 08:20:12 +0200
> Michael Grzeschik <mgr@pengutronix.de> wrote:
> 
> > On Sat, Aug 17, 2013 at 09:46:20AM +0400, Alexander Shiyan wrote:
> > > This patch is a preparation mc13xxx powerbutton driver to support
> > > MC13892 and support the probe through the DT.
> > 
> > As this patch already mention by itself, it's doing to much at once.
> > And by looking at it, it realy does more than it tells here.
> > 
> > Can you rework that into seperate readable tasks. In this patch you
> > nearly rewrite the whole file. That runs the review impossible.
> 
> All changes in this patch are addicted to each other, can not be divided.

I find this hard to believe. Here are some changes that can be separated
easily:

- Rename defines from MC13XXX_BUTTON_ to MC13783_BUTTON_
- convert module_platform_driver to module_platform_driver_probe, why do
  you change this anyway?
- convert from kzalloc to devm_kzalloc
- rewrite error message from "missing platform data" to "Missing
  platform data"

Drop these changes or make them separate patches and your original patch
would be smaller already.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
