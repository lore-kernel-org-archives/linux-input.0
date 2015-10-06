From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: joydev - fix dereferencing possible ERR_PTR()
Date: Wed,  7 Oct 2015 01:30:57 +0200
Message-ID: <1444174257-27984-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Kitt <steve@sk2.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Commit 5702222c9a7a ("Input: joydev - use memdup_user() to duplicate
memory from user-space") changed the kmalloc() and copy_from_user()
with a single call to memdup_user() but wrongly used the same error
path than the old code in which the buffer allocated by kmalloc() was
freed if copy_from_user() failed.

This is of course wrong since if memdup_user() fails, no memory was
allocated and the error in the error-valued pointer should be returned.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Fixes: 5702222c9a7a ("Input: joydev - use memdup_user() to duplicate
memory from user-space")

---

 drivers/input/joydev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index e3dcd4abae18..5d11fea3c8ec 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -445,10 +445,8 @@ static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
 
 	/* Validate the map. */
 	abspam = memdup_user(argp, len);
-	if (IS_ERR(abspam)) {
-		retval = PTR_ERR(abspam);
-		goto out;
-	}
+	if (IS_ERR(abspam))
+		return PTR_ERR(abspam);
 
 	for (i = 0; i < joydev->nabs; i++) {
 		if (abspam[i] > ABS_MAX) {
@@ -478,10 +476,8 @@ static int joydev_handle_JSIOCSBTNMAP(struct joydev *joydev,
 
 	/* Validate the map. */
 	keypam = memdup_user(argp, len);
-	if (IS_ERR(keypam)) {
-		retval = PTR_ERR(keypam);
-		goto out;
-	}
+	if (IS_ERR(keypam))
+		return PTR_ERR(keypam);
 
 	for (i = 0; i < joydev->nkey; i++) {
 		if (keypam[i] > KEY_MAX || keypam[i] < BTN_MISC) {
-- 
2.4.3
