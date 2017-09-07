From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: uinput - remove uinput_allocate_device()
Date: Wed,  6 Sep 2017 17:21:11 -0700
Message-ID: <20170907002112.14097-5-dmitry.torokhov@gmail.com>
References: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There is no need for this wrapper; let's use input_allocate_device()
directly, and complete initialization in uinput_create_device().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 09549eddfcd4..06f3ac67dde1 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -324,6 +324,10 @@ static int uinput_create_device(struct uinput_device *udev)
 		dev->flush = uinput_dev_flush;
 	}
 
+	dev->event = uinput_dev_event;
+
+	input_set_drvdata(udev->dev, udev);
+
 	error = input_register_device(udev->dev);
 	if (error)
 		goto fail2;
@@ -406,18 +410,6 @@ static int uinput_validate_absbits(struct input_dev *dev)
 	return 0;
 }
 
-static int uinput_allocate_device(struct uinput_device *udev)
-{
-	udev->dev = input_allocate_device();
-	if (!udev->dev)
-		return -ENOMEM;
-
-	udev->dev->event = uinput_dev_event;
-	input_set_drvdata(udev->dev, udev);
-
-	return 0;
-}
-
 static int uinput_dev_setup(struct uinput_device *udev,
 			    struct uinput_setup __user *arg)
 {
@@ -493,9 +485,9 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
 		return -EINVAL;
 
 	if (!udev->dev) {
-		retval = uinput_allocate_device(udev);
-		if (retval)
-			return retval;
+		udev->dev = input_allocate_device();
+		if (!udev->dev)
+			return -ENOMEM;
 	}
 
 	dev = udev->dev;
@@ -826,9 +818,9 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 		return retval;
 
 	if (!udev->dev) {
-		retval = uinput_allocate_device(udev);
-		if (retval)
-			goto out;
+		udev->dev = input_allocate_device();
+		if (!udev->dev)
+			return -ENOMEM;
 	}
 
 	switch (cmd) {
-- 
2.14.1.581.gf28d330327-goog
