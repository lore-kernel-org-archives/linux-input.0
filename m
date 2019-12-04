Return-Path: <SRS0=Phb3=Z2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F951C432C0
	for <linux-input@archiver.kernel.org>; Wed,  4 Dec 2019 02:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B8020640
	for <linux-input@archiver.kernel.org>; Wed,  4 Dec 2019 02:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfLDCoB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:44:01 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47988 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfLDCoB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Dec 2019 21:44:01 -0500
Received: from localhost.localdomain (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5B12BCEC92;
        Wed,  4 Dec 2019 03:53:09 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     David Herrmann <dh.herrmann@googlemail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Fabian Henneke <fabian.henneke@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: uhid: Fix returning EPOLLOUT from uhid_char_poll
Date:   Wed,  4 Dec 2019 03:43:55 +0100
Message-Id: <20191204024355.4566-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Always return EPOLLOUT from uhid_char_poll to allow polling /dev/uhid
for writable state.

Fixes: 1f9dec1e0164 ("HID: uhid: allow poll()'ing on uhid devices")
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
---
 drivers/hid/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index fa0cc0899827..935c3d0a3b63 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -772,7 +772,7 @@ static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 	if (uhid->head != uhid->tail)
 		return EPOLLIN | EPOLLRDNORM;
 
-	return 0;
+	return EPOLLOUT | EPOLLWRNORM;
 }
 
 static const struct file_operations uhid_fops = {
-- 
2.23.0

