Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C52445AE3;
	Thu, 30 Jul 2026 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440961; cv=none; b=I77RQ3o5V7o6MXs4pkzbkQgzG3gihky2KupYoHdkmhec39koILK4krk11jYx88bBulIIuVMWvDIct3HJcvvOZhhc//Vl39HwJL3pjq9b+/pj7KsPeXLrmCwpYUfAKXC+17cxT+Wo5nyEt7wYZSRZ0yjFCZ89FyI6OmTwpPZD29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440961; c=relaxed/simple;
	bh=aj8hhWibeTU8QIY9QYQlCqxjBoWJiWzaRKvTZMNVdc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jm8U1I2WQ6nBg3eUaA3ob9BnRZjtgtogC94/ERLRpv+5R7Uifmi16mdwYAiChD4s+mT3Y55Rl6/xaJlLHEqsLR3yvjS9SFnr/WI5nuy5e0gmEAjMLMw48+tJq1v1USY4nMQ5Zt5jtj8jyYtI2QZhfHzwka3BkpeVyaoeo/Gka3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WqeIvB8h; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WqeIvB8h"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C17DC41BE1;
	Thu, 30 Jul 2026 21:49:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkeT9Pdai3f6; Thu, 30 Jul 2026 21:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440950; bh=aj8hhWibeTU8QIY9QYQlCqxjBoWJiWzaRKvTZMNVdc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WqeIvB8hknFbmSYU20I7I9ytGKZPE3IKSE8WKVGtm2+bznE3+UmDYwvmkwR+/XS+x
	 Ax0/BYVv7evmdnMu0IPZrkQIXVQQvdsZvU/UktSMhaVXOlbC4w0M3Ka4Gmv6FC7MIt
	 IHqszHuu97C0Fgd7g57TYSIbzO+WimM9Oz20x2Xi1GOkEDT+437aj7MypChhXy46K/
	 uExaj5yTEuutEorxxDZw1/Hdiox6/1SKS9DdHYjvFkDSsY0NgOJgevNtBs8tAOUD1r
	 xXuH1Gjwlzxkkrc62mSnmpioJyMWpavyjwkOhEktckKhTEsgzb9+sNEvU2eBxvMqnP
	 g+tW6+j56xGbg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:18:23 +0530
Subject: [PATCH v2 3/5] Input: zinitix - add support for modes 0 and 1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-zinitix-modes-v2-3-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
In-Reply-To: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

Zinitix touchscreens have three modes, numbered 0 to 2. The driver
implements mode 2, and leaves out modes 0 and 1. The difference in the
touchscreen modes is the schema of the event data.

Implement modes 0 and 1 in the driver, along with their event structs.
Maintain a common, canonical event struct which is to be the superset of
the mode-specific structs. With that, introduce functions to convert the
mode event info to the canonical format.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/input/touchscreen/zinitix.c | 133 +++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index a0a89d25e25b..aafd0b7d8edb 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -145,7 +145,37 @@ struct point_coord {
 	u8	angle;
 };
 
+struct point_coord_mode0 {
+	__le16	x;
+	__le16	y;
+	u8	width;
+	u8	sub_status;
+};
+
 struct touch_event {
+	__le16	status;
+	__le16	event_flag;
+	u8	finger_mask;
+	u8	time_stamp;
+	struct point_coord point_coord[MAX_SUPPORTED_FINGER_NUM];
+};
+
+struct touch_event_mode0 {
+	__le16	status;
+	u8	finger_mask;
+	u8	time_stamp;
+	struct point_coord_mode0 point_coord[MAX_SUPPORTED_FINGER_NUM];
+};
+
+struct touch_event_mode1 {
+	__le16	status;
+	__le16	event_flag;
+	u8	finger_mask;
+	u8	time_stamp;
+	struct point_coord_mode0 point_coord[MAX_SUPPORTED_FINGER_NUM];
+};
+
+struct touch_event_mode2 {
 	__le16	status;
 	u8	finger_mask;
 	u8	time_stamp;
@@ -165,6 +195,7 @@ struct bt541_ts_data {
 	u16 firmware_version;
 	u16 regdata_version;
 	u16 icon_status_reg;
+	int (*read_point_status)(struct bt541_ts_data *bt541, struct touch_event *event);
 };
 
 static int zinitix_read_data(struct i2c_client *client,
@@ -440,6 +471,87 @@ static void zinitix_report_keys(struct bt541_ts_data *bt541, u16 icon_events)
 				 bt541->keycodes[i], icon_events & BIT(i));
 }
 
