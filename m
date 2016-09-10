From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v12 5/5] Input: goodix - add support for gt9157
Date: Sat, 10 Sep 2016 20:57:37 +0300
Message-ID: <1473530257-7495-6-git-send-email-irina.tirdea@intel.com>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473530257-7495-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Goodix touchscreen GT9157 has the same basic functionality
as GT911 touchscreen. This is based on Goodix datasheets
for GT911 and GT9157 and on Goodix driver gt9xx.c for
Android (publicly available in Android kernel trees for
various devices).

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 drivers/input/touchscreen/goodix.c                             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index ef5f42d..421b7d5 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -5,6 +5,7 @@ Required properties:
  - compatible		: Should be "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
+				 or "goodix,gt9157"
 				 or "goodix,gt927"
 				 or "goodix,gt9271"
 				 or "goodix,gt928"
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 6fba804..bd4dd4b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -192,6 +192,7 @@ static int goodix_get_cfg_len(u16 id)
 	case 911:
 	case 9271:
 	case 9110:
+	case 9157:
 	case 927:
 	case 928:
 		return GOODIX_CONFIG_911_LENGTH;
@@ -1168,6 +1169,7 @@ static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
+	{ .compatible = "goodix,gt9157" },
 	{ .compatible = "goodix,gt927" },
 	{ .compatible = "goodix,gt9271" },
 	{ .compatible = "goodix,gt928" },
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
