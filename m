Return-Path: <SRS0=Nfmz=5B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2DC18E5B
	for <linux-input@archiver.kernel.org>; Mon, 16 Mar 2020 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A7C206E2
	for <linux-input@archiver.kernel.org>; Mon, 16 Mar 2020 14:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgCPO2I (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:28:08 -0400
Received: from comms.puri.sm ([159.203.221.185]:34396 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731465AbgCPO2I (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Mar 2020 10:28:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 0B272E0422;
        Mon, 16 Mar 2020 07:28:07 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lv14Uuw2sJos; Mon, 16 Mar 2020 07:28:06 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     dmitry.torokhov@gmail.com, andriy.shevchenko@linux.intel.com,
        m.felsch@pengutronix.de, mylene.josserand@bootlin.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] Input: edt-ft5x06 - add fw_version debugfs file to read
Date:   Mon, 16 Mar 2020 15:27:56 +0100
Message-Id: <20200316142756.25344-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add simple fw_version file in debugfs to read the value from 0xa6
which is the firmware version.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

Since we got at least 2 different FT firmware version in our controller,
we need to distinguish them.

thanks,
                              martin


 drivers/input/touchscreen/edt-ft5x06.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index bc7fb2c005b5..efb09bba739a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -51,6 +51,8 @@
 #define EV_REGISTER_OFFSET_Y		0x45
 #define EV_REGISTER_OFFSET_X		0x46
 
+#define REG_FW_VERSION			0xa6
+
 #define NO_REGISTER			0xff
 
 #define WORK_REGISTER_OPMODE		0x3c
@@ -685,6 +687,22 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
 DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
 			edt_ft5x06_debugfs_mode_set, "%llu\n");
 
+static int edt_ft5x06_debugfs_fw_version_get(void *data, u64 *version)
+{
+	struct edt_ft5x06_ts_data *tsdata = data;
+	struct i2c_client *client = tsdata->client;
+
+	*version = edt_ft5x06_register_read(tsdata, REG_FW_VERSION);
+	if (*version == 0xff || *version == 0x00)
+		dev_dbg(&client->dev, "failed to get firmware version\n");
+
+	return 0;
+};
+
+DEFINE_SIMPLE_ATTRIBUTE(debugfs_fw_version_fops,
+			edt_ft5x06_debugfs_fw_version_get,
+			NULL, "%llu\n");
+
 static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 				char __user *buf, size_t count, loff_t *off)
 {
@@ -779,6 +797,9 @@ edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
 
 	debugfs_create_file("mode", S_IRUSR | S_IWUSR,
 			    tsdata->debug_dir, tsdata, &debugfs_mode_fops);
+	debugfs_create_file("fw_version", S_IRUSR,
+			    tsdata->debug_dir, tsdata,
+			    &debugfs_fw_version_fops);
 	debugfs_create_file("raw_data", S_IRUSR,
 			    tsdata->debug_dir, tsdata, &debugfs_raw_data_fops);
 }
-- 
2.20.1

