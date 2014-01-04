From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ims-pcu - fix error unwinding path in application mode
Date: Fri, 3 Jan 2014 21:00:59 -0800
Message-ID: <20140104050058.GA20652@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43900 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaADFBD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 00:01:03 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <chealy@imsco-us.com>, linux-kernel@vger.kernel.org

We first create backlight and then input devices so we shoudl destroy them
in opposite order when handling errors.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Andrey, this fixup was split off from the patch I sent earlier today.

 drivers/input/misc/ims-pcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4244f47..513ecdf 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1929,10 +1929,10 @@ static int ims_pcu_init_application_mode(struct ims_pcu *pcu)
 
 	return 0;
 
-err_destroy_backlight:
-	ims_pcu_destroy_backlight(pcu);
 err_destroy_buttons:
 	ims_pcu_destroy_buttons(pcu);
+err_destroy_backlight:
+	ims_pcu_destroy_backlight(pcu);
 	return error;
 }
 
-- 
1.8.4.2


-- 
Dmitry
