From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v2 1/3] Input: cyttsp - remove unused irq_gpio from platform_data
Date: Tue, 5 Jan 2016 13:59:13 +0100
Message-ID: <c9f1beb99dfb2194dd1fb68b91f0ded7efb57e6c.1451997697.git.oreste.salerno@tomtom.com>
References: <cover.1451997697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451997697.git.oreste.salerno@tomtom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

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
