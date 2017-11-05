From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v3 2/2] Input: synaptics - Lenovo X1 Carbon 5 should use SMBUS/RMI
Date: Sun,  5 Nov 2017 19:09:51 +0200
Message-ID: <20171105170951.20261-3-yiannis.marangos@gmail.com>
References: <20171105170951.20261-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43175 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdKERKW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 5 Nov 2017 12:10:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id 4so2258598wrt.0
        for <linux-input@vger.kernel.org>; Sun, 05 Nov 2017 09:10:22 -0800 (PST)
In-Reply-To: <20171105170951.20261-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>

Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ee5466a374bf..b3c683a84d3f 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -172,6 +172,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN0073", /* X1 Carbon 5 */
 	"LEN200f", /* T450s */
 	NULL
 };
-- 
2.14.3