+static int zinitix_read_point_status_mode0(struct bt541_ts_data *bt541,
+					   struct touch_event *event)
+{
+	struct touch_event_mode0 event_mode0;
+	int ret;
+	int i;
+
+	ret = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
+				&event_mode0, sizeof(struct touch_event_mode0));
+	if (ret)
+		return ret;
+
+	event->status = event_mode0.status;
+	event->finger_mask = event_mode0.finger_mask;
+	event->time_stamp = event_mode0.time_stamp;
+
+	for (i = 0; i < ARRAY_SIZE(event_mode0.point_coord); i++) {
+		event->point_coord[i].x = event_mode0.point_coord[i].x;
+		event->point_coord[i].y = event_mode0.point_coord[i].y;
+		event->point_coord[i].width = event_mode0.point_coord[i].width;
+		event->point_coord[i].sub_status = event_mode0.point_coord[i].sub_status;
+	}
+
+	return 0;
+}
+
+static int zinitix_read_point_status_mode1(struct bt541_ts_data *bt541,
+					   struct touch_event *event)
+{
+	struct touch_event_mode1 event_mode1;
+	int ret;
+	int i;
+
+	ret = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
+				&event_mode1, sizeof(struct touch_event_mode1));
+	if (ret)
+		return ret;
+
+	event->status = event_mode1.status;
+	event->event_flag = event_mode1.event_flag;
+	event->finger_mask = event_mode1.finger_mask;
+	event->time_stamp = event_mode1.time_stamp;
+
+	for (i = 0; i < ARRAY_SIZE(event_mode1.point_coord); i++) {
+		event->point_coord[i].x = event_mode1.point_coord[i].x;
+		event->point_coord[i].y = event_mode1.point_coord[i].y;
+		event->point_coord[i].width = event_mode1.point_coord[i].width;
+		event->point_coord[i].sub_status = event_mode1.point_coord[i].sub_status;
+	}
+
+	return 0;
+}
+
+static int zinitix_read_point_status_mode2(struct bt541_ts_data *bt541,
+					   struct touch_event *event)
+{
+	struct touch_event_mode2 event_mode2;
+	int ret;
+	int i;
+
+	ret = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
+				&event_mode2, sizeof(struct touch_event_mode2));
+	if (ret)
+		return ret;
+
+	event->status = event_mode2.status;
+	event->finger_mask = event_mode2.finger_mask;
+	event->time_stamp = event_mode2.time_stamp;
+
+	for (i = 0; i < ARRAY_SIZE(event_mode2.point_coord); i++) {
+		event->point_coord[i].x = event_mode2.point_coord[i].x;
+		event->point_coord[i].y = event_mode2.point_coord[i].y;
+		event->point_coord[i].width = event_mode2.point_coord[i].width;
+		event->point_coord[i].sub_status = event_mode2.point_coord[i].sub_status;
+		event->point_coord[i].minor_width = event_mode2.point_coord[i].minor_width;
+		event->point_coord[i].angle = event_mode2.point_coord[i].angle;
+	}
+
+	return 0;
+}
+
 static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 {
 	struct bt541_ts_data *bt541 = bt541_handler;
@@ -451,8 +563,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 
 	memset(&touch_event, 0, sizeof(struct touch_event));
 
-	error = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
-				  &touch_event, sizeof(struct touch_event));
+	error = bt541->read_point_status(bt541, &touch_event);
 	if (error) {
 		dev_err(&client->dev, "Failed to read in touchpoint struct\n");
 		goto out;
@@ -682,13 +793,19 @@ static int zinitix_ts_probe(struct i2c_client *client)
 		bt541->zinitix_mode = DEFAULT_TOUCH_POINT_MODE;
 	}
 
-	if (bt541->zinitix_mode != 2) {
-		/*
-		 * If there are devices that don't support mode 2, support
-		 * for other modes (0, 1) will be needed.
-		 */
+	switch (bt541->zinitix_mode) {
+	case 0:
+		bt541->read_point_status = zinitix_read_point_status_mode0;
+		break;
+	case 1:
+		bt541->read_point_status = zinitix_read_point_status_mode1;
+		break;
+	case 2:
+		bt541->read_point_status = zinitix_read_point_status_mode2;
+		break;
+	default:
 		dev_err(&client->dev,
-			"Malformed zinitix,mode property, must be 2 (supplied: %d)\n",
+			"Malformed zinitix,mode property, must be 0, 1, or 2 (supplied: %d)\n",
 			bt541->zinitix_mode);
 		return -EINVAL;
 	}

-- 
2.54.0

