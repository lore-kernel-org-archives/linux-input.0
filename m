From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] Input: mms114 - remove unneded semicolons
Date: Mon, 14 Sep 2015 14:43:58 +0200
Message-ID: <1442234638-31460-2-git-send-email-javier@osg.samsung.com>
References: <1442234638-31460-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442234638-31460-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jingoo Han <jg1.han@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

They aren't needed and are just creating null statements so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/input/touchscreen/mms114.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 7cce87650fc8..1fafc9f57af6 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -394,12 +394,12 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
 		dev_err(dev, "failed to get x-size property\n");
 		return NULL;
-	};
+	}
 
 	if (of_property_read_u32(np, "y-size", &pdata->y_size)) {
 		dev_err(dev, "failed to get y-size property\n");
 		return NULL;
-	};
+	}
 
 	of_property_read_u32(np, "contact-threshold",
 				&pdata->contact_threshold);
-- 
2.4.3
