From: Ryan Mallon <rmallon@gmail.com>
Subject: [PATCH 2/2] uinput: Use input_inject_event in uinput_inject_event
Date: Wed, 11 Sep 2013 09:32:53 +1000
Message-ID: <1378855973-11595-2-git-send-email-rmallon@gmail.com>
References: <1378855973-11595-1-git-send-email-rmallon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378855973-11595-1-git-send-email-rmallon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: carl@ok-labs.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ryan Mallon <rmallon@gmail.com>
List-Id: linux-input@vger.kernel.org

Call input_inject_event rather than input_event in uinput_inject_event. This
mirrors the behaviour of evdev_write. input_inject_event will ignore the
injected event if the uinput input device has been grabbed for exclusive
access by a handler other than uinput.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 drivers/input/misc/uinput.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 6aea346..0962ecb 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -443,7 +443,7 @@ static ssize_t uinput_inject_event(struct uinput_device *udev,
 		if (input_event_from_user(buffer + bytes, &ev))
 			return -EFAULT;
 
-		input_event(udev->dev, ev.type, ev.code, ev.value);
+		input_inject_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
 	}
 
-- 
1.7.9.7
