From: Tim Kersten <tim@io41.com>
Subject: [PATCH] Bump HID_MAX_USAGES to 32768
Date: Wed, 14 Jul 2010 12:45:47 +0100
Message-ID: <CF547DFF-246C-484C-B161-B37F74347EAE@io41.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51045 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0GNLpv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 07:45:51 -0400
Received: by eya25 with SMTP id 25so974674eya.19
        for <linux-input@vger.kernel.org>; Wed, 14 Jul 2010 04:45:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

to cater for number of usages reported by  JAOTECH/Alcor Micro Corp
wired remote. Needed for volume and channnel buttons. (USB ID 058f:9462)

Signed-off-by: Tim Kersten <tim@io41.com>
---
 include/linux/hid.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 895001f..91fbf4e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -339,7 +339,7 @@ struct hid_global {
  * This is the local environment. It is persistent up the next main-item.
  */
 
-#define HID_MAX_USAGES                 12288
+#define HID_MAX_USAGES                 32768
 #define HID_DEFAULT_NUM_COLLECTIONS    16
 
 struct hid_local {
-- 
1.7.0.4
