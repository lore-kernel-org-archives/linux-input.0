From: hans.duedal@gmail.com
Subject: hid: roccat: Fix code style issues
Date: Sat, 11 Oct 2014 17:01:49 +0200
Message-ID: <1413039709-37143-1-git-send-email-hans.duedal@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:44886 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbaJKPCE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2014 11:02:04 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so4692380lab.21
        for <linux-input@vger.kernel.org>; Sat, 11 Oct 2014 08:02:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: erazor_de@users.sourceforge.net
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, Hans Duedal <hans.duedal@gmail.com>

From: Hans Duedal <hans.duedal@gmail.com>

Missing whitespace, semi-colon after macro, and a duplicated out of
memory message.

Signed-off-by: Hans Duedal <hans.duedal@gmail.com>
---
 drivers/hid/hid-roccat-kone.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 6101816..c292650 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -46,6 +46,7 @@ static void kone_profile_activated(struct kone_device *kone, uint new_profile)
 static void kone_profile_report(struct kone_device *kone, uint new_profile)
 {
 	struct kone_roccat_report roccat_report;
+
 	roccat_report.event = kone_mouse_event_switch_profile;
 	roccat_report.value = new_profile;
 	roccat_report.key = 0;
@@ -163,6 +164,7 @@ static int kone_set_settings(struct usb_device *usb_dev,
 		struct kone_settings const *settings)
 {
 	int retval;
+
 	retval = kone_send(usb_dev, kone_command_settings,
 			settings, sizeof(struct kone_settings));
 	if (retval)
@@ -387,7 +389,7 @@ static struct bin_attribute bin_attr_profile##number = {	\
 	.read = kone_sysfs_read_profilex,			\
 	.write = kone_sysfs_write_profilex,			\
 	.private = &profile_numbers[number-1],			\
-};
+}
 PROFILE_ATTR(1);
 PROFILE_ATTR(2);
 PROFILE_ATTR(3);
@@ -456,6 +458,7 @@ static ssize_t kone_sysfs_show_tcu(struct device *dev,
 static int kone_tcu_command(struct usb_device *usb_dev, int number)
 {
 	unsigned char value;
+
 	value = number;
 	return kone_send(usb_dev, kone_command_calibrate, &value, 1);
 }
@@ -697,10 +700,8 @@ static int kone_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {

 		kone = kzalloc(sizeof(*kone), GFP_KERNEL);
-		if (!kone) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!kone)
 			return -ENOMEM;
-		}
 		hid_set_drvdata(hdev, kone);

 		retval = kone_init_kone_device_struct(usb_dev, kone);
--
1.9.3 (Apple Git-50)

