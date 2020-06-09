Return-Path: <SRS0=GK5G=7W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F2BC433E1
	for <linux-input@archiver.kernel.org>; Tue,  9 Jun 2020 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E1220853
	for <linux-input@archiver.kernel.org>; Tue,  9 Jun 2020 12:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d0tSCri1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgFIMrb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:47:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54322 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbgFIMqk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2020 08:46:40 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0AA61314;
        Tue,  9 Jun 2020 14:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591706797;
        bh=OOH+LAXUnO54rY/U8UNrIE1qIeSrYaq/xrNetIgDJ/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0tSCri1MiOPPEmnFQJsxZ1iXXrFBfNY1UgzCqbmHnRQpzb2sBVwxrnhpt1YvIDYM
         9O8tEfYEuTcvx5LLozaR/xhnD/5vEVFulm666XCiyTYhALNo39jq6cX8p2WEBBzA3y
         vKJ+C0jjMUv9voc3ni4x0DkMUH/yrGowKq38GeiE=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/17] drivers: input: joystick: Fix trivial spelling
Date:   Tue,  9 Jun 2020 13:46:03 +0100
Message-Id: <20200609124610.3445662-11-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/input/joystick/spaceball.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index cf7cbcd0c29d..92002a8b9e8b 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -124,7 +124,7 @@ static void spaceball_process_packet(struct spaceball* spaceball)
 }
 
 /*
- * Spaceball 4000 FLX packets all start with a one letter packet-type decriptor,
+ * Spaceball 4000 FLX packets all start with a one letter packet-type descriptor,
  * and end in 0x0d. It uses '^' as an escape for CR, XOFF and XON characters which
  * can occur in the axis values.
  */
-- 
2.25.1

