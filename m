From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input-evdev: Rename a jump label in two functions
Date: Sat, 24 Sep 2016 13:10:11 +0200
Message-ID: <e50828fe-76b9-f087-575a-52aa6e107ba6@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92cc52f5-c5e1-cafe-76f2-04e4ed997735@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <92cc52f5-c5e1-cafe-76f2-04e4ed997735@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 12:50:31 +0200

Adjust a jump label according to the current Linux coding style convention.
Thus replace the identifier "out" by "unlock".

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/evdev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 83fcfd6..548874d 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -545,22 +545,21 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 
 	if (!evdev->exist || client->revoked) {
 		retval = -ENODEV;
-		goto out;
+		goto unlock;
 	}
 
 	while (retval + input_event_size() <= count) {
 
 		if (input_event_from_user(buffer + retval, &event)) {
 			retval = -EFAULT;
-			goto out;
+			goto unlock;
 		}
 		retval += input_event_size();
 
 		input_inject_event(&evdev->handle,
 				   event.type, event.code, event.value);
 	}
-
- out:
+unlock:
 	mutex_unlock(&evdev->mutex);
 	return retval;
 }
@@ -1292,12 +1291,11 @@ static long evdev_ioctl_handler(struct file *file, unsigned int cmd,
 
 	if (!evdev->exist || client->revoked) {
 		retval = -ENODEV;
-		goto out;
+		goto unlock;
 	}
 
 	retval = evdev_do_ioctl(file, cmd, p, compat_mode);
-
- out:
+unlock:
 	mutex_unlock(&evdev->mutex);
 	return retval;
 }
-- 
2.10.0
