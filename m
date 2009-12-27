From: Andreas Mohr <andi@lisas.de>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice and
	keyboards
Date: Sun, 27 Dec 2009 15:20:21 +0100
Message-ID: <20091227142021.GA30090@rhlx01.hs-esslingen.de>
References: <20091221070951.GA4170@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:42261 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZL0OUX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2009 09:20:23 -0500
Content-Disposition: inline
In-Reply-To: <20091221070951.GA4170@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi,

On an ATI SB600 (RS690), no problems either on mouse/kbd after a S2R cycle,
on current git with this patch applied (verified).
And this with a rather problematic "new-fangled, designer (tm)"
Logitech Wireless Keyboard M/N Y-RR54 , P/N 867512-0102 (plus mouse!),
plugged into PS/2 connectors!

Thanks for your work!

Andreas Mohr
