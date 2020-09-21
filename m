Return-Path: <SRS0=6bYf=C6=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7510C43463
	for <linux-input@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9675620EDD
	for <linux-input@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIUID6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:03:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgIUICT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 24E51D5E5C3142B64F1A;
        Mon, 21 Sep 2020 16:02:17 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:10 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] HID: intel-ish-hid: simplify the return expression of ishtp_hid_parse
Date:   Mon, 21 Sep 2020 16:24:34 +0800
Message-ID: <20200921082434.2591357-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index b8aae69ad15d..edf5ae942508 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -22,14 +22,9 @@ static int ishtp_hid_parse(struct hid_device *hid)
 {
 	struct ishtp_hid_data *hid_data =  hid->driver_data;
 	struct ishtp_cl_data *client_data = hid_data->client_data;
-	int rv;
-
-	rv = hid_parse_report(hid, client_data->report_descr[hid_data->index],
-			      client_data->report_descr_size[hid_data->index]);
-	if (rv)
-		return	rv;
 
-	return 0;
+	return hid_parse_report(hid, client_data->report_descr[hid_data->index],
+				client_data->report_descr_size[hid_data->index]);
 }
 
 /* Empty callbacks with success return code */
-- 
2.25.1

