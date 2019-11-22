Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D30C432C3
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 08:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DF820708
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 08:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKVI0Z (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:26:25 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:52542 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfKVI0Y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 03:26:24 -0500
IronPort-SDR: MgzCr4Y+OvHazrB/sbK1R4XFjM4vAxEqIeD6x/PxzBfxQDdk5I7CC/2rtz2RVeGl/8KBEpiCwR
 e5gibqYXfM5V+XsFkMueOxHufOKEkA5gfvy2hRHCBanYDv1sCO/xIsF0JVW/x2kSTErD+xJ/Ew
 Qx2irjbO2d/UlcUGDpK0vXJNNh8IdtiflJK2WsmB+H/nKcGTFY1hJnKYtEFcywoIlmC9wda2VI
 gP+GRrFxTFBvixXaSqAk2UE/79+q5/ExcI9B1uh3T3g3KEpN0lAOhKbspyzoe237N3ASeb+L2p
 tns=
X-IronPort-AV: E=Sophos;i="5.69,229,1571731200"; 
   d="scan'208";a="43358973"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 22 Nov 2019 00:26:23 -0800
IronPort-SDR: NovqKH9ZCndvBlGwCA9ax4Neqe1mUqUpc86PgIE1FKWkb8HZnY767l8N0IHX9ykyAs/Dc7UVl0
 5R7X+jM/N9AuryY+DcWypzhNFN2Tw4Q1ZjZsjedC4ofnPKKXb5kFd3dE7ygT05jqajyRWmksjI
 jc5EOnnzYS4uBH/eQ6jn47+YMWbEGja9KG3KPvUx413xb6lExUv5FIGebEIBLKCvZ7L65Fon3c
 6LVVI9mFmxxXxkHoYcMj5ieI0Jk4BoByQIhWEuS3qu0LMYegj9iy87amr5UR0g6LqdvxB1bUG5
 MUs=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <rydberg@bitmath.org>, <dmitry.torokhov@gmail.com>,
        <nick@shmanahar.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v6 37/48] Input: atmel_mxt_ts: return error from mxt_process_messages_until_invalid()
Date:   Fri, 22 Nov 2019 17:23:51 +0900
Message-ID: <20191122082402.18173-38-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122082402.18173-1-jiada_wang@mentor.com>
References: <20191122082402.18173-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dean Jenkins <Dean_Jenkins@mentor.com>

mxt_process_messages_until_invalid() failed to propagate the error
code from mxt_read_and_process_messages() so return the error code.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 054aacc768b8..a5af1f91d704 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1564,6 +1564,8 @@ static int mxt_process_messages_until_invalid(struct mxt_data *data)
 	/* Read messages until we force an invalid */
 	do {
 		read = mxt_read_and_process_messages(data, count);
+		if (read < 0)
+			return read;
 		if (read < count)
 			return 0;
 	} while (--tries);
-- 
2.17.1

