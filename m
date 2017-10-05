From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH 2/2] Input: synaptics - Lenovo X1 Carbon 5 devices should use SMBUS/RMI
Date: Thu,  5 Oct 2017 21:22:21 +0300
Message-ID: <20171005182221.7138-3-yiannis.marangos@gmail.com>
References: <20171005182221.7138-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36924 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdJESWN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 14:22:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id v38so7049985wrc.4
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 11:22:12 -0700 (PDT)
In-Reply-To: <20171005182221.7138-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>

X1 Carbon 5 has two synaptics ids: LEN0072 and LEN0073.
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5af0b7d200bc..c9ab666e5ab1 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -172,6 +172,8 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN0072", /* X1 Carbon 5 */
+	"LEN0073", /* X1 Carbon 5 */
 	"LEN200f", /* T450s */
 	NULL
 };
-- 
2.14.1

