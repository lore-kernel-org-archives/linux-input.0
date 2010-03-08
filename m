From: Benjamin Tissoires <tissoire@cena.fr>
Subject: [PATCH 1/3] HID: Export hid_register_field
Date: Mon, 08 Mar 2010 22:29:40 +0100
Message-ID: <1268083780.9018.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:44679 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831Ab0CHV3t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 16:29:49 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 783C3D48181
	for <linux-input@vger.kernel.org>; Mon,  8 Mar 2010 22:29:43 +0100 (CET)
Received: from [192.168.0.112] (lan31-8-82-247-176-67.fbx.proxad.net [82.247.176.67])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 42517D48110
	for <linux-input@vger.kernel.org>; Mon,  8 Mar 2010 22:29:41 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


The Apple Magic Mouse (and probably other devices) publish reports that are not
called out in their HID report descriptors -- they only send them when enabled
through other writes to the devices. Exporting hid_register_report is not
sufficient as the given report is empty.

As the hid parser does not know the new fields, the driver has to register them
manually. This allows the driver to manually register the different fields.

Signed-off-by: Benjamin Tissoires <tissoire@cena.fr>
---
 drivers/hid/hid-core.c |    3 ++-
 include/linux/hid.h    |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bfd8301..3313dff 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL_GPL(hid_register_report);
  * Register a new field for this report.
  */
 
-static struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values)
+struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values)
 {
 	struct hid_field *field;
 
@@ -103,6 +103,7 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 
 	return field;
 }
+EXPORT_SYMBOL_GPL(hid_register_field);
 
 /*
  * Open a collection. The type/usage is pushed on the stack.
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b1344ec..50f17de 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -691,6 +691,7 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
 void hid_output_report(struct hid_report *report, __u8 *data);
 struct hid_device *hid_allocate_device(void);
 struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id);
+struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
-- 1.6.6.1 


