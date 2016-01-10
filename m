From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v3 1/3] Input: cyttsp - remove unused irq_gpio from platform_data
Date: Sun, 10 Jan 2016 18:36:07 +0100
Message-ID: <f2e8051d9c1648d75af124e7d92c979590fd8c47.1452447124.git.oreste.salerno@tomtom.com>
References: <cover.1452447124.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:40674 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756795AbcAJRgX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2016 12:36:23 -0500
In-Reply-To: <cover.1452447124.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com

This field is not being used and the irq is anyway passed
via the 'irq' parameter to cyttsp_probe.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 include/linux/input/cyttsp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.h
index 5af7c66..d7c2520 100644
--- a/include/linux/input/cyttsp.h
+++ b/include/linux/input/cyttsp.h
@@ -51,7 +51,6 @@ struct cyttsp_platform_data {
 	int (*init)(void);
 	void (*exit)(void);
 	char *name;
-	s16 irq_gpio;
 	u8 *bl_keys;
 };
 
-- 
1.9.1

