From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH] HID: add comment for power callback in struct hid_ll_driver
Date: Wed, 20 Sep 2017 18:40:36 +0900
Message-ID: <1505900436-31183-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35495 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdITJlJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 05:41:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so996556pfi.2
        for <linux-input@vger.kernel.org>; Wed, 20 Sep 2017 02:41:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>

There is a missing comment in struct hid_ll_driver. So, add it.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 include/linux/hid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index ab05a86..7c3d4a1 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -753,6 +753,7 @@ struct hid_driver {
  * @stop: called on remove
  * @open: called by input layer on open
  * @close: called by input layer on close
+ * @power: request underlying hardware to enter requested power mode
  * @parse: this method is called only once to parse the device data,
  *	   shouldn't allocate anything to not leak memory
  * @request: send report request to device (e.g. feature report)
-- 
2.7.4

