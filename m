Return-Path: <SRS0=6nV4=4A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B663AC2BA83
	for <linux-input@archiver.kernel.org>; Wed, 12 Feb 2020 08:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966C420714
	for <linux-input@archiver.kernel.org>; Wed, 12 Feb 2020 08:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgBLIrd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:47:33 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:17181 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgBLIrc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Feb 2020 03:47:32 -0500
IronPort-SDR: hhhJHJU8F/bbMXsv9dxLIOSkOcGdPpRLYENba9yMX1H1IUiZkvgnF9LLruRa14kFGh5GSG45kp
 bc5n49yIurnlcgQPM8XkLPDgSk9927PRAY3XoabtDnUZqRcDHHWFpOAECok+Lb1HEWGZMgBchG
 I4GlJ3pCqEieIayjTMiOxzV/CLTxVKPf0PipftkyjKWRJyFXRvTgvPjt97xKbrdR3xkRsI85nS
 24wxSyWwjzR10NsSt1sBw/korkCfNG/LMDH9rPxPS06kVuG+PtCjT/lY2ziwb3/NNRgfDib/PY
 ddo=
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="45742622"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 12 Feb 2020 00:47:32 -0800
IronPort-SDR: b9Gfd5QSmNvDNJVXjQxoJd8L/1Ef+jQlLC8Lj+JYN7WoeqWkbcHFEwlEiVAoWd4TTHx/Hnonmq
 RaJmIgFiVp7Qme9WM3v3dxBla6zrzgHjfglzIfu3NrWLh5ci1JeS3DGUwrzxsaC+OzyLL08eBY
 YXjJlxL6ebEpIkOY6187pHv/kZug6zoGCo15/B2vVAsa+YaCxDlJLsrmENjXS2Lp36i6euX/ru
 pcERBBqnvVfhXOGC/qiCQ8rnqGeLGH1LIlchN6aAIL+tTzUbAShpLSzIjAomMdZQRW8us3SKe6
 GII=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <rydberg@bitmath.org>, <dmitry.torokhov@gmail.com>,
        <nick@shmanahar.org>, <bsz@semihalf.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v7 42/48] Input: Atmel: handle ReportID "0x00" while processing T5 messages
Date:   Wed, 12 Feb 2020 00:42:12 -0800
Message-ID: <20200212084218.32344-43-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212084218.32344-1-jiada_wang@mentor.com>
References: <20200212084218.32344-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Deepak Das <deepak_das@mentor.com>

ReportID "0x00" is reserved by Atmel and should not be used by any
Atmel touch controller.

reportID is the first byte retrieved from T5 message payload.
Currently Atmel driver continues to process the T5 messages even if
the reportID "0x00" is returned by Touch Controller.

This commit modifies Atmel touch driver to return -EINVAL if ReportID
"0x00" is received while processing T5 messages.

Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e15f977e0af6..9e6e916c8d96 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -76,6 +76,7 @@
 #define MXT_PROCI_TOUCHSEQUENCELOGGER	93
 #define MXT_TOUCH_MULTITOUCHSCREEN_T100 100
 #define MXT_PROCI_ACTIVESTYLUS_T107	107
+#define MXT_RPTID_RESERVED		0
 
 /* MXT_GEN_MESSAGE_T5 object */
 #define MXT_RPTID_NOMSG		0xff
@@ -1381,6 +1382,11 @@ static int mxt_proc_message(struct mxt_data *data, u8 *message)
 	u8 report_id = message[0];
 	bool dump = data->debug_enabled;
 
+	if (report_id == MXT_RPTID_RESERVED) {
+		dev_err(&data->client->dev,
+			"Received Reserved ReportID 0x00\n");
+		return -EINVAL;
+	}
 	if (report_id == MXT_RPTID_NOMSG)
 		return 0;
 
@@ -1451,6 +1457,8 @@ static int mxt_read_and_process_messages(struct mxt_data *data, u8 count)
 		ret = mxt_proc_message(data,
 			data->msg_buf + data->T5_msg_size * i);
 
+		if (ret < 0)
+			return ret;
 		if (ret == 1)
 			num_valid++;
 	}
-- 
2.17.1

