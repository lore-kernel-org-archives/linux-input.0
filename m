From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v2 2/2] Input: synaptics - Lenovo X1 Carbon 5 should use SMBUS/RMI
Date: Fri,  6 Oct 2017 17:06:30 +0300
Message-ID: <20171006140630.6398-3-yiannis.marangos@gmail.com>
References: <20171006140630.6398-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44250 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdJFOGl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 10:06:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id 196so2865921wma.1
        for <linux-input@vger.kernel.org>; Fri, 06 Oct 2017 07:06:40 -0700 (PDT)
In-Reply-To: <20171006140630.6398-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>

---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5af0b7d200bc..eecb8872c1a5 100644
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
2.14.2

