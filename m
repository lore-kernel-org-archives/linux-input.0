Return-Path: <SRS0=+nWv=YR=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9CCA9EAF
	for <linux-input@archiver.kernel.org>; Thu, 24 Oct 2019 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5920679
	for <linux-input@archiver.kernel.org>; Thu, 24 Oct 2019 15:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409689AbfJXPSo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:18:44 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60340 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405432AbfJXPSl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Oct 2019 11:18:41 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HTJg210035USYZQ01TJg1v; Thu, 24 Oct 2019 17:18:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNesp-0006z0-Td; Thu, 24 Oct 2019 17:18:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNesp-0007fQ-RU; Thu, 24 Oct 2019 17:18:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] HID: intel-ish-hid: Spelling s/diconnect/disconnect/
Date:   Thu, 24 Oct 2019 17:18:37 +0200
Message-Id: <20191024151837.29421-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fix misspelling of "disconnect".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hid/intel-ish-hid/ishtp/hbm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index c6c9ac09dac3a377..30a91d068306a000 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -402,7 +402,7 @@ static void ishtp_hbm_cl_connect_res(struct ishtp_device *dev,
  * @dev: ISHTP device instance
  * @disconnect_req: disconnect request structure
  *
- * Disconnect request bus message from the fw. Send diconnect response.
+ * Disconnect request bus message from the fw. Send disconnect response.
  */
 static void ishtp_hbm_fw_disconnect_req(struct ishtp_device *dev,
 	struct hbm_client_connect_request *disconnect_req)
-- 
2.17.1

