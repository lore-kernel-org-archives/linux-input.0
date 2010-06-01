From: Luo Jinghua <sunmoon1997@gmail.com>
Subject: [PATCH] input: bcm5974 turn wellspring mode off if failed to start traffic
Date: Wed,  2 Jun 2010 03:45:59 +0800
Message-ID: <1275421559-7980-1-git-send-email-sunmoon1997@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51778 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab0FBDqw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jun 2010 23:46:52 -0400
Received: by pvg11 with SMTP id 11so2122928pvg.19
        for <linux-input@vger.kernel.org>; Tue, 01 Jun 2010 20:46:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Luo Jinghua <sunmoon1997@gmail.com>

The bcm5974 driver doesn't work on my MacbookPro6,2 for some reason. It
failed to start traffic and left the wellsprint mode on. As a result,
the keyboard is slow to response and become unusable.

Signed-off-by: Luo Jinghua <sunmoon1997@gmail.com>
---
 drivers/input/mouse/bcm5974.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 6dedded..5518089 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -595,6 +595,7 @@ static int bcm5974_start_traffic(struct bcm5974 *dev)
 
 err_kill_bt:
 	usb_kill_urb(dev->bt_urb);
+	bcm5974_wellspring_mode(dev, false);
 error:
 	return -EIO;
 }
-- 
1.7.1

