Return-Path: <SRS0=wy78=CN=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485CC2BB84
	for <linux-input@archiver.kernel.org>; Fri,  4 Sep 2020 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8743F20658
	for <linux-input@archiver.kernel.org>; Fri,  4 Sep 2020 13:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="KYTszfo0";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Rpc++GkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgIDNsg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:48:36 -0400
Received: from smtp115.ord1d.emailsrvr.com ([184.106.54.115]:58913 "EHLO
        smtp115.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730628AbgIDNqv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 4 Sep 2020 09:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1599225717;
        bh=VSHpuGItY/0L/qHMSAVCvrmqgedAh5jY8QrKza32y8I=;
        h=From:To:Subject:Date:From;
        b=KYTszfo0zOBWjnr7/t3qslMANLwmdktaASKJgnDos6ECvspUxqO/Es+IptuhZ/AXQ
         XUZdt2CYu5yeZIKZoFFR87OkZZ8LWrwqFlVb6C661Ck727bsPLnrtrZuYB/yUbVhvI
         dXzXiFT/eoGoAq2aJY4g/717QJ1VEOeWM8oh1krQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1599225717;
        bh=VSHpuGItY/0L/qHMSAVCvrmqgedAh5jY8QrKza32y8I=;
        h=From:To:Subject:Date:From;
        b=Rpc++GkEQTxz+f6DcQ9i5buyTMyvuDZByklGKaOFP4KkwT9a1jo7YAdlcvi3PChyA
         QFE7Dn5vG+6F2o28fDmKzo/XfFVc6sZF5eXBo8mDxSgc094y5nIqfHdFvEN37b24er
         77UK35LjgZZ7nFK4XmLVSLWZ6B87hcoUkxcdKixc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9BFAB20113;
        Fri,  4 Sep 2020 09:21:56 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-input@vger.kernel.org
Cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: wiimote: narrow spinlock range in wiimote_hid_event()
Date:   Fri,  4 Sep 2020 14:21:43 +0100
Message-Id: <20200904132143.9496-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904132143.9496-1-abbotti@mev.co.uk>
References: <20200904132143.9496-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: ee464daf-2bdc-4db4-9ef3-697c4738b247-3-1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

In `wiimote_hid_event()`, the `wdata->state.lock` spinlock does not need
to be held while searching `handlers[]` for a suitable handler function.
Change it so the spinlock is only held during the call to the handler
function itself.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/hid/hid-wiimote-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index e03a0ba5611a..41012681cafd 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1625,12 +1625,12 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	if (size < 1)
 		return -EINVAL;
 
-	spin_lock_irqsave(&wdata->state.lock, flags);
-
 	for (i = 0; handlers[i].id; ++i) {
 		h = &handlers[i];
 		if (h->id == raw_data[0] && h->size < size) {
+			spin_lock_irqsave(&wdata->state.lock, flags);
 			h->func(wdata, &raw_data[1]);
+			spin_unlock_irqrestore(&wdata->state.lock, flags);
 			break;
 		}
 	}
@@ -1639,8 +1639,6 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 		hid_warn(hdev, "Unhandled report %hhu size %d\n", raw_data[0],
 									size);
 
-	spin_unlock_irqrestore(&wdata->state.lock, flags);
-
 	return 0;
 }
 
-- 
2.28.0

