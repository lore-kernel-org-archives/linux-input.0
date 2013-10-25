From: Yunkang Tang <tommywill2011@gmail.com>
Subject: [PATCH] Input: Adding support for touchpad on Dell XT2 model
Date: Fri, 25 Oct 2013 23:39:41 +0800
Message-ID: <1382715581-2584-1-git-send-email-yunkang.tang@cn.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54197 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab3JYPj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Oct 2013 11:39:57 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so5333901pab.11
        for <linux-input@vger.kernel.org>; Fri, 25 Oct 2013 08:39:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, cernekee@gmail.com, dturvene@dahetral.com
Cc: linux-input@vger.kernel.org, ndevos@redhat.com, gaspard@oknaj.eu, jclift@redhat.com, yunkang.tang@cn.alps.com

Hi all,

This patch adding the support for touchpad on Dell XT2 model.
It's a dual device with device ID: 73, 00, 14, that comply with "ALPS_PROTO_V2".


Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
---
 drivers/input/mouse/alps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index ca7a26f..24b3626 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -103,6 +103,7 @@ static const struct alps_model_info alps_model_data[] = {
 	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
 	{ { 0x62, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
+	{ { 0x73, 0x00, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_DUALPOINT },		/* Dell XT2 */
 	{ { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },		/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
-- 
1.8.1.2

