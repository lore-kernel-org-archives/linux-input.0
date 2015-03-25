From: Filip Ayazi <filipayazi@gmail.com>
Subject: [PATCH] input: synaptics: fix min-max quirk value for E440
Date: Wed, 25 Mar 2015 21:33:44 +0100
Message-ID: <1427315624-6653-1-git-send-email-filipayazi@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34086 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbbCYUeF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 16:34:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: cramm0@gmail.com, linux-kernel@vger.kernel.org, consume.noise@gmail.com, linux-input@vger.kernel.org, Filip Ayazi <filipayazi@gmail.com>

Commit 98dc070373 ("Input: synaptics - add quirk for Thinkpad E440") had
a typo in ymax, this changes the value to the one reported by
touchpad-edge-detector and mentioned in the commit.

Signed-off-by: Filip Ayazi <filipayazi@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f6a3a7b..3b06c8a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -155,7 +155,7 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 	{
 		(const char * const []){"LEN2006", NULL},
 		{2691, 2691},
-		1024, 5045, 2457, 4632
+		1024, 5045, 2457, 4832
 	},
 	{
 		(const char * const []){"LEN2006", NULL},
-- 
1.9.1

