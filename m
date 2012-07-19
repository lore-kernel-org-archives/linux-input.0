From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v8] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 19 Jul 2012 15:50:01 +0200
Message-ID: <20120719135001.GA644@polaris.bitmath.org>
References: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341763522-14374-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120709080640.GA4137@polaris.bitmath.org>
 <20120719041656.GA3300@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:43413 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSNs6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 09:48:58 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id EC9F9DD66
	for <linux-input@vger.kernel.org>; Thu, 19 Jul 2012 15:48:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120719041656.GA3300@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: simon.budig@kernelconcepts.de, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi Dmitry,

> OK, so the patch below should fix most of Henrik's comments and some of
> mine. Compile-tested only though. It would be nice to have it verified
> on real hardware so we could get it in in the next merge window.

Looking good, just a question for Simon: In the mt report function,
the loop uses every fourth byte of rdbuf, but the access looks a bit
funny; buf[5], buf[6] etc. It is fine as long as it works, just
checking. :-)

Thanks,
Henrik
