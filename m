From: Ryan Mallon <rmallon@gmail.com>
Subject: [PATCH 2/2] uinput: Support injecting multiple events in one write() call
Date: Wed, 18 Sep 2013 08:55:44 +1000
Message-ID: <1379458544-6508-2-git-send-email-rmallon@gmail.com>
References: <1379458544-6508-1-git-send-email-rmallon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379458544-6508-1-git-send-email-rmallon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: carl@ok-labs.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ryan Mallon <rmallon@gmail.com>
List-Id: linux-input@vger.kernel.org

Rework the code in uinput_inject_event so that it matches the code in
evdev_write and allows injecting more than one event, or zero events.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 drivers/input/misc/uinput.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index a0a4bba..0247a8a 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -434,16 +434,24 @@ static ssize_t uinput_inject_event(struct uinput_device *udev,
 				   const char __user *buffer, size_t count)
 {
 	struct input_event ev;
+	size_t bytes = 0;
 
-	if (count < input_event_size())
+	if (count != 0 && count < input_event_size())
 		return -EINVAL;
 
-	if (input_event_from_user(buffer, &ev))
-		return -EFAULT;
+	while (bytes + input_event_size() <= count) {
+		if (input_event_from_user(buffer + bytes, &ev)) {
+			if (!bytes)
+				bytes = -EFAULT;
+			goto out;
+		}
 
-	input_event(udev->dev, ev.type, ev.code, ev.value);
+		input_event(udev->dev, ev.type, ev.code, ev.value);
+		bytes += input_event_size();
+	}
 
-	return input_event_size();
+ out:
+	return bytes;
 }
 
 static ssize_t uinput_write(struct file *file, const char __user *buffer,
-- 
1.7.9.7
