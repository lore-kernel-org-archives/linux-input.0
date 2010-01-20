From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] [hid-wacom] Implement Wacom quirk in the kernel
Date: Wed, 20 Jan 2010 12:00:53 +0000
Message-ID: <1263988853.1735.2524.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab0ATMBD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 07:01:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>

The hid-wacom driver required user-space to poke at the tablet
to make it send data about the cursor location.

This patch makes it do the same thing but in the kernel.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-wacom.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 7475421..e55ed3f 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -155,7 +155,9 @@ static int wacom_probe(struct hid_device *hdev,
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct wacom_data *wdata;
+	char rep_data[2];
 	int ret;
+	int limit;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (wdata == NULL) {
@@ -165,6 +167,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	hid_set_drvdata(hdev, wdata);
 
+	/* Parse the HID report now */
 	ret = hid_parse(hdev);
 	if (ret) {
 		dev_err(&hdev->dev, "parse failed\n");
@@ -177,6 +180,28 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	/* Set Wacom mode2 */
+	rep_data[0] = 0x03; rep_data[1] = 0x00;
+	limit =3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 2);
+	} while (ret < 0 && limit-- > 0);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to poke device #1, %d\n", ret);
+		goto err_free;
+	}
+
+	/* 0x06 - high reporting speed, 0x05 - low speed */
+	rep_data[0] = 0x06; rep_data[1] = 0x00;
+	limit = 3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 2);
+	} while (ret < 0 && limit-- > 0);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to poke device #2, %d\n", ret);
+		goto err_free;
+	}
+
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
-- 
1.6.5.2


