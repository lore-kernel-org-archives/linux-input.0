Return-Path: <SRS0=KWuL=2G=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA5CC43603
	for <linux-input@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5052053B
	for <linux-input@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLPMaF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:30:05 -0500
Received: from sauhun.de ([88.99.104.3]:39786 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfLPM3w (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:52 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 0E8082C2D9A;
        Mon, 16 Dec 2019 13:29:51 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] input: mouse: convert to i2c_new_scanned_device
Date:   Mon, 16 Dec 2019 13:29:49 +0100
Message-Id: <20191216122950.3613-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216122950.3613-1-wsa+renesas@sang-engineering.com>
References: <20191216122950.3613-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/input/mouse/psmouse-smbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 027efdd2b2ad..27358e543283 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -190,6 +190,7 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 	struct psmouse_smbus_dev *smbdev = data;
 	unsigned short addr_list[] = { smbdev->board.addr, I2C_CLIENT_END };
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 
 	adapter = i2c_verify_adapter(dev);
 	if (!adapter)
@@ -198,12 +199,12 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HOST_NOTIFY))
 		return 0;
 
-	smbdev->client = i2c_new_probed_device(adapter, &smbdev->board,
-					       addr_list, NULL);
-	if (!smbdev->client)
+	client = i2c_new_scanned_device(adapter, &smbdev->board, addr_list, NULL);
+	if (IS_ERR(client))
 		return 0;
 
 	/* We have our(?) device, stop iterating i2c bus. */
+	smbdev->client = client;
 	return 1;
 }
 
-- 
2.20.1

