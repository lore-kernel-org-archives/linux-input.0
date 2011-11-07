From: chris@cnpbagwell.com
Subject: [PATCH] Input: wacom - ignore unwanted bamboo packets
Date: Sun,  6 Nov 2011 19:22:15 -0600
Message-ID: <1320628935-14540-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41558 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab1KGBWb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Nov 2011 20:22:31 -0500
Received: by ywf7 with SMTP id 7so4711130ywf.19
        for <linux-input@vger.kernel.org>; Sun, 06 Nov 2011 17:22:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Bamboo's Pen and Touch packets always start with a value
of 0x02 in first byte.  In 3rd gen Bamboo's, the hw is now
periodically sending some additional packets with unrelated data
and uses a value other than 0x02 to inform driver this.

Ignore those packets now.

This was reported by users as bad behavior in Gimp. The
invalid packets being processed made the stylus report
out of proximity for the 1 packet and this triggered some
secondary bug which caused Gimp to stop drawing until
user really took pen out of proximity of tablet.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---

This patch is for next branch; were 3rd gen Bamboo patches
are.

It was tested on 1st gen and 3rd gen Bamboo.

 drivers/input/tablet/wacom_wac.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 164bb55..6b9adc7 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -799,6 +799,9 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int i;
 
+	if (data[0] != 0x02)
+	    return 0;
+
 	for (i = 0; i < 2; i++) {
 		int p = data[9 * i + 2];
 		bool touch = p && !wacom->shared->stylus_in_proximity;
@@ -875,6 +878,9 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 	int count = data[1] & 0x03;
 	int i;
 
+	if (data[0] != 0x02)
+	    return 0;
+
 	/* data has up to 7 fixed sized 8-byte messages starting at data[2] */
 	for (i = 0; i < count; i++) {
 		int offset = (8 * i) + 2;
@@ -900,6 +906,9 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
 
+	if (data[0] != 0x02)
+	    return 0;
+
 	prox = (data[1] & 0x20) == 0x20;
 
 	/*
-- 
1.7.7

