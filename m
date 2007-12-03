From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH 1/4] apanel: free input device on close
Date: Mon, 03 Dec 2007 14:18:08 -0800
Message-ID: <20071203221900.468532656@linux-foundation.org>
References: <20071203221807.077325020@linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58921 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752639AbXLCWVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Dec 2007 17:21:13 -0500
Content-Disposition: inline; filename=fujitsu-apanel-input-free.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

Fix memory leak.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/drivers/input/misc/apanel.c	2007-11-20 06:03:06.000000000 -0800
+++ b/drivers/input/misc/apanel.c	2007-11-20 06:04:52.000000000 -0800
@@ -176,6 +176,7 @@ static int apanel_detach_client(struct i
 
 	input_unregister_polled_device(ap->ipdev);
 	i2c_detach_client(&ap->client);
+	input_free_polled_device(ap->ipdev);
 
 	return 0;
 }

-- 

