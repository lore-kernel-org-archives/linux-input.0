Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD3C77B61
	for <linux-input@archiver.kernel.org>; Thu, 27 Apr 2023 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbjD0Lrx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbjD0Lrw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2023 07:47:52 -0400
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E85E7;
        Thu, 27 Apr 2023 04:47:49 -0700 (PDT)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1682596065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BPz+sCdj0zEEm34nzbfMEWWZqvUZAC80l+biy0y2rpg=;
        b=XY9UqjkvFlyevL4fYzw6AZpw2XsfcMue5NcxP/+4Fx+s4rqkxDlQl19tW1Tg6Cm6nkQMJt
        qgyB33ESgGLKCJ+4VRZhqBt2xJY4N7zLnl6IXYEGLGkH/XxDxN58zjFS8o6NBfjpld8ocv
        sz3/Jej09teSGb0MtLyFcaXPqnKWqJ8=
To:     Ping Cheng <ping.cheng@wacom.com>
Cc:     Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] HID: wacom: Added error check
Date:   Thu, 27 Apr 2023 14:47:45 +0300
Message-Id: <20230427114745.53136-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

   Added a variable check and
   transition in case of an error

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/hid/wacom_sys.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index fb538a6c4add..aff4a21a46b6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2417,8 +2417,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
-- 
2.25.1

