From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/4] HID: ntrig: constify attribute_group structures.
Date: Thu,  3 Aug 2017 16:59:05 +0530
Message-ID: <1501759745-18294-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501759745-18294-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501759745-18294-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-ntrig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1b0084d..3d121d8 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -445,7 +445,7 @@ static DEVICE_ATTR(deactivate_slack, S_IWUSR | S_IRUGO, show_deactivate_slack,
 	NULL
 };
 
-static struct attribute_group ntrig_attribute_group = {
+static const struct attribute_group ntrig_attribute_group = {
 	.attrs = sysfs_attrs
 };
 
-- 
1.9.1
