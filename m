From: "Zhu, Lejun" <lejun.zhu@linux.intel.com>
Subject: [PATCH] soc_button_array: fix a crash during rmmod
Date: Tue, 22 Apr 2014 14:38:39 +0800
Message-ID: <53560E6F.9000806@linux.intel.com>
References: <53560DD1.5050805@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16603 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbaDVGik (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 02:38:40 -0400
In-Reply-To: <53560DD1.5050805@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When the system has zero or one button available, trying to rmmod
soc_button_array will cause crash. Fix this by properly handling -ENODEV
in probe().

Signed-off-by: Lejun Zhu <lejun.zhu@linux.intel.com>
---
 drivers/input/misc/soc_button_array.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/soc_button_array.c
b/drivers/input/misc/soc_button_array.c
index 08ead2a..20c80f5 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -169,6 +169,7 @@ static int soc_button_pnp_probe(struct pnp_dev *pdev,
 				soc_button_remove(pdev);
 				return error;
 			}
+			continue;
 		}

 		priv->children[i] = pd;
-- 
1.8.3.2



















