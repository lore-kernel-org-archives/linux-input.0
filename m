From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] HID: roccat: Drop cast
Date: Thu, 26 Jun 2014 22:58:52 +0530
Message-ID: <20140626172852.GA2878@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: linux-input@vger.kernel.org

This patch removes the cast on data of type void* as it is not needed.
The following Coccinelle semantic patch was used for making the change:

@r@
expression x;
void* e;
type T;
identifier f;
@@

(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T *)x)->f
|
- (T *)
  e
)

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/hid/hid-roccat-lua.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-lua.c b/drivers/hid/hid-roccat-lua.c
index 6adc0fa..65e2e76 100644
--- a/drivers/hid/hid-roccat-lua.c
+++ b/drivers/hid/hid-roccat-lua.c
@@ -61,7 +61,7 @@ static ssize_t lua_sysfs_write(struct file *fp, struct kobject *kobj,
 		return -EINVAL;
 
 	mutex_lock(&lua->lua_lock);
-	retval = roccat_common2_send(usb_dev, command, (void *)buf, real_size);
+	retval = roccat_common2_send(usb_dev, command, buf, real_size);
 	mutex_unlock(&lua->lua_lock);
 
 	return retval ? retval : real_size;
-- 
1.9.1
