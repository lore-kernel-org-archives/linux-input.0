From: Amit Nagal <helloin.amit@gmail.com>
Subject: [PATCH] hidraw : free list for all error in hidraw_open
Date: Fri, 2 Sep 2011 10:59:37 +0530
Message-ID: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42]:36098 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1IBFhZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2011 01:37:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>

Hi ,

In function hidraw_open (linux-3.0.3/drivers/hid/hidraw.c ) ,  struct
hidraw_list *list should be freed for all error conditions .
Following is patch enclosed for the same :

Signed-off-by: Amit Nagal <helloin.amit@gmail.com>
---

diff -uprN linux-3.0.3/drivers/hid/hidraw.c.orig
linux-3.0.3/drivers/hid/hidraw.c
--- linux-3.0.3/drivers/hid/hidraw.c.orig       2011-09-01
13:23:19.000000000 -0400
+++ linux-3.0.3/drivers/hid/hidraw.c    2011-09-02 06:25:08.000000000 -0400
@@ -259,7 +259,6 @@ static int hidraw_open(struct inode *ino

        mutex_lock(&minors_lock);
        if (!hidraw_table[minor]) {
-               kfree(list);
                err = -ENODEV;
                goto out_unlock;
        }
@@ -285,6 +284,8 @@ static int hidraw_open(struct inode *ino
 out_unlock:
        mutex_unlock(&minors_lock);
 out:
+       if (err < 0)
+               kfree(list);
        return err;

 }

--
