From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4] input: wacom - make LED status readable through sysfs
Date: Mon,  3 Oct 2011 17:03:48 -0700
Message-ID: <1317686628-29686-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42523 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab1JDACA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 20:02:00 -0400
Received: by qadb15 with SMTP id b15so2022777qad.19
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 17:01:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 6a61c8b..5a3895e 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -584,7 +584,14 @@ static ssize_t wacom_led##SET_ID##_select_store(struct device *dev,	\
 {									\
 	return wacom_led_select_store(dev, SET_ID, buf, count);		\
 }									\
-static DEVICE_ATTR(status_led##SET_ID##_select, S_IWUSR, NULL,		\
+static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct wacom *wacom = dev_get_drvdata(dev);			\
+	return snprintf(buf, 2, "%d\n", wacom->led.select[SET_ID]);	\
+}									\
+static DEVICE_ATTR(status_led##SET_ID##_select, S_IWUSR | S_IRUSR,	\
+		    wacom_led##SET_ID##_select_show,			\
 		    wacom_led##SET_ID##_select_store)
 
 DEVICE_LED_SELECT_ATTR(0);
-- 
1.7.6

