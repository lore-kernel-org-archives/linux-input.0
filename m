From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: uinput - return -EINVAL when read buffer size is too small
Date: Fri, 30 Mar 2012 23:06:18 -0700
Message-ID: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58411 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2CaGG2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:06:28 -0400
Received: by pbcun15 with SMTP id un15so2610026pbc.19
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:06:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

From: David Herrmann <dh.herrmann@googlemail.com>

Let's check whether the user-supplied buffer is actually big enough and
return -EINVAL if it is not. This differs from current behavior, which
caused 0 to be returned and actually does not make any sense, as
broken application will simply repeat the read getting into endless
loop.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 7360568..eb9723a 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -457,6 +457,9 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
 
+	if (count < input_event_size())
+		return -EINVAL;
+
 	if (udev->state != UIST_CREATED)
 		return -ENODEV;
 
-- 
1.7.7.6

