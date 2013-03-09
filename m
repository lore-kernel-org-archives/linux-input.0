From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/4] Input: wm97xx: Fix handling of wrong readings
Date: Sat, 9 Mar 2013 15:42:39 -0800
Message-ID: <20130309234239.GA8969@core.coreip.homeip.net>
References: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:56741 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3CIXml (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Mar 2013 18:42:41 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so2485761pbc.30
        for <linux-input@vger.kernel.org>; Sat, 09 Mar 2013 15:42:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de

Hi Markus,

On Sat, Mar 09, 2013 at 06:05:49PM +0100, Markus Pargmann wrote:
> Hi,
> 
> the series adds/fixes some handling for wrong readings of penup/down
> and out of screen readings. Those wrong readings had a big impact on
> the usability in my tests.
> 
> Changes in v2:
> - Fixed style of multiline condition in patch 1

I queued the patches for 3.10. I stripped the stable designation though
as I believe we should only designate for stable patches that fixes
grave bugs, not something that improves the behavior.

Thanks.

-- 
Dmitry
