From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: [PATCH 1/1] Input: don't modify the id of ioctl-provided ff effect on
 upload failure
Date: Sun, 23 Feb 2014 15:18:15 +0100
Message-ID: <CADbOyBTf4fWhUveA7UgCP4EpLXAyrZCV-xs-wZ7HGyBwxhQFhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:41650 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaBWOSR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 09:18:17 -0500
Received: by mail-ve0-f175.google.com with SMTP id oy12so508966veb.20
        for <linux-input@vger.kernel.org>; Sun, 23 Feb 2014 06:18:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org, =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>

From: Elias Vanderstuyft <elias.vds@gmail.com>

If a new (id == -1) ff effect was uploaded from userspace,
ff-core.c::input_ff_upload() will have assigned
a positive number to the new effect id.
Currently, evdev.c::evdev_do_ioctl() will save this new id to userspace,
regardless of whether the upload succeeded or not.

On upload failure, this can be confusing because the dev->ff->effects[] array
will not contain an element at the index of that new effect id.

Note: Unfortunately applications should still expect changed effect id for
quite some time.

This has been discussed on:
http://www.mail-archive.com/linux-input@vger.kernel.org/msg08513.html
("ff-core effect id handling in case of a failed effect upload")

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Elias Vanderstuyft <elias.vds@gmail.com>
---
 drivers/input/evdev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/input/evdev.c     2014-02-23 14:21:19.980606615 +0100
+++ b/drivers/input/evdev.c     2014-02-23 14:25:04.417118859 +0100
@@ -954,11 +954,13 @@ static long evdev_do_ioctl(struct file *
                        return -EFAULT;

                error = input_ff_upload(dev, &effect, file);
+               if (error)
+                       return error;

                if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
                        return -EFAULT;

-               return error;
+               return 0;
        }

        /* Multi-number variable-length handlers */
