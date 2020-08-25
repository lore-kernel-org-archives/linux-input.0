Return-Path: <SRS0=zshN=CD=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B2C433DF
	for <linux-input@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCDC2073A
	for <linux-input@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgHYE5L (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:11 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:45624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728691AbgHYE5F (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D3900837F24C;
        Tue, 25 Aug 2020 04:57:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waste57_250ae2b27059
X-Filterd-Recvd-Size: 1609
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/29] Input: MT - Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:09 -0700
Message-Id: <02cb394f8c305473c1a783a5ea8425de79fe0ec1.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/input/input-mt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index f699538bdac4..44fe6f2f063c 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -323,11 +323,14 @@ static int adjust_dual(int *begin, int step, int *end, int eq, int mu)
 	p = begin + step;
 	s = p == end ? f + 1 : *p;
 
-	for (; p != end; p += step)
-		if (*p < f)
-			s = f, f = *p;
-		else if (*p < s)
+	for (; p != end; p += step) {
+		if (*p < f) {
+			s = f;
+			f = *p;
+		} else if (*p < s) {
 			s = *p;
+		}
+	}
 
 	c = (f + s + 1) / 2;
 	if (c == 0 || (c > mu && (!eq || mu > 0)))
-- 
2.26.0

