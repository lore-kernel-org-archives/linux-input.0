Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F0CC433EF
	for <linux-input@archiver.kernel.org>; Wed, 13 Jul 2022 03:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiGMDVg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 Jul 2022 23:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMDVe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Jul 2022 23:21:34 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68DB5C48F1;
        Tue, 12 Jul 2022 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7H5QC
        /ebLWEw0Vftb7BZuIxCrCx4xpLAewO2u8p2DHg=; b=mdmi7qwGOHl68OCOxAo0T
        mKMBMCTWl36/djl/DVaV62jRO4kmQg53BrvfUY+QCr3VgI9VTIXl0ohUScQBKv1z
        FQ/27+3pzd5UJTG3P3QnMzVTztZljdY0xBZnxYKRra9C3FqmowVKzViz/IORMbxK
        tR1GuPVdtQAiq91kIlrJRM=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp11 (Coremail) with SMTP id D8CowACHPPovOs5iQQ5eMg--.5854S2;
        Wed, 13 Jul 2022 11:21:23 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] HID: rmi: replace ternary operator with min()
Date:   Wed, 13 Jul 2022 11:20:47 +0800
Message-Id: <20220713032047.2238205-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACHPPovOs5iQQ5eMg--.5854S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyUWF1UGFy3Jw1fKw15Jwb_yoW8XrW8pF
        WkCFZ0yrWUAF18Cw1Ut3WDCa4rtwn7Gay5u34jv347WFn8tF98GrW5Ka4UWwn0vFs3J39r
        Xr1DurW5G3WqvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz6wZUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8BQ9+1uohid3cwAAs0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

drivers/hid/hid-rmi.c:240: WARNING opportunity for min().
drivers/hid/hid-rmi.c:350: WARNING opportunity for min().

min() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/hid/hid-rmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 311eee599ce9..bb1f423f4ace 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -237,8 +237,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 
 			read_input_count = data->readReport[1];
 			memcpy(buf + bytes_read, &data->readReport[2],
-				read_input_count < bytes_needed ?
-					read_input_count : bytes_needed);
+				min(read_input_count, bytes_needed));
 
 			bytes_read += read_input_count;
 			bytes_needed -= read_input_count;
@@ -347,8 +346,7 @@ static int rmi_read_data_event(struct hid_device *hdev, u8 *data, int size)
 		return 0;
 	}
 
-	memcpy(hdata->readReport, data, size < hdata->input_report_size ?
-			size : hdata->input_report_size);
+	memcpy(hdata->readReport, data, min((u32)size, hdata->input_report_size));
 	set_bit(RMI_READ_DATA_PENDING, &hdata->flags);
 	wake_up(&hdata->wait);
 
-- 
2.25.1

