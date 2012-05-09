From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: uinput - return -EINVAL when read buffer size is too small
Date: Wed,  9 May 2012 01:08:24 -0700
Message-ID: <1336550908-30644-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36822 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757688Ab2EIIIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 04:08:34 -0400
Received: by pbbrp8 with SMTP id rp8so190360pbb.19
        for <linux-input@vger.kernel.org>; Wed, 09 May 2012 01:08:34 -0700 (PDT)
In-Reply-To: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Aristeu Rozanski <aris@ruivo.org>
Cc: linux-input@vger.kernel.org

From: David Herrmann <dh.herrmann@googlemail.com>

Let's check whether the user-supplied buffer is actually big enough and
return -EINVAL if it is not. This differs from current behavior, which
caused 0 to be returned and actually does not make any sense, as
broken application will simply repeat the read getting into endless
loop.

Note that we treat 0 as a special case, according to the standard:

"Before any action described below is taken, and if nbyte is zero,
the read() function may detect and return errors as described below.
In the absence of errors, or if error detection is not performed,
the read() function shall return zero and have no other results."

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 1b4ee4a..e74ed9c 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -476,6 +476,9 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	struct input_event event;
 	int retval = 0;
 
+	if (count != 0 && count < input_event_size())
+		return -EINVAL;
+
 	if (udev->state != UIST_CREATED)
 		return -ENODEV;
 
-- 
1.7.7.6

