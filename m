From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 1/3] HID: fixed typos from last commits regarding sysfs bin
 attr groups
Date: Mon, 15 Nov 2010 21:32:45 +0100
Message-ID: <1289853165.2188.45.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Added a 'static' where it belongs and changed a function call to use
the right one.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.c |    2 +-
 fs/sysfs/group.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index ccb5724..799dc80 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -695,7 +695,7 @@ exit_1:
 
 static void kone_remove_sysfs_attributes(struct usb_interface *intf)
 {
-	sysfs_remove_group(&intf->dev.kobj, &kone_bin_attribute_group);
+	sysfs_remove_bin_group(&intf->dev.kobj, &kone_bin_attribute_group);
 	sysfs_remove_group(&intf->dev.kobj, &kone_attribute_group);
 }
 
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 841baed..7e60e9c 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -167,7 +167,7 @@ void sysfs_remove_bin_group(struct kobject * kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_remove_bin_group);
 
-int internal_merge_group(struct kobject *kobj,
+static int internal_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp, int type)
 {
 	struct sysfs_dirent *dir_sd;
-- 
1.7.2.3
