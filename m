From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 10/11] touchscreen: sun4i_ts: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:50 +0530
Message-ID: <20180721191029.25658-9-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Andi Shyti <andi@etezian.org>, Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9e5975..78960961a524 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -230,8 +230,8 @@ static ssize_t show_temp_label(struct device *dev,
 	return sprintf(buf, "SoC temperature\n");
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);
+static DEVICE_ATTR(temp1_input, 0444, show_temp, NULL);
+static DEVICE_ATTR(temp1_label, 0444, show_temp_label, NULL);
 
 static struct attribute *sun4i_ts_attrs[] = {
 	&dev_attr_temp1_input.attr,
-- 
2.17.1
