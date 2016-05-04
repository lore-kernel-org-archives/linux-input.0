From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v3 3/4] Input: zforce_ts: Add device tree support for scanning frequency
Date: Wed, 4 May 2016 12:24:40 +0200
Message-ID: <1462357481-16258-4-git-send-email-dirk.behme@de.bosch.com>
References: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:42118 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425AbcEDKYr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 06:24:47 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 0F283D80204
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:46 +0200 (CEST)
Received: from FE-HUB1001.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id C3DC72E40611
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:45 +0200 (CEST)
In-Reply-To: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>

From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

Add device tree support for idle and finger scanning frequency.

For usage details see documentation.

Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 .../devicetree/bindings/input/touchscreen/zforce_ts.txt   |  4 ++++
 drivers/input/touchscreen/zforce_ts.c                     | 15 ++++++++++++++-
 include/linux/platform_data/zforce_ts.h                   |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
index e3c27c4..d8d57ba 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
@@ -11,6 +11,8 @@ Required properties:
 Optional properties:
 - irq-gpios : interrupt gpio the chip is connected to
 - vdd-supply: Regulator controlling the controller supply
+- scan-idle-hz: idle scanning frequency in Hz (0 - 65535 Hz; default 10 Hz)
+- scan-active-hz: touch scanning frequeny in Hz (0 - 65535 Hz; default 50 Hz)
 
 Example:
 
@@ -28,6 +30,8 @@ Example:
 
 			x-size = <800>;
 			y-size = <600>;
+			scan-idle-hz = <50>;
+			scan-active-hz = <250>;
 		};
 
 		/* ... */
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index c912a0b..2e489fd 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -87,6 +87,9 @@
 
 #define SETCONFIG_DUALTOUCH		(1 << 0)
 
+#define SCAN_FREQ_DEFAULT_IDLE		10
+#define SCAN_FREQ_DEFAULT_FINGER	50
+
 struct zforce_point {
 	int coord_x;
 	int coord_y;
@@ -304,7 +307,9 @@ static int zforce_start(struct zforce_ts *ts)
 		goto error;
 	}
 
-	ret = zforce_scan_frequency(ts, 10, 50, 50);
+	ret = zforce_scan_frequency(ts, pdata->scan_freq_idle,
+				    pdata->scan_freq_finger,
+				    pdata->scan_freq_finger);
 	if (ret) {
 		dev_err(&client->dev, "Unable to set scan frequency, %d\n",
 			ret);
@@ -838,6 +843,14 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (of_property_read_u16(np, "scan-idle-hz",
+				 &pdata->scan_freq_idle))
+		pdata->scan_freq_idle = SCAN_FREQ_DEFAULT_IDLE;
+
+	if (of_property_read_u16(np, "scan-active-hz",
+				 &pdata->scan_freq_finger))
+		pdata->scan_freq_finger = SCAN_FREQ_DEFAULT_FINGER;
+
 	return pdata;
 }
 
diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
index 7bdece8..90a1181 100644
--- a/include/linux/platform_data/zforce_ts.h
+++ b/include/linux/platform_data/zforce_ts.h
@@ -18,6 +18,8 @@
 struct zforce_ts_platdata {
 	unsigned int x_max;
 	unsigned int y_max;
+	u16 scan_freq_idle;
+	u16 scan_freq_finger;
 };
 
 #endif /* _LINUX_INPUT_ZFORCE_TS_H */
-- 
1.9.1

