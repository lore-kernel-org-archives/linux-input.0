From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: atmel_mxt_ts - suspend patch and minor fixes
Date: Mon,  3 Aug 2015 16:23:08 +0100
Message-ID: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:15838 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754239AbbHCPcs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>

Hi Dmitry-

Here is the suspend patch for atmel_mxt_ts, again. I've tested it on Pixel
2 today. The code for T7 deep sleep has been widely used for years in our
github version of the driver.

Also, several minor (but useful) fixes.

And I've added myself to MAINTAINERS because checkpatch.

best regards

Nick Dyer

