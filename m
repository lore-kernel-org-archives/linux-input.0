Return-Path: <SRS0=Ma1V=4W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1371CC3F2D2
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FAB20848
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428603;
	bh=OxIDXJsgioKRpwAg+0x+Vf5qgEy9TBUr+PTln/+kECM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMWub6+rQD7yjTnwhaY7ZmX+FTG7pXpIbCvFjJ4EWHllysHKpxjyGHfpRp2SLH3gd
	 A2oBLHao5SyV9VdJdUj9Kfbm7f3Wp9ZdqfFgZhBwwVl8SdUcokjzsY+bbvejeHE5Rz
	 b/Wd2JgIshJMZzdNPVzTOc416XK8D/u/gHXawcoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCERQj (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgCERQQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Mar 2020 12:16:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC762166E;
        Thu,  5 Mar 2020 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428575;
        bh=OxIDXJsgioKRpwAg+0x+Vf5qgEy9TBUr+PTln/+kECM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI85aioCYh039ObqoKO2M39Q5OjNvaMQfYbT8g8epyOXzo0xlBVA92n1gDUagG78M
         Ik9SLDVzuHvYlFc30Q/e2gM5hLCJZ72Q8IbDnVhWfy2+m/E8yymrEgD6m3WT2Br5C5
         uyE4XkIA+qWBUJh9A1/x6YdZ1CKpLQCuoH0qOEWg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Korsnes <jkorsnes@cisco.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Armando Visconti <armando.visconti@st.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/7] HID: core: increase HID report buffer size to 8KiB
Date:   Thu,  5 Mar 2020 12:16:07 -0500
Message-Id: <20200305171612.30555-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171612.30555-1-sashal@kernel.org>
References: <20200305171612.30555-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Johan Korsnes <jkorsnes@cisco.com>

[ Upstream commit 84a4062632462c4320704fcdf8e99e89e94c0aba ]

We have a HID touch device that reports its opens and shorts test
results in HID buffers of size 8184 bytes. The maximum size of the HID
buffer is currently set to 4096 bytes, causing probe of this device to
fail. With this patch we increase the maximum size of the HID buffer to
8192 bytes, making device probe and acquisition of said buffers succeed.

Signed-off-by: Johan Korsnes <jkorsnes@cisco.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Armando Visconti <armando.visconti@st.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5f31318851366..2149f650982ea 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -451,7 +451,7 @@ struct hid_report_enum {
 };
 
 #define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a packet size of space */
-#define HID_MAX_BUFFER_SIZE	4096		/* 4kb */
+#define HID_MAX_BUFFER_SIZE	8192		/* 8kb */
 #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
 #define HID_OUTPUT_FIFO_SIZE	64
 
-- 
2.20.1

