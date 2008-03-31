From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] Fix tosakbd suspend
Date: Tue, 1 Apr 2008 01:38:01 +0400
Message-ID: <20080331213801.GA9372@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:61754 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbYCaViI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2008 17:38:08 -0400
Received: by nf-out-0910.google.com with SMTP id g13so719593nfb.21
        for <linux-input@vger.kernel.org>; Mon, 31 Mar 2008 14:38:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dtor@mail.ru

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/input/keyboard/tosakbd.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/tosakbd.c b/drivers/input/keyboard/tosakbd.c
index 3884d1e..306cbe8 100644
--- a/drivers/input/keyboard/tosakbd.c
+++ b/drivers/input/keyboard/tosakbd.c
@@ -210,6 +210,9 @@ static int tosakbd_suspend(struct platform_device *dev, pm_message_t state)
 
 	del_timer_sync(&tosakbd->timer);
 
+	PGSR1 = (PGSR1 & ~TOSA_GPIO_LOW_STROBE_BIT);
+	PGSR2 = (PGSR2 & ~TOSA_GPIO_HIGH_STROBE_BIT);
+
 	return 0;
 }
 
-- 
1.5.4.4


-- 
With best wishes
Dmitry

