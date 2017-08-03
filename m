From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/4] HID: multitouch: constify attribute_group structures.
Date: Thu,  3 Aug 2017 16:56:43 +0530
Message-ID: <1501759603-18121-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501759603-18121-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35028 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdHCL1F (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Aug 2017 07:27:05 -0400
In-Reply-To: <1501759603-18121-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f3e35e7..58285bc 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -341,7 +341,7 @@ static ssize_t mt_set_quirks(struct device *dev,
 	NULL
 };
 
-static struct attribute_group mt_attribute_group = {
+static const struct attribute_group mt_attribute_group = {
 	.attrs = sysfs_attrs
 };
 
-- 
1.9.1

