From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: mousedev - reformat structure initializers
Date: Wed,  3 Oct 2012 14:03:00 -0700
Message-ID: <1349298182-22452-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60793 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab2JCVDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Oct 2012 17:03:07 -0400
Received: by dakn41 with SMTP id n41so1393563dak.19
        for <linux-input@vger.kernel.org>; Wed, 03 Oct 2012 14:03:06 -0700 (PDT)
In-Reply-To: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Reformat structure initializers to match the rest of input handlers

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mousedev.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 8d3942f..91f6220 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -782,14 +782,14 @@ static unsigned int mousedev_poll(struct file *file, poll_table *wait)
 }
 
 static const struct file_operations mousedev_fops = {
-	.owner =	THIS_MODULE,
-	.read =		mousedev_read,
-	.write =	mousedev_write,
-	.poll =		mousedev_poll,
-	.open =		mousedev_open,
-	.release =	mousedev_release,
-	.fasync =	mousedev_fasync,
-	.llseek = noop_llseek,
+	.owner		= THIS_MODULE,
+	.read		= mousedev_read,
+	.write		= mousedev_write,
+	.poll		= mousedev_poll,
+	.open		= mousedev_open,
+	.release	= mousedev_release,
+	.fasync		= mousedev_fasync,
+	.llseek		= noop_llseek,
 };
 
 static int mousedev_install_chrdev(struct mousedev *mousedev)
@@ -1051,13 +1051,13 @@ static const struct input_device_id mousedev_ids[] = {
 MODULE_DEVICE_TABLE(input, mousedev_ids);
 
 static struct input_handler mousedev_handler = {
-	.event =	mousedev_event,
-	.connect =	mousedev_connect,
-	.disconnect =	mousedev_disconnect,
-	.fops =		&mousedev_fops,
-	.minor =	MOUSEDEV_MINOR_BASE,
-	.name =		"mousedev",
-	.id_table =	mousedev_ids,
+	.event		= mousedev_event,
+	.connect	= mousedev_connect,
+	.disconnect	= mousedev_disconnect,
+	.fops		= &mousedev_fops,
+	.minor		= MOUSEDEV_MINOR_BASE,
+	.name		= "mousedev",
+	.id_table	= mousedev_ids,
 };
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-- 
1.7.11.4

