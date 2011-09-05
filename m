From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/2] HID: wacom: Unregister sysfs attributes on remove
Date: Mon,  5 Sep 2011 18:45:29 +0200
Message-ID: <1315241129-3889-2-git-send-email-dh.herrmann@googlemail.com>
References: <1315241129-3889-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40059 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab1IEQpq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Sep 2011 12:45:46 -0400
Received: by ewy4 with SMTP id 4so2295934ewy.19
        for <linux-input@vger.kernel.org>; Mon, 05 Sep 2011 09:45:45 -0700 (PDT)
In-Reply-To: <1315241129-3889-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

HID devices can be hotplugged so we should unregister all sysfs attributes when
removing a driver. Otherwise, manually unloading the wacom-driver will not
remove the sysfs attributes. Only when the device is disconnected, they are
removed, eventually.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wacom.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index f66a597..a597039 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -423,6 +423,7 @@ static void wacom_remove(struct hid_device *hdev)
 #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	struct wacom_data *wdata = hid_get_drvdata(hdev);
 #endif
+	device_remove_file(&hdev->dev, &dev_attr_speed);
 	hid_hw_stop(hdev);
 
 #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
-- 
1.7.6.1

