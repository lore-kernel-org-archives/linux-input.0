From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/5] drivers/hid/hid-roccat.c: eliminate a null pointer dereference
Date: Sat, 29 Oct 2011 01:58:15 +0200
Message-ID: <1319846297-2985-3-git-send-email-julia@diku.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

It is not possible to take the lock in device if device is NULL.
The mutex_lock is thus moved after the NULL test, and the relevant part of
the shared error handling code is moved up.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression E, E1;
identifier f;
statement S1,S2,S3;
@@

if (E == NULL)
{
  ... when != if (E == NULL || ...) S1 else S2
      when != E = E1
*E->f
  ... when any
  return ...;
}
else S3
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/hid/hid-roccat.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 2596321..36a28b8 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -163,14 +163,15 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 	device = devices[minor];
 
-	mutex_lock(&device->readers_lock);
-
 	if (!device) {
 		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
-		error = -ENODEV;
-		goto exit_err;
+		kfree(reader);
+		mutex_lock(&devices_lock);
+		return -ENODEV;
 	}
 
+	mutex_lock(&device->readers_lock);
+
 	if (!device->open++) {
 		/* power on device on adding first reader */
 		error = hid_hw_power(device->hid, PM_HINT_FULLON);
