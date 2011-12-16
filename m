From: Dima Zavin <dima@android.com>
Subject: [PATCH 2/3] input: evdev: if no events and non-block, return EAGAIN not 0
Date: Fri, 16 Dec 2011 10:07:05 -0800
Message-ID: <1324058826-12891-2-git-send-email-dima@android.com>
References: <1324058826-12891-1-git-send-email-dima@android.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:44829 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760342Ab1LPSHO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Dec 2011 13:07:14 -0500
Received: by eaad1 with SMTP id d1so96367eaa.1
        for <linux-input@vger.kernel.org>; Fri, 16 Dec 2011 10:07:12 -0800 (PST)
In-Reply-To: <1324058826-12891-1-git-send-email-dima@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dima Zavin <dima@android.com>, Jeff Brown <jeffbrown@android.com>

Cc: Jeff Brown <jeffbrown@android.com>
Signed-off-by: Dima Zavin <dima@android.com>
---
 drivers/input/evdev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 03344b3..2e563af 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -412,6 +412,8 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 		retval += input_event_size();
 	}
 
+	if (retval == 0 && file->f_flags & O_NONBLOCK)
+		retval = -EAGAIN;
 	return retval;
 }
 
-- 
1.7.3.1

