From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 0/3] Updates to the wm97xx-drivers
Date: Mon, 4 Jul 2011 19:33:42 -0700
Message-ID: <20110705023342.GD2724@core.coreip.homeip.net>
References: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
 <20110703203721.GA13701@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab1GEEhH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:37:07 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so4900484iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:37:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110703203721.GA13701@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-input@vger.kernel.org, dp@opensource.wolfsonmicro.com

On Sun, Jul 03, 2011 at 01:37:22PM -0700, Mark Brown wrote:
> On Sun, Jul 03, 2011 at 07:09:27PM +0200, Wolfram Sang wrote:
> > I noticed a problem that reading battery status was dependent on the pen_down
> > status. While trying to solve the problem, I came up with the first two cleanup
> > patches. The third one then fixes the original itch. The series been tested
> > with Linux 3.0-rc5 on a Jaytech PID7901 having a WM9715. The code for WM9705
> > and WM9713 has only been compile tested. Testers are very welcome :)
> 
> All
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All applied, thanks Wolfram.

-- 
Dmitry
