From: simon.budig@kernelconcepts.de
Subject: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Sat, 23 Jun 2012 01:48:17 +0200
Message-ID: <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:38808 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2FVX44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jun 2012 19:56:56 -0400
In-Reply-To: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi all.

This is a new iteration of the driver for the edt ft5x06 based
polytouch series of touchscreens. It contains most of the changes from
Dmitry. I did not incorporate the attribute is_visible-stuff, since it
did not work as expected for me. Also I do not release the reset pin.

I guess that Dmitris Signed-off-by needs to be included as well since he
contributed quite some improvements, but I was unsure if it would be the
correct procedure for me to include it in this patch.

This version also changes the driver to protocol B.

This patch also passes checkpatch, although I really hate how it forces
me to use some tabs/spaces in a way that messes with alignment when
changing tab with. Ah well.

Please give feedback on problems or on further plans for inclusion into
mainline.

Thanks,
        Simon

