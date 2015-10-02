From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 01/18] Input: joydev - use memdup_user() to duplicate memory from user-space
Date: Fri,  2 Oct 2015 15:40:12 +0200
Message-ID: <1443793229-22363-2-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The memdup_user() helper function can be used to duplicate a memory region
from user-space to kernel-space. There is no need to open code the same
logic using kmalloc() and copy_from_user() instead. This was found with
make coccicheck that reported the following warning:

drivers/input/joydev.c:447:10-17: WARNING opportunity for memdup_user
drivers/input/joydev.c:483:10-17: WARNING opportunity for memdup_user

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/joydev.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 6cb5a3e5f9a1..e3dcd4abae18 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -444,12 +444,9 @@ static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
 	len = min(len, sizeof(joydev->abspam));
 
 	/* Validate the map. */
-	abspam = kmalloc(len, GFP_KERNEL);
-	if (!abspam)
-		return -ENOMEM;
-
-	if (copy_from_user(abspam, argp, len)) {
-		retval = -EFAULT;
+	abspam = memdup_user(argp, len);
+	if (IS_ERR(abspam)) {
+		retval = PTR_ERR(abspam);
 		goto out;
 	}
 
@@ -480,12 +477,9 @@ static int joydev_handle_JSIOCSBTNMAP(struct joydev *joydev,
 	len = min(len, sizeof(joydev->keypam));
 
 	/* Validate the map. */
-	keypam = kmalloc(len, GFP_KERNEL);
-	if (!keypam)
-		return -ENOMEM;
-
-	if (copy_from_user(keypam, argp, len)) {
-		retval = -EFAULT;
+	keypam = memdup_user(argp, len);
+	if (IS_ERR(keypam)) {
+		retval = PTR_ERR(keypam);
 		goto out;
 	}
 
-- 
2.4.3
