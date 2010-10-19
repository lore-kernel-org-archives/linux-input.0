From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] HID: hidraw, fix window in hidraw_release
Date: Tue, 19 Oct 2010 11:24:45 +0200
Message-ID: <1287480285-5335-1-git-send-email-jslaby@suse.cz>
References: <20101009144026.c37f8d25.ospite@studenti.unina.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101009144026.c37f8d25.ospite@studenti.unina.it>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: alan@signal11.us, linux-input@vger.kernel.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-input@vger.kernel.org

There is a window between hidraw_table check and its dereference.
In that window, the device may be unplugged and removed form the
system and we will then dereference NULL.

Lock that place properly so that either we get NULL and jump out or we
can work with real pointer.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/hid/hidraw.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 925992f..6d81be3 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -218,9 +218,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	unsigned int minor = iminor(inode);
 	struct hidraw *dev;
 	struct hidraw_list *list = file->private_data;
+	int ret;
 
-	if (!hidraw_table[minor])
-		return -ENODEV;
+	mutex_lock(&minors_lock);
+	if (!hidraw_table[minor]) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 
 	list_del(&list->node);
 	dev = hidraw_table[minor];
@@ -233,10 +237,12 @@ static int hidraw_release(struct inode * inode, struct file * file)
 			kfree(list->hidraw);
 		}
 	}
-
+	ret = 0;
+unlock:
+	mutex_unlock(&minors_lock);
 	kfree(list);
 
-	return 0;
+	return ret;
 }
 
 static long hidraw_ioctl(struct file *file, unsigned int cmd,
-- 
1.7.3.1
