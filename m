From: simon.budig@kernelconcepts.de
Subject: [PATCH v8] Touchscreen driver for FT5x06 based EDT displays
Date: Sun,  8 Jul 2012 18:05:21 +0200
Message-ID: <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:42967 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2GHSZc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jul 2012 14:25:32 -0400
In-Reply-To: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi all.

This is a new iteration of the driver for the edt ft5x06 based
polytouch series of touchscreens.

This version moves some of the code in separate functions as requested by
Henrik (with one exception where I did not see the point, namely the inital
readout of some sensor parameters in _probe()).

The raw data readout has been simplified greatly, it now allocates a buffer
for the whole sensor area on switching into factory mode, fills it
completely on read() and copies the requested data. On switch into work mode
the memory is released again.

I hope this finally approaches upstreamability  :)

Thanks,
        Simon

