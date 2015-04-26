From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Input: sentelic - use "static inline" instead of "inline"
Date: Sun, 26 Apr 2015 18:15:22 +0000
Message-ID: <1430072122-9902-1-git-send-email-raj.khem@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32987 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbDZSPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Apr 2015 14:15:34 -0400
Received: by igbpi8 with SMTP id pi8so56527762igb.0
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2015 11:15:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

gcc-5 defaults to gnu11 which used c99 inline semantics
in c99 'inline' is not externally visible unlike gnu89, therefore
we use 'static inline' which has same semantics between gnu89 and c99

Signed-off-by: Khem Raj <raj.khem@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/sentelic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index aa697ec..42df9e3 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -123,11 +123,11 @@ struct fsp_data {
 extern int fsp_detect(struct psmouse *psmouse, bool set_properties);
 extern int fsp_init(struct psmouse *psmouse);
 #else
-inline int fsp_detect(struct psmouse *psmouse, bool set_properties)
+static inline int fsp_detect(struct psmouse *psmouse, bool set_properties)
 {
 	return -ENOSYS;
 }
-inline int fsp_init(struct psmouse *psmouse)
+static inline int fsp_init(struct psmouse *psmouse)
 {
 	return -ENOSYS;
 }
-- 
2.1.4

