From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/5] HID: hid-lenovo-tpkbd, remove doubled hid_get_drvdata
Date: Thu,  4 Apr 2013 22:32:12 +0200
Message-ID: <1365107532-32721-5-git-send-email-jslaby@suse.cz>
References: <1365107532-32721-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365107532-32721-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: jirislaby@gmail.com
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In pointer_press_speed_show, we do
    data_pointer = hid_get_drvdata(hdev);
twice in a row. Remove one of those.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/hid-lenovo-tpkbd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index a0535fd..07837f5 100644
--- a/drivers/hid/hid-lenovo-tpkbd.c
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -228,8 +228,6 @@ static ssize_t pointer_press_speed_show(struct device *dev,
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
-	data_pointer = hid_get_drvdata(hdev);
-
 	return snprintf(buf, PAGE_SIZE, "%u\n",
 		data_pointer->press_speed);
 }
-- 
1.8.2
