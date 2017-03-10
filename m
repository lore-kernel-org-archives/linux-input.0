From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: rmi4 - prevent null pointer dereference in f30
Date: Fri, 10 Mar 2017 19:05:52 +0100
Message-ID: <20170310180552.8375-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753818AbdCJSGA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 13:06:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

If the platform data has f30_data.disable set, f30 in rmi_f30_config()
might be null. Prevent a kernel oops by checking for non-null f30.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_f30.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index d8ff285..a0e4030 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -170,6 +170,10 @@ static int rmi_f30_config(struct rmi_function *fn)
 				rmi_get_platform_data(fn->rmi_dev);
 	int error;
 
+	/* can happen if f30_data.disable is set */
+	if (!f30)
+		return 0;
+
 	if (pdata->f30_data.trackstick_buttons) {
 		/* Try [re-]establish link to F03. */
 		f30->f03 = rmi_find_function(fn->rmi_dev, 0x03);
-- 
2.9.3

