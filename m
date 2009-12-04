From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [PATCH] Input: Force Feedback core memory leak
Date: Fri,  4 Dec 2009 15:05:14 +0200
Message-ID: <1259931914-6228-2-git-send-email-ext-jari.vanhala@nokia.com>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60134 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbZLDNFP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 08:05:15 -0500
In-Reply-To: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, ext-jari.vanhala@nokia.com

Effects is allocated, but not freed anywhere.

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/ff-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 3d7816c..d310a97 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -367,6 +367,7 @@ void input_ff_destroy(struct input_dev *dev)
 		if (dev->ff->destroy)
 			dev->ff->destroy(dev->ff);
 		kfree(dev->ff->private);
+		kfree(dev->ff->effects);
 		kfree(dev->ff);
 		dev->ff = NULL;
 	}
-- 
1.6.3.3

