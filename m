From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/4] HID: logitech-hidpp: constify attribute_group structures.
Date: Thu,  3 Aug 2017 16:59:04 +0530
Message-ID: <1501759745-18294-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 41b3946..fc8de14 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2923,7 +2923,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	NULL
 };
 
-static struct attribute_group ps_attribute_group = {
+static const struct attribute_group ps_attribute_group = {
 	.attrs = sysfs_attrs
 };
 
-- 
1.9.1
