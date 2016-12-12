From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] Input: ALPS: fix protcol -> protocol
Date: Mon, 12 Dec 2016 07:53:54 -0200
Message-ID: <20161212095442.2391-1-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33425 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbcLLJzA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 04:55:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/input/mouse/alps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index b9417e2..50f05a7 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -146,7 +146,7 @@ struct alps_protocol_info {
  *   (aka command mode response) identifies the firmware minor version.  This
  *   can be used to distinguish different hardware models which are not
  *   uniquely identifiable through their E7 responses.
- * @protocol_info: information about protcol used by the device.
+ * @protocol_info: information about protocol used by the device.
  *
  * Many (but not all) ALPS touchpads can be identified by looking at the
  * values returned in the "E7 report" and/or the "EC report."  This table
-- 
2.9.3

