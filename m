Return-Path: <SRS0=Ma1V=4W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA668C3F2D1
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A321556
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583429065;
	bh=pJVC9i/QPbvPIH+sJdfj6m0BKMTWaYXmsMkok+iVz6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uFqajOhJ41zfQPFSrZ6Y2G3zpJvGtehvTmeWYwTlZm702icIHZBR1iC1ZUVs7wbXM
	 0v5CZUkhsKc+PWTxC0s6ryy9bKNIB9giC+nsm/RefXmslYDIMULE1/vNXgXAQtX82v
	 z9+C93qGFt58SOqoydqlXdTU/SJxUyy35C9NPaT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCERNP (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCERNO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F472146E;
        Thu,  5 Mar 2020 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428393;
        bh=pJVC9i/QPbvPIH+sJdfj6m0BKMTWaYXmsMkok+iVz6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKcPrZL2PJitHPXMEx4PJCVhKDvrz9C1dlYKKK3qSjIhZv3cQw606C9oHNnmfgk80
         o6CjH63kYPkePExpmQHs9r9uSSNHB4kI0CFoqG/Ko6wAledBNFxGxBoWzTElgQryUH
         q6+gbwLgudIYfBoOveNSKjdgFM2/413lCZpSOhx4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Korsnes <jkorsnes@cisco.com>,
        Armando Visconti <armando.visconti@st.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 03/67] HID: core: fix off-by-one memset in hid_report_raw_event()
Date:   Thu,  5 Mar 2020 12:12:04 -0500
Message-Id: <20200305171309.29118-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Johan Korsnes <jkorsnes@cisco.com>

[ Upstream commit 5ebdffd25098898aff1249ae2f7dbfddd76d8f8f ]

In case a report is greater than HID_MAX_BUFFER_SIZE, it is truncated,
but the report-number byte is not correctly handled. This results in a
off-by-one in the following memset, causing a kernel Oops and ensuing
system crash.

Note: With commit 8ec321e96e05 ("HID: Fix slab-out-of-bounds read in
hid_field_extract") I no longer hit the kernel Oops as we instead fail
"controlled" at probe if there is a report too long in the HID
report-descriptor. hid_report_raw_event() is an exported symbol, so
presumabely we cannot always rely on this being the case.

Fixes: 966922f26c7f ("HID: fix a crash in hid_report_raw_event()
                     function.")
Signed-off-by: Johan Korsnes <jkorsnes@cisco.com>
Cc: Armando Visconti <armando.visconti@st.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 851fe54ea59e7..359616e3efbbb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1741,7 +1741,9 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 
 	rsize = ((report->size - 1) >> 3) + 1;
 
-	if (rsize > HID_MAX_BUFFER_SIZE)
+	if (report_enum->numbered && rsize >= HID_MAX_BUFFER_SIZE)
+		rsize = HID_MAX_BUFFER_SIZE - 1;
+	else if (rsize > HID_MAX_BUFFER_SIZE)
 		rsize = HID_MAX_BUFFER_SIZE;
 
 	if (csize < rsize) {
-- 
2.20.1

