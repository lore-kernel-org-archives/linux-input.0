Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F61C47082
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0C061920
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhFGQ1x (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhFGQWg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Jun 2021 12:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B1A561921;
        Mon,  7 Jun 2021 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082520;
        bh=PSeUHXyNu4/zMavba5976xT+dMH+3+5S0oxbo9sJw4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiGCSjhYvuaMU6C548WWAxOC1a0q+omSaoZl5bg1CAI00Siiuf1hqoAV5+B4Y28Ju
         O1dIZy0GMp7DIoN4seC6Lc3XxINN9WwxOX1OK1fx5hWBkbc6VUDD1ZqnVlQ7Ewlzv9
         XB48l4i1h2KGxJQ1HuALn8vor1qLqf8LHeBJ9t5LrYC9TLUKTA5R4FaPgCNUIErxMM
         uCEo0NeN7b35P26xs+2wbIwv/Lo+I8aksDyNFTD0JVXHNHfk2Qy9jtlZNOHnEMviKq
         dQpVKYokqY9MX3HisGdQxCBAbTCyd4JSNwu5Lq/c8zV8CqKw10YvweUBprbC53V1Xx
         1stVDvyiUPfzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/18] HID: hid-sensor-hub: Return error for hid_set_field() failure
Date:   Mon,  7 Jun 2021 12:15:00 -0400
Message-Id: <20210607161517.3584577-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161517.3584577-1-sashal@kernel.org>
References: <20210607161517.3584577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit edb032033da0dc850f6e7740fa1023c73195bc89 ]

In the function sensor_hub_set_feature(), return error when hid_set_field()
fails.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sensor-hub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index aa078c1dad14..6c7e12d8e7d9 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -223,16 +223,21 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	buffer_size = buffer_size / sizeof(__s32);
 	if (buffer_size) {
 		for (i = 0; i < buffer_size; ++i) {
-			hid_set_field(report->field[field_index], i,
-				      (__force __s32)cpu_to_le32(*buf32));
+			ret = hid_set_field(report->field[field_index], i,
+					    (__force __s32)cpu_to_le32(*buf32));
+			if (ret)
+				goto done_proc;
+
 			++buf32;
 		}
 	}
 	if (remaining_bytes) {
 		value = 0;
 		memcpy(&value, (u8 *)buf32, remaining_bytes);
-		hid_set_field(report->field[field_index], i,
-			      (__force __s32)cpu_to_le32(value));
+		ret = hid_set_field(report->field[field_index], i,
+				    (__force __s32)cpu_to_le32(value));
+		if (ret)
+			goto done_proc;
 	}
 	hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
 	hid_hw_wait(hsdev->hdev);
-- 
2.30.2

